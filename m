Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72E5C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BAC22CEA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfHSQ7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 12:59:55 -0400
Received: from foss.arm.com ([217.140.110.172]:57500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbfHSQ7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 12:59:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14C1F360;
        Mon, 19 Aug 2019 09:59:54 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 472E53F718;
        Mon, 19 Aug 2019 09:59:53 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:59:48 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        clang-built-linux@googlegroups.com
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Enabling UBSAN breaks KCOV in clang (8.0.*) on arm64
Message-ID: <20190819165947.GA30292@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found that when I enable both KCOV and UBSAN on arm64, clang fails to
emit any __sanitizer_cov_trace_*() calls in the resulting binary,
rendering KCOV useless.

For example, when building v5.3-rc3's arch/arm64/kernel/setup.o:

* With defconfig + CONFIG KCOV:

  clang -Wp,-MD,arch/arm64/kernel/.setup.o.d  -nostdinc -isystem
  /mnt/data/opt/toolchain/llvm/8.0.0/clang+llvm-8.0.0-x86_64-linux-sles11.3/lib/clang/8.0.0/include
  -I./arch/arm64/include -I./arch/arm64/include/generated  -I./include
  -I./arch/arm64/include/uapi -I./arch/arm64/include/generated/uapi
  -I./include/uapi -I./include/generated/uapi -include
  ./include/linux/kconfig.h -include ./include/linux/compiler_types.h
  -D__KERNEL__ -mlittle-endian -DKASAN_SHADOW_SCALE_SHIFT=3
  -Qunused-arguments -Wall -Wundef -Werror=strict-prototypes
  -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE
  -Werror=implicit-function-declaration -Werror=implicit-int
  -Wno-format-security -std=gnu89 --target=aarch64-linux
  --prefix=/mnt/data/opt/toolchain/kernel-org-crosstool/gcc-8.1.0-nolibc/aarch64-linux/bin/
  --gcc-toolchain=/mnt/data/opt/toolchain/kernel-org-crosstool/gcc-8.1.0-nolibc/aarch64-linux
  -no-integrated-as -Werror=unknown-warning-option -mgeneral-regs-only
  -DCONFIG_AS_LSE=1 -fno-asynchronous-unwind-tables
  -DKASAN_SHADOW_SCALE_SHIFT=3 -fno-delete-null-pointer-checks
  -Wno-address-of-packed-member -O2 -Wframe-larger-than=2048
  -fstack-protector-strong -Wno-format-invalid-specifier -Wno-gnu
  -Wno-tautological-compare -mno-global-merge -Wno-unused-const-variable
  -fno-omit-frame-pointer -fno-optimize-sibling-calls -g
  -Wdeclaration-after-statement -Wvla -Wno-pointer-sign
  -fno-strict-overflow -fno-merge-all-constants -fno-stack-check
  -Werror=date-time -Werror=incompatible-pointer-types
  -Wno-initializer-overrides -Wno-format -Wno-sign-compare
  -Wno-format-zero-length  -fsanitize-coverage=trace-pc
  -DKBUILD_BASENAME='"setup"' -DKBUILD_MODNAME='"setup"' -c -o
  arch/arm64/kernel/setup.o arch/arm64/kernel/setup.c

  ... and there are 44 calls to __sanitizer_cov_trace_pc in the
  resulting setup.o

* with defconfig + CONFIG_KCOV + CONFIG_UBSAN:

  clang -Wp,-MD,arch/arm64/kernel/.setup.o.d  -nostdinc -isystem
  /mnt/data/opt/toolchain/llvm/8.0.0/clang+llvm-8.0.0-x86_64-linux-sles11.3/lib/clang/8.0.0/include
  -I./arch/arm64/include -I./arch/arm64/include/generated  -I./include
  -I./arch/arm64/include/uapi -I./arch/arm64/include/generated/uapi
  -I./include/uapi -I./include/generated/uapi -include
  ./include/linux/kconfig.h -include ./include/linux/compiler_types.h
  -D__KERNEL__ -mlittle-endian -DKASAN_SHADOW_SCALE_SHIFT=3
  -Qunused-arguments -Wall -Wundef -Werror=strict-prototypes
  -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE
  -Werror=implicit-function-declaration -Werror=implicit-int
  -Wno-format-security -std=gnu89 --target=aarch64-linux
  --prefix=/mnt/data/opt/toolchain/kernel-org-crosstool/gcc-8.1.0-nolibc/aarch64-linux/bin/
  --gcc-toolchain=/mnt/data/opt/toolchain/kernel-org-crosstool/gcc-8.1.0-nolibc/aarch64-linux
  -no-integrated-as -Werror=unknown-warning-option -mgeneral-regs-only
  -DCONFIG_AS_LSE=1 -fno-asynchronous-unwind-tables
  -DKASAN_SHADOW_SCALE_SHIFT=3 -fno-delete-null-pointer-checks
  -Wno-address-of-packed-member -O2 -Wframe-larger-than=2048
  -fstack-protector-strong -Wno-format-invalid-specifier -Wno-gnu
  -Wno-tautological-compare -mno-global-merge -Wno-unused-const-variable
  -fno-omit-frame-pointer -fno-optimize-sibling-calls -g
  -Wdeclaration-after-statement -Wvla -Wno-pointer-sign
  -fno-strict-overflow -fno-merge-all-constants -fno-stack-check
  -Werror=date-time -Werror=incompatible-pointer-types
  -Wno-initializer-overrides -Wno-format -Wno-sign-compare
  -Wno-format-zero-length    -fsanitize=shift
  -fsanitize=integer-divide-by-zero  -fsanitize=unreachable
  -fsanitize=signed-integer-overflow  -fsanitize=bounds
  -fsanitize=object-size  -fsanitize=bool  -fsanitize=enum
  -fsanitize-coverage=trace-pc    -DKBUILD_BASENAME='"setup"'
  -DKBUILD_MODNAME='"setup"' -c -o arch/arm64/kernel/setup.o
  arch/arm64/kernel/setup.c

  ... and there are 0 calls to __sanitizer_cov_trace_pc in the resulting
  setup.o, even though -fsanitize-coverage=trace-pc was passed to clang.

If I remove -fsanitize=bounds, there are 121 calls to
__sanitizer_cov_trace_pc in setup.o. Removing the other options enabled
by UBSAN didn't have any effect on setup.o.

I'm using the llvm.org 8.0.{0,1} binaries [1,2], along with the
kernel.org crosstool 8.1.0 binaries [3].

Any ideas as to what's going on?

Thanks,
Mark.

[1] http://releases.llvm.org/download.html#8.0.0
[2] http://releases.llvm.org/download.html#8.0.1
[3] https://mirrors.edge.kernel.org/pub/tools/crosstool/
