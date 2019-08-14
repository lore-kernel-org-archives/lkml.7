Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00B0C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80A82084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hP6kX/FV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfHNQO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:14:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42499 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfHNQO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:14:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id b16so14937447wrq.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 09:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g2Vb9pRuewyB7X8dmpxJboh/540awqzNX/YAPeizCG8=;
        b=hP6kX/FVHVqqZerZsbPksnoiujOfy+LBYL+vUym2xSKUm0idVsRnQSwxtTXu38OLC1
         g7RfKwJrTbBJ40sVBr+bMyqIs5plMNeywbXaRPio+VX/3XIyhe1uJEgUWo1Nq/kyvqzP
         fQVT0lMxNzXn3k/A9L2/BRrSfHqid+46jCgDJY++V3HzDPyVR/k22PZxEHIWhHBi+pBO
         ckVl9KHicDE2xTcNfX3ebmJXZCtfxY4NBGChT5i7eKDQoy9tZCLXSJN8DkURA4nnL7IH
         VsoFdHNkLjT7BGMcHN6BQ5DyQud4Z5iexEluVfz0DoYpjB4lDNr4YYEzdoLVsRVnwpXD
         1szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g2Vb9pRuewyB7X8dmpxJboh/540awqzNX/YAPeizCG8=;
        b=IvA73ifdnkLtaqCFdoCp2gSfyb/b88BOH0mxAk73Amvc1CmjHr/om04QK9YVUJEg1Y
         5A2fNpTEGfX2+m2JnPvmCGgokPDaNzmQnL3nim7PUjPBTZ16UkDW5oRyLTjCf+Tpcexz
         zKLPDTz9zv935IiwLnQN3Nwuccjm8Tezlt5+SPwRMi3dHc6ACatYkenU2pWwPzAlbHJm
         FZxvDWNN/apo+9lE9plJKxcL50TzqWJxDd23X8aGE4O1prF4WwQOlvbk9zgxqPKqfeXW
         5RRPWeTUj0pbtuW5+K97cl6GEmOu96DSgE/9f/rNPwDBPh3fduEzdJF8LRWT7uTiTdWn
         NZgQ==
X-Gm-Message-State: APjAAAUaqTHOCElY+YQhYd0FRlRcW4j0u7AS5A5481Ar/XmT47pePbrt
        ifoZEpsXXby+r/qRbkHd8KEEvQ52nc5bFJFuNSgOfA==
X-Google-Smtp-Source: APXvYqw7R4gJ8Wt7CCX3V4131yqsLCQKNrpQa0DPB4hst9pYKhtNS5ThTKVF8a/aJR+ruxVVVBVxz5S8Hd1BGr0sBJc=
X-Received: by 2002:adf:eb52:: with SMTP id u18mr519212wrn.174.1565799294784;
 Wed, 14 Aug 2019 09:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <201908131602.6E858DEC@keescook>
