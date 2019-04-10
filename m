Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42544C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097532133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfDJIYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:24:49 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:57327 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729024AbfDJIYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:24:49 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436846|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.438601-0.11346-0.44794;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03310;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.EJJYW7S_1554884686;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.EJJYW7S_1554884686)
          by smtp.aliyun-inc.com(10.147.40.7);
          Wed, 10 Apr 2019 16:24:46 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, Guo Ren <guoren@kernel.org>
Subject: [PATCH v3 0/3] csky: perf callchain dwarf support
Date:   Wed, 10 Apr 2019 16:16:42 +0800
Message-Id: <cover.1554883878.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set add perf DWARF unwinding support for C-SKY.
Including user registers/stack dump API, and libdw support.

CC: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: Jiri Olsa <jolsa@redhat.com>
CC: Namhyung Kim <namhyung@kernel.org>
CC: Guo Ren <guoren@kernel.org>

Changes since v2:
  - use same registers name as struct pt_regs
  - code convention

Changes since v1:
  - seperate the callchain support using frame pointer

Mao Han (3):
  perf: use hweight64 instead of hweight_long
  csky: Add support for perf registers sampling
  csky: add support for libdw

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
 tools/perf/arch/csky/util/unwind-libdw.c     |  78 +++++++++++++++++++++
 tools/perf/util/evsel.c                      |   2 +-
 13 files changed, 384 insertions(+), 2 deletions(-)
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

