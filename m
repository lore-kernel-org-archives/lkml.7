Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A03AECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 23:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5D321906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 23:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MYFX0Dt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfJAXjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 19:39:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41354 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729164AbfJAXjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 19:39:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7so9245790pfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 16:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Pc94ZK6cY3zLNK3o7GrOpgbo59DDKimz/DKEZZSuL6w=;
        b=MYFX0Dt6Eb0EkbBi3vof+VS7KKlSCB9r2ujuOvnXzjoUSco4oN+VIgr+azzKSctR2W
         I7KicndIj9UbzI6iFOYgeayTyMdol3MGzezhcm7q3JWT4zSn9szQRF9YA/uQ8Vn7j4Ha
         fcBLswVcOE8E5pPgVjULs1dIsJRpgxNqPj8mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Pc94ZK6cY3zLNK3o7GrOpgbo59DDKimz/DKEZZSuL6w=;
        b=fBvVUydNx8ZqSzpn0/GHKRNGDmOCx/sh17TJyXPMoZB3aY71O9HcpZiZlnCJKhA+Wc
         radriCQx+i/CvYckx0UMZ83VcJuXS1UfHoqdlc4vrHuMi4OcIRLVAS+mgpGi7NAuV0gb
         pikMFDOTGhfLjacpiHpJxtgRMumxlbsK3hUuzLVDOwtNcGvTWV5DotK+NHW9JKiOz/dC
         0XLg+daCGdlCx4mVodIm+eT7NYg3ZB4Jl1F7vsQ1nSb6q8kpEysnF6OMuuAbXh5cm9Hd
         ef33WjrHIY05qNyz4hpp8XaiazUNhn8LDBjPIvgeplFaZHwGLZAi5hYyGBbNqWx3EDO7
         HZ9A==
X-Gm-Message-State: APjAAAXTndI11SR9CWlRkiWYGDnK1/SwYnSkUJHeACHt9MW7Ec3I1OUH
        pFV076qqTihOhpqAesRPpK+FJg==
X-Google-Smtp-Source: APXvYqyjlBuS5lpXndlooYdCnCorpOwpddwVVjN6G6SAmpJhoD753SDnjog+NR1DsLVGmdvnTQCbyQ==
X-Received: by 2002:aa7:85d3:: with SMTP id z19mr1055743pfn.1.1569973183999;
        Tue, 01 Oct 2019 16:39:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v1sm23132769pfg.26.2019.10.01.16.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 16:39:43 -0700 (PDT)
Date:   Tue, 1 Oct 2019 16:39:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bill Metzenthen <billm@melbpc.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86: math-emu: check __copy_from_user result
Message-ID: <201910011638.F2F70EF@keescook>
References: <20191001142344.1274185-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191001142344.1274185-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 04:23:34PM +0200, Arnd Bergmann wrote:
> The new __must_check annotation on __copy_from_user successfully
> identified some code that has lacked the check since at least
> linux-2.1.73:
> 
> arch/x86/math-emu/reg_ld_str.c:88:2: error: ignoring return value of function declared with 'warn_unused_result' attribute [-Werror,-Wunused-result]
>         __copy_from_user(sti_ptr, s, 10);
>         ^~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~
> arch/x86/math-emu/reg_ld_str.c:1129:2: error: ignoring return value of function declared with 'warn_unused_result' attribute [-Werror,-Wunused-result]
>         __copy_from_user(register_base + offset, s, other);
>         ^~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/x86/math-emu/reg_ld_str.c:1131:3: error: ignoring return value of function declared with 'warn_unused_result' attribute [-Werror,-Wunused-result]
>                 __copy_from_user(register_base, s + other, offset);
>                 ^~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> In addition, the get_user/put_user helpers do not enforce a return value
> check, but actually still require one. These have been missing
> for even longer.
> 
> Change the internal wrappers around get_user/put_user to force
> a signal and add a corresponding wrapper around __copy_from_user
> to check all such cases.
> 
> Fixes: 257e458057e5 ("Import 2.1.73")
> Fixes: 9dd819a15162 ("uaccess: add missing __must_check attributes")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

Notes below...

> ---
>  arch/x86/math-emu/fpu_system.h | 6 ++++--
>  arch/x86/math-emu/reg_ld_str.c | 6 +++---
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/math-emu/fpu_system.h b/arch/x86/math-emu/fpu_system.h
> index f98a0c956764..9b41391867dc 100644
> --- a/arch/x86/math-emu/fpu_system.h
> +++ b/arch/x86/math-emu/fpu_system.h
> @@ -107,6 +107,8 @@ static inline bool seg_writable(struct desc_struct *d)
>  #define FPU_access_ok(y,z)	if ( !access_ok(y,z) ) \
>  				math_abort(FPU_info,SIGSEGV)
>  #define FPU_abort		math_abort(FPU_info, SIGSEGV)
> +#define FPU_copy_from_user(to, from, n)	\
> +		do { if (copy_from_user(to, from, n)) FPU_abort; } while (0)
>  
>  #undef FPU_IGNORE_CODE_SEGV
>  #ifdef FPU_IGNORE_CODE_SEGV
> @@ -122,7 +124,7 @@ static inline bool seg_writable(struct desc_struct *d)
>  #define	FPU_code_access_ok(z) FPU_access_ok((void __user *)FPU_EIP,z)
>  #endif
>  
> -#define FPU_get_user(x,y)       get_user((x),(y))
> -#define FPU_put_user(x,y)       put_user((x),(y))
> +#define FPU_get_user(x,y) do { if (get_user((x),(y))) FPU_abort; } while (0)
> +#define FPU_put_user(x,y) do { if (put_user((x),(y))) FPU_abort; } while (0)
>  
>  #endif
> diff --git a/arch/x86/math-emu/reg_ld_str.c b/arch/x86/math-emu/reg_ld_str.c
> index f3779743d15e..fe6246ff9887 100644
> --- a/arch/x86/math-emu/reg_ld_str.c
> +++ b/arch/x86/math-emu/reg_ld_str.c
> @@ -85,7 +85,7 @@ int FPU_load_extended(long double __user *s, int stnr)
>  
>  	RE_ENTRANT_CHECK_OFF;
>  	FPU_access_ok(s, 10);
> -	__copy_from_user(sti_ptr, s, 10);
> +	FPU_copy_from_user(sti_ptr, s, 10);

These access_ok() checks seem redundant everywhere in this file (after
your switch from __copy* to copy*. I mean, I guess, just leave them, but
*shrug*

-Kees

>  	RE_ENTRANT_CHECK_ON;
>  
>  	return FPU_tagof(sti_ptr);
> @@ -1126,9 +1126,9 @@ void frstor(fpu_addr_modes addr_modes, u_char __user *data_address)
>  	/* Copy all registers in stack order. */
>  	RE_ENTRANT_CHECK_OFF;
>  	FPU_access_ok(s, 80);
> -	__copy_from_user(register_base + offset, s, other);
> +	FPU_copy_from_user(register_base + offset, s, other);
>  	if (offset)
> -		__copy_from_user(register_base, s + other, offset);
> +		FPU_copy_from_user(register_base, s + other, offset);
>  	RE_ENTRANT_CHECK_ON;
>  
>  	for (i = 0; i < 8; i++) {
> -- 
> 2.20.0
> 

-- 
Kees Cook
