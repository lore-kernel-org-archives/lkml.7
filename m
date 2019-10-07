Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D081C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23A520835
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ab23GOHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfJGVej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 17:34:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45634 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbfJGVej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 17:34:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id y72so9437011pfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 14:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BSjkDRau+gNdox3X7pHNAbU0K+agxk4/tBMFb1iKCao=;
        b=ab23GOHoPcRYJ3HnTEWquyTi7459NzB39trOtCcHOHakfrohJkbUChsngGiYM4KDyK
         vxfmdUYHLdqsNshjcH+q8e98hXss8l7HdvNfXmcZfmq6F+BkqApDKKc6PS5DwcOby/6V
         TFS0ykh514AcdP4JUMOoLl1pUci1xEoG1RUi2Jy3q8ZjvGrps5wyBZ4khqJ8pBz0SUk4
         cuVywcZEKWSp5nuTVo33oVhYH27LbkUvHuURsjZmdTiY4AepM3o4aC0FoJs9uYaVwjR7
         QDxDrx+IHpicC12wtnjUVCjjzfmGL4redMR+Bq8sY/Z99hhCkTSfVcfj4T3zuS10LJep
         jLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BSjkDRau+gNdox3X7pHNAbU0K+agxk4/tBMFb1iKCao=;
        b=DqG2NMyneM7y7V8pwyVwdjLkN/9QHjdp3V6gZnP7MmzSiEebKGHcPTqiTnHEomB744
         5BVklDiWJoDWMwpOkblRBzPGFVRYyqY/h9jtCmWKlQKGXljuLuMPnNrh9C6xGsyItlRu
         2VpoW12DkuTxquPaQTp+k6KW383HFjpxAby8zzHyrODobD8Xss2D9oOymSWux4cSFrgk
         sGbOlSPN2JcMB5ITLmG0CqdYfTye+C7ovr0zGwjh9yhkHAP2XuZlcGfs5/LSaMT9CC0M
         jnSgvqfE2qjrl2+WSUZAS7YbyPv8kzQwyA1sLQ2ENO5/lQ935W/byGVEuihKlLOUX7Eh
         G9Mw==
X-Gm-Message-State: APjAAAWH5JUYfF/sklwNPVmo1tID1z49knOG7fM19KGDj5RKYeyN2XOB
        uxEK8KxZIFxkrn4kPIVhnptB4Xtm+6Za2S1V9wNQQA==
X-Google-Smtp-Source: APXvYqyJ1eEkkfxEKHwxJsrKlG+h+OSiueWjtAo7aaPSl6xLlErSUZNoBFBuC9yRkYNHSyHthB/WDDPCAb+QHmGUuDY=
X-Received: by 2002:a63:2f45:: with SMTP id v66mr33356685pgv.263.1570484077649;
 Mon, 07 Oct 2019 14:34:37 -0700 (PDT)
