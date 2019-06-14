Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446CAC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1680B2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbfFNOJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:09:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18574 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728762AbfFNOJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:09:36 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CBC109D5139CFB18DE92;
        Fri, 14 Jun 2019 22:09:34 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Fri, 14 Jun 2019 22:09:24 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <tmricht@linux.ibm.com>,
        <brueckner@linux.ibm.com>, <kan.liang@linux.intel.com>,
        <ben@decadent.org.uk>, <mathieu.poirier@linaro.org>,
        <mark.rutland@arm.com>, <will.deacon@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH v2 5/5] perf jevents: Add support for Hisi hip08 L3C PMU aliasing
Date:   Fri, 14 Jun 2019 22:08:03 +0800
Message-ID: <1560521283-73314-6-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1560521283-73314-1-git-send-email-john.garry@huawei.com>
References: <1560521283-73314-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Hisi hip08 L3C PMU aliasing.

The kernel driver is in drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arm64/hisilicon/hip08/uncore-l3c.json     | 37 +++++++++++++++++++
 tools/perf/pmu-events/jevents.c               |  1 +
 2 files changed, 38 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json
new file mode 100644
index 000000000000..ca48747642e1
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-l3c.json
@@ -0,0 +1,37 @@
+[
+   {
+	    "EventCode": "0x00",
+	    "EventName": "uncore_hisi_l3c.rd_cpipe",
+	    "BriefDescription": "Total read accesses",
+	    "PublicDescription": "Total read accesses",
+	    "Unit": "hisi_sccl,l3c",
+   },
+   {
+	    "EventCode": "0x01",
+	    "EventName": "uncore_hisi_l3c.wr_cpipe",
+	    "BriefDescription": "Total write accesses",
+	    "PublicDescription": "Total write accesses",
+	    "Unit": "hisi_sccl,l3c",
+   },
+   {
+	    "EventCode": "0x02",
+	    "EventName": "uncore_hisi_l3c.rd_hit_cpipe",
+	    "BriefDescription": "Total read hits",
+	    "PublicDescription": "Total read hits",
+	    "Unit": "hisi_sccl,l3c",
+   },
+   {
+	    "EventCode": "0x03",
+	    "EventName": "uncore_hisi_l3c.wr_hit_cpipe",
+	    "BriefDescription": "Total write hits",
+	    "PublicDescription": "Total write hits",
+	    "Unit": "hisi_sccl,l3c",
+   },
+   {
+	    "EventCode": "0x04",
+	    "EventName": "uncore_hisi_l3c.victim_num",
+	    "BriefDescription": "l3c precharge commands",
+	    "PublicDescription": "l3c precharge commands",
+	    "Unit": "hisi_sccl,l3c",
+   },
+]
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 909e53e3b5bd..7d241efd03de 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -238,6 +238,7 @@ static struct map {
 	{ "UPI LL", "uncore_upi" },
 	{ "hisi_sccl,ddrc", "hisi_sccl,ddrc" },
 	{ "hisi_sccl,hha", "hisi_sccl,hha" },
+	{ "hisi_sccl,l3c", "hisi_sccl,l3c" },
 	{}
 };
 
-- 
2.17.1

