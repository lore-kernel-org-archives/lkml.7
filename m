Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D58C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D835E217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 02:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfDKCzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 22:55:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfDKCzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 22:55:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 042E831676AD;
        Thu, 11 Apr 2019 02:55:13 +0000 (UTC)
Received: from treble (ovpn-120-231.rdu2.redhat.com [10.10.120.231])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 067C85D704;
        Thu, 11 Apr 2019 02:55:10 +0000 (UTC)
Date:   Wed, 10 Apr 2019 21:55:09 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
Subject: Re: [RFC patch 25/41] mm/kasan: Simplify stacktrace handling
Message-ID: <20190411025509.cslu3nq27g7ww6qu@treble>
References: <20190410102754.387743324@linutronix.de>
 <20190410103645.862294081@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190410103645.862294081@linutronix.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 11 Apr 2019 02:55:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 12:28:19PM +0200, Thomas Gleixner wrote:
> Replace the indirection through struct stack_trace by using the storage
> array based interfaces.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: kasan-dev@googlegroups.com
> Cc: linux-mm@kvack.org
> ---
>  mm/kasan/common.c |   30 ++++++++++++------------------
>  mm/kasan/report.c |    7 ++++---
>  2 files changed, 16 insertions(+), 21 deletions(-)
> 
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -48,34 +48,28 @@ static inline int in_irqentry_text(unsig
>  		 ptr < (unsigned long)&__softirqentry_text_end);
>  }
>  
> -static inline void filter_irq_stacks(struct stack_trace *trace)
> +static inline unsigned int filter_irq_stacks(unsigned long *entries,
> +					     unsigned int nr_entries)
>  {
> -	int i;
> +	unsigned int i;
>  
> -	if (!trace->nr_entries)
> -		return;
> -	for (i = 0; i < trace->nr_entries; i++)
> -		if (in_irqentry_text(trace->entries[i])) {
> +	for (i = 0; i < nr_entries; i++) {
> +		if (in_irqentry_text(entries[i])) {
>  			/* Include the irqentry function into the stack. */
> -			trace->nr_entries = i + 1;
> -			break;
> +			return i + 1;

Isn't this an off-by-one error if "i" points to the last entry of the
array?

-- 
Josh
