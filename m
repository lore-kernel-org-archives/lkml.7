Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916DBC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 06:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CD7233A0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 06:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392328AbfHWGQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 02:16:08 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:34193 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390037AbfHWGQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 02:16:08 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07521714|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.525283-0.101757-0.37296;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03309;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.FGwcr64_1566540964;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.FGwcr64_1566540964)
          by smtp.aliyun-inc.com(10.147.41.158);
          Fri, 23 Aug 2019 14:16:04 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Mao Han <han_mao@c-sky.com>
Subject: [PATCH V5 0/3] riscv: Add perf callchain support
Date:   Fri, 23 Aug 2019 14:15:57 +0800
Message-Id: <cover.1566540652.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set add perf callchain(FP/DWARF) support for RISC-V.
It comes from the csky version callchain support with some
slight modifications. The patchset base on Linux 5.3.

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


Mao Han (3):
  riscv: Add perf callchain support
  riscv: Add support for perf registers sampling
  riscv: Add support for libdw

 arch/riscv/Kconfig                            |   2 +
 arch/riscv/Makefile                           |   3 +
 arch/riscv/include/uapi/asm/perf_regs.h       |  42 ++++++++++
 arch/riscv/kernel/Makefile                    |   4 +-
 arch/riscv/kernel/perf_callchain.c            | 115 ++++++++++++++++++++++++++
 arch/riscv/kernel/perf_regs.c                 |  44 ++++++++++
 tools/arch/riscv/include/uapi/asm/perf_regs.h |  42 ++++++++++
 tools/perf/Makefile.config                    |   6 +-
 tools/perf/arch/riscv/Build                   |   1 +
 tools/perf/arch/riscv/Makefile                |   4 +
 tools/perf/arch/riscv/include/perf_regs.h     |  96 +++++++++++++++++++++
 tools/perf/arch/riscv/util/Build              |   2 +
 tools/perf/arch/riscv/util/dwarf-regs.c       |  72 ++++++++++++++++
 tools/perf/arch/riscv/util/unwind-libdw.c     |  57 +++++++++++++
 14 files changed, 488 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/include/uapi/asm/perf_regs.h
 create mode 100644 arch/riscv/kernel/perf_callchain.c
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

