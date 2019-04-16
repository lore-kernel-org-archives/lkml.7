Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17C6C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E1E2077C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfDPLf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:35:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58031 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbfDPLf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:35:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3GBZfQb3428348
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 04:35:41 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3GBZeLb3428345;
        Tue, 16 Apr 2019 04:35:40 -0700
Date:   Tue, 16 Apr 2019 04:35:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-477f00f9617009a9a3a9271885231573b728ca4f@git.kernel.org>
Cc:     eranian@google.com, tglx@linutronix.de, mingo@kernel.org,
        kan.liang@linux.intel.com, jolsa@redhat.com,
        torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        vincent.weaver@maine.edu, alexander.shishkin@linux.intel.com,
        acme@redhat.com
Reply-To: eranian@google.com, tglx@linutronix.de, mingo@kernel.org,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          kan.liang@linux.intel.com, torvalds@linux-foundation.org,
          jolsa@redhat.com, vincent.weaver@maine.edu, hpa@zytor.com,
          acme@redhat.com, alexander.shishkin@linux.intel.com
In-Reply-To: <20190402194509.2832-5-kan.liang@linux.intel.com>
References: <20190402194509.2832-5-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel/ds: Extract code of event update in
 short period
Git-Commit-ID: 477f00f9617009a9a3a9271885231573b728ca4f
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

Commit-ID:  477f00f9617009a9a3a9271885231573b728ca4f
Gitweb:     https://git.kernel.org/tip/477f00f9617009a9a3a9271885231573b728ca4f
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 2 Apr 2019 12:45:01 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Apr 2019 12:19:39 +0200

perf/x86/intel/ds: Extract code of event update in short period

The drain_pebs() could be called twice in a short period for auto-reload
event in pmu::read(). The intel_pmu_save_and_restart_reload() should be
called to update the event->count.

This case should also be handled on Icelake. Extract the code for
later reuse.

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
Link: https://lkml.kernel.org/r/20190402194509.2832-5-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/ds.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 2f80b7e282ff..9ac73860645d 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1491,6 +1491,25 @@ static void intel_pmu_drain_pebs_core(struct pt_regs *iregs)
 	__intel_pmu_pebs_event(event, iregs, at, top, 0, n);
 }
 
+static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, int size)
+{
+	struct perf_event *event;
+	int bit;
+
+	/*
+	 * The drain_pebs() could be called twice in a short period
+	 * for auto-reload event in pmu::read(). There are no
+	 * overflows have happened in between.
+	 * It needs to call intel_pmu_save_and_restart_reload() to
+	 * update the event->count for this case.
+	 */
+	for_each_set_bit(bit, (unsigned long *)&cpuc->pebs_enabled, size) {
+		event = cpuc->events[bit];
+		if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
+			intel_pmu_save_and_restart_reload(event, 0);
+	}
+}
+
 static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1518,19 +1537,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs)
 	}
 
 	if (unlikely(base >= top)) {
-		/*
-		 * The drain_pebs() could be called twice in a short period
-		 * for auto-reload event in pmu::read(). There are no
-		 * overflows have happened in between.
-		 * It needs to call intel_pmu_save_and_restart_reload() to
-		 * update the event->count for this case.
-		 */
-		for_each_set_bit(bit, (unsigned long *)&cpuc->pebs_enabled,
-				 size) {
-			event = cpuc->events[bit];
-			if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
-				intel_pmu_save_and_restart_reload(event, 0);
-		}
+		intel_pmu_pebs_event_update_no_drain(cpuc, size);
 		return;
 	}
 
