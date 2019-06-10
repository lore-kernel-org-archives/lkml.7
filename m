Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900D0C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF282082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389219AbfFJKBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 06:01:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56642 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389034AbfFJKBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 06:01:14 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2E5DBBBC5DAFD6257719;
        Mon, 10 Jun 2019 18:01:11 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Mon, 10 Jun 2019 18:00:52 +0800
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
Subject: [PATCH 3/5] perf jevents: Add support for Hisi hip08 DDRC PMU aliasing
Date:   Mon, 10 Jun 2019 17:59:30 +0800
Message-ID: <1560160772-210844-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1560160772-210844-1-git-send-email-john.garry@huawei.com>
References: <1560160772-210844-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Hisi hip08 DDRC PMU event aliasing. We can now do
something like this:

$perf list

[snip]

uncore ddrc:
  uncore_hisi_sccl_ddrc.act_cmd
       [DDRC active commands. Unit: hisi_sccl,ddrc]
  uncore_hisi_sccl_ddrc.flux_rcmd
       [DDRC read commands. Unit: hisi_sccl,ddrc]
  uncore_hisi_sccl_ddrc.flux_wcmd
       [DDRC write commands. Unit: hisi_sccl,ddrc]
  uncore_hisi_sccl_ddrc.flux_wr
       [DDRC precharge commands. Unit: hisi_sccl,ddrc]
  uncore_hisi_sccl_ddrc.rnk_chg
       [DDRC rank commands. Unit: hisi_sccl,ddrc]
  uncore_hisi_sccl_ddrc.rw_chg
       [DDRC read and write changes. Unit: hisi_sccl,ddrc]

$sudo ./perf stat -e uncore_hisi_sccl_ddrc.flux_rcmd --no-merge sleep 1

 Performance counter stats for 'system wide':

                 0      uncore_hisi_sccl_ddrc.flux_rcmd [hisi_sccl1_ddrc0]
                 0      uncore_hisi_sccl_ddrc.flux_rcmd [hisi_sccl3_ddrc1]
                 0      uncore_hisi_sccl_ddrc.flux_rcmd [hisi_sccl1_ddrc3]
                 0      uncore_hisi_sccl_ddrc.flux_rcmd [hisi_sccl1_ddrc1]
                 0      uncore_hisi_sccl_ddrc.flux_rcmd [hisi_sccl3_ddrc2]
                 0      uncore_hisi_sccl_ddrc.flux_rcmd [hisi_sccl3_ddrc0]
            25,722      uncore_hisi_sccl_ddrc.flux_rcmd [hisi_sccl1_ddrc2]
                 0      uncore_hisi_sccl_ddrc.flux_rcmd [hisi_sccl3_ddrc3]

       1.001344685 seconds time elapsed

The kernel driver is in drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arm64/hisilicon/hip08/uncore-ddrc.json    | 44 +++++++++++++++++++
 tools/perf/pmu-events/jevents.c               |  1 +
 2 files changed, 45 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
new file mode 100644
index 000000000000..901b1fe65629
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
@@ -0,0 +1,44 @@
+[
+   {
+	    "EventCode": "0x02",
+	    "EventName": "uncore_hisi_sccl_ddrc.flux_wcmd",
+	    "BriefDescription": "DDRC write commands",
+	    "PublicDescription": "DDRC write commands",
+	    "Unit": "hisi_sccl,ddrc",
+   },
+   {
+	    "EventCode": "0x03",
+	    "EventName": "uncore_hisi_sccl_ddrc.flux_rcmd",
+	    "BriefDescription": "DDRC read commands",
+	    "PublicDescription": "DDRC read commands",
+	    "Unit": "hisi_sccl,ddrc",
+   },
+   {
+	    "EventCode": "0x04",
+	    "EventName": "uncore_hisi_sccl_ddrc.flux_wr",
+	    "BriefDescription": "DDRC precharge commands",
+	    "PublicDescription": "DDRC precharge commands",
+	    "Unit": "hisi_sccl,ddrc",
+   },
+   {
+	    "EventCode": "0x05",
+	    "EventName": "uncore_hisi_sccl_ddrc.act_cmd",
+	    "BriefDescription": "DDRC active commands",
+	    "PublicDescription": "DDRC active commands",
+	    "Unit": "hisi_sccl,ddrc",
+   },
+   {
+	    "EventCode": "0x06",
+	    "EventName": "uncore_hisi_sccl_ddrc.rnk_chg",
+	    "BriefDescription": "DDRC rank commands",
+	    "PublicDescription": "DDRC rank commands",
+	    "Unit": "hisi_sccl,ddrc",
+   },
+   {
+	    "EventCode": "0x07",
+	    "EventName": "uncore_hisi_sccl_ddrc.rw_chg",
+	    "BriefDescription": "DDRC read and write changes",
+	    "PublicDescription": "DDRC read and write changes",
+	    "Unit": "hisi_sccl,ddrc",
+   },
+]
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 58f77fd0f59f..cf9a60333554 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -236,6 +236,7 @@ static struct map {
 	{ "CPU-M-CF", "cpum_cf" },
 	{ "CPU-M-SF", "cpum_sf" },
 	{ "UPI LL", "uncore_upi" },
+	{ "hisi_sccl,ddrc", "hisi_sccl,ddrc" },
 	{}
 };
 
-- 
2.17.1

