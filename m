Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460E1C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9EA21670
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ZNKosdDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbfFYImR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:42:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43977 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbfFYImR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:42:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8fbB73533000
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:41:38 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8fbB73533000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561452099;
        bh=t6kJAyeOgWblu1QAXfhLFjiCX//sjG3Vq1Veq4mOtiU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ZNKosdDhJzmWKESrDHSawNE8drWV+wUiDXsjVsWFL+F0xInqmmAmBSd9hw/q6d9eg
         BVHpUUc3L3TUpM/Kn5hnWOHlgOo1WmJQQisWi0vb11vQiZERfIJsahwyD/9d0TLz1n
         FgpIPQ6xSmAXQKMjnY6TnR1zn13SEZuslmVPZ4gClcFuJ8+Au8Lb7tterFMSTLqyl2
         e7A3kvAdEvvYu9iU2WOqMXBB4VsBWZLBe+zcOc5zhdHOPVxBXmqnYE2PVspbuqVII7
         De3myNgIJLLdVCetbYxJCMI8EKs+4vNoTwQ2TyhuTGpYOIR2BRLg1C4Cdleos+FbPv
         4XSXtD8j5kr8w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8fb7H3532997;
        Tue, 25 Jun 2019 01:41:37 -0700
Date:   Tue, 25 Jun 2019 01:41:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-122f1c51b11a9e572263c4965d772381fcef06c5@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, bp@alien8.de, luto@kernel.org,
        jolsa@kernel.org, kan.liang@linux.intel.com,
        torvalds@linux-foundation.org, jolsa@redhat.com, acme@redhat.com,
        vincent.weaver@maine.edu, eranian@google.com, acme@kernel.org,
        peterz@infradead.org, gregkh@linuxfoundation.org,
        namhyung@kernel.org, tglx@linutronix.de
Reply-To: namhyung@kernel.org, tglx@linutronix.de,
          gregkh@linuxfoundation.org, eranian@google.com, acme@kernel.org,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org, hpa@zytor.com, bp@alien8.de,
          alexander.shishkin@linux.intel.com, luto@kernel.org,
          jolsa@kernel.org, kan.liang@linux.intel.com, jolsa@redhat.com,
          torvalds@linux-foundation.org, acme@redhat.com,
          vincent.weaver@maine.edu
In-Reply-To: <20190616140358.27799-7-jolsa@kernel.org>
References: <20190616140358.27799-7-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/rapl: Get MSR values from new probe
 framework
Git-Commit-ID: 122f1c51b11a9e572263c4965d772381fcef06c5
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

Commit-ID:  122f1c51b11a9e572263c4965d772381fcef06c5
Gitweb:     https://git.kernel.org/tip/122f1c51b11a9e572263c4965d772381fcef06c5
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 16 Jun 2019 16:03:56 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:28:34 +0200

perf/x86/rapl: Get MSR values from new probe framework

There's no need to have special code for getting
the bit and MSR value for given event. We can
now easily get it from rapl_msrs array.

Also getting rid of RAPL_IDX_*, which is no longer
needed and replacing INTEL_RAPL* with PERF_RAPL*
enums.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan <kan.liang@linux.intel.com>
Cc: Liang
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: https://lkml.kernel.org/r/20190616140358.27799-7-jolsa@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/rapl.c | 53 +++++++++-----------------------------------
 1 file changed, 11 insertions(+), 42 deletions(-)

diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 417de3fdde61..00b2b5d82d58 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -55,6 +55,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/perf_event.h>
+#include <linux/nospec.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include "../perf_event.h"
@@ -65,19 +66,6 @@ MODULE_LICENSE("GPL");
 /*
  * RAPL energy status counters
  */
