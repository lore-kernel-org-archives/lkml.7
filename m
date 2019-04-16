Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DDFC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD5B20857
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfDPLhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:37:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36951 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfDPLhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:37:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3GBb0Ub3428649
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 04:37:00 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3GBb0Dl3428646;
        Tue, 16 Apr 2019 04:37:00 -0700
Date:   Tue, 16 Apr 2019 04:37:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-d3617b98b04583df222f34992e65712862a77bf1@git.kernel.org>
Cc:     eranian@google.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, vincent.weaver@maine.edu,
        ak@linux.intel.com, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, torvalds@linux-foundation.org, acme@redhat.com,
        peterz@infradead.org, jolsa@redhat.com, kan.liang@linux.intel.com
Reply-To: peterz@infradead.org, kan.liang@linux.intel.com,
          jolsa@redhat.com, torvalds@linux-foundation.org, hpa@zytor.com,
          acme@redhat.com, vincent.weaver@maine.edu,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, ak@linux.intel.com, eranian@google.com,
          alexander.shishkin@linux.intel.com
In-Reply-To: <20190402194509.2832-7-kan.liang@linux.intel.com>
References: <20190402194509.2832-7-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/lbr: Avoid reading the LBRs when adaptive
 PEBS handles them
Git-Commit-ID: d3617b98b04583df222f34992e65712862a77bf1
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

Commit-ID:  d3617b98b04583df222f34992e65712862a77bf1
Gitweb:     https://git.kernel.org/tip/d3617b98b04583df222f34992e65712862a77bf1
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Tue, 2 Apr 2019 12:45:03 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Apr 2019 12:26:17 +0200

perf/x86/lbr: Avoid reading the LBRs when adaptive PEBS handles them

With adaptive PEBS the CPU can directly supply the LBR information,
so we don't need to read it again. But the LBRs still need to be
enabled. Add a special count to the cpuc that distinguishes these
two cases, and avoid reading the LBRs unnecessarily when PEBS is
active.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: acme@kernel.org
Cc: jolsa@kernel.org
Link: https://lkml.kernel.org/r/20190402194509.2832-7-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/lbr.c  | 13 ++++++++++++-
 arch/x86/events/perf_event.h |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 07b7175fc378..6f814a27416b 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -488,6 +488,8 @@ void intel_pmu_lbr_add(struct perf_event *event)
 	 * be 'new'. Conversely, a new event can get installed through the
 	 * context switch path for the first time.
 	 */
+	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip > 0)
+		cpuc->lbr_pebs_users++;
 	perf_sched_cb_inc(event->ctx->pmu);
 	if (!cpuc->lbr_users++ && !event->total_time_running)
 		intel_pmu_lbr_reset();
@@ -507,8 +509,11 @@ void intel_pmu_lbr_del(struct perf_event *event)
 		task_ctx->lbr_callstack_users--;
 	}
 
+	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip > 0)
+		cpuc->lbr_pebs_users--;
 	cpuc->lbr_users--;
 	WARN_ON_ONCE(cpuc->lbr_users < 0);
+	WARN_ON_ONCE(cpuc->lbr_pebs_users < 0);
 	perf_sched_cb_dec(event->ctx->pmu);
 }
 
@@ -658,7 +663,13 @@ void intel_pmu_lbr_read(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	if (!cpuc->lbr_users)
+	/*
+	 * Don't read when all LBRs users are using adaptive PEBS.
+	 *
+	 * This could be smarter and actually check the event,
+	 * but this simple approach seems to work for now.
+	 */
+	if (!cpuc->lbr_users || cpuc->lbr_users == cpuc->lbr_pebs_users)
 		return;
 
 	if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_32)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 2059c143946f..dced91582147 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -233,6 +233,7 @@ struct cpu_hw_events {
 	 * Intel LBR bits
 	 */
 	int				lbr_users;
+	int				lbr_pebs_users;
 	struct perf_branch_stack	lbr_stack;
 	struct perf_branch_entry	lbr_entries[MAX_LBR_ENTRIES];
 	struct er_account		*lbr_sel;
