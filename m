Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1864C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70D12082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JZs+5Deu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390113AbfFJVdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:33:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36416 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389760AbfFJVdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:33:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id d21so4157867plr.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 14:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=825Is8NE7RT8Jz0RpT7VVuP0UsDVOSwHLm6oF1wC/YU=;
        b=JZs+5DeutR1B/D3BdPr4D+n3NH1somXSgr0zmI6lWGlLMSblkHtowdJJ8SnJ/EyEaT
         vrFjXglj30BU2fmFW/XhemfiYhbvsDJD7e8e/bLPI/HCHW4EsSv7G1jT0FZqaMF0NSuS
         Gx4kpEr/qt1k8y3/DrU7IYsObBsYTcttNkmos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=825Is8NE7RT8Jz0RpT7VVuP0UsDVOSwHLm6oF1wC/YU=;
        b=duh027KUmg7GRPP3MAac51LR13hU/juIX7jTY0G6DWNSeVT4+H6Ef1w4k/0IxUHCOK
         /JuNvyzMDybAshVhSqZEWXFmoEVKNGsrZsH8ayMFZqjs8tI3S6Es9aJak9UX4aOl6G9k
         oI135na2SSOJ8SgQ23+3rVYu4VnCAmsqu1vsUbg8H0gJkgLa+jI2ZjRhbCNfUrLNjryz
         E9vza5IteISErJLgfEUbb/HCJAzhFUKEd0iIP2e7nx5R/tOv1Da94oJnEARuJwfUY7ju
         mDohtFJw3Lce4+Bb+IkBIcZ6aRJWr/NphEN+XMSAWgMHtN8CGhH/iBWYYKnQCM16TPUW
         95ZA==
X-Gm-Message-State: APjAAAW5hFA0SZXKbLGhV6rilDllaNvlmoNMBO0PYcgEUJbnPTNQgai/
        ZDvasyW51GNhyGJR0UbcA/+WLA==
X-Google-Smtp-Source: APXvYqw9TXY3olY6Pl/0Z1nz7YqPCYtLr1ZiA+NtCVd1DLzmoU/1gP95w+gvw/fnAiD4DrEKysAVHA==
X-Received: by 2002:a17:902:102c:: with SMTP id b41mr22976465pla.204.1560202386832;
        Mon, 10 Jun 2019 14:33:06 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id x14sm14944984pfq.158.2019.06.10.14.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 14:33:06 -0700 (PDT)
Date:   Mon, 10 Jun 2019 14:33:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Garnier <thgarnie@chromium.org>
Cc:     kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 04/12] x86: relocate_kernel - Adapt assembly for PIE
 support
Message-ID: <201906101433.0A1A27960@keescook>
References: <20190520231948.49693-1-thgarnie@chromium.org>
 <20190520231948.49693-5-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520231948.49693-5-thgarnie@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 04:19:29PM -0700, Thomas Garnier wrote:
> From: Thomas Garnier <thgarnie@google.com>
> 
> Change the assembly code to use only absolute references of symbols for the
> kernel to be PIE compatible.
> 
> Position Independent Executable (PIE) support will allow to extend the
> KASLR randomization range below 0xffffffff80000000.
> 
> Signed-off-by: Thomas Garnier <thgarnie@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/kernel/relocate_kernel_64.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 11eda21eb697..3320368b6ec9 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -208,7 +208,7 @@ identity_mapped:
>  	movq	%rax, %cr3
>  	lea	PAGE_SIZE(%r8), %rsp
>  	call	swap_pages
> -	movq	$virtual_mapped, %rax
> +	movabsq	$virtual_mapped, %rax
>  	pushq	%rax
>  	ret
>  
> -- 
> 2.21.0.1020.gf2820cf01a-goog
> 

-- 
Kees Cook
