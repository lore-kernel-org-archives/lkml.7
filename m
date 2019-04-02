Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BE9C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25A02084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Npbowo8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfDBHw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:52:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34755 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfDBHw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:52:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so15303486wrq.1;
        Tue, 02 Apr 2019 00:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=VbjnPB8oxfwyp4XsX1/X3QiYhlRSJbXfLliTZ1HkW1Q=;
        b=Npbowo8Ai5nkxYcBtzQfgel5AJbSrsgwWEvIeO4IMtXlj2V2wTtRfBN0RlkL9O5Jmg
         /ZDK21e1nVh0ci8BHqfQi+eZ+sAIv1g5PpiM7VwbHQw+kZd60cXZB3cMcUHqJawcghvR
         rdkNtKpvx/XzPVBAqYWoBGbd/210HHkPX+2K9CZYszQ+HtSm2gBtG41VVKjP5p2CIQqI
         kWxztnV24aKUxCSTPNxihs6WTPlWNWBGWl/Brtst2NAT6t5qrP592ttCRO7Q3kco2HcN
         /1JNnZRnDDgU6yvE37MA5ryjn8vhBHxz/VP51FlZz3nHH2bsYUk6omYjy/6+jlyuH3bH
         qJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=VbjnPB8oxfwyp4XsX1/X3QiYhlRSJbXfLliTZ1HkW1Q=;
        b=QYxaGooNctnndRkBxIERZ7iEVZvfhplxYpH6O49Kv+dHsHHcNEYghQ9Fk7exAfjrrX
         5JUp+e+MOM7UH/F/SiL1osDG3bVyf781spPElMHgD+rOAmlBlypDwz8nSdQWkt+Kl0ht
         7/Xk5GEsaTf52foS+N+rI3EvjBdMmvwMRqxhY6wsGDJ9tL9JLY5jizkYoPlYzHpD+4CH
         Edeb3Oup9FqgiNUF17/4gXa0C5Sk+opBTYRy+6Apeer7m1t9CJWrDSL2nYILkI6jM9te
         UCrCPn1kN4s0Ev1lBRX5Qj2PKSKBXvcsexabcG5rIbcXxaXW/1PJNkReTOmub538jGER
         z7LQ==
X-Gm-Message-State: APjAAAVhMFcCBsTI7EQl36BIeSwutDUBUhBCFGz7sMOgSaeSoPnSHr5d
        zQA+2Xt8iulVO0C98dBw4C6rhR5TxJjb1asSGfM=
X-Google-Smtp-Source: APXvYqzsMIWvHJdXjVtz1tlgcwE9Fkdd2h9XL5/dBU5OIbpVOs3v1TOj4LQ+T7P1XLpeCq2DRNZ43Ps/lBaDAz6TPD8=
X-Received: by 2002:a5d:698b:: with SMTP id g11mr2146374wru.65.1554191544197;
 Tue, 02 Apr 2019 00:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAQw7nPwykOEV5i+yWjkxzgf1gPa5ewFhDxbbn8XXjwFUA@mail.gmail.com>
 <20190402070858.49597-1-ndesaulniers@google.com>
In-Reply-To: <20190402070858.49597-1-ndesaulniers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 2 Apr 2019 09:52:13 +0200
Message-ID: <CA+icZUUgvw7G0rrrhLL0KGXgeuPAxnSAQCopqWrqAAXvjSK=Yw@mail.gmail.com>
Subject: Re: [PATCH v3] Makefile: lld: tell clang to use lld
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 9:09 AM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
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
> Add -Qunused-arguments to KBUILD_CPPFLAGS when using LLD, as otherwise
> Clang likes to complain about -fuse-lld= being unused when compiling but
> not linking (-c) such as when cc-option is used.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/342
> Link: https://github.com/ClangBuiltLinux/linux/issues/366
> Link: https://github.com/ClangBuiltLinux/linux/issues/357
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks for bringing this up again, Nick.

Suggested-by: Sedat Dilek <sedat.dilek@gmail.com> (see [1]).

I suggest to do a separate patch on the move of  "KBUILD_CPPFLAGS +=
-Qunused-arguments".
( Patch was attached in [2],[3]. )

As pointed by Nathan this needs the removal in the original code-block.

Other than that:

Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>

[1] https://github.com/ClangBuiltLinux/linux/issues/366#issuecomment-466836735
[2] https://github.com/ClangBuiltLinux/linux/issues/366#issuecomment-467118373
[3] https://github.com/ClangBuiltLinux/linux/files/2901865/kbuild-clang-lld-Move-Qunused-arguments-CPPFLAGS-patch.txt

> ---
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
>  Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 026fbc450906..895c076b6305 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -514,6 +514,10 @@ ifneq ($(GCC_TOOLCHAIN),)
>  CLANG_FLAGS    += --gcc-toolchain=$(GCC_TOOLCHAIN)
>  endif
>  CLANG_FLAGS    += -no-integrated-as
> +ifneq ($(shell $(LD) --version 2>&1 | head -n 1 | grep LLD),)
> +CLANG_FLAGS    += -fuse-ld=$(shell which $(LD))
> +KBUILD_CPPFLAGS += -Qunused-arguments
> +endif
>  KBUILD_CFLAGS  += $(CLANG_FLAGS)
>  KBUILD_AFLAGS  += $(CLANG_FLAGS)
>  export CLANG_FLAGS
> --
> 2.21.0.392.gf8f6787159e-goog
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To post to this group, send email to clang-built-linux@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20190402070858.49597-1-ndesaulniers%40google.com.
> For more options, visit https://groups.google.com/d/optout.
