Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9347C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C69B2258D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559137174;
	bh=Sa7KD0sbfMnSk1KR2lSFgDC/QscLlH/Tnu5Spvttrtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DIB/D6TNqchO+5B6rYvKy/whA9qdz3WWHGDeBGYvGRTge6A1ojRyc8KVuFmTJIORc
	 hlbUpx9Lo78aqrnMalnIDStGIS8Erq0m9We0+BBlD38LKOOVwEvRdbHSS41N8yHdP3
	 1H5ldysLXYQIidoEncCAHRMMfpyoqmq0hLSMg03c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfE2Njd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:39:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbfE2Nja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:39:30 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.211.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CAD4229E9;
        Wed, 29 May 2019 13:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559137169;
        bh=Sa7KD0sbfMnSk1KR2lSFgDC/QscLlH/Tnu5Spvttrtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J5VmgomYXTFYms0ix6dc33EoKG2aAF2s3xHFMYRjGKA9hcAw6fmQYrSBrpQrRy08v
         Vb1ee6Hbft0hi86u5Tc0xX++5cHU0YfmEZxDJ4ty56fdjvUy+/pAVDJrcK6r0PK1qK
         HrIjdA20drZfXYcOY6FWSD4AM4sWzpISb0zFTnZs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 40/41] perf intel-pt: Improve sync_switch by processing PERF_RECORD_SWITCH* in events
Date:   Wed, 29 May 2019 10:36:04 -0300
Message-Id: <20190529133605.21118-41-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

sync_switch is a facility to synchronize decoding more closely with the
point in the kernel when the context actually switched.

Improve it by processing "context switch in" events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190412113830.4126-8-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 40 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 03b1da6d1da4..6aaba1146fc8 100644
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
2.20.1