-#define RAPL_IDX_PP0_NRG_STAT	0	/* all cores */
-#define INTEL_RAPL_PP0		0x1	/* pseudo-encoding */
-#define RAPL_IDX_PKG_NRG_STAT	1	/* entire package */
-#define INTEL_RAPL_PKG		0x2	/* pseudo-encoding */
-#define RAPL_IDX_RAM_NRG_STAT	2	/* DRAM */
-#define INTEL_RAPL_RAM		0x3	/* pseudo-encoding */
-#define RAPL_IDX_PP1_NRG_STAT	3	/* gpu */
-#define INTEL_RAPL_PP1		0x4	/* pseudo-encoding */
-#define RAPL_IDX_PSYS_NRG_STAT	4	/* psys */
-#define INTEL_RAPL_PSYS		0x5	/* pseudo-encoding */
-
-#define NR_RAPL_DOMAINS         0x5
-
 enum perf_rapl_events {
 	PERF_RAPL_PP0 = 0,		/* all cores */
 	PERF_RAPL_PKG,			/* entire package */
@@ -86,6 +74,7 @@ enum perf_rapl_events {
 	PERF_RAPL_PSYS,			/* psys */
 
 	PERF_RAPL_MAX,
+	NR_RAPL_DOMAINS = PERF_RAPL_MAX,
 };
 
 static const char *const rapl_domain_names[NR_RAPL_DOMAINS] __initconst = {
@@ -149,6 +138,7 @@ static struct rapl_pmus *rapl_pmus;
 static cpumask_t rapl_cpu_mask;
 static unsigned int rapl_cntr_mask;
 static u64 rapl_timer_ms;
+static struct perf_msr rapl_msrs[];
 
 static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
 {
@@ -340,7 +330,7 @@ static void rapl_pmu_event_del(struct perf_event *event, int flags)
 static int rapl_pmu_event_init(struct perf_event *event)
 {
 	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
-	int bit, msr, ret = 0;
+	int bit, ret = 0;
 	struct rapl_pmu *pmu;
 
 	/* only look at RAPL events */
@@ -356,33 +346,12 @@ static int rapl_pmu_event_init(struct perf_event *event)
 
 	event->event_caps |= PERF_EV_CAP_READ_ACTIVE_PKG;
 
-	/*
-	 * check event is known (determines counter)
-	 */
-	switch (cfg) {
-	case INTEL_RAPL_PP0:
-		bit = RAPL_IDX_PP0_NRG_STAT;
-		msr = MSR_PP0_ENERGY_STATUS;
-		break;
-	case INTEL_RAPL_PKG:
-		bit = RAPL_IDX_PKG_NRG_STAT;
-		msr = MSR_PKG_ENERGY_STATUS;
-		break;
-	case INTEL_RAPL_RAM:
-		bit = RAPL_IDX_RAM_NRG_STAT;
-		msr = MSR_DRAM_ENERGY_STATUS;
-		break;
-	case INTEL_RAPL_PP1:
-		bit = RAPL_IDX_PP1_NRG_STAT;
-		msr = MSR_PP1_ENERGY_STATUS;
-		break;
-	case INTEL_RAPL_PSYS:
-		bit = RAPL_IDX_PSYS_NRG_STAT;
-		msr = MSR_PLATFORM_ENERGY_STATUS;
-		break;
-	default:
+	if (!cfg || cfg >= NR_RAPL_DOMAINS + 1)
 		return -EINVAL;
-	}
+
+	cfg = array_index_nospec((long)cfg, NR_RAPL_DOMAINS + 1);
+	bit = cfg - 1;
+
 	/* check event supported */
 	if (!(rapl_cntr_mask & (1 << bit)))
 		return -EINVAL;
@@ -397,7 +366,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 	event->cpu = pmu->cpu;
 	event->pmu_private = pmu;
-	event->hw.event_base = msr;
+	event->hw.event_base = rapl_msrs[bit].msr;
 	event->hw.config = cfg;
 	event->hw.idx = bit;
 
@@ -705,7 +674,7 @@ static int rapl_check_hw_unit(bool apply_quirk)
 	 * of 2. Datasheet, September 2014, Reference Number: 330784-001 "
 	 */
 	if (apply_quirk)
-		rapl_hw_unit[RAPL_IDX_RAM_NRG_STAT] = 16;
+		rapl_hw_unit[PERF_RAPL_RAM] = 16;
 
 	/*
 	 * Calculate the timer rate:
