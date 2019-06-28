Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C31C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 22:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E61A208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 22:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfF1WHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 18:07:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:44146 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfF1WHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 18:07:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 15:07:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,429,1557212400"; 
   d="scan'208";a="338031187"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga005.jf.intel.com with ESMTP; 28 Jun 2019 15:07:46 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 5887A3015ED; Fri, 28 Jun 2019 15:07:46 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 1/3] perf vendor events intel: Metric fixes for SKX/CLX
Date:   Fri, 28 Jun 2019 15:07:35 -0700
Message-Id: <20190628220737.13259-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

- Add a missing filter for the DRAM_Latency / DRAM_Parallel_Reads metrics
- Remove the useless PMM_* metrics from Skylake

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 .../arch/x86/cascadelakex/clx-metrics.json    |  4 ++--
 .../arch/x86/skylakex/skx-metrics.json        | 22 ++-----------------
 2 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index 1a1a3501180a..a382b115633d 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
@@ -314,13 +314,13 @@
         "MetricName": "DRAM_BW_Use"
     },
     {
-        "MetricExpr": "1000000000 * ( cha@event\\=0x36\\\\\\,umask\\=0x21@ / cha@event\\=0x35\\\\\\,umask\\=0x21@ ) / ( cha_0@event\\=0x0@ / duration_time )",
+	"MetricExpr": "1000000000 * ( cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,config\\=0x40433@ / cha@event\\=0x35\\\\\\,umask\\=0x21\\\\\\,config\\=0x40433@ ) / ( cha_0@event\\=0x0@ / duration_time )",
         "BriefDescription": "Average latency of data read request to external memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetches",
         "MetricGroup": "Memory_Lat",
         "MetricName": "DRAM_Read_Latency"
     },
     {
-        "MetricExpr": "cha@event\\=0x36\\\\\\,umask\\=0x21@ / cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,thresh\\=1@",
+	"MetricExpr": "cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,config\\=0x40433@ / cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,thresh\\=1\\\\\\,config\\=0x40433@",
         "BriefDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches",
         "MetricGroup": "Memory_BW",
         "MetricName": "DRAM_Parallel_Reads"
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
index 56e03ba771f4..35b255fa6a79 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
@@ -314,35 +314,17 @@
         "MetricName": "DRAM_BW_Use"
     },
     {
-        "MetricExpr": "1000000000 * ( cha@event\\=0x36\\\\\\,umask\\=0x21@ / cha@event\\=0x35\\\\\\,umask\\=0x21@ ) / ( cha_0@event\\=0x0@ / duration_time )",
+	"MetricExpr": "1000000000 * ( cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,config\\=0x40433@ / cha@event\\=0x35\\\\\\,umask\\=0x21\\\\\\,config\\=0x40433@ ) / ( cha_0@event\\=0x0@ / duration_time )",
         "BriefDescription": "Average latency of data read request to external memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetches",
         "MetricGroup": "Memory_Lat",
         "MetricName": "DRAM_Read_Latency"
     },
     {
-        "MetricExpr": "cha@event\\=0x36\\\\\\,umask\\=0x21@ / cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,thresh\\=1@",
+	"MetricExpr": "cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,config\\=0x40433@ / cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,thresh\\=1\\\\\\,config\\=0x40433@",
         "BriefDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches",
         "MetricGroup": "Memory_BW",
         "MetricName": "DRAM_Parallel_Reads"
     },
-    {
-        "MetricExpr": "( 1000000000 * ( imc@event\\=0xe0\\\\\\,umask\\=0x1@ / imc@event\\=0xe3@ ) / imc_0@event\\=0x0@ ) if 1 if 0 == 1 else 0 else 0",
-        "BriefDescription": "Average latency of data read request to external 3D X-Point memory [in nanoseconds]. Accounts for demand loads and L1/L2 data-read prefetches",
-        "MetricGroup": "Memory_Lat",
-        "MetricName": "MEM_PMM_Read_Latency"
-    },
-    {
-        "MetricExpr": "( ( 64 * imc@event\\=0xe3@ / 1000000000 ) / duration_time ) if 1 if 0 == 1 else 0 else 0",
-        "BriefDescription": "Average 3DXP Memory Bandwidth Use for reads [GB / sec]",
-        "MetricGroup": "Memory_BW",
-        "MetricName": "PMM_Read_BW"
-    },
-    {
-        "MetricExpr": "( ( 64 * imc@event\\=0xe7@ / 1000000000 ) / duration_time ) if 1 if 0 == 1 else 0 else 0",
-        "BriefDescription": "Average 3DXP Memory Bandwidth Use for Writes [GB / sec]",
-        "MetricGroup": "Memory_BW",
-        "MetricName": "PMM_Write_BW"
-    },
     {
         "MetricExpr": "cha_0@event\\=0x0@",
         "BriefDescription": "Socket actual clocks when any core is active on that socket",
-- 
2.20.1

