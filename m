Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1745AC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41F4218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="nBFoL3fY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfGCOmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:42:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57581 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCOmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:42:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63Efidj3329588
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:41:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63Efidj3329588
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562164905;
        bh=dMt4k9DA83JQMdo4OOHSD7vs0yl1XvWwolhfO2uMpY0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=nBFoL3fYgOATEF8ciJA9THccESLg8T6AxX7m2/1z8Z3RSQpeqaJAjlqaSVsu2vV/d
         Egx62R/uBFANJcqgQfdfCkouUiWrx0NjKUca0yTaF/TONNmuqhuJUbAMxgJUGO6ff4
         lyL0/5ZtQzV+HIR6RY+L1CHeBKrYBYWWF36t/uNnHI+fR/oebpNK98USHKo2s39XCH
         y71h2RekszgHDS/uEfoZJfayLFZCQldjjp6p+vw0w9QJW/y/CKHLJki5x50UXyaP5N
         OVv6i/jbSYrifcadu/SwHUSrVQjVt5C6LTP5Btp/xz9jvTYBGxu7UuE1zC7i5gjaeG
         ExRNrAE3NlB/g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63Efie83329585;
        Wed, 3 Jul 2019 07:41:44 -0700
Date:   Wed, 3 Jul 2019 07:41:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-4df79ba3eb1b82e2939fb984b36a0e71bbed611b@git.kernel.org>
Cc:     acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, ak@linux.intel.com, tglx@linutronix.de,
        jolsa@kernel.org
Reply-To: jolsa@kernel.org, tglx@linutronix.de, ak@linux.intel.com,
          hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          acme@redhat.com
In-Reply-To: <20190628220737.13259-1-andi@firstfloor.org>
References: <20190628220737.13259-1-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events intel: Metric fixes for SKX/CLX
Git-Commit-ID: 4df79ba3eb1b82e2939fb984b36a0e71bbed611b
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

Commit-ID:  4df79ba3eb1b82e2939fb984b36a0e71bbed611b
Gitweb:     https://git.kernel.org/tip/4df79ba3eb1b82e2939fb984b36a0e71bbed611b
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Fri, 28 Jun 2019 15:07:35 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 2 Jul 2019 16:08:16 -0300

perf vendor events intel: Metric fixes for SKX/CLX

- Add a missing filter for the DRAM_Latency / DRAM_Parallel_Reads metrics
- Remove the useless PMM_* metrics from Skylake

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190628220737.13259-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../arch/x86/cascadelakex/clx-metrics.json         |  4 ++--
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  | 22 ++--------------------
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
