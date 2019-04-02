Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D75C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4416D208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbfDBGlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:41:05 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:45631 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729202AbfDBGlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:41:04 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07652075|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.411663-0.127946-0.46039;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16378;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.EFvqbEk_1554187232;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.EFvqbEk_1554187232)
          by smtp.aliyun-inc.com(10.147.41.138);
          Tue, 02 Apr 2019 14:40:32 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mao Han <han_mao@c-sky.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, Guo Ren <guoren@kernel.org>
Subject: [PATCH v2 0/2] csky: perf callchain dwarf support
Date:   Tue,  2 Apr 2019 14:35:40 +0800
Message-Id: <cover.1554186270.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set add perf DWARF unwinding support for C-SKY.
Including user registers/stack dump API, and libdw support.

Changes since v1:
  - seperate the callchain support using frame pointer

CC: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: Jiri Olsa <jolsa@redhat.com>
CC: Namhyung Kim <namhyung@kernel.org>
CC: Guo Ren <guoren@kernel.org>

Mao Han (2):
  csky: Add support for perf registers sampling
  csky: add support for libdw

 arch/csky/Kconfig                            |  2 +
 arch/csky/include/uapi/asm/perf_regs.h       | 48 ++++++++++++++
 arch/csky/kernel/Makefile                    |  1 +
 arch/csky/kernel/perf_regs.c                 | 40 ++++++++++++
 tools/arch/csky/include/uapi/asm/perf_regs.h | 48 ++++++++++++++
 tools/perf/Makefile.config                   |  6 +-
 tools/perf/arch/csky/Build                   |  1 +
 tools/perf/arch/csky/Makefile                |  3 +
 tools/perf/arch/csky/include/perf_regs.h     | 98 ++++++++++++++++++++++++++++
 tools/perf/arch/csky/util/Build              |  2 +
 tools/perf/arch/csky/util/dwarf-regs.c       | 25 +++++++
 tools/perf/arch/csky/util/unwind-libdw.c     | 58 ++++++++++++++++
 12 files changed, 331 insertions(+), 1 deletion(-)
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

