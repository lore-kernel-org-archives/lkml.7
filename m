Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDAFC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563D220830
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMeK5+uF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbfDBH5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:57:31 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36964 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbfDBH5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:57:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id v21so10753667edq.4;
        Tue, 02 Apr 2019 00:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PDzEI0LQqgCaaBXpu0DLpU1NfxthO6DRHjU6wR4TtN0=;
        b=sMeK5+uFBAH4RgqVbDkmOZkOjjEvvYDjvo6BZgUeNLC8AVBVNs9svJnjFgZ/fgk7aK
         mGstoTJOLVjJeouinwulk/oiYTjYdNuwEitHx9gwNX3ItIbuPCr+hcYdY07i5/xze8au
         3UzPwFr0NEwWWREle1fgCm1SpkBsN3odBfNHUmsMQgfftdWmXZpP9BZ5evdhb1/Ktd0H
         bSU9L+WaOhnNqGA83F7ohiKCg8YOegzkXWpywsB8ZRrLWqTH70eXVD0Fq0yq8GGOn665
         Q9WuZQZtkgITBP0U1VJssXkceV5o3IoJPV/kD22shbZzX3hILD/MuBsKfj7+ApP/LPcf
         xqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PDzEI0LQqgCaaBXpu0DLpU1NfxthO6DRHjU6wR4TtN0=;
        b=kLRz9Vb3CY1CxipJTbQBdEgl4w7aJThJnLWou8ztFirN4sw0JP+7RpPVVLNJToCBQ+
         VNc2DqfDbGaZBB9AAQQPDrAQvILNEsLO9MjnZ6z4mJ678sDY56OWUr1LoXfVC44n9wK+
         /y6cVmgdGuvp2Ji5V5aylg0WyPFkK5JmS72oe2EIY2UWFyBpOV/jp++oC/wAJpPO3ka/
         WWCKJ4+enuM6hah7xEns95D3MsO2k/iEP24Az76qdCALxrUMNIoCeqF9hUvju3ERu/qu
         hvI5bAaT3Urw2gdwqsMsX3y+dM6FqGaSsbyjXooefJcsei8CLMzqnkjsig4rDtW0j4c8
         +Szw==
X-Gm-Message-State: APjAAAUaBT4yC2mZfqCmF67u72ynSM5WnqsfiaCwFDyMWoBnYR/c/LAu
        6fYGoyyMxmpnLHyfXHpOjD8=
X-Google-Smtp-Source: APXvYqw4yVYKwYKTFDlMuvh7LK03/xq1y7OpcGD4StoG5pVUMv9EUefMw5NfIEFQyh9vsqT8fFI6aA==
X-Received: by 2002:a50:8854:: with SMTP id c20mr45440137edc.167.1554191848380;
        Tue, 02 Apr 2019 00:57:28 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id l20sm2300124ejb.30.2019.04.02.00.57.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Apr 2019 00:57:27 -0700 (PDT)
Date:   Tue, 2 Apr 2019 00:57:25 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     yamada.masahiro@socionext.com, keescook@chromium.org,
        clang-built-linux@googlegroups.com,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Makefile: lld: tell clang to use lld
Message-ID: <20190402075725.GB5308@archlinux-ryzen>
References: <20190402072726.GA16650@archlinux-ryzen>
 <20190402073317.56529-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402073317.56529-1-ndesaulniers@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 12:33:17AM -0700, Nick Desaulniers wrote:
> This is needed because clang doesn't select which linker to use based on
> $LD but rather -fuse-ld={bfd,gold,lld,<absolute path to linker>}.  This
> is problematic especially for cc-ldoption, which checks for linker flag
> support via invoking the compiler, rather than the linker.
> 
> Select the linker via absolute path from $PATH via `which`. This allows
> you to build with:
> 
> $ make LD=ld.lld
> $ make LD=ld.lld-8
> $ make LD=/path/to/ld.lld
> 
> Add -Qunused-arguments to KBUILD_CPPFLAGS sooner, as otherwise
> Clang likes to complain about -fuse-lld= being unused when compiling but
> not linking (-c) such as when cc-option is used. There's no need to
> guard with cc-option.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/342
> Link: https://github.com/ClangBuiltLinux/linux/issues/366
> Link: https://github.com/ClangBuiltLinux/linux/issues/357
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
> Changes V3->V4:
> * Unconditionally add -Qunused-arguments sooners, as per Nathan.
> * Slight modification to commit message for that point.
> Changes V2->V3:
> * Use absolute path based on `which $LD` as per Masahiro.
> * Add -Qunused-arguments.
> * Drop tested-by/reviewed-by tags, since this patched has changed enough
>   to warrant re-testing/re-review, IMO.
> * Add more info to the commit message.
> Changes V1->V2:
> * add reviewed and tested by tags.
> * move this addition up 2 statments so that it's properly added to
>   KBUILD_*FLAGS as per Nathan.
> 
>  Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 026fbc450906..b290e76e1ca5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -514,6 +514,10 @@ ifneq ($(GCC_TOOLCHAIN),)
>  CLANG_FLAGS	+= --gcc-toolchain=$(GCC_TOOLCHAIN)
>  endif
>  CLANG_FLAGS	+= -no-integrated-as
> +ifneq ($(shell $(LD) --version 2>&1 | head -n 1 | grep LLD),)
> +CLANG_FLAGS	+= -fuse-ld=$(shell which $(LD))
> +endif
> +KBUILD_CPPFLAGS	+= -Qunused-arguments
>  KBUILD_CFLAGS	+= $(CLANG_FLAGS)
>  KBUILD_AFLAGS	+= $(CLANG_FLAGS)
>  export CLANG_FLAGS
> @@ -716,7 +720,6 @@ stackp-flags-$(CONFIG_STACKPROTECTOR_STRONG)      := -fstack-protector-strong
>  KBUILD_CFLAGS += $(stackp-flags-y)
>  
>  ifdef CONFIG_CC_IS_CLANG
> -KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
>  KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
>  KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
>  KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
> -- 
> 2.21.0.392.gf8f6787159e-goog
> 
