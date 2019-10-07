Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A839BC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A737206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 20:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u1LrB81c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfJGU2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 16:28:33 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33232 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfJGU2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 16:28:32 -0400
Received: by mail-pl1-f196.google.com with SMTP id d22so7427465pls.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 13:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1nT5pqV4UDWiGVYI8ECyB7FPfmS2/KcyZkTgCypark=;
        b=u1LrB81cC3BeMUn8kgZgo2KGKVPgUa1ovd64Kua6Kup8KfJNEO5ihdRUj1rMsFGO6c
         cm/v8YiLHDNztFDjprtB0snB3gurKB3wsBYJMn+xt76JZuRZiovDcmYul5Btd7MgkTls
         0pU5yJq8i4JXAoak2rdgqH0QjYsCRZSolJHrVc5N8Xff7aklN1nDsb9NKWbOrFToiXgL
         qaRP587UqTEK++wwFwp2TuY40KAKFB8fwATEEG2fVmfvfsosAPpF1E0qsDIsgka3TUAG
         fyQpwoQFVIoLXJaMxZ4Xs7zHZ54Ig22wxnLvWEGt0+p3FF9MkH7fZE9jKJkQmiLCeBTD
         lF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1nT5pqV4UDWiGVYI8ECyB7FPfmS2/KcyZkTgCypark=;
        b=SbEJ5wSNwVpcTRHklIcGWd6l+XYlZhokUo4z3uq03kQC3nJgfDNUaXaTXczvZeNtbj
         5nNHpE5Ry3kzrggM+Pk2HlrTk7AvbXIraNboxckEEp2V7AHVtjxf4cm/YXJQBa0+CDPR
         yy/lCH006Og4qiwGT+0vP9AfI42D7+GW0I3RGBJlPMuUCB4q5ipbXShyzHSRzlBQam7F
         ELlEcQ3fvse2iFMRexWQJWzekL+cKMtXOaTpt46L+A/1HSZW5VZgah/C3RaQygXKaSER
         QXJ1rKX/0HcYKnG/YRkcIYD8ihStYkh7+wV0CFLqn+MPNtkM+uBA67vbowCY8B8SrE/J
         Kn2A==
X-Gm-Message-State: APjAAAX8tNfTNr9T/pqB4B/8C0/R4A1chTIkQkAb/AE//MzzvCx45S2h
        5ezS4768DYsUcHE/dFpo9da070M3tNDl2AUcmLMffw==
X-Google-Smtp-Source: APXvYqxY3DBPUnmnAcFKk81tHOjOGlqpMNYPS9n45dz7GPcexxoKwFi3I/h/PeS2VzBnssGE3nxyZReyM4s5sAwdFEw=
X-Received: by 2002:a17:902:820e:: with SMTP id x14mr113358pln.223.1570480111571;
 Mon, 07 Oct 2019 13:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191007201452.208067-1-samitolvanen@google.com>
In-Reply-To: <20191007201452.208067-1-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 7 Oct 2019 13:28:19 -0700
Message-ID: <CAKwvOdmaMaO-Gpv2x0CWG+CRUCNKbNWJij97Jr0LaRaZXjAiTA@mail.gmail.com>
Subject: Re: [PATCH] arm64: lse: fix LSE atomics with LLVM's integrated assembler
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 1:14 PM 'Sami Tolvanen' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> Unlike gcc, clang considers each inline assembly block to be independent
> and therefore, when using the integrated assembler for inline assembly,
> any preambles that enable features must be repeated in each block.
>
> Instead of changing all inline assembly blocks that use LSE, this change
> adds -march=armv8-a+lse to KBUILD_CFLAGS, which works with both clang
> and gcc.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Thanks Sami, looks like this addresses:
Link: https://github.com/ClangBuiltLinux/linux/issues/671
I tried adding `.arch armv8-a+lse` directives to all of the inline asm:
https://github.com/ClangBuiltLinux/linux/issues/573#issuecomment-535098996
though that quickly ran aground in some failed assertion using the
alternatives system that I don't quite yet understand.

One thing to be careful about is that blankets the entire kernel in
`+lse`, allowing LSE atomics to be selected at any point.  The
assembler directive in the header (or per inline asm block) is more
fine grained.  I'm not sure that they would be guarded by the
alternative system.  Maybe that's not an issue, but it is the reason I
tried to localize the assembler directive first.

Note that Clang really wants the target arch specified by either:
1. command line argument (as in this patch)
2. per function function attribute
3. per asm statement assembler directive

1 is the smallest incision.

> ---
>  arch/arm64/Makefile          | 2 ++
>  arch/arm64/include/asm/lse.h | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 84a3d502c5a5..7a7c0cb8ed60 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -36,6 +36,8 @@ lseinstr := $(call as-instr,.arch_extension lse,-DCONFIG_AS_LSE=1)
>  ifeq ($(CONFIG_ARM64_LSE_ATOMICS), y)
>    ifeq ($(lseinstr),)
>  $(warning LSE atomics not supported by binutils)
> +  else
> +KBUILD_CFLAGS  += -march=armv8-a+lse
>    endif
>  endif
>
> diff --git a/arch/arm64/include/asm/lse.h b/arch/arm64/include/asm/lse.h
> index 80b388278149..8603a9881529 100644
> --- a/arch/arm64/include/asm/lse.h
> +++ b/arch/arm64/include/asm/lse.h
> @@ -14,8 +14,6 @@
>  #include <asm/atomic_lse.h>
>  #include <asm/cpucaps.h>
>
> -__asm__(".arch_extension       lse");
> -
>  extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
>  extern struct static_key_false arm64_const_caps_ready;
>
> --
> 2.23.0.581.g78d2f28ef7-goog
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20191007201452.208067-1-samitolvanen%40google.com.



-- 
Thanks,
~Nick Desaulniers
