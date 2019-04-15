Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7518FC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40AA820656
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfDOJWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:22:48 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:37645 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725798AbfDOJWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:22:48 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07654969|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.415708-0.142496-0.441796;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03277;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.ELbNRwG_1555320166;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.ELbNRwG_1555320166)
          by smtp.aliyun-inc.com(10.147.40.7);
          Mon, 15 Apr 2019 17:22:46 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>, Guo Ren <guoren@kernel.org>
Subject: [PATCH V5 0/2] csky: perf callchain dwarf support
Date:   Mon, 15 Apr 2019 17:17:28 +0800
Message-Id: <cover.1555319439.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set add perf DWARF unwinding support for C-SKY.
Including user registers/stack dump API, and libdw support.

CC: Guo Ren <guoren@kernel.org>

Changes since v4:
  - remove some of the dwarf regs definition

Changes since v3:
  - update with patch from Arnaldo
    replace other hweight_long with hweight64

Changes since v2:
  - use same registers name as struct pt_regs
  - code convention

Changes since v1:
  - seperate the callchain support using frame pointer
Mao Han (2):
  csky: Add support for perf registers sampling
  csky: Add support for libdw

 arch/csky/Kconfig                            |   2 +
 arch/csky/include/uapi/asm/perf_regs.h       |  51 ++++++++++++++
 arch/csky/kernel/Makefile                    |   1 +
 arch/csky/kernel/perf_regs.c                 |  40 +++++++++++
 tools/arch/csky/include/uapi/asm/perf_regs.h |  51 ++++++++++++++
 tools/perf/Makefile.config                   |   6 +-
 tools/perf/arch/csky/Build                   |   1 +
 tools/perf/arch/csky/Makefile                |   3 +
 tools/perf/arch/csky/include/perf_regs.h     | 100 +++++++++++++++++++++++++++
 tools/perf/arch/csky/util/Build              |   2 +
 tools/perf/arch/csky/util/dwarf-regs.c       |  49 +++++++++++++
 tools/perf/arch/csky/util/unwind-libdw.c     |  77 +++++++++++++++++++++
 12 files changed, 382 insertions(+), 1 deletion(-)
 create mode 100644 arch/csky/include/uapi/asm/perf_regs.h
 create mode 100644 arch/csky/kernel/perf_regs.c
 create mode 100644 tools/arch/csky/include/uapi/asm/perf_regs.h
 create mode 100644 tools/perf/arch/csky/Build
 create mode 100644 tools/perf/arch/csky/Makefile
 create mode 100644 tools/perf/arch/csky/include/perf_regs.h
 create mode 100644 tools/perf/arch/csky/util/Build
 create mode 100644 tools/perf/arch/csky/util/dwarf-regs.c
 create mode 100644 tools/perf/arch/csky/util/unwind-libdw.c

-- 
2.7.4

