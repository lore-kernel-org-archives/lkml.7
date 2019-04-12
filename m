Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2C1C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8A62084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="KMMZhUiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfDLOgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:36:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39084 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbfDLOgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:36:24 -0400
Received: from zn.tnic (p200300EC2F08840068A43035F0D96009.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:8400:68a4:3035:f0d9:6009])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 737471EC082D;
        Fri, 12 Apr 2019 16:36:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555079782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=l24fn+1yQceb+jWMGCoOZipr+Wqn65+fBYIcCZksigY=;
        b=KMMZhUiOmesrTXlc3qTgOMEUbdsZczZjq1Kn8SziLt5MqbKI/SFfFIkRLJmIlqeqG/DQzN
        QlYNH8E5HjQBsLacT1KZA7ekGU4pwuPu5S14/1Jb4LaiHb/mOnnRaAGBYWWC04Pp5NTEcx
        jSpn0PRVhk5Z4ahWQd8DN+JCrFs5ZXE=
Date:   Fri, 12 Apr 2019 16:36:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 23/27] x86/fpu: Defer FPU state load until return to
 userspace
Message-ID: <20190412143615.GE19808@zn.tnic>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
 <20190403164156.19645-24-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190403164156.19645-24-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 06:41:52PM +0200, Sebastian Andrzej Siewior wrote:
> @@ -226,10 +236,9 @@ static void fpu__initialize(struct fpu *fpu)
>  {
>  	WARN_ON_FPU(fpu != &current->thread.fpu);
>  
> +	set_thread_flag(TIF_NEED_FPU_LOAD);
>  	fpstate_init(&fpu->state);
>  	trace_x86_fpu_init_state(fpu);
> -
> -	trace_x86_fpu_activate_state(fpu);

That is called nowhere after this patch.

Shouldn't it be called below, before fpregs_activate() because
fpregs_activate() does trace_x86_fpu_regs_activated()?

>  /*
> @@ -308,6 +317,8 @@ void fpu__drop(struct fpu *fpu)
>   */
>  static inline void copy_init_fpstate_to_fpregs(void)
>  {
> +	fpregs_lock();
> +
>  	if (use_xsave())
>  		copy_kernel_to_xregs(&init_fpstate.xsave, -1);
>  	else if (static_cpu_has(X86_FEATURE_FXSR))
> @@ -317,6 +328,9 @@ static inline void copy_init_fpstate_to_fpregs(void)
>  
>  	if (boot_cpu_has(X86_FEATURE_OSPKE))
>  		copy_init_pkru_to_fpregs();
> +
> +	fpregs_mark_activate();
> +	fpregs_unlock();
>  }
>  
>  /*
> @@ -339,6 +353,45 @@ void fpu__clear(struct fpu *fpu)
>  		copy_init_fpstate_to_fpregs();
>  }
>  
> +/*
> + * Load FPU context before returning to userspace.
> + */
> +void switch_fpu_return(void)
> +{
> +	if (!static_cpu_has(X86_FEATURE_FPU))
> +		return;
> +
> +	__fpregs_load_activate();
> +}
> +EXPORT_SYMBOL_GPL(switch_fpu_return);
> +
> +#ifdef CONFIG_X86_DEBUG_FPU
> +/*
> + * If current FPU state according to its tracking (loaded FPU ctx on this CPU)
> + * is not valid then we must have TIF_NEED_FPU_LOAD set so the context is loaded on
> + * return to userland.
> + */
> +void fpregs_assert_state_consistent(void)
> +{
> +       struct fpu *fpu = &current->thread.fpu;
> +
> +       if (test_thread_flag(TIF_NEED_FPU_LOAD))
> +               return;
> +       WARN_ON_FPU(!fpregs_state_valid(fpu, smp_processor_id()));
> +}
> +EXPORT_SYMBOL_GPL(fpregs_assert_state_consistent);
> +#endif
> +
> +void fpregs_mark_activate(void)
> +{
> +	struct fpu *fpu = &current->thread.fpu;
> +

<--- here?

> +	fpregs_activate(fpu);
> +	fpu->last_cpu = smp_processor_id();
> +	clear_thread_flag(TIF_NEED_FPU_LOAD);
> +}
> +EXPORT_SYMBOL_GPL(fpregs_mark_activate);

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
