Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BECAC43215
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 09:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA6A2071B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 09:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfKWJYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 04:24:39 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6704 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726141AbfKWJYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 04:24:39 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4E1E4951DB582CD7BE01;
        Sat, 23 Nov 2019 17:24:35 +0800 (CST)
Received: from huawei.com (10.175.102.38) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Sat, 23 Nov 2019
 17:24:25 +0800
From:   Tan Xiaojun <tanxiaojun@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <ak@linux.intel.com>,
        <adrian.hunter@intel.com>, <yao.jin@linux.intel.com>,
        <tmricht@linux.ibm.com>, <brueckner@linux.ibm.com>,
        <songliubraving@fb.com>, <gregkh@linuxfoundation.org>,
        <kim.phillips@arm.com>, <James.Clark@arm.com>,
        <jeremy.linton@arm.com>
CC:     <gengdongjiu@huawei.com>, <wxf.wang@hisilicon.com>,
        <liwei391@huawei.com>, <tanxiaojun@huawei.com>,
        <huawei.libin@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>
Subject: [RFC v3 0/5] perf tools: Add support for some spe events and precise ip
Date:   Sat, 23 Nov 2019 18:11:13 +0800
Message-ID: <20191123101118.12635-1-tanxiaojun@huawei.com>
X-Mailer: git-send-email 2.17.1
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
of llc-miss, tlb-miss, branch-miss and remote-access is added.

v1->v2:
Some cleanup and bugfix fixes were made, and support for the precise
ip of branch-misses was added. Thanks for the suggestions of Jeremy
and James.

v2->v3:
Mainly add four spe precise ip events, you can see through perf list.
More details in [5/5].

Tan Xiaojun (5):
  perf tools: Move arm-spe-pkt-decoder.h/c to the new dir
  perf tools: Add support for "report" for some spe events
  perf report: Add --spe options for arm-spe
  drivers: perf: add some arm spe events
  perf tools: Add support to process multi spe events

 drivers/perf/arm_spe_pmu.c                    |  44 +
 tools/perf/Documentation/perf-report.txt      |  10 +
 tools/perf/arch/arm64/util/arm-spe.c          |  47 +-
 tools/perf/builtin-report.c                   |   5 +
 tools/perf/util/Build                         |   2 +-
 tools/perf/util/arm-spe-decoder/Build         |   1 +
 .../util/arm-spe-decoder/arm-spe-decoder.c    | 225 +++++
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  66 ++
 .../arm-spe-pkt-decoder.c                     |   0
 .../arm-spe-pkt-decoder.h                     |   2 +
 tools/perf/util/arm-spe.c                     | 771 +++++++++++++++++-
 tools/perf/util/arm-spe.h                     |  20 +
 tools/perf/util/auxtrace.c                    |  49 ++
 tools/perf/util/auxtrace.h                    |  29 +
 tools/perf/util/session.h                     |   2 +
 15 files changed, 1231 insertions(+), 42 deletions(-)
 create mode 100644 tools/perf/util/arm-spe-decoder/Build
 create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
 create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
 rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.c (100%)
 rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.h (96%)

-- 
2.17.1

