Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4271CC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B6221874
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562124532;
	bh=nthMXQ3xh+asFOhNhIIr70OPlb+T7ky2twljPY3/cu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DK6OcDTMIUHbixvaqrXJNQT4E2+bpbzQWWEgvYU8p1Un9kivN9Y42RhMs14DHN3K+
	 vTU0KHyB+GHay/boNnN8owwao4kHgER1X2onUDKtD9Z9DIA9R0TdYMTpu2/jbJnmfw
	 bkHxwxqGf/FhxPhHCvHdXPVIxfsf176XpVNweTek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfGCD2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 23:28:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbfGCD2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 23:28:49 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0E8A2054F;
        Wed,  3 Jul 2019 03:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562124528;
        bh=nthMXQ3xh+asFOhNhIIr70OPlb+T7ky2twljPY3/cu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yhVU4TLvyiYE7snWZ9UV7SShlP8iqMHzcmS9xC+VLj3Y9qL1TiAZ5Z4D8LY3rrFI/
         HeqY4jtRH7bVz/TWJrynDKQp/te98uoHWq4WvefyA+Xmlg+DXR3bklDR9l/vJ/G/tL
         ODznBju2AHrZaoDGgrCdkgLTzurr2JI/NOQQM/y8=
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
Subject: [PATCH 12/18] perf jevents: Add support for Hisi hip08 L3C PMU aliasing
Date:   Wed,  3 Jul 2019 00:27:40 -0300
Message-Id: <20190703032746.21692-13-acme@kernel.org>
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

Add support for Hisi hip08 L3C PMU aliasing.

The kernel driver is in drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c

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
Link: http://lkml.kernel.org/r/1561732552-143038-5-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
index 3c95affd85a4..287a6f10ca48 100644
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
2.20.1

