Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC90C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DF1206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbfDBQe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:34:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:58501 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728741AbfDBQe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:34:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Apr 2019 09:34:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,301,1549958400"; 
   d="scan'208";a="160731305"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2019 09:34:26 -0700
Date:   Tue, 2 Apr 2019 09:34:26 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mitsuo Hayasaka <mitsuo.hayasaka.hu@hitachi.com>
Subject: Re: [patch 01/14] x86/irq/64: Limit IST stack overflow check to #DB
 stack
Message-ID: <20190402163426.GB29004@linux.intel.com>
References: <20190331214020.836098943@linutronix.de>
 <20190331215134.837052834@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190331215134.837052834@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 11:40:21PM +0200, Thomas Gleixner wrote:
> 37fe6a42b343 ("x86: Check stack overflow in detail") added a broad check
> for the full exception stack area, i.e. it considers the full exception
> stack are as valid.
        ^^^
        area

> 
> That's wrong in two aspects:
> 
>  1) It does not check the individual areas one by one
> 
>  2) #DF, NMI and #MCE are not enabling interrupts which means that a
>     regular device interrupt cannot happen in their context. In fact if a
>     device interrupt hits one of those IST stacks that's a bug because some
>     code path enabled interrupts while handling the exception.
> 
> Limit the check to the #DB stack and consider all other IST stacks as
> 'overflow' or invalid.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mitsuo Hayasaka <mitsuo.hayasaka.hu@hitachi.com>
> ---
>  arch/x86/kernel/irq_64.c |   19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> --- a/arch/x86/kernel/irq_64.c
> +++ b/arch/x86/kernel/irq_64.c
> @@ -26,9 +26,18 @@ int sysctl_panic_on_stackoverflow;
>  /*
>   * Probabilistic stack overflow check:
>   *
> - * Only check the stack in process context, because everything else
> - * runs on the big interrupt stacks. Checking reliably is too expensive,
> - * so we just check from interrupts.
> + * Regular device interrupts can enter on the following stacks:
> + *
> + * - User stack
> + *
> + * - Kernel task stack
> + *
> + * - Interrupt stack if a device driver reenables interrupt
> + *   which should only happen in really old drivers.
> + *
> + * - Debug IST stack
> + *
> + * All other contexts are invalid.
>   */
>  static inline void stack_overflow_check(struct pt_regs *regs)
>  {
> @@ -53,8 +62,8 @@ static inline void stack_overflow_check(
>  		return;
>  
>  	oist = this_cpu_ptr(&orig_ist);
> -	estack_top = (u64)oist->ist[0] - EXCEPTION_STKSZ + STACK_TOP_MARGIN;
> -	estack_bottom = (u64)oist->ist[N_EXCEPTION_STACKS - 1];
> +	estack_bottom = (u64)oist->ist[DEBUG_STACK];
> +	estack_top = estack_bottom - DEBUG_STKSZ + STACK_TOP_MARGIN;
>  	if (regs->sp >= estack_top && regs->sp <= estack_bottom)
>  		return;
>  
> 
> 
