Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDA5CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 21:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA2620679
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 21:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kmFuT5Kg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506143AbfJRVXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 17:23:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45716 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbfJRVXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 17:23:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1so4010146pgj.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 14:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vIoI90AJcGtmRzHkaXHGdwrJxP2gbeW0bBXLDxZIi6o=;
        b=kmFuT5Kg6bHVBqvSrwwjd80o3NyLk9kXgyAEqkBiecWeSw5sIbx2razxWIcHpKmuCx
         bJO2L0Jt09AzB11Ioy48fJTW8FR+EMVEr0M9zHJAcwWGJOQg3HRcf2WrQ1l4SzEXAZq4
         n6Xg7mC6TZcE9jyt02zaa38SwNptcs9lLZ8G/gPn1z84v6FiEYb28HVQX/UzL1C7GhyF
         PAoEIeSihIs40ESqTd4Oi5iDvDNXP4+cR6jf/BkW9ReFPCWFW0DLQ4SlZLRQeGvSHN7n
         CoZ3rxSv+LnWUEqcGvtveotIJsaouPfkBE7vIksnyOAEvvP1q7/C1giHe26s6vQXFvJX
         liOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vIoI90AJcGtmRzHkaXHGdwrJxP2gbeW0bBXLDxZIi6o=;
        b=OopL+GMTqHJ7w0071+WcPJZWq0pgPpvUGEtWXN45Kw0eg3swGBKdHaL/T/Z4qfWd15
         i5cbqeuopWPwoEyBQyJt53wUhSxJ2bUpQD8wGBP81EeuLEyUY6MUMdZNxAxLhhv022iu
         x0jlvQqljCaAl3ltr3z7ufdbRH60Nb2i1YvmZc3/MtHKRdnaxSGzuN2jVwMCg8EfKguK
         TzDlUClKv6pGDLBexHtGJYKN+XThM+jjiok4c4U2aQAs3Wt1kc0c4UpTdkCufqEt2cPC
         NW6054DMfLIPNOe+6CiJOOwJIRi6MBbacIO4grd7n4/AcQvn0FUxqu76InyIFpjAVNFP
         ZkKA==
X-Gm-Message-State: APjAAAUdmymz+EK8kScmc+zq1VUgcfRrLwZYCRTRgIBH7/XCYD9Y4TS0
        1SCuUvBa6t3Oapb8MbhVLc9roRxRtJ8WxRVfaI0hcg==
X-Google-Smtp-Source: APXvYqyiiPLOZOS1kQpsZ9qqN50RFADJX438WB0rEo22PxmnqtNJSl9IB/wB6WS07gKTHpmXSLKmBJieIge5XbhC8jY=
X-Received: by 2002:aa7:8210:: with SMTP id k16mr9015314pfi.84.1571433802129;
 Fri, 18 Oct 2019 14:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191018161033.261971-13-samitolvanen@google.com>
In-Reply-To: <20191018161033.261971-13-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 18 Oct 2019 14:23:10 -0700
Message-ID: <CAKwvOd=rU2cC7C3a=8D2WBEmS49YgR7=aCriE31JQx7ExfQZrg@mail.gmail.com>
Subject: Re: [PATCH 12/18] arm64: reserve x18 only with Shadow Call Stack
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 9:11 AM 'Sami Tolvanen' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> Only reserve x18 with CONFIG_SHADOW_CALL_STACK. Note that all external
> kernel modules must also have x18 reserved if the kernel uses SCS.

Ah, ok.  The tradeoff for maintainers to consider, either:
1. one less GPR for ALL kernel code or
2. remember not to use x18 in inline as lest you potentially break SCS

This patch is 2 (the earlier patch was 1).  Maybe we don't write
enough inline asm that this will be hard to remember, and we do have
CI in Android to watch for this (on mainline, not sure about -next).

Either way,
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/Makefile | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 1c7b276bc7c5..ef76101201b2 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -55,7 +55,7 @@ endif
>
>  KBUILD_CFLAGS  += -mgeneral-regs-only $(lseinstr) $(brokengasinst)     \
>                    $(compat_vdso) $(cc_has_k_constraint)
> -KBUILD_CFLAGS  += -fno-asynchronous-unwind-tables -ffixed-x18
> +KBUILD_CFLAGS  += -fno-asynchronous-unwind-tables
>  KBUILD_CFLAGS  += $(call cc-disable-warning, psabi)
>  KBUILD_AFLAGS  += $(lseinstr) $(brokengasinst) $(compat_vdso)
>
> @@ -72,6 +72,10 @@ stack_protector_prepare: prepare0
>                                         include/generated/asm-offsets.h))
>  endif
>
> +ifeq ($(CONFIG_SHADOW_CALL_STACK), y)
> +KBUILD_CFLAGS  += -ffixed-x18
> +endif
> +
>  ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
>  KBUILD_CPPFLAGS        += -mbig-endian
>  CHECKFLAGS     += -D__AARCH64EB__
> --
> 2.23.0.866.gb869b98d4c-goog
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20191018161033.261971-13-samitolvanen%40google.com.



-- 
Thanks,
~Nick Desaulniers