MIME-Version: 1.0
References: <20191007211418.30321-1-samitolvanen@google.com>
In-Reply-To: <20191007211418.30321-1-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 7 Oct 2019 14:34:26 -0700
Message-ID: <CAKwvOdnX6O0Grth11R8JLoD9bp-BECheucZKHbiHt4=XpQferA@mail.gmail.com>
Subject: Re: [PATCH] arm64: fix alternatives with LLVM's integrated assembler
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 2:14 PM 'Sami Tolvanen' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> LLVM's integrated assembler fails with the following error when
> building KVM:
>
>   <inline asm>:12:6: error: expected absolute expression
>    .if kvm_update_va_mask == 0
>        ^
>   <inline asm>:21:6: error: expected absolute expression
>    .if kvm_update_va_mask == 0
>        ^
>   <inline asm>:24:2: error: unrecognized instruction mnemonic
>           NOT_AN_INSTRUCTION
>           ^
>   LLVM ERROR: Error parsing inline asm
>
> These errors come from ALTERNATIVE_CB and __ALTERNATIVE_CFG,
> which test for the existence of the callback parameter in inline
> assembly using the following expression:
>
>   " .if " __stringify(cb) " == 0\n"
>
> This works with GNU as, but isn't supported by LLVM. This change
> splits __ALTERNATIVE_CFG and ALTINSTR_ENTRY into separate macros
> to fix the LLVM build.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/472
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/include/asm/alternative.h | 32 ++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
> index b9f8d787eea9..324e7d5ab37e 100644
> --- a/arch/arm64/include/asm/alternative.h
> +++ b/arch/arm64/include/asm/alternative.h
> @@ -35,13 +35,16 @@ void apply_alternatives_module(void *start, size_t length);
>  static inline void apply_alternatives_module(void *start, size_t length) { }
>  #endif
>
> -#define ALTINSTR_ENTRY(feature,cb)                                           \
> +#define ALTINSTR_ENTRY(feature)                                                      \
>         " .word 661b - .\n"                             /* label           */ \
> -       " .if " __stringify(cb) " == 0\n"                                     \
>         " .word 663f - .\n"                             /* new instruction */ \
> -       " .else\n"                                                            \
> +       " .hword " __stringify(feature) "\n"            /* feature bit     */ \
> +       " .byte 662b-661b\n"                            /* source len      */ \
> +       " .byte 664f-663f\n"                            /* replacement len */
> +
> +#define ALTINSTR_ENTRY_CB(feature, cb)                                       \
> +       " .word 661b - .\n"                             /* label           */ \
>         " .word " __stringify(cb) "- .\n"               /* callback */        \
> -       " .endif\n"                                                           \
>         " .hword " __stringify(feature) "\n"            /* feature bit     */ \
>         " .byte 662b-661b\n"                            /* source len      */ \
>         " .byte 664f-663f\n"                            /* replacement len */
> @@ -62,15 +65,14 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
>   *
>   * Alternatives with callbacks do not generate replacement instructions.
>   */
> -#define __ALTERNATIVE_CFG(oldinstr, newinstr, feature, cfg_enabled, cb)        \
> +#define __ALTERNATIVE_CFG(oldinstr, newinstr, feature, cfg_enabled)    \
>         ".if "__stringify(cfg_enabled)" == 1\n"                         \
>         "661:\n\t"                                                      \
>         oldinstr "\n"                                                   \
>         "662:\n"                                                        \
>         ".pushsection .altinstructions,\"a\"\n"                         \
> -       ALTINSTR_ENTRY(feature,cb)                                      \
> +       ALTINSTR_ENTRY(feature)                                         \
>         ".popsection\n"                                                 \
> -       " .if " __stringify(cb) " == 0\n"                               \
>         ".pushsection .altinstr_replacement, \"a\"\n"                   \
>         "663:\n\t"                                                      \
>         newinstr "\n"                                                   \
> @@ -78,17 +80,25 @@ static inline void apply_alternatives_module(void *start, size_t length) { }
>         ".popsection\n\t"                                               \
>         ".org   . - (664b-663b) + (662b-661b)\n\t"                      \
>         ".org   . - (662b-661b) + (664b-663b)\n"                        \
> -       ".else\n\t"                                                     \
> +       ".endif\n"
> +
> +#define __ALTERNATIVE_CFG_CB(oldinstr, feature, cfg_enabled, cb)       \
> +       ".if "__stringify(cfg_enabled)" == 1\n"                         \
> +       "661:\n\t"                                                      \
> +       oldinstr "\n"                                                   \
> +       "662:\n"                                                        \
> +       ".pushsection .altinstructions,\"a\"\n"                         \
> +       ALTINSTR_ENTRY_CB(feature, cb)                                  \
> +       ".popsection\n"                                                 \
>         "663:\n\t"                                                      \
>         "664:\n\t"                                                      \
> -       ".endif\n"                                                      \
>         ".endif\n"
>
>  #define _ALTERNATIVE_CFG(oldinstr, newinstr, feature, cfg, ...)        \
> -       __ALTERNATIVE_CFG(oldinstr, newinstr, feature, IS_ENABLED(cfg), 0)
> +       __ALTERNATIVE_CFG(oldinstr, newinstr, feature, IS_ENABLED(cfg))
>
>  #define ALTERNATIVE_CB(oldinstr, cb) \
> -       __ALTERNATIVE_CFG(oldinstr, "NOT_AN_INSTRUCTION", ARM64_CB_PATCH, 1, cb)
> +       __ALTERNATIVE_CFG_CB(oldinstr, ARM64_CB_PATCH, 1, cb)
>  #else
>
>  #include <asm/assembler.h>


Should the definition of the ALTERNATIVE macro
(arch/arm64/include/asm/alternative.h#L295) also be updated in this
patch to not pass `1` as the final parameter? Otherwise with this
patch and your LSE one
(https://lore.kernel.org/lkml/20191007201452.208067-1-samitolvanen@google.com/T/#u)
I get one error on linux-next that looks related:
$ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CC=clang AS=clang
-j71 arch/arm64/kvm/
...
arch/arm64/kvm/hyp/entry.S:109:87: error: too many positional arguments
 alternative_insn nop, .inst (0xd500401f | ((0) << 16 | (4) << 5) |
((!!1) << 8)), 4, 1

               ^

Since __ALTERNATIVE_CFG now takes one less arg, with your patch?

-- 
Thanks,
~Nick Desaulniers
