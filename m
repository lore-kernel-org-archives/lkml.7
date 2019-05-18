Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E21C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E48C20872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="VbjaTBSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbfERJaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:30:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38665 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERJae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:30:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9U0rf1741785
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:30:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9U0rf1741785
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558171801;
        bh=kvtoq5yZBuVHiqSl5bAZi2dNFpi/zDZNYvheWwGi/8s=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=VbjaTBSG5+gp7Ja6Ou6v46w/GV0a72MMH30r6jdL+jW59YPUt8hJ5y7ut7Wxd1NLY
         If8VE7noZxLIqvMHC88FlOz25obHxZVxh0ACcpjCPkqe67eVzvlpqKuyo/N0uxWY/m
         g+VSd1BEdCIG/TB+hp4L7Mn79+w5N07pwH10/mwbrQ0iSAXYKqASVw5UOIjGySfmEA
         lWRREoLfNj9ISDUVJIjP6EXJnRyLXt0lOn9I+usF+qze74QakXXd5AQ1Pe4Pd8SCLf
         BPuTh4HnjfZOisyrSblQ3/aiWXSwUzXxs/ngzHQS+CCQjI9V1gxGkGklTp3dM5t3XB
         fZOS00+s961oQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9U0D01741782;
        Sat, 18 May 2019 02:30:00 -0700
Date:   Sat, 18 May 2019 02:30:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Florian Fainelli <tipbot@zytor.com>
Message-ID: <tip-7025fdbea3a67c5980b94574b755a5fd65ea8a36@git.kernel.org>
Cc:     acme@redhat.com, tglx@linutronix.de, mark.rutland@arm.com,
        john.garry@huawei.com, ganapatrao.kulkarni@cavium.com,
        alexander.shishkin@linux.intel.com, hpa@zytor.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, mingo@kernel.org, seanvk.dev@oregontracks.org,
        will.deacon@arm.com, namhyung@kernel.org, peterz@infradead.org,
        f.fainelli@gmail.com
Reply-To: mingo@kernel.org, jolsa@redhat.com, namhyung@kernel.org,
          f.fainelli@gmail.com, peterz@infradead.org, will.deacon@arm.com,
          seanvk.dev@oregontracks.org, john.garry@huawei.com,
          mark.rutland@arm.com, tglx@linutronix.de, acme@redhat.com,
          linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
          alexander.shishkin@linux.intel.com, hpa@zytor.com,
          ganapatrao.kulkarni@cavium.com
In-Reply-To: <20190513202522.9050-4-f.fainelli@gmail.com>
References: <20190513202522.9050-4-f.fainelli@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events arm64: Add Cortex-A57 and
 Cortex-A72 events
Git-Commit-ID: 7025fdbea3a67c5980b94574b755a5fd65ea8a36
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

Commit-ID:  7025fdbea3a67c5980b94574b755a5fd65ea8a36
Gitweb:     https://git.kernel.org/tip/7025fdbea3a67c5980b94574b755a5fd65ea8a36
Author:     Florian Fainelli <f.fainelli@gmail.com>
AuthorDate: Mon, 13 May 2019 13:25:22 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:49 -0300

perf vendor events arm64: Add Cortex-A57 and Cortex-A72 events

The Cortex-A57 and Cortex-A72 both support all ARMv8 recommended events
up to the RC_ST_SPEC (0x91) event with the exception of:

- L1D_CACHE_REFILL_INNER (0x44)
- L1D_CACHE_REFILL_OUTER (0x45)
- L1D_TLB_RD (0x4E)
- L1D_TLB_WR (0x4F)
- L2D_TLB_REFILL_RD (0x5C)
- L2D_TLB_REFILL_WR (0x5D)
- L2D_TLB_RD (0x5E)
- L2D_TLB_WR (0x5F)
- STREX_SPEC (0x6F)

Create an appropriate JSON file for mapping those events and update the
mapfile.csv for matching the Cortex-A57 and Cortex-A72 MIDR to that
file.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: John Garry <john.garry@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean V Kelley <seanvk.dev@oregontracks.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org (moderated list:arm pmu profiling and debugging)
Link: http://lkml.kernel.org/r/20190513202522.9050-4-f.fainelli@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../cortex-a57-a72}/core-imp-def.json              | 92 +++++++++++++++++++---
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |  2 +
 2 files changed, 81 insertions(+), 13 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/core-imp-def.json
