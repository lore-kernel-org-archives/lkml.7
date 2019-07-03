Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5E5C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82425218C5
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562124540;
	bh=VuztSqwca7S8Whmd4cenDt9wONqCjm3KnuFVqbPoIMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RiDOEw1q/gbfma6os5XJmHYn4iD8DoJAP7JEKaocdr32QpyMHWRRc9eISoVNCDvfQ
	 GVa8pHQNiyOtrmOGNCc0m8L8DBSyFvmlenjr+xJZwwLqzvtp8j9lfYVjcBUjfbtr8F
	 EjPZ8oDudgn8jd8heTv0kV+ucH5Tea0n5ihB2amw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfGCD26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 23:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbfGCD2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 23:28:54 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A27C2189E;
        Wed,  3 Jul 2019 03:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562124533;
        bh=VuztSqwca7S8Whmd4cenDt9wONqCjm3KnuFVqbPoIMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eMknLnYpw46OXos7QDPR0Qfu0sHHqy2TetTTLurh6lUiUZUF4V1Hw9AgB2fG3iV6p
         8QKwf8upqrZTkPPD2IbIrza42Q7AavQK4+p83GnSrxAO8AT46VRlG4JmwFPkGeNEmQ
         trF3V8/6Er3qnavnidrkb2iDYUdp1NV9oouPzvA0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/18] perf vendor events intel: Metric fixes for SKX/CLX
Date:   Wed,  3 Jul 2019 00:27:42 -0300
Message-Id: <20190703032746.21692-15-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703032746.21692-1-acme@kernel.org>
References: <20190703032746.21692-1-acme@kernel.org>
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
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190628220737.13259-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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

