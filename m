Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5AAC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45EE5206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfDZJj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:39:29 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43788 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfDZJj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:39:29 -0400
Received: by mail-qt1-f196.google.com with SMTP id g4so3316197qtq.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 02:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V4i3NOMOGubVVMAlFGhPrBoxHBbe+vOVX6oCJC9qFGo=;
        b=ZPDTorb/rxy7vfxAajjdi9xgaHjJQuSYLUhbgEzoNE0jUxYeG3dMDCbLQqJ4o3+Rqv
         +3/DBWOCQx+GSm3pbpaLTfSs3Z1IYV8tNGl20yjHiYMNm5OVRi2nOBfiupVrbeVpe49O
         6XOqJgyXdiK6KcfXTD/eWMCzR+lamZulTVhQAp6QLMapAUGeQan1MeiH9HumNCO+LNIU
         Cgh93qxn6vy9Y1chusWz+qDNTZf81oIdAEX0jA9PzlAUfIvoP1Qlt22MESyG6OiL4KGU
         +Y+r9RPwfrBVAbiBIgmIGjQHFUNWyv+SlSJVfdm56Tr23r2uK8nep3lXK/MFHj8GVjd6
         0WJA==
X-Gm-Message-State: APjAAAXUH3lH5WuMZQ7AA9QvsXGA2YuSU8gBNq/8SHwg9X5BbU3mq6hP
        JJKuLez83YPEsb6V/Ws/RJ8xCxDTouKMf7ipHQlihflcfbI=
X-Google-Smtp-Source: APXvYqy6Qx1CBx5fom/XcV0wXTMjqthm7qI/+hNFPu3+QFYXSGbFQaOZn+tbrscvgawr9Jyar/FaqGB8O3a7NqimwsA=
X-Received: by 2002:a0c:ba10:: with SMTP id w16mr35536726qvf.115.1556271568497;
 Fri, 26 Apr 2019 02:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190409212517.7321-1-linux@rasmusvillemoes.dk> <20190409212517.7321-10-linux@rasmusvillemoes.dk>
In-Reply-To: <20190409212517.7321-10-linux@rasmusvillemoes.dk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Apr 2019 11:39:12 +0200
Message-ID: <CAK8P3a1by1-ZF2NoTdGbxv+AJu92d3Sp5L08BhLCA+0PNS8s2Q@mail.gmail.com>
Subject: Re: [PATCH 09/10] arm64: select DYNAMIC_DEBUG_RELATIVE_POINTERS
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 11:26 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> Similar to GENERIC_BUG_RELATIVE_POINTERS, one can now relativize the
> four const char* members of struct _ddebug, thus saving 16 bytes per
> instance (one for each pr_debug(), dev_debug() etc. in a
> CONFIG_DYNAMIC_DEBUG kernel). The asm-generic implementation seems to
> work out-of-the-box, though this is only compile-tested.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

This causes a build regression when compiling with clang,
see http://staging-storage.kernelci.org/next-clang/master/next-20190424/arm64/allmodconfig/clang-8/build.log

../init/initramfs.c:477:3: error: invalid operand in inline asm:
'.ifndef __UNIQUE_ID_ddebug18.pushsection __verbose,"aw".type
__UNIQUE_ID_ddebug18, STT_OBJECT.size __UNIQUE_ID_ddebug18,
${5:c}1:__UNIQUE_ID_ddebug18: .int ${0:c} - 1b /*
_ddebug::modname_disp */ .int ${1:c} - 1b /* _ddebug::function_disp */
.int ${2:c} - 1b /* _ddebug::filename_disp */ .int ${3:c} - 1b /*
_ddebug::format_disp */ .int ${4:c}      /* _ddebug::flags_lineno */
.org 1b+${5:c}.popsection.set __UNIQUE_ID_ddebug18.ddebug.once,
${6:c}.elseif __UNIQUE_ID_ddebug18.ddebug.once - ${6:c}.line 477 -
1.error "'__UNIQUE_ID_ddebug18' used as _ddebug identifier more than
once".endif'
                pr_debug("Detected %s compressed data\n", compress_name);
                ^
../include/linux/printk.h:336:2: note: expanded from macro 'pr_debug'
        dynamic_pr_debug(fmt, ##__VA_ARGS__)
        ^
../include/linux/dynamic_debug.h:158:2: note: expanded from macro
'dynamic_pr_debug'
        _dynamic_func_call(fmt, __dynamic_pr_debug,             \
        ^
../include/linux/dynamic_debug.h:148:2: note: expanded from macro
'_dynamic_func_call'
        __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
        ^
../include/linux/dynamic_debug.h:128:2: note: expanded from macro
'__dynamic_func_call'
        DEFINE_DYNAMIC_DEBUG_METADATA(id, fmt);         \
        ^
../include/asm-generic/dynamic_debug.h:92:15: note: expanded from
macro 'DEFINE_DYNAMIC_DEBUG_METADATA'
        asm volatile(".ifndef " __stringify(name) "\n"                  \
                     ^

I assume the same thing happens on the other architectures as well.

        Arnd

> ---
>  arch/arm64/Kconfig            | 1 +
>  arch/arm64/include/asm/Kbuild | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7e34b9eba5de..d0871d523d5d 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -83,6 +83,7 @@ config ARM64
>         select CRC32
>         select DCACHE_WORD_ACCESS
>         select DMA_DIRECT_REMAP
> +       select DYNAMIC_DEBUG_RELATIVE_POINTERS
>         select EDAC_SUPPORT
>         select FRAME_POINTER
>         select GENERIC_ALLOCATOR
> diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
> index 1e17ea5c372b..1ead0d645686 100644
> --- a/arch/arm64/include/asm/Kbuild
> +++ b/arch/arm64/include/asm/Kbuild
> @@ -3,6 +3,7 @@ generic-y += delay.h
>  generic-y += div64.h
>  generic-y += dma.h
>  generic-y += dma-contiguous.h
> +generic-y += dynamic_debug.h
>  generic-y += early_ioremap.h
>  generic-y += emergency-restart.h
>  generic-y += hw_irq.h
> --
> 2.20.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