similarity index 52%
copy from tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
copy to tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/core-imp-def.json
index 752e47eb6977..0ac9b7927450 100644
--- a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/core-imp-def.json
@@ -11,12 +11,6 @@
     {
         "ArchStdEvent": "L1D_CACHE_REFILL_WR",
     },
-    {
-        "ArchStdEvent": "L1D_CACHE_REFILL_INNER",
-    },
-    {
-        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER",
-    },
     {
         "ArchStdEvent": "L1D_CACHE_WB_VICTIM",
     },
@@ -33,22 +27,25 @@
         "ArchStdEvent": "L1D_TLB_REFILL_WR",
     },
     {
-        "ArchStdEvent": "L1D_TLB_RD",
+        "ArchStdEvent": "L2D_CACHE_RD",
     },
     {
-        "ArchStdEvent": "L1D_TLB_WR",
+        "ArchStdEvent": "L2D_CACHE_WR",
     },
     {
-        "ArchStdEvent": "L2D_TLB_REFILL_RD",
+        "ArchStdEvent": "L2D_CACHE_REFILL_RD",
     },
     {
-        "ArchStdEvent": "L2D_TLB_REFILL_WR",
+        "ArchStdEvent": "L2D_CACHE_REFILL_WR",
     },
     {
-        "ArchStdEvent": "L2D_TLB_RD",
+        "ArchStdEvent": "L2D_CACHE_WB_VICTIM",
     },
     {
-        "ArchStdEvent": "L2D_TLB_WR",
+        "ArchStdEvent": "L2D_CACHE_WB_CLEAN",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_INVAL",
     },
     {
         "ArchStdEvent": "BUS_ACCESS_RD",
@@ -56,6 +53,18 @@
     {
         "ArchStdEvent": "BUS_ACCESS_WR",
     },
+    {
+        "ArchStdEvent": "BUS_ACCESS_SHARED",
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_NOT_SHARED",
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_NORMAL",
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_PERIPH",
+    },
     {
         "ArchStdEvent": "MEM_ACCESS_RD",
     },
@@ -71,6 +80,57 @@
     {
         "ArchStdEvent": "UNALIGNED_LDST_SPEC",
     },
+    {
+        "ArchStdEvent": "LDREX_SPEC",
+    },
+    {
+        "ArchStdEvent": "STREX_PASS_SPEC",
+    },
+    {
+        "ArchStdEvent": "STREX_FAIL_SPEC",
+    },
+    {
+        "ArchStdEvent": "LD_SPEC",
+    },
+    {
+        "ArchStdEvent": "ST_SPEC",
+    },
+    {
+        "ArchStdEvent": "LDST_SPEC",
+    },
+    {
+        "ArchStdEvent": "DP_SPEC",
+    },
+    {
+        "ArchStdEvent": "ASE_SPEC",
+    },
+    {
+        "ArchStdEvent": "VFP_SPEC",
+    },
+    {
+        "ArchStdEvent": "PC_WRITE_SPEC",
+    },
+    {
+        "ArchStdEvent": "CRYPTO_SPEC",
+    },
+    {
+        "ArchStdEvent": "BR_IMMED_SPEC",
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_SPEC",
+    },
+    {
+        "ArchStdEvent": "BR_INDIRECT_SPEC",
+    },
+    {
+        "ArchStdEvent": "ISB_SPEC",
+    },
+    {
+        "ArchStdEvent": "DSB_SPEC",
+    },
+    {
+        "ArchStdEvent": "DMB_SPEC",
+    },
     {
         "ArchStdEvent": "EXC_UNDEF",
     },
@@ -109,5 +169,11 @@
     },
     {
         "ArchStdEvent": "EXC_TRAP_FIQ",
-    }
+    },
+    {
+        "ArchStdEvent": "RC_LD_SPEC",
+    },
+    {
+        "ArchStdEvent": "RC_ST_SPEC",
+    },
 ]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 013155f1eb58..927fcddcb4aa 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -14,6 +14,8 @@
 #Family-model,Version,Filename,EventType
 0x00000000410fd030,v1,arm/cortex-a53,core
 0x00000000420f1000,v1,arm/cortex-a53,core
+0x00000000410fd070,v1,arm/cortex-a57-a72,core
+0x00000000410fd080,v1,arm/cortex-a57-a72,core
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
 0x00000000480fd010,v1,hisilicon/hip08,core
