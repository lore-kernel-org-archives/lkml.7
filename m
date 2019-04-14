Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D1EC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 17:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0923020880
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 17:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfDNRAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 13:00:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43611 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfDNRAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 13:00:43 -0400
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hFiUg-0004Ov-JP; Sun, 14 Apr 2019 19:00:38 +0200
Date:   Sun, 14 Apr 2019 19:00:37 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
Subject: Re: [RFC patch 25/41] mm/kasan: Simplify stacktrace handling
In-Reply-To: <alpine.DEB.2.21.1904141853530.4917@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1904141858300.4917@nanos.tec.linutronix.de>
References: <20190410102754.387743324@linutronix.de> <20190410103645.862294081@linutronix.de> <20190411025509.cslu3nq27g7ww6qu@treble> <alpine.DEB.2.21.1904141853530.4917@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Apr 2019, Thomas Gleixner wrote:
> On Wed, 10 Apr 2019, Josh Poimboeuf wrote:
> > On Wed, Apr 10, 2019 at 12:28:19PM +0200, Thomas Gleixner wrote:
> > > Replace the indirection through struct stack_trace by using the storage
> > > array based interfaces.
> > > 
> > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > > Cc: Alexander Potapenko <glider@google.com>
> > > Cc: Dmitry Vyukov <dvyukov@google.com>
> > > Cc: kasan-dev@googlegroups.com
> > > Cc: linux-mm@kvack.org
> > > ---
> > >  mm/kasan/common.c |   30 ++++++++++++------------------
> > >  mm/kasan/report.c |    7 ++++---
> > >  2 files changed, 16 insertions(+), 21 deletions(-)
> > > 
> > > --- a/mm/kasan/common.c
> > > +++ b/mm/kasan/common.c
> > > @@ -48,34 +48,28 @@ static inline int in_irqentry_text(unsig
> > >  		 ptr < (unsigned long)&__softirqentry_text_end);
> > >  }
> > >  
> > > -static inline void filter_irq_stacks(struct stack_trace *trace)
> > > +static inline unsigned int filter_irq_stacks(unsigned long *entries,
> > > +					     unsigned int nr_entries)
> > >  {
> > > -	int i;
> > > +	unsigned int i;
> > >  
> > > -	if (!trace->nr_entries)
> > > -		return;
> > > -	for (i = 0; i < trace->nr_entries; i++)
> > > -		if (in_irqentry_text(trace->entries[i])) {
> > > +	for (i = 0; i < nr_entries; i++) {
> > > +		if (in_irqentry_text(entries[i])) {
> > >  			/* Include the irqentry function into the stack. */
> > > -			trace->nr_entries = i + 1;
> > > -			break;
> > > +			return i + 1;
> > 
> > Isn't this an off-by-one error if "i" points to the last entry of the
> > array?
> 
> Yes, copied one ...

Oh, no. The point is that it returns the number of stack entries to
store. So if i == nr_entries - 1, then it returns nr_entries, i.e. all
entries are stored.

Thanks,

	tglx

