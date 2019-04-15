Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE85EC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9861C2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfDOJ5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:57:32 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:41705 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725794AbfDOJ5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:57:30 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07511862|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.504454-0.105798-0.389748;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07423;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.ELbwotw_1555322247;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.ELbwotw_1555322247)
          by smtp.aliyun-inc.com(10.147.40.2);
          Mon, 15 Apr 2019 17:57:27 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>, Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>
Subject: [PATCH v2 0/3] riscv: Add perf callchain support
Date:   Mon, 15 Apr 2019 17:52:10 +0800
Message-Id: <cover.1555320740.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set add perf callchain(FP/DWARF) support for RISC-V.
It comes from the csky version callchain support with some
slight modifications. The patchset base on Linux 5.1-rc4:
15ade5d2e7775667cf191cf2f94327a4889f8b9d

CC: Palmer Dabbelt <palmer@sifive.com>
CC: linux-riscv<linux-riscv@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>
CC: Guo Ren <guoren@kernel.org>

Changes since v1:
  - simplify implementation and code convention

Mao Han (3):
  riscv: Add perf callchain support
  riscv: Add support for perf registers sampling
  riscv: Add support for libdw

 arch/riscv/Kconfig                            |   2 +
 arch/riscv/include/uapi/asm/perf_regs.h       |  42 ++++++++++
 arch/riscv/kernel/Makefile                    |   4 +-
 arch/riscv/kernel/perf_callchain.c            | 113 ++++++++++++++++++++++++++
 arch/riscv/kernel/perf_regs.c                 |  44 ++++++++++
 tools/arch/riscv/include/uapi/asm/perf_regs.h |  42 ++++++++++
 tools/perf/Makefile.config                    |   6 +-
 tools/perf/arch/riscv/Build                   |   1 +
 tools/perf/arch/riscv/Makefile                |   3 +
 tools/perf/arch/riscv/include/perf_regs.h     |  96 ++++++++++++++++++++++
 tools/perf/arch/riscv/util/Build              |   2 +
 tools/perf/arch/riscv/util/dwarf-regs.c       |  72 ++++++++++++++++
 tools/perf/arch/riscv/util/unwind-libdw.c     |  57 +++++++++++++
 13 files changed, 482 insertions(+), 2 deletions(-)
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

