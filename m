Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172EFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2EFF20850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWFDiEVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfCTTLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:11:02 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44364 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfCTTLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:11:01 -0400
Received: by mail-ed1-f67.google.com with SMTP id x10so2945772edh.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 12:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1Aow+/zog/x41YcKptemBSnJx4nWAT5jkKKVh51P6Xs=;
        b=CWFDiEVIPEbcNZqXNsemqwUCqTjnyoE1YS2XruzAvvQoKxpHlD5wKb662B4NEhpg67
         zXjchDaby3bXPS+fD/jUmCIPo8F0VEvL3VJdd2n7KtCC5rDuW0t0DFstJWOmgKKj6BFD
         a2Xf9xVugxeMtQYWA7bGqPELRMEhmSGCsEB5BDll6qm91nKxIOB1wxdJl71FjSBh4hcC
         KPoqyczgNkS8hhYYFkAdii/BDEbOzf9Q17oFkswatv+0V/4WiQB6RjhuclMNsGlhwAkC
         eXvsaknN4Etrt+pbSd+cTbPQrnq4Gs3S2EOR4I3TfTDn8Ey/3x+PMsZsE0GqC8Ex7YTn
         efjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1Aow+/zog/x41YcKptemBSnJx4nWAT5jkKKVh51P6Xs=;
        b=WlVIcK+eHywek+pmXi6IcQpMxNVhCxedeuw0fY4GHLi8QmwctkNvkc+fqPsW2bh6/F
         nuTf7ilHmtUyAdBRIQOJ0v45sRg7Uzvupo4TMZ4X0NoG6HEVkcuu3flVzLbUbbNF7c5S
         LE+DRcDgGeogNraYPy3QqfCBeG31dY9vAeIJcYsp8A7mUSVaAho9Br3TOkxpyaZM74ZQ
         zzPZnYuZ9iPDnMkRDCEMl48JfmYsFnjOs3vUhWh/9/Nsu5NOfGnNLlC89Prf8Q4/t59H
         FH1atInIWgMy9v2eKXBQxxKdv9w+0mbKrzCfjM/iugaqL6nClc8w8GXfrsyhucp0RVMr
         8k9w==
X-Gm-Message-State: APjAAAWO/CmjQmU/N5o5H3KW23f6k2Fbprqcz8LfYukouTHHVrzoLOeN
        R5LdCr3NNSfLRsh7lx7qVmg=
X-Google-Smtp-Source: APXvYqxko4BIqopk8XrBCbzlHLCmv15oLRlCWKnyjz1rYh/6KyHoboJKaA9BPOP9kkEc5RFzW/dWNA==
X-Received: by 2002:a50:a387:: with SMTP id s7mr18532667edb.24.1553109060111;
        Wed, 20 Mar 2019 12:11:00 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id e45sm317083edd.3.2019.03.20.12.10.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 20 Mar 2019 12:10:59 -0700 (PDT)
Date:   Wed, 20 Mar 2019 12:10:57 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] x86/hw_breakpoints: Return -EINVAL in default case in
 hw_breakpoint_arch_parse
Message-ID: <20190320191057.GD28744@archlinux-ryzen>
References: <20190307212756.4648-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307212756.4648-1-natechancellor@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 02:27:56PM -0700, Nathan Chancellor wrote:
> When building with -Wsometimes-uninitialized, Clang warns:
> 
> arch/x86/kernel/hw_breakpoint.c:355:2: warning: variable 'align' is used
> uninitialized whenever switch default is taken
> [-Wsometimes-uninitialized]
> 
> It's not wrong but we can see that arch_build_bp_info will only ever
> initialize hw->len to one of the specified switch cases. We can easily
> silence Clang by just returning -EINVAL in the default case so that we
> can never use align without initializing it first.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/392
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  arch/x86/kernel/hw_breakpoint.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> index ff9bfd40429e..d73083021002 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c
> @@ -354,6 +354,7 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
>  #endif
>  	default:
>  		WARN_ON_ONCE(1);
> +		return -EINVAL;
>  	}
>  
>  	/*
> -- 
> 2.21.0
> 

Gentle ping (if there was a response to this, I didn't receive it). I
know I sent it in the middle of a merge window so I get if it slipped
through the cracks.

Thanks,
Nathan