In-Reply-To: <201908131602.6E858DEC@keescook>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 14 Aug 2019 19:14:42 +0300
Message-ID: <CAKv+Gu9fEAG3CqmORyO2X_Uqse09nnXEQiB1kTL-xBqLWsy8Xg@mail.gmail.com>
Subject: Re: [PATCH] arm64/efi: Move variable assignments after SECTIONS
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Peter Smith <peter.smith@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2019 at 02:04, Kees Cook <keescook@chromium.org> wrote:
>
> It seems that LLVM's linker does not correctly handle variable assignments
> involving section positions that are updated during the SECTIONS
> parsing. Commit aa69fb62bea1 ("arm64/efi: Mark __efistub_stext_offset as
> an absolute symbol explicitly") ran into this too, but found a different
> workaround.
>
> However, this was not enough, as other variables were also miscalculated
> which manifested as boot failures under UEFI where __efistub__end was
> not taking the correct _end value (they should be the same):
>
> $ ld.lld -EL -maarch64elf --no-undefined -X -shared \
>         -Bsymbolic -z notext -z norelro --no-apply-dynamic-relocs \
>         -o vmlinux.lld -T poc.lds --whole-archive vmlinux.o && \
>   readelf -Ws vmlinux.lld | egrep '\b(__efistub_|)_end\b'
> 368272: ffff000002218000     0 NOTYPE  LOCAL  HIDDEN    38 __efistub__end
> 368322: ffff000012318000     0 NOTYPE  GLOBAL DEFAULT   38 _end
>
> $ aarch64-linux-gnu-ld.bfd -EL -maarch64elf --no-undefined -X -shared \
>         -Bsymbolic -z notext -z norelro --no-apply-dynamic-relocs \
>         -o vmlinux.bfd -T poc.lds --whole-archive vmlinux.o && \
>   readelf -Ws vmlinux.bfd | egrep '\b(__efistub_|)_end\b'
> 338124: ffff000012318000     0 NOTYPE  LOCAL  DEFAULT  ABS __efistub__end
> 383812: ffff000012318000     0 NOTYPE  GLOBAL DEFAULT 15325 _end
>
> To work around this, all of the __efistub_-prefixed variable assignments
> need to be moved after the linker script's SECTIONS entry. As it turns
> out, this also solves the problem fixed in commit aa69fb62bea1, so those
> changes are reverted here.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/634
> Link: https://bugs.llvm.org/show_bug.cgi?id=42990
> Signed-off-by: Kees Cook <keescook@chromium.org>

Although it is slightly disappointing that we need to work around this
kind of bugs when adding support for a new toolchain, I don't see
anything wrong with this patch, so

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>


> ---
>  arch/arm64/kernel/image-vars.h  | 51 +++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/image.h       | 42 ---------------------------
>  arch/arm64/kernel/vmlinux.lds.S |  2 ++
>  3 files changed, 53 insertions(+), 42 deletions(-)
>  create mode 100644 arch/arm64/kernel/image-vars.h
>
> diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
> new file mode 100644
> index 000000000000..25a2a9b479c2
> --- /dev/null
> +++ b/arch/arm64/kernel/image-vars.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Linker script variables to be set after section resolution, as
> + * ld.lld does not like variables assigned before SECTIONS is processed.
> + */
> +#ifndef __ARM64_KERNEL_IMAGE_VARS_H
> +#define __ARM64_KERNEL_IMAGE_VARS_H
> +
> +#ifndef LINKER_SCRIPT
> +#error This file should only be included in vmlinux.lds.S
> +#endif
> +
> +#ifdef CONFIG_EFI
> +
> +__efistub_stext_offset = stext - _text;
> +
> +/*
> + * The EFI stub has its own symbol namespace prefixed by __efistub_, to
> + * isolate it from the kernel proper. The following symbols are legally
> + * accessed by the stub, so provide some aliases to make them accessible.
> + * Only include data symbols here, or text symbols of functions that are
> + * guaranteed to be safe when executed at another offset than they were
> + * linked at. The routines below are all implemented in assembler in a
> + * position independent manner
> + */
> +__efistub_memcmp               = __pi_memcmp;
> +__efistub_memchr               = __pi_memchr;
> +__efistub_memcpy               = __pi_memcpy;
> +__efistub_memmove              = __pi_memmove;
> +__efistub_memset               = __pi_memset;
> +__efistub_strlen               = __pi_strlen;
> +__efistub_strnlen              = __pi_strnlen;
> +__efistub_strcmp               = __pi_strcmp;
> +__efistub_strncmp              = __pi_strncmp;
> +__efistub_strrchr              = __pi_strrchr;
> +__efistub___flush_dcache_area  = __pi___flush_dcache_area;
> +
> +#ifdef CONFIG_KASAN
> +__efistub___memcpy             = __pi_memcpy;
> +__efistub___memmove            = __pi_memmove;
> +__efistub___memset             = __pi_memset;
> +#endif
> +
> +__efistub__text                        = _text;
> +__efistub__end                 = _end;
> +__efistub__edata               = _edata;
> +__efistub_screen_info          = screen_info;
> +
> +#endif
> +
> +#endif /* __ARM64_KERNEL_IMAGE_VARS_H */
> diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
> index 2b85c0d6fa3d..c7d38c660372 100644
> --- a/arch/arm64/kernel/image.h
> +++ b/arch/arm64/kernel/image.h
> @@ -65,46 +65,4 @@
>         DEFINE_IMAGE_LE64(_kernel_offset_le, TEXT_OFFSET);      \
>         DEFINE_IMAGE_LE64(_kernel_flags_le, __HEAD_FLAGS);
>
> -#ifdef CONFIG_EFI
> -
> -/*
> - * Use ABSOLUTE() to avoid ld.lld treating this as a relative symbol:
> - * https://github.com/ClangBuiltLinux/linux/issues/561
> - */
> -__efistub_stext_offset = ABSOLUTE(stext - _text);
> -
> -/*
> - * The EFI stub has its own symbol namespace prefixed by __efistub_, to
> - * isolate it from the kernel proper. The following symbols are legally
> - * accessed by the stub, so provide some aliases to make them accessible.
> - * Only include data symbols here, or text symbols of functions that are
> - * guaranteed to be safe when executed at another offset than they were
> - * linked at. The routines below are all implemented in assembler in a
> - * position independent manner
> - */
> -__efistub_memcmp               = __pi_memcmp;
> -__efistub_memchr               = __pi_memchr;
> -__efistub_memcpy               = __pi_memcpy;
> -__efistub_memmove              = __pi_memmove;
> -__efistub_memset               = __pi_memset;
> -__efistub_strlen               = __pi_strlen;
> -__efistub_strnlen              = __pi_strnlen;
> -__efistub_strcmp               = __pi_strcmp;
> -__efistub_strncmp              = __pi_strncmp;
> -__efistub_strrchr              = __pi_strrchr;
> -__efistub___flush_dcache_area  = __pi___flush_dcache_area;
> -
> -#ifdef CONFIG_KASAN
> -__efistub___memcpy             = __pi_memcpy;
> -__efistub___memmove            = __pi_memmove;
> -__efistub___memset             = __pi_memset;
> -#endif
> -
> -__efistub__text                        = _text;
> -__efistub__end                 = _end;
> -__efistub__edata               = _edata;
> -__efistub_screen_info          = screen_info;
> -
> -#endif
> -
>  #endif /* __ARM64_KERNEL_IMAGE_H */
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 7fa008374907..803b24d2464a 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -245,6 +245,8 @@ SECTIONS
>         HEAD_SYMBOLS
>  }
>
> +#include "image-vars.h"
> +
>  /*
>   * The HYP init code and ID map text can't be longer than a page each,
>   * and should not cross a page boundary.
> --
> 2.17.1
>
>
> --
> Kees Cook
