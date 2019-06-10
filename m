Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A45C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 23:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A65F20859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 23:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S5twQrqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390961AbfFJXwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 19:52:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35217 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390932AbfFJXwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 19:52:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id s27so5863615pgl.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 16:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=//UIhUwMjcLEhM8jw0JdGfPxbu/l+D9BdzjQBHxa+3I=;
        b=S5twQrqcfMlYQ7HpJx67BBgHCAXoiezTWufgTwmq7vEJIDmSmgxiNFaSqrzgEZLYBb
         tiZ+uAc3MEee8GOKVN3q66fZBuujaKmt6U4ZDFTEE92khx921OCBx/0XA3OLN2i34diO
         jJwwMQZ/GLIYF6fVKnWmKER+HFF1f0apsT4/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=//UIhUwMjcLEhM8jw0JdGfPxbu/l+D9BdzjQBHxa+3I=;
        b=hWtq70ko3KIobait4P7IQ/1iMfnymc8RuOMYnREu0xOfiH/UH6E6KpD/cL6zeUqUGS
         iid2vvpc1Uivkw/qDga20GN1z7CA+UalcVoFKa0Vd7W0+0UKRHTO3Bbdr1df5zCEZ4TC
         +mdjk/gFopLOoHespi2+7WeSd2FOq43ez/qMXNnD2d0X++MNO8+BjEdN9Xi8U508a+UK
         mBujLXV3I7eUqTivi2zrxa4/Gdlvs15ZALoBtzaGGzMkYg21ntndMbAy3MTurEmx2QZ2
         uWSG5KIxtkyzuMDCWmnNgGSOzsZ8Da9vS+hi8ffF6EncSfUM+w0TafYAM2UmjYd+Rqkk
         PcZg==
X-Gm-Message-State: APjAAAVNyx+/PHDCuN5jGudBLvii0O7DO7tmu7JvzYModiZJ2voTTkuh
        mXypIR0ik0cCsjP9z7GyDvvMaA==
X-Google-Smtp-Source: APXvYqx/uFQL581YeJrYZ1Czs+Zxdcfgf1YQbiKV68dE70gZNUeve1m6AmJretOfUB9S5Ieus0eafg==
X-Received: by 2002:a63:a056:: with SMTP id u22mr17603182pgn.318.1560210754118;
        Mon, 10 Jun 2019 16:52:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 144sm18161980pfy.54.2019.06.10.16.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 16:52:33 -0700 (PDT)
Date:   Mon, 10 Jun 2019 16:52:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Garnier <thgarnie@chromium.org>
Cc:     kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        Thomas Garnier <thgarnie@google.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 10/12] x86/power/64: Adapt assembly for PIE support
Message-ID: <201906101652.94483CD@keescook>
References: <20190520231948.49693-1-thgarnie@chromium.org>
 <20190520231948.49693-11-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520231948.49693-11-thgarnie@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 04:19:35PM -0700, Thomas Garnier wrote:
> From: Thomas Garnier <thgarnie@google.com>
> 
> Change the assembly code to use only relative references of symbols for the
> kernel to be PIE compatible.
> 
> Position Independent Executable (PIE) support will allow to extend the
> KASLR randomization range below 0xffffffff80000000.
> 
> Signed-off-by: Thomas Garnier <thgarnie@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Acked-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  arch/x86/power/hibernate_asm_64.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
> index 3008baa2fa95..9ed980efef72 100644
> --- a/arch/x86/power/hibernate_asm_64.S
> +++ b/arch/x86/power/hibernate_asm_64.S
> @@ -24,7 +24,7 @@
>  #include <asm/frame.h>
>  
>  ENTRY(swsusp_arch_suspend)
> -	movq	$saved_context, %rax
> +	leaq	saved_context(%rip), %rax
>  	movq	%rsp, pt_regs_sp(%rax)
>  	movq	%rbp, pt_regs_bp(%rax)
>  	movq	%rsi, pt_regs_si(%rax)
> @@ -115,7 +115,7 @@ ENTRY(restore_registers)
>  	movq	%rax, %cr4;  # turn PGE back on
>  
>  	/* We don't restore %rax, it must be 0 anyway */
> -	movq	$saved_context, %rax
> +	leaq	saved_context(%rip), %rax
>  	movq	pt_regs_sp(%rax), %rsp
>  	movq	pt_regs_bp(%rax), %rbp
>  	movq	pt_regs_si(%rax), %rsi
> -- 
> 2.21.0.1020.gf2820cf01a-goog
> 

-- 
Kees Cook
