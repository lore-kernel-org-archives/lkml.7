Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2B7C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E5A21871
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PvvijpnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfGCOja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:39:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49165 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCOja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:39:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63Ecn263328826
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:38:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63Ecn263328826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562164730;
        bh=3UIigSOAi48ycbenztV1QQogmvq2oriwdEcHfBJDfPk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=PvvijpnAaC9LSnSDictaM34fMXGBdCpBAYl4qq/dehlgZfzFlR8T3IR42JGHUw0yK
         544StyYiJ2XLic/rXpwLUrpEKC4WLgvLlroER58/GeCtW/cDpg67+eAODX/s9/VDFN
         l2MBTP4x1zrrhvJv2R/T0JY9gGYyohUsOJfwkWadi7BMq1i3FmbZZt/aTgwP872C6u
         m9j43xpEAVFsoxvFneTxLA5lxP8ODIxICSgz7655TykJ3fqwRcTnnbWqFmLsa2E06b
         BEQukBETfrerzUdWvWz22Ee0OTtbCaK32dbFJKImYEMv4A2jfAsSqg5BGJB1torOR8
         Jo2ftDlJBX1og==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EcmPt3328823;
        Wed, 3 Jul 2019 07:38:48 -0700
Date:   Wed, 3 Jul 2019 07:38:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for John Garry <tipbot@zytor.com>
Message-ID: <tip-57cc732479bac2a3cbd759fb07188657c871d5c1@git.kernel.org>
Cc:     zhangshaokun@hisilicon.com, tglx@linutronix.de, acme@redhat.com,
        will.deacon@arm.com, alexander.shishkin@linux.intel.com,
        john.garry@huawei.com, mathieu.poirier@linaro.org,
        mark.rutland@arm.com, ben@decadent.org.uk,
        kan.liang@linux.intel.com, mingo@kernel.org,
        brueckner@linux.ibm.com, ak@linux.intel.com, namhyung@kernel.org,
        peterz@infradead.org, hpa@zytor.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, tmricht@linux.ibm.com
Reply-To: tmricht@linux.ibm.com, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, hpa@zytor.com, peterz@infradead.org,
          namhyung@kernel.org, ak@linux.intel.com, brueckner@linux.ibm.com,
          mingo@kernel.org, kan.liang@linux.intel.com, ben@decadent.org.uk,
          mark.rutland@arm.com, mathieu.poirier@linaro.org,
          alexander.shishkin@linux.intel.com, john.garry@huawei.com,
          will.deacon@arm.com, tglx@linutronix.de, acme@redhat.com,
          zhangshaokun@hisilicon.com
In-Reply-To: <1561732552-143038-3-git-send-email-john.garry@huawei.com>
References: <1561732552-143038-3-git-send-email-john.garry@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf jevents: Add support for Hisi hip08 DDRC PMU
 aliasing
Git-Commit-ID: 57cc732479bac2a3cbd759fb07188657c871d5c1
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

Commit-ID:  57cc732479bac2a3cbd759fb07188657c871d5c1
Gitweb:     https://git.kernel.org/tip/57cc732479bac2a3cbd759fb07188657c871d5c1
Author:     John Garry <john.garry@huawei.com>
AuthorDate: Fri, 28 Jun 2019 22:35:50 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 2 Jul 2019 16:08:15 -0300

perf jevents: Add support for Hisi hip08 DDRC PMU aliasing

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
 .../arch/arm64/hisilicon/hip08/uncore-ddrc.json    | 44 ++++++++++++++++++++++
 tools/perf/pmu-events/jevents.c                    |  1 +
 2 files changed, 45 insertions(+)

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
 
