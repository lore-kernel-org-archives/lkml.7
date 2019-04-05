Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10451C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D451F21738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbfDEQh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:37:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:58889 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730565AbfDEQh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:37:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2019 09:37:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,313,1549958400"; 
   d="scan'208";a="161773812"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga001.fm.intel.com with ESMTP; 05 Apr 2019 09:37:27 -0700
Date:   Fri, 5 Apr 2019 09:37:27 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [patch V2 03/29] x86/irq/64: Remove a hardcoded irq_stack_union
 access
Message-ID: <20190405163727.GB19359@linux.intel.com>
References: <20190405150658.237064784@linutronix.de>
 <20190405150928.684985548@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405150928.684985548@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 05:07:01PM +0200, Thomas Gleixner wrote:
> From: Andy Lutomirski <luto@kernel.org>
> 
> stack_overflow_check() is using both irq_stack_ptr and irq_stack_union to
> find the IRQ stack. That's going to break when vmapped irq stacks are
> introduced.
> 
> Change it to just use irq_stack_ptr.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
>  arch/x86/kernel/irq_64.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- a/arch/x86/kernel/irq_64.c
> +++ b/arch/x86/kernel/irq_64.c
> @@ -55,9 +55,8 @@ static inline void stack_overflow_check(
>  	    regs->sp <= curbase + THREAD_SIZE)
>  		return;
>  
> -	irq_stack_top = (u64)this_cpu_ptr(irq_stack_union.irq_stack) +
> -			STACK_TOP_MARGIN;
>  	irq_stack_bottom = (u64)__this_cpu_read(irq_stack_ptr);
> +	irq_stack_top = irq_stack_bottom - IRQ_STACK_SIZE + STACK_TOP_MARGIN;

Not introduced in this patch, but the names for top and bottom are flipped,
both for irq_stack and estack.  STACK_TOP_MARGIN should also be
STACK_BOTTOM_MARGIN.  The actual checks are functionally correct, but holy
hell does it make reading the code confusing, and the WARN prints backwards
information.

E.g.:

  swapper/10 has overflown the kernel stack

    cur:ffffc900000bc000,sp:ffff888277b03f78
    irq stk top-bottom:ffff888277b00080-ffff888277b04000
    exception stk top-bottom:fffffe00001b4080-fffffe00001b9000


Printing out top-bottom for "cur" would also probably be helpful.

Let me know if you'd like me to send a patch, or if you'll fold a change
into this series.


For this patch,

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>

>  	if (regs->sp >= irq_stack_top && regs->sp <= irq_stack_bottom)
>  		return;
>  
> 
> 
