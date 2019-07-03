Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1C6C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5C121871
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ZvRqjHpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfGCOkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:40:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39923 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCOkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:40:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EdYSC3329150
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:39:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EdYSC3329150
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562164775;
        bh=9UO2tseUPI+6EDIOvnGezrt9XxIG+YSJbodqrs0fvYQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ZvRqjHpSTfSID79l5nEc13nsov/klFz5pwzbTRoJYq4mQ5xD0dtdP30rDvwSTeyog
         rcAkU1sYLwH9ReCd2LmifCUgT8y6XvUZS0UYQ4wSOlgV33JRn2aL3cXTXgvQMJg+dN
         HOBS+A8Ut37psiPdOYYUvaesyhgfhh9ycFFV8zeuEsrw6KlkNaYUB0x70Ag6vWAqis
         s5m2E69/GsiWWI5U6KU1D3ltHC3IcxGGTFGIv0DRaozvUMPA8qIHEsixpHelv2U+G3
         bO51LrzKsXocOgt2K68beSNAJKWguRT3S8g2S1R2gCHSFOtv3xNqHjCJoRmsxUT2fq
         dXwrXAGZ9OUvw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EdY8H3329147;
        Wed, 3 Jul 2019 07:39:34 -0700
Date:   Wed, 3 Jul 2019 07:39:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for John Garry <tipbot@zytor.com>
Message-ID: <tip-8f5b703add99473b59b4a38a6b66afbafc29d92e@git.kernel.org>
Cc:     tmricht@linux.ibm.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, ben@decadent.org.uk, hpa@zytor.com,
        mathieu.poirier@linaro.org, zhangshaokun@hisilicon.com,
        kan.liang@linux.intel.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, mingo@kernel.org, will.deacon@arm.com,
        namhyung@kernel.org, tglx@linutronix.de, john.garry@huawei.com,
        ak@linux.intel.com, acme@redhat.com, mark.rutland@arm.com,
        brueckner@linux.ibm.com
Reply-To: mathieu.poirier@linaro.org, zhangshaokun@hisilicon.com,
          tmricht@linux.ibm.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org, ben@decadent.org.uk, hpa@zytor.com,
          acme@redhat.com, mark.rutland@arm.com, brueckner@linux.ibm.com,
          kan.liang@linux.intel.com, alexander.shishkin@linux.intel.com,
          mingo@kernel.org, jolsa@kernel.org, namhyung@kernel.org,
          will.deacon@arm.com, tglx@linutronix.de, john.garry@huawei.com,
          ak@linux.intel.com
In-Reply-To: <1561732552-143038-4-git-send-email-john.garry@huawei.com>
References: <1561732552-143038-4-git-send-email-john.garry@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf jevents: Add support for Hisi hip08 HHA PMU
 aliasing
Git-Commit-ID: 8f5b703add99473b59b4a38a6b66afbafc29d92e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8f5b703add99473b59b4a38a6b66afbafc29d92e
Gitweb:     https://git.kernel.org/tip/8f5b703add99473b59b4a38a6b66afbafc29d92e
Author:     John Garry <john.garry@huawei.com>
AuthorDate: Fri, 28 Jun 2019 22:35:51 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 2 Jul 2019 16:08:15 -0300

perf jevents: Add support for Hisi hip08 HHA PMU aliasing

Add support for Hisi hip08 HHA PMU aliasing.

The kernel driver is in drivers/perf/hisilicon/hisi_uncore_hha_pmu.c

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
Link: http://lkml.kernel.org/r/1561732552-143038-4-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../arch/arm64/hisilicon/hip08/uncore-hha.json     | 51 ++++++++++++++++++++++
 tools/perf/pmu-events/jevents.c                    |  1 +
 2 files changed, 52 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
new file mode 100644
index 000000000000..447d3064de90
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/uncore-hha.json
@@ -0,0 +1,51 @@
+[
+   {
+	    "EventCode": "0x00",
+	    "EventName": "uncore_hisi_hha.rx_ops_num",
+	    "BriefDescription": "The number of all operations received by the HHA",
+	    "PublicDescription": "The number of all operations received by the HHA",
+	    "Unit": "hisi_sccl,hha",
+   },
+   {
+	    "EventCode": "0x01",
+	    "EventName": "uncore_hisi_hha.rx_outer",
+	    "BriefDescription": "The number of all operations received by the HHA from another socket",
+	    "PublicDescription": "The number of all operations received by the HHA from another socket",
+	    "Unit": "hisi_sccl,hha",
+   },
+   {
+	    "EventCode": "0x02",
+	    "EventName": "uncore_hisi_hha.rx_sccl",
+	    "BriefDescription": "The number of all operations received by the HHA from another SCCL in this socket",
+	    "PublicDescription": "The number of all operations received by the HHA from another SCCL in this socket",
+	    "Unit": "hisi_sccl,hha",
+   },
+   {
+	    "EventCode": "0x1c",
+	    "EventName": "uncore_hisi_hha.rd_ddr_64b",
+	    "BriefDescription": "The number of read operations sent by HHA to DDRC which size is 64 bytes",
+	    "PublicDescription": "The number of read operations sent by HHA to DDRC which size is 64bytes",
+	    "Unit": "hisi_sccl,hha",
+   },
+   {
+	    "EventCode": "0x1d",
+	    "EventName": "uncore_hisi_hha.wr_dr_64b",
+	    "BriefDescription": "The number of write operations sent by HHA to DDRC which size is 64 bytes",
+	    "PublicDescription": "The number of write operations sent by HHA to DDRC which size is 64 bytes",
+	    "Unit": "hisi_sccl,hha",
+   },
+   {
+	    "EventCode": "0x1e",
+	    "EventName": "uncore_hisi_hha.rd_ddr_128b",
+	    "BriefDescription": "The number of read operations sent by HHA to DDRC which size is 128 bytes",
+	    "PublicDescription": "The number of read operations sent by HHA to DDRC which size is 128 bytes",
+	    "Unit": "hisi_sccl,hha",
+   },
+   {
+	    "EventCode": "0x1f",
+	    "EventName": "uncore_hisi_hha.wr_ddr_128b",
+	    "BriefDescription": "The number of write operations sent by HHA to DDRC which size is 128 bytes",
+	    "PublicDescription": "The number of write operations sent by HHA to DDRC which size is 128 bytes",
+	    "Unit": "hisi_sccl,hha",
+   },
+]
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index d5997741f1d8..3c95affd85a4 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -237,6 +237,7 @@ static struct map {
 	{ "CPU-M-SF", "cpum_sf" },
 	{ "UPI LL", "uncore_upi" },
 	{ "hisi_sccl,ddrc", "hisi_sccl,ddrc" },
+	{ "hisi_sccl,hha", "hisi_sccl,hha" },
 	{}
 };
 
