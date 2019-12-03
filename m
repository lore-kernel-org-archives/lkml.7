Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AB8C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1C4205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfLCOgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:36:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:34784 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725957AbfLCOgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:36:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C21A3B365;
        Tue,  3 Dec 2019 14:36:36 +0000 (UTC)
Date:   Tue, 3 Dec 2019 15:36:35 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kexec@lists.infradead.org
Subject: Re: [RFC PATCH v5 1/3] printk-rb: new printk ringbuffer
 implementation (writer)
Message-ID: <20191203143635.cc6hh6bscr6kw4zw@pathway.suse.cz>
References: <20191128015235.12940-1-john.ogness@linutronix.de>
 <20191128015235.12940-2-john.ogness@linutronix.de>
 <20191202154841.qikvuvqt4btudxzg@pathway.suse.cz>
 <87fti1bipb.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fti1bipb.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-12-03 15:13:36, John Ogness wrote:
> On 2019-12-02, Petr Mladek <pmladek@suse.com> wrote:
> >> +/*
> >> + * Sanity checker for reserve size. The ringbuffer code assumes that a data
> >> + * block does not exceed the maximum possible size that could fit within the
> >> + * ringbuffer. This function provides that basic size check so that the
> >> + * assumption is safe.
> >> + */
> >> +static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
> >> +{
> >> +	struct prb_data_block *db = NULL;
> >> +
> >> +	/* Writers are not allowed to write data-less records. */
> >> +	if (size == 0)
> >> +		return false;
> >
> > I would personally let this decision to the API caller.
> >
> > The code actually have to support data-less records. They are used
> > when the descriptor is reserved but the data block can't get reserved.
> 
> Exactly. Data-less records are how the ringbuffer identifies that data
> has been lost. If users were allowed to store data-less records, that
> destinction is no longer possible (unless I created some extra field in
> the descriptor). Does it even make sense for printk to store data-less
> records explicitly?

From my POV, it does not make much sense.

> The current printk implementation silently ignores empty messages.

I am not able to find it. I only see that empty continuous framgments
are ignored in log_output(). Normal empty lines seems to be strored.

Well, I can't see any usecase for this. I think that we could ignore
all empty strings.


> > The above statement might create false feeling that it could not
> > happen later in the code. It might lead to bugs in writer code.
> 
> Then let me change the statement to describe that data-less records are
> used internally by the ringbuffer and cannot be explicitly created by
> writers.

Sounds godo to me.

> > Also reader API users might not expect to get a "valid" data-less
> > record.
> 
> Readers will never see them. The reader API implementation skips over
> data-less records.

Yeah. They will see bump in the seq number. We would need to
distinguish empty records and lost records as you wrote above.
It looks better to ignore empty records already during write.

Best Regards,
Petr
