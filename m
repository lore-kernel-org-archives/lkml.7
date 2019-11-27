Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC48C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917732068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ln3XC+Nf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfK0OIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 09:08:07 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50186 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfK0OIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 09:08:07 -0500
Received: from zn.tnic (p200300EC2F0F3700E96120E3EC041D57.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:3700:e961:20e3:ec04:1d57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 035F61EC0CEA;
        Wed, 27 Nov 2019 15:08:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1574863682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5j8VPYCmYHx3fh+OtrTcC93rJVI3yBgKJ8qLj1fRrSs=;
        b=ln3XC+NfbK8QFPfrdEV18IAvxwZJbr0P4+Kcb1FRSLOm+zvBq7s5CxjAT9lcyXlGuR8a8b
        QLYDVej6L5k+mB9Bf/K+QMBPMmqckk/rLXCGWWSyFa6FCEfw/qkWYg5QS/iqwXnbJVm2bz
        gNsMwrG0Pt1lD1xtk8oygsZLUg4r4Y0=
Date:   Wed, 27 Nov 2019 15:07:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Barret Rhoden <brho@google.com>,
        Josh Bleecher Snyder <josharian@gmail.com>,
        "Rik van Riel\"" <riel@surriel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, ian@airs.com
Subject: Re: [PATCH] x86/fpu: Don't cache access to fpu_fpregs_owner_ctx
Message-ID: <20191127140754.GB3812@zn.tnic>
References: <c87e93c3-5f30-f242-74b7-6c7ccc91158a@google.com>
 <20191126202026.csrmjre6vn2nxq7c@linutronix.de>
 <e4d6406b-0d47-5cc5-f3a8-6d14bd90760b@google.com>
 <20191127124243.u74osvlkhcmsskng@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191127124243.u74osvlkhcmsskng@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 01:42:43PM +0100, Sebastian Andrzej Siewior wrote:
> The state/owner of FPU is saved fpu_fpregs_owner_ctx by pointing to the
				 ^
				 to

> context that is currently loaded. It never changed during the life time
> of a task and remained stable/constant.
> 
> Since we deferred loading the FPU registers on return to userland, the

Drop those "we"s :)

> content of fpu_fpregs_owner_ctx may change during preemption and must
> not be cached.
> This went unnoticed for some time and was now noticed, in particular
> gcc-9 is able to cache that load in copy_fpstate_to_sigframe() and reuse
> it in the retry loop:
> 
>   copy_fpstate_to_sigframe()
>     load fpu_fpregs_owner_ctx and save on stack
>     fpregs_lock()
>     copy_fpregs_to_sigframe() /* failed */
>     fpregs_unlock()
>          *** PREEMPTION, another uses FPU, changes fpu_fpregs_owner_ctx ***
> 
>     fault_in_pages_writeable() /* succeed, retry */
> 
>     fpregs_lock()
> 	__fpregs_load_activate()
> 	  fpregs_state_valid() /* uses fpu_fpregs_owner_ctx from stack */
>     copy_fpregs_to_sigframe() /* succeeds, random FPU content */
> 
> This is a comparison of the assembly of gcc-9, without vs with this
> patch:
> 
> | # arch/x86/kernel/fpu/signal.c:173:      if (!access_ok(buf, size))
> |        cmpq    %rdx, %rax      # tmp183, _4
> |        jb      .L190   #,
> |-# arch/x86/include/asm/fpu/internal.h:512:       return fpu == this_cpu_read_stable(fpu_fpregs_owner_ctx) && cpu == fpu->last_cpu;
> |-#APP
> |-# 512 "arch/x86/include/asm/fpu/internal.h" 1
> |-       movq %gs:fpu_fpregs_owner_ctx,%rax      #, pfo_ret__
> |-# 0 "" 2
> |-#NO_APP
> |-       movq    %rax, -88(%rbp) # pfo_ret__, %sfp
> …
> |-# arch/x86/include/asm/fpu/internal.h:512:       return fpu == this_cpu_read_stable(fpu_fpregs_owner_ctx) && cpu == fpu->last_cpu;
> |-       movq    -88(%rbp), %rcx # %sfp, pfo_ret__
> |-       cmpq    %rcx, -64(%rbp) # pfo_ret__, %sfp
> |+# arch/x86/include/asm/fpu/internal.h:512:       return fpu == this_cpu_read(fpu_fpregs_owner_ctx) && cpu == fpu->last_cpu;
> |+#APP
> |+# 512 "arch/x86/include/asm/fpu/internal.h" 1
> |+       movq %gs:fpu_fpregs_owner_ctx(%rip),%rax        # fpu_fpregs_owner_ctx, pfo_ret__
> |+# 0 "" 2
> |+# arch/x86/include/asm/fpu/internal.h:512:       return fpu == this_cpu_read(fpu_fpregs_owner_ctx) && cpu == fpu->last_cpu;
> |+#NO_APP
> |+       cmpq    %rax, -64(%rbp) # pfo_ret__, %sfp
> 
> Use this_cpu_read() instead this_cpu_read_stable() to avoid caching of
> fpu_fpregs_owner_ctx during preemption points.
> 
> Fixes: 5f409e20b7945 ("x86/fpu: Defer FPU state load until return to userspace")

Or

a352a3b7b792 ("x86/fpu: Prepare copy_fpstate_to_sigframe() for TIF_NEED_FPU_LOAD")

maybe, which adds the fpregs_unlock() ?

> ---
> 
> There is no Sign-off by here. Could this please be verified by the
> reporter?

Not the reporter, but I just tested it successfully too:

Tested-by: Borislav Petkov <bp@suse.de>

> Also I would like to add
> 	Debugged-by: Ian Lance Taylor

Yes, pls. CCed.

> 
> but I lack the complete address also I'm not sure if he wants to.
> Also please send a Reported-by line since I'm not sure who started this.
> 
>  arch/x86/include/asm/fpu/internal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> index 4c95c365058aa..44c48e34d7994 100644
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -509,7 +509,7 @@ static inline void __fpu_invalidate_fpregs_state(struct fpu *fpu)
>  
>  static inline int fpregs_state_valid(struct fpu *fpu, unsigned int cpu)
>  {
> -	return fpu == this_cpu_read_stable(fpu_fpregs_owner_ctx) && cpu == fpu->last_cpu;
> +	return fpu == this_cpu_read(fpu_fpregs_owner_ctx) && cpu == fpu->last_cpu;
> }

And to add one more data point from IRC: this is also documented:

/*
 * this_cpu_read() makes gcc load the percpu variable every time it is
 * accessed while this_cpu_read_stable() allows the value to be cached.
							^^^^^^^^^^^^^^^

 * this_cpu_read_stable() is more efficient and can be used if its value
 * is guaranteed to be valid across cpus.  The current users include
 * get_current() and get_thread_info() both of which are actually
 * per-thread variables implemented as per-cpu variables and thus
 * stable for the duration of the respective task.
 */
#define this_cpu_read_stable(var)       percpu_stable_op("mov", var)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
