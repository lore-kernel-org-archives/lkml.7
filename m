Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5D0C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2853721773
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404363AbfHBI51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 04:57:27 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41812 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728157AbfHBI50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:57:26 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D7B11396BBB377ADAA3F;
        Fri,  2 Aug 2019 16:57:24 +0800 (CST)
Received: from huawei.com (10.175.102.38) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 2 Aug 2019
 16:57:17 +0800
From:   Tan Xiaojun <tanxiaojun@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <ak@linux.intel.com>,
        <adrian.hunter@intel.com>, <yao.jin@linux.intel.com>,
        <tmricht@linux.ibm.com>, <brueckner@linux.ibm.com>,
        <songliubraving@fb.com>, <gregkh@linuxfoundation.org>,
        <kim.phillips@arm.com>
CC:     <gengdongjiu@huawei.com>, <wxf.wang@hisilicon.com>,
        <liwei391@huawei.com>, <tanxiaojun@huawei.com>,
        <huawei.libin@huawei.com>, <linux-kernel@vger.kernel.org>,
        <jeremy.linton@arm.com>, <linux-perf-users@vger.kernel.org>
Subject: [RFC PATCH 0/3] perf tools: Add support for "report" for some spe events
Date:   Fri, 2 Aug 2019 17:40:10 +0800
Message-ID: <1564738813-10944-1-git-send-email-tanxiaojun@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the commit ffd3d18c20b8 ("perf tools: Add ARM Statistical
Profiling Extensions (SPE) support") is merged, "perf record" and
"perf report --dump-raw-trace" have been supported. However, the
raw data that is dumped cannot be used without parsing.

This patchset is to improve the "perf report" support for spe, and
further process the data. Currently, support for the three events
of llc-miss, tlb-miss, and branch-miss is added.

More details in [2/3].

Tan Xiaojun (3):
  perf tools: Move arm-spe-pkt-decoder.h/c to the new dir
  perf tools: Add support for "report" for some spe events
  perf report: add --spe options for arm-spe

 tools/perf/Documentation/perf-report.txt           |   9 +
 tools/perf/builtin-report.c                        |   5 +
 tools/perf/util/Build                              |   2 +-
 tools/perf/util/arm-spe-decoder/Build              |   1 +
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c  | 214 ++++++
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h  |  51 ++
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     | 462 +++++++++++++
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |  45 ++
 tools/perf/util/arm-spe-pkt-decoder.c              | 462 -------------
 tools/perf/util/arm-spe-pkt-decoder.h              |  43 --
 tools/perf/util/arm-spe.c                          | 717 ++++++++++++++++++++-
 tools/perf/util/auxtrace.c                         |  45 ++
 tools/perf/util/auxtrace.h                         |  27 +
 tools/perf/util/session.h                          |   2 +
 14 files changed, 1544 insertions(+), 541 deletions(-)
 create mode 100644 tools/perf/util/arm-spe-decoder/Build
 create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
 create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
 create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
 create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
 delete mode 100644 tools/perf/util/arm-spe-pkt-decoder.c
 delete mode 100644 tools/perf/util/arm-spe-pkt-decoder.h

-- 
2.7.4

