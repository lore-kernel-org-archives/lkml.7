Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6F4C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9726C2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfDLLkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:40:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:12712 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbfDLLj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:39:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Apr 2019 04:39:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,341,1549958400"; 
   d="scan'208";a="336687258"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 12 Apr 2019 04:39:57 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] perf intel-pt: Improve sync_switch
Date:   Fri, 12 Apr 2019 14:38:29 +0300
Message-Id: <20190412113830.4126-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190412113830.4126-1-adrian.hunter@intel.com>
References: <20190412113830.4126-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sync_switch is a facility to synchronize decoding more closely with the
point in the kernel when the context actually switched.

Improve it by processing "context switch in" events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 40 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 6d288237887b..deaf2888dc55 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1914,6 +1914,44 @@ static int intel_pt_process_switch(struct intel_pt *pt,
 	return machine__set_current_tid(pt->machine, cpu, -1, tid);
 }
 
+static int intel_pt_context_switch_in(struct intel_pt *pt,
+				      struct perf_sample *sample)
+{
+	pid_t pid = sample->pid;
+	pid_t tid = sample->tid;
+	int cpu = sample->cpu;
+
+	if (pt->sync_switch) {
+		struct intel_pt_queue *ptq;
+
+		ptq = intel_pt_cpu_to_ptq(pt, cpu);
+		if (ptq && ptq->sync_switch) {
+			ptq->next_tid = -1;
+			switch (ptq->switch_state) {
+			case INTEL_PT_SS_NOT_TRACING:
+			case INTEL_PT_SS_UNKNOWN:
+			case INTEL_PT_SS_TRACING:
+				break;
+			case INTEL_PT_SS_EXPECTING_SWITCH_EVENT:
+			case INTEL_PT_SS_EXPECTING_SWITCH_IP:
+				ptq->switch_state = INTEL_PT_SS_TRACING;
+				break;
+			default:
+				break;
+			}
+		}
+	}
+
+	/*
+	 * If the current tid has not been updated yet, ensure it is now that
+	 * a "switch in" event has occurred.
+	 */
+	if (machine__get_current_tid(pt->machine, cpu) == tid)
+		return 0;
+
+	return machine__set_current_tid(pt->machine, cpu, pid, tid);
+}
+
 static int intel_pt_context_switch(struct intel_pt *pt, union perf_event *event,
 				   struct perf_sample *sample)
 {
@@ -1925,7 +1963,7 @@ static int intel_pt_context_switch(struct intel_pt *pt, union perf_event *event,
 
 	if (pt->have_sched_switch == 3) {
 		if (!out)
-			return 0;
+			return intel_pt_context_switch_in(pt, sample);
 		if (event->header.type != PERF_RECORD_SWITCH_CPU_WIDE) {
 			pr_err("Expecting CPU-wide context switch event\n");
 			return -EINVAL;
-- 
2.17.1

