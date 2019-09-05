Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87363C3A5AA
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 03:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E6E2168B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 03:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbfIEDqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 23:46:44 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:36994 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730112AbfIEDqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 23:46:44 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07439447|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.453906-0.11693-0.429164;FP=0|0|0|0|0|-1|-1|-1;HT=e01l10434;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.FP-7udU_1567655200;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.FP-7udU_1567655200)
          by smtp.aliyun-inc.com(10.147.40.44);
          Thu, 05 Sep 2019 11:46:40 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Mao Han <han_mao@c-sky.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <green.hu@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>
Subject: [PATCH V7 0/2] riscv: Add perf callchain support
Date:   Thu,  5 Sep 2019 11:46:34 +0800
Message-Id: <cover.1567653632.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds perf callchain(FP/DWARF) support for RISC-V.
It comes from the csky version callchain support with some
slight modifications. The patchset base on Linux 5.3-rc6.

The patchset has some 'checkpatch.pl --strict' warnings:
WARNING: Use #include <linux/perf_regs.h> instead of <asm/perf_regs.h>
#141: FILE: tools/perf/arch/riscv/include/perf_regs.h:9:
+#include <asm/perf_regs.h>

CHECK: Avoid CamelCase: <Dwfl_Thread>
#329: FILE: tools/perf/arch/riscv/util/unwind-libdw.c:9:
+bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)

CHECK: Avoid CamelCase: <Dwarf_Word>
#333: FILE: tools/perf/arch/riscv/util/unwind-libdw.c:13:
+	Dwarf_Word dwarf_regs[32];
As all the other Linux architectures use asm/perf_regs.h directly and
get these camelcases, I didn't try to fix them.

Changes since v6:
  - add "WITH Linux-syscall-note" for uapi headers.

Changes since v5:
  - use walk_stackframe from stacktrace.c to handle
    kernel callchain unwinding(fix invalid mem access)

Changes since v4:
  - Add missing PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET
    verified with extra CFLAGS(-Wall -Werror)

Changes since v3:
  - Add more strict check for unwind_frame_kernel
  - update for kernel 5.3

Changes since v2:
  - fix inconsistent comment
  - force to build kernel with -fno-omit-frame-pointer if perf
    event is enabled

Changes since v1:
  - simplify implementation and code convention

Signed-off-by: Mao Han <han_mao@c-sky.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: linux-riscv <linux-riscv@lists.infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Guo Ren <guoren@kernel.org>

Mao Han (2):
  riscv: Add support for perf registers sampling
  riscv: Add support for libdw

 arch/riscv/Kconfig                            |  2 +
 arch/riscv/include/uapi/asm/perf_regs.h       | 42 ++++++++++++
 arch/riscv/kernel/Makefile                    |  1 +
 arch/riscv/kernel/perf_regs.c                 | 44 ++++++++++++
 tools/arch/riscv/include/uapi/asm/perf_regs.h | 42 ++++++++++++
 tools/perf/Makefile.config                    |  6 +-
 tools/perf/arch/riscv/Build                   |  1 +
 tools/perf/arch/riscv/Makefile                |  4 ++
 tools/perf/arch/riscv/include/perf_regs.h     | 96 +++++++++++++++++++++++++++
 tools/perf/arch/riscv/util/Build              |  2 +
 tools/perf/arch/riscv/util/dwarf-regs.c       | 72 ++++++++++++++++++++
 tools/perf/arch/riscv/util/unwind-libdw.c     | 57 ++++++++++++++++
 12 files changed, 368 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/uapi/asm/perf_regs.h
 create mode 100644 arch/riscv/kernel/perf_regs.c
 create mode 100644 tools/arch/riscv/include/uapi/asm/perf_regs.h
 create mode 100644 tools/perf/arch/riscv/Build
 create mode 100644 tools/perf/arch/riscv/Makefile
 create mode 100644 tools/perf/arch/riscv/include/perf_regs.h
 create mode 100644 tools/perf/arch/riscv/util/Build
 create mode 100644 tools/perf/arch/riscv/util/dwarf-regs.c
 create mode 100644 tools/perf/arch/riscv/util/unwind-libdw.c

-- 
2.7.4

