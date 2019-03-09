Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C0CC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416CA20851
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfCIOkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 09:40:18 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37151 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbfCIOkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 09:40:18 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29EdeZ93109332
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 06:39:40 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29Edbbg3109322;
        Sat, 9 Mar 2019 06:39:37 -0800
Date:   Sat, 9 Mar 2019 06:39:37 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-8041ffd36f42d8521d66dd1e236feb58cecd68bc@git.kernel.org>
Cc:     acme@redhat.com, bp@alien8.de, alexander.shishkin@linux.intel.com,
        torvalds@linux-foundation.org, dave.hansen@linux.intel.com,
        kan.liang@linux.intel.com, tglx@linutronix.de, luto@kernel.org,
        peterz@infradead.org, riel@surriel.com, yao.jin@linux.intel.com,
        hpa@zytor.com, mingo@kernel.org, eranian@google.com,
        vincent.weaver@maine.edu, jolsa@redhat.com,
        linux-kernel@vger.kernel.org
Reply-To: yao.jin@linux.intel.com, mingo@kernel.org, hpa@zytor.com,
          jolsa@redhat.com, eranian@google.com, vincent.weaver@maine.edu,
          linux-kernel@vger.kernel.org, bp@alien8.de,
          alexander.shishkin@linux.intel.com,
          torvalds@linux-foundation.org, acme@redhat.com,
          dave.hansen@linux.intel.com, kan.liang@linux.intel.com,
          peterz@infradead.org, tglx@linutronix.de, luto@kernel.org,
          riel@surriel.com
In-Reply-To: <20190227165729.1861-1-kan.liang@linux.intel.com>
References: <20190227165729.1861-1-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel/uncore: Fix client IMC events
 return huge result
Git-Commit-ID: 8041ffd36f42d8521d66dd1e236feb58cecd68bc
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

Commit-ID:  8041ffd36f42d8521d66dd1e236feb58cecd68bc
Gitweb:     https://git.kernel.org/tip/8041ffd36f42d8521d66dd1e236feb58cecd68bc
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Wed, 27 Feb 2019 08:57:29 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 9 Mar 2019 14:10:31 +0100

perf/x86/intel/uncore: Fix client IMC events return huge result

The client IMC bandwidth events currently return very large values:

  $ perf stat -e uncore_imc/data_reads/ -e uncore_imc/data_writes/ -I 10000 -a

  10.000117222 34,788.76 MiB uncore_imc/data_reads/
  10.000117222 8.26 MiB uncore_imc/data_writes/
  20.000374584 34,842.89 MiB uncore_imc/data_reads/
  20.000374584 10.45 MiB uncore_imc/data_writes/
  30.000633299 37,965.29 MiB uncore_imc/data_reads/
  30.000633299 323.62 MiB uncore_imc/data_writes/
  40.000891548 41,012.88 MiB uncore_imc/data_reads/
  40.000891548 6.98 MiB uncore_imc/data_writes/
  50.001142480 1,125,899,906,621,494.75 MiB uncore_imc/data_reads/
  50.001142480 6.97 MiB uncore_imc/data_writes/

The client IMC events are freerunning counters. They still use the
old event encoding format (0x1 for data_read and 0x2 for data write).
The counter bit width is calculated by common code, which assume that
the standard encoding format is used for the freerunning counters.
Error bit width information is calculated.

The patch intends to convert the old client IMC event encoding to the
standard encoding format.

Current common code uses event->attr.config which directly copy from
user space. We should not implicitly modify it for a converted event.
The event->hw.config is used to replace the event->attr.config in
common code.

For client IMC events, the event->attr.config is used to calculate a
converted event with standard encoding format in the custom
event_init(). The converted event is stored in event->hw.config.
For other events of freerunning counters, they already use the standard
encoding format. The same value as event->attr.config is assigned to
event->hw.config in common event_init().

Reported-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Jin Yao <yao.jin@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: stable@kernel.org # v4.18+
Fixes: 9aae1780e7e8 ("perf/x86/intel/uncore: Clean up client IMC uncore")
Link: https://lkml.kernel.org/r/20190227165729.1861-1-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/uncore.c     |  1 +
 arch/x86/events/intel/uncore.h     | 12 ++++++------
 arch/x86/events/intel/uncore_snb.c |  4 +++-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index d516161c00c4..9fe64c01a2e5 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -732,6 +732,7 @@ static int uncore_pmu_event_init(struct perf_event *event)
 		/* fixed counters have event field hardcoded to zero */
 		hwc->config = 0ULL;
 	} else if (is_freerunning_event(event)) {
+		hwc->config = event->attr.config;
 		if (!check_valid_freerunning_event(box, event))
 			return -EINVAL;
 		event->hw.idx = UNCORE_PMC_IDX_FREERUNNING;
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index cb46d602a6b8..853a49a8ccf6 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -292,8 +292,8 @@ static inline
 unsigned int uncore_freerunning_counter(struct intel_uncore_box *box,
 					struct perf_event *event)
 {
-	unsigned int type = uncore_freerunning_type(event->attr.config);
-	unsigned int idx = uncore_freerunning_idx(event->attr.config);
+	unsigned int type = uncore_freerunning_type(event->hw.config);
+	unsigned int idx = uncore_freerunning_idx(event->hw.config);
 	struct intel_uncore_pmu *pmu = box->pmu;
 
 	return pmu->type->freerunning[type].counter_base +
@@ -377,7 +377,7 @@ static inline
 unsigned int uncore_freerunning_bits(struct intel_uncore_box *box,
 				     struct perf_event *event)
 {
-	unsigned int type = uncore_freerunning_type(event->attr.config);
+	unsigned int type = uncore_freerunning_type(event->hw.config);
 
 	return box->pmu->type->freerunning[type].bits;
 }
@@ -385,7 +385,7 @@ unsigned int uncore_freerunning_bits(struct intel_uncore_box *box,
 static inline int uncore_num_freerunning(struct intel_uncore_box *box,
 					 struct perf_event *event)
 {
-	unsigned int type = uncore_freerunning_type(event->attr.config);
+	unsigned int type = uncore_freerunning_type(event->hw.config);
 
 	return box->pmu->type->freerunning[type].num_counters;
 }
@@ -399,8 +399,8 @@ static inline int uncore_num_freerunning_types(struct intel_uncore_box *box,
 static inline bool check_valid_freerunning_event(struct intel_uncore_box *box,
 						 struct perf_event *event)
 {
-	unsigned int type = uncore_freerunning_type(event->attr.config);
-	unsigned int idx = uncore_freerunning_idx(event->attr.config);
+	unsigned int type = uncore_freerunning_type(event->hw.config);
+	unsigned int idx = uncore_freerunning_idx(event->hw.config);
 
 	return (type < uncore_num_freerunning_types(box, event)) &&
 	       (idx < uncore_num_freerunning(box, event));
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index b12517fae77a..13493f43b247 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -442,9 +442,11 @@ static int snb_uncore_imc_event_init(struct perf_event *event)
 
 	/* must be done before validate_group */
 	event->hw.event_base = base;
-	event->hw.config = cfg;
 	event->hw.idx = idx;
 
+	/* Convert to standard encoding format for freerunning counters */
+	event->hw.config = ((cfg - 1) << 8) | 0x10ff;
+
 	/* no group validation needed, we have free running counters */
 
 	return 0;
