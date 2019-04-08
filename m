Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70539C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4024420880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfDHRGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:06:04 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53469 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729151AbfDHRGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 13:06:02 -0400
Received: from p5492ee6e.dip0.t-ipconnect.de ([84.146.238.110] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hDXiW-0003bn-Sm; Mon, 08 Apr 2019 19:05:57 +0200
Date:   Mon, 8 Apr 2019 19:05:56 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 24/27] x86/fpu: Add a fastpath to __fpu__restore_sig()
In-Reply-To: <20190403164156.19645-25-bigeasy@linutronix.de>
Message-ID: <alpine.DEB.2.21.1904081905170.2352@nanos.tec.linutronix.de>
References: <20190403164156.19645-1-bigeasy@linutronix.de> <20190403164156.19645-25-bigeasy@linutronix.de>
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

On Wed, 3 Apr 2019, Sebastian Andrzej Siewior wrote:

> The previous commits refactor the restoration of the FPU registers so
> that they can be loaded from in-kernel memory. This overhead can be
> avoided if the load can be performed without a pagefault.
> 
> Attempt to restore FPU registers by invoking
> copy_user_to_fpregs_zeroing(). If it fails try the slowpath which can handle
> pagefaults.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/kernel/fpu/signal.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index a5b086ec426a5..f20e1d1fffa29 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -242,10 +242,10 @@ sanitize_restored_xstate(union fpregs_state *state,
>  /*
>   * Restore the extended state if present. Otherwise, restore the FP/SSE state.
>   */
> -static inline int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
> +static int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
>  {
>  	if (use_xsave()) {
> -		if ((unsigned long)buf % 64 || fx_only) {
> +		if (fx_only) {

This change is weird and not mentioned in the changelog....

>  			u64 init_bv = xfeatures_mask & ~XFEATURE_MASK_FPSSE;
>  			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
>  			return copy_user_to_fxregs(buf);
> @@ -327,7 +327,19 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
>  		if (ret)
>  			goto err_out;
>  		envp = &env;
> +	} else {
> +		fpregs_lock();
> +		pagefault_disable();
> +		ret = copy_user_to_fpregs_zeroing(buf_fx, xfeatures, fx_only);
> +		pagefault_enable();
> +		if (!ret) {
> +			fpregs_mark_activate();
> +			fpregs_unlock();
> +			return 0;
> +		}
> +		fpregs_unlock();
>  	}
> +
>  	if (use_xsave() && !fx_only) {
>  		u64 init_bv = xfeatures_mask & ~xfeatures;
>  
> -- 
> 2.20.1
> 
> 
