Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3555CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B92206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571764954;
	bh=RoR3fcocZoMB+jVU9MHhimMcDXaQJ50Rbho6yQQSC7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Wft7p8Q88AR7Ax1xIcew6cO6NlcOr97SilaSzVNSn75I+wEr/bxQnAxNu49ub+zVo
	 kueco9mrtlOCOLWF0eFM0ss6eHB642PFI1LbcSpkY5Ch/k8tpov9Ry6AeyTnRy6O6K
	 Ngc1/CWzZ39YZK0g9DImbW6rg+gk+2/c56qWzdr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbfJVRWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 13:22:33 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:42247 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731730AbfJVRWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 13:22:33 -0400
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iMxrD-0002o8-Lr; Tue, 22 Oct 2019 19:22:07 +0200
Date:   Tue, 22 Oct 2019 18:22:06 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Laura Abbott <labbott@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 03/18] arm64: kvm: stop treating register x18 as caller
 save
Message-ID: <20191022182206.0d8b2301@why>
In-Reply-To: <20191018161033.261971-4-samitolvanen@google.com>
References: <20191018161033.261971-1-samitolvanen@google.com>
        <20191018161033.261971-4-samitolvanen@google.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: samitolvanen@google.com, will@kernel.org, catalin.marinas@arm.com, rostedt@goodmis.org, ard.biesheuvel@linaro.org, mark.rutland@arm.com, keescook@chromium.org, kernel-hardening@lists.openwall.com, ndesaulniers@google.com, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, labbott@redhat.com, Dave.Martin@arm.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019 09:10:18 -0700
Sami Tolvanen <samitolvanen@google.com> wrote:

> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> In preparation of using x18 as a task struct pointer register when
> running in the kernel, stop treating it as caller save in the KVM
> guest entry/exit code. Currently, the code assumes there is no need
> to preserve it for the host, given that it would have been assumed
> clobbered anyway by the function call to __guest_enter(). Instead,
> preserve its value and restore it upon return.
> 
> Link: https://patchwork.kernel.org/patch/9836891/
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/kvm/hyp/entry.S | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
> index e5cc8d66bf53..20bd9a20ea27 100644
> --- a/arch/arm64/kvm/hyp/entry.S
> +++ b/arch/arm64/kvm/hyp/entry.S
> @@ -23,6 +23,7 @@
>  	.pushsection	.hyp.text, "ax"
>  
>  .macro save_callee_saved_regs ctxt
> +	str	x18,      [\ctxt, #CPU_XREG_OFFSET(18)]
>  	stp	x19, x20, [\ctxt, #CPU_XREG_OFFSET(19)]
>  	stp	x21, x22, [\ctxt, #CPU_XREG_OFFSET(21)]
>  	stp	x23, x24, [\ctxt, #CPU_XREG_OFFSET(23)]
> @@ -38,6 +39,7 @@
>  	ldp	x25, x26, [\ctxt, #CPU_XREG_OFFSET(25)]
>  	ldp	x27, x28, [\ctxt, #CPU_XREG_OFFSET(27)]
>  	ldp	x29, lr,  [\ctxt, #CPU_XREG_OFFSET(29)]
> +	ldr	x18,      [\ctxt, #CPU_XREG_OFFSET(18)]

There is now an assumption that ctxt is x18 (otherwise why would it be
out of order?). Please add a comment to that effect.

>  .endm
>  
>  /*
> @@ -87,12 +89,9 @@ alternative_else_nop_endif
>  	ldp	x14, x15, [x18, #CPU_XREG_OFFSET(14)]
>  	ldp	x16, x17, [x18, #CPU_XREG_OFFSET(16)]
>  
> -	// Restore guest regs x19-x29, lr
> +	// Restore guest regs x18-x29, lr
>  	restore_callee_saved_regs x18

Or you could elect another register such as x29 as the base, and keep
the above in a reasonable order.

>  
> -	// Restore guest reg x18
> -	ldr	x18,      [x18, #CPU_XREG_OFFSET(18)]
> -
>  	// Do not touch any register after this!
>  	eret
>  	sb
> @@ -114,7 +113,7 @@ ENTRY(__guest_exit)
>  	// Retrieve the guest regs x0-x1 from the stack
>  	ldp	x2, x3, [sp], #16	// x0, x1
>  
> -	// Store the guest regs x0-x1 and x4-x18
> +	// Store the guest regs x0-x1 and x4-x17
>  	stp	x2, x3,   [x1, #CPU_XREG_OFFSET(0)]
>  	stp	x4, x5,   [x1, #CPU_XREG_OFFSET(4)]
>  	stp	x6, x7,   [x1, #CPU_XREG_OFFSET(6)]
> @@ -123,9 +122,8 @@ ENTRY(__guest_exit)
>  	stp	x12, x13, [x1, #CPU_XREG_OFFSET(12)]
>  	stp	x14, x15, [x1, #CPU_XREG_OFFSET(14)]
>  	stp	x16, x17, [x1, #CPU_XREG_OFFSET(16)]
> -	str	x18,      [x1, #CPU_XREG_OFFSET(18)]
>  
> -	// Store the guest regs x19-x29, lr
> +	// Store the guest regs x18-x29, lr
>  	save_callee_saved_regs x1
>  
>  	get_host_ctxt	x2, x3

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
