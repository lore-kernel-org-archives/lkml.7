Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1097EC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 07:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77F82082F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 07:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axdyS4o+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfHTH2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 03:28:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33650 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbfHTH2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 03:28:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id u16so11242106wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 00:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=STCVugaalN31QOAqpmu8JBsQHyEheYIMWoFlG13Ws1k=;
        b=axdyS4o+41ZLsyyoqW/OiBsMqhJKhwsW5ug9wfTGyKHCIqsSeMk6W6gg8dXdWq04M/
         k15aqUvkbiyo6wA8H36CQJKj+AeKJ3E6gab5VgTFyeWzIXoHP/v19ICfQpdhrX20VgAl
         vJCKGPddLJjJUvn9Fx1TdSsg6PBAznKt67bPaPnmbWTwMiYlJvBLHQr6gyZ6MKZYG5R/
         1ds31uM8RE4GwQDDStxo4p4imzGQDml2nT83Tya71BcWP1AbSzh9clcgN2/fzIhFv0Kq
         17ksKvBwhgLqqigzx/M57NB1dfqcbOFtqmgqtWHNmXFhEFVWUxfXAJTB+PSPoSaa3Q1B
         ONzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=STCVugaalN31QOAqpmu8JBsQHyEheYIMWoFlG13Ws1k=;
        b=qOQeTgxsnX6PSZd6s4yKCvNRHaH6hsxuWxu1VfWz8PP+/VQA/G0KPE8rhHJM2dJk9c
         ZM1AACelomQD2cHHe16heYBH25X2mhZRHF76/rsSxfI01KKlxUeD0cw2IedPECYn9dXP
         Nai4iPGMJ7I9q1lUldC/s5+SHLEhAtdA85ayDUA2XST/jkowQU6stoOfGZLuoLJk3wHi
         ec4QgYX6dy9qZ0PmAG3sPKxIpq87fXkc6YaRtLFwQOir/Sw3YHKWhNJ+aogJn9hN9HM0
         MjbEB7Me8NRFGQUFnRExv5JqcN8RNGLSU/DscIAhnQx7YRITwIB8hzQ2QnhOozTYvALf
         RA3Q==
X-Gm-Message-State: APjAAAWAsE8VQ4z+tp4Fl8lO/nfheHkgbxmOclNPDa7JcKYto6n5KCTS
        bB6aHCyugQjSbeBhmJ71qzQ=
X-Google-Smtp-Source: APXvYqzZkyccKTB9sO8aQYAF760a8z9N5u/eZKPl0+WKU6C8cBEm4b/Vo0X+hI2wwpnyPXrkeJQ4Bw==
X-Received: by 2002:adf:f3c1:: with SMTP id g1mr32406227wrp.203.1566286091940;
        Tue, 20 Aug 2019 00:28:11 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id i5sm17557544wrn.48.2019.08.20.00.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 00:28:11 -0700 (PDT)
