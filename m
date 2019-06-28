Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7099C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAFCA208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfF1Oha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 10:37:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57372 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726785AbfF1Oh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 10:37:29 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 67663DD812BA72D3E07C;
        Fri, 28 Jun 2019 22:37:27 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Fri, 28 Jun 2019 22:37:20 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <tmricht@linux.ibm.com>,
        <brueckner@linux.ibm.com>, <kan.liang@linux.intel.com>,
        <ben@decadent.org.uk>, <mathieu.poirier@linaro.org>,
        <mark.rutland@arm.com>, <will.deacon@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>, <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 0/4] Perf uncore PMU event alias support for Hisi hip08 ARM64 platform
Date:   Fri, 28 Jun 2019 22:35:48 +0800
Message-ID: <1561732552-143038-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for uncore PMU event aliasing for HiSilicon
hip08 ARM64 platform.

We can now get proper event description for uncore events for the
perf tool.

For HHA, DDRC, and L3C JSONs, we don't have all the event info yet, so
I will seek it out to update the JSONs later.

Changes to v3:
- Omit "perf pmu: Fix uncore PMU alias list for ARM64", as it has already
  been picked up
- Add comment for pmu_uncore_alias_match()

Changes to v2:
- Use strtok_r() in pmu_uncore_alias_match()
- from "sccl" from uncore aliases

John Garry (4):
  perf pmu: Support more complex PMU event aliasing
  perf jevents: Add support for Hisi hip08 DDRC PMU aliasing
  perf jevents: Add support for Hisi hip08 HHA PMU aliasing
  perf jevents: Add support for Hisi hip08 L3C PMU aliasing

 .../arm64/hisilicon/hip08/uncore-ddrc.json    | 44 ++++++++++++++++
 .../arm64/hisilicon/hip08/uncore-hha.json     | 51 +++++++++++++++++++
 .../arm64/hisilicon/hip08/uncore-l3c.json     | 37 ++++++++++++++
 tools/perf/pmu-events/jevents.c               |  3 ++
 tools/perf/util/pmu.c                         | 46 +++++++++++++++--
 5 files changed, 176 insertions(+), 5 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json

-- 
2.17.1

