Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E0FC06510
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7ED5205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562124521;
	bh=kh1htbmle8QuNO8L1oukcK+e54dA3anpyPlbs9vBagc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yv6yLAfuQEYlzy9A4AbS7AN0cDzazX0hdv1y2ppl0eOuGIGtFBjfKeOpQeeBV1+7h
	 eah3gbSkIeVr20gxSg1YP8boDSWhZnXDt2eCcbxX6eLtL/aJWdF7954U5CLjIr5g2v
	 /CD61A+pXqMO9ijRxgH7SpYRiD50lgEVgydtGOiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfGCD2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 23:28:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbfGCD2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 23:28:38 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9332B2189F;
        Wed,  3 Jul 2019 03:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562124516;
        bh=kh1htbmle8QuNO8L1oukcK+e54dA3anpyPlbs9vBagc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bkDsVs7CLtHxFfDemD59Sy0dhp9T1MQ93UXpPypJNEvqbhu36B4fpCp1/Xx3MYApm
         KTyq7lqvvqilYS8BNCp/rVox0+JKA3ltmhkfHQR0Yac3xsL9aA6uBhj4ZrZkri2FZO
         RI7/km5S2b4Wn9/Dov9J/AV/WPbPgTJBdQDud23E=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/18] perf jevents: Add support for Hisi hip08 DDRC PMU aliasing
Date:   Wed,  3 Jul 2019 00:27:38 -0300
Message-Id: <20190703032746.21692-11-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703032746.21692-1-acme@kernel.org>
References: <20190703032746.21692-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Garry <john.garry@huawei.com>

Add support for Hisi hip08 DDRC PMU aliasing. We can now do something like
this:

$perf list

[snip]

uncore ddrc:
  uncore_hisi_ddrc.act_cmd
       [DDRC active commands. Unit: hisi_sccl,ddrc]
  uncore_hisi_ddrc.flux_rcmd
       [DDRC read commands. Unit: hisi_sccl,ddrc]
  uncore_hisi_ddrc.flux_wcmd
       [DDRC write commands. Unit: hisi_sccl,ddrc]
  uncore_hisi_ddrc.flux_wr
       [DDRC precharge commands. Unit: hisi_sccl,ddrc]
  uncore_hisi_ddrc.rnk_chg
       [DDRC rank commands. Unit: hisi_sccl,ddrc]
  uncore_hisi_ddrc.rw_chg
       [DDRC read and write changes. Unit: hisi_sccl,ddrc]

Performance counter stats for 'system wide':

                 0      uncore_hisi_ddrc.flux_rcmd [hisi_sccl1_ddrc0]
                 0      uncore_hisi_ddrc.flux_rcmd [hisi_sccl3_ddrc1]
                 0      uncore_hisi_ddrc.flux_rcmd [hisi_sccl5_ddrc2]
                 0      uncore_hisi_ddrc.flux_rcmd [hisi_sccl7_ddrc3]
                 0      uncore_hisi_ddrc.flux_rcmd [hisi_sccl5_ddrc0]
                 0      uncore_hisi_ddrc.flux_rcmd [hisi_sccl7_ddrc1]
                 0      uncore_hisi_ddrc.flux_rcmd [hisi_sccl1_ddrc3]
                 0      uncore_hisi_ddrc.flux_rcmd [hisi_sccl1_ddrc1]
                 0      uncore_hisi_ddrc.flux_rcmd [hisi_sccl3_ddrc2]
                 0      uncore_hisi_ddrc.flux_rcmd [hisi_sccl5_ddrc3]
                 0      uncore_hisi_ddrc.flux_rcmd [hisi_sccl3_ddrc0]
                 0      uncore_hisi_ddrc.flux_rcmd [hisi_sccl5_ddrc1]
                 0      uncore_hisi_ddrc.flux_rcmd [hisi_sccl7_ddrc2]
                 0      uncore_hisi_ddrc.flux_rcmd [hisi_sccl7_ddrc0]
            20,421      uncore_hisi_ddrc.flux_rcmd [hisi_sccl1_ddrc2]
                 0      uncore_hisi_ddrc.flux_rcmd [hisi_sccl3_ddrc3]

       1.001559011 seconds time elapsed

The kernel driver is in drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ben Hutchings <ben@decadent.org.uk>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxarm@huawei.com
Link: http://lkml.kernel.org/r/1561732552-143038-3-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../arm64/hisilicon/hip08/uncore-ddrc.json    | 44 +++++++++++++++++++
 tools/perf/pmu-events/jevents.c               |  1 +
 2 files changed, 45 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
new file mode 100644
index 000000000000..0d1556fcdffe
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-ddrc.json
@@ -0,0 +1,44 @@
+[
+   {
+	    "EventCode": "0x02",
+	    "EventName": "uncore_hisi_ddrc.flux_wcmd",
+	    "BriefDescription": "DDRC write commands",
+	    "PublicDescription": "DDRC write commands",
+	    "Unit": "hisi_sccl,ddrc",
+   },
+   {
+	    "EventCode": "0x03",
+	    "EventName": "uncore_hisi_ddrc.flux_rcmd",
+	    "BriefDescription": "DDRC read commands",
+	    "PublicDescription": "DDRC read commands",
+	    "Unit": "hisi_sccl,ddrc",
+   },
+   {
+	    "EventCode": "0x04",
+	    "EventName": "uncore_hisi_ddrc.flux_wr",
+	    "BriefDescription": "DDRC precharge commands",
+	    "PublicDescription": "DDRC precharge commands",
+	    "Unit": "hisi_sccl,ddrc",
+   },
+   {
+	    "EventCode": "0x05",
+	    "EventName": "uncore_hisi_ddrc.act_cmd",
+	    "BriefDescription": "DDRC active commands",
+	    "PublicDescription": "DDRC active commands",
+	    "Unit": "hisi_sccl,ddrc",
+   },
+   {
+	    "EventCode": "0x06",
+	    "EventName": "uncore_hisi_ddrc.rnk_chg",
+	    "BriefDescription": "DDRC rank commands",
+	    "PublicDescription": "DDRC rank commands",
+	    "Unit": "hisi_sccl,ddrc",
+   },
+   {
+	    "EventCode": "0x07",
+	    "EventName": "uncore_hisi_ddrc.rw_chg",
+	    "BriefDescription": "DDRC read and write changes",
+	    "PublicDescription": "DDRC read and write changes",
+	    "Unit": "hisi_sccl,ddrc",
+   },
+]
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index a1184ea64cc6..d5997741f1d8 100644
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
2.20.1