Date:   Tue, 20 Aug 2019 00:28:09 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: Enabling UBSAN breaks KCOV in clang (8.0.*) on arm64
Message-ID: <20190820072809.GA62296@archlinux-threadripper>
References: <20190819165947.GA30292@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819165947.GA30292@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 05:59:48PM +0100, Mark Rutland wrote:
> Hi,
> 
> I found that when I enable both KCOV and UBSAN on arm64, clang fails to
> emit any __sanitizer_cov_trace_*() calls in the resulting binary,
> rendering KCOV useless.
> 
> For example, when building v5.3-rc3's arch/arm64/kernel/setup.o:
> 
> * With defconfig + CONFIG KCOV:
> 
>   clang -Wp,-MD,arch/arm64/kernel/.setup.o.d  -nostdinc -isystem
>   /mnt/data/opt/toolchain/llvm/8.0.0/clang+llvm-8.0.0-x86_64-linux-sles11.3/lib/clang/8.0.0/include
>   -I./arch/arm64/include -I./arch/arm64/include/generated  -I./include
>   -I./arch/arm64/include/uapi -I./arch/arm64/include/generated/uapi
>   -I./include/uapi -I./include/generated/uapi -include
>   ./include/linux/kconfig.h -include ./include/linux/compiler_types.h
>   -D__KERNEL__ -mlittle-endian -DKASAN_SHADOW_SCALE_SHIFT=3
>   -Qunused-arguments -Wall -Wundef -Werror=strict-prototypes
>   -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE
>   -Werror=implicit-function-declaration -Werror=implicit-int
>   -Wno-format-security -std=gnu89 --target=aarch64-linux
>   --prefix=/mnt/data/opt/toolchain/kernel-org-crosstool/gcc-8.1.0-nolibc/aarch64-linux/bin/
>   --gcc-toolchain=/mnt/data/opt/toolchain/kernel-org-crosstool/gcc-8.1.0-nolibc/aarch64-linux
>   -no-integrated-as -Werror=unknown-warning-option -mgeneral-regs-only
>   -DCONFIG_AS_LSE=1 -fno-asynchronous-unwind-tables
>   -DKASAN_SHADOW_SCALE_SHIFT=3 -fno-delete-null-pointer-checks
>   -Wno-address-of-packed-member -O2 -Wframe-larger-than=2048
>   -fstack-protector-strong -Wno-format-invalid-specifier -Wno-gnu
>   -Wno-tautological-compare -mno-global-merge -Wno-unused-const-variable
>   -fno-omit-frame-pointer -fno-optimize-sibling-calls -g
>   -Wdeclaration-after-statement -Wvla -Wno-pointer-sign
>   -fno-strict-overflow -fno-merge-all-constants -fno-stack-check
>   -Werror=date-time -Werror=incompatible-pointer-types
>   -Wno-initializer-overrides -Wno-format -Wno-sign-compare
>   -Wno-format-zero-length  -fsanitize-coverage=trace-pc
>   -DKBUILD_BASENAME='"setup"' -DKBUILD_MODNAME='"setup"' -c -o
>   arch/arm64/kernel/setup.o arch/arm64/kernel/setup.c
> 
>   ... and there are 44 calls to __sanitizer_cov_trace_pc in the
>   resulting setup.o
> 
> * with defconfig + CONFIG_KCOV + CONFIG_UBSAN:
> 
>   clang -Wp,-MD,arch/arm64/kernel/.setup.o.d  -nostdinc -isystem
>   /mnt/data/opt/toolchain/llvm/8.0.0/clang+llvm-8.0.0-x86_64-linux-sles11.3/lib/clang/8.0.0/include
>   -I./arch/arm64/include -I./arch/arm64/include/generated  -I./include
>   -I./arch/arm64/include/uapi -I./arch/arm64/include/generated/uapi
>   -I./include/uapi -I./include/generated/uapi -include
>   ./include/linux/kconfig.h -include ./include/linux/compiler_types.h
>   -D__KERNEL__ -mlittle-endian -DKASAN_SHADOW_SCALE_SHIFT=3
>   -Qunused-arguments -Wall -Wundef -Werror=strict-prototypes
>   -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE
>   -Werror=implicit-function-declaration -Werror=implicit-int
>   -Wno-format-security -std=gnu89 --target=aarch64-linux
>   --prefix=/mnt/data/opt/toolchain/kernel-org-crosstool/gcc-8.1.0-nolibc/aarch64-linux/bin/
>   --gcc-toolchain=/mnt/data/opt/toolchain/kernel-org-crosstool/gcc-8.1.0-nolibc/aarch64-linux
>   -no-integrated-as -Werror=unknown-warning-option -mgeneral-regs-only
>   -DCONFIG_AS_LSE=1 -fno-asynchronous-unwind-tables
>   -DKASAN_SHADOW_SCALE_SHIFT=3 -fno-delete-null-pointer-checks
>   -Wno-address-of-packed-member -O2 -Wframe-larger-than=2048
>   -fstack-protector-strong -Wno-format-invalid-specifier -Wno-gnu
>   -Wno-tautological-compare -mno-global-merge -Wno-unused-const-variable
>   -fno-omit-frame-pointer -fno-optimize-sibling-calls -g
>   -Wdeclaration-after-statement -Wvla -Wno-pointer-sign
>   -fno-strict-overflow -fno-merge-all-constants -fno-stack-check
>   -Werror=date-time -Werror=incompatible-pointer-types
>   -Wno-initializer-overrides -Wno-format -Wno-sign-compare
>   -Wno-format-zero-length    -fsanitize=shift
>   -fsanitize=integer-divide-by-zero  -fsanitize=unreachable
>   -fsanitize=signed-integer-overflow  -fsanitize=bounds
>   -fsanitize=object-size  -fsanitize=bool  -fsanitize=enum
>   -fsanitize-coverage=trace-pc    -DKBUILD_BASENAME='"setup"'
>   -DKBUILD_MODNAME='"setup"' -c -o arch/arm64/kernel/setup.o
>   arch/arm64/kernel/setup.c
> 
>   ... and there are 0 calls to __sanitizer_cov_trace_pc in the resulting
>   setup.o, even though -fsanitize-coverage=trace-pc was passed to clang.
> 
> If I remove -fsanitize=bounds, there are 121 calls to
> __sanitizer_cov_trace_pc in setup.o. Removing the other options enabled
> by UBSAN didn't have any effect on setup.o.
> 
> I'm using the llvm.org 8.0.{0,1} binaries [1,2], along with the
> kernel.org crosstool 8.1.0 binaries [3].
> 
> Any ideas as to what's going on?
> 
> Thanks,
> Mark.
> 
> [1] http://releases.llvm.org/download.html#8.0.0
> [2] http://releases.llvm.org/download.html#8.0.1
> [3] https://mirrors.edge.kernel.org/pub/tools/crosstool/

Hi Mark,

I've narrowed it down further; it seems that the combination of
-fsanitize-coverage=trace-pc and -fsanitize=local-bounds prevents the
emission of __sanitizer_cov_trace_pc. -fsanitize=bounds is the same as
-fsanitize=local-bounds and -fsanitize=array-bounds, the latter of which
has no issues.

https://godbolt.org/z/YdF-he

This reproducer was taken from a somewhat related bug report in April.

https://bugs.llvm.org/show_bug.cgi?id=41387

What's also interesting is when you remove -Qunused-arguments from the
clang command, the following warning appears (also visible in the
godbolt link):

clang-10: warning: argument unused during compilation:
'-fsanitize-coverage=trace-pc' [-Wunused-command-line-argument]

I have no idea why this combination is special, I've been searching the
source trying to see what I can find and I am currently not coming up
with anything (I'm sure a good night's rest will give me a fresh set of
eyes).

This is still an issue on Clang trunk.

Cheers,
Nathan
