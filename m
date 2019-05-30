Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6076DC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33740249B2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Dib+/ZLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfE3IVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:21:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38261 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfE3IVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:21:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U8LGvk2906072
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:21:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U8LGvk2906072
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559204477;
        bh=BOpmNGG3C/si5Tq4iw4XVp70GH+uonk7eHF/SzEXYvw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Dib+/ZLteRZOBxVN71KOx+GEEquh1nbXPQQkthrD9vcI81xJ0Hbi9NF275BDzUirR
         lWkSqBTnSOZQhQocn+AzwwnYABmPAotjQuEJ/HXHLiLGJHDbVJ/dX2mwJkpSqJQktW
         8TzrUrDhDc/IfTz/eSA8B5aADIIylw2POHiUna9hrNPbaRu1VzcLgJ+gQMdOnUI9XJ
         qsgVRRP1kGc7EdSymszbLw7u0T8Y381ph0iDU6kjIIMObh2/wOwd+/BomQ5wn/y9q9
         VpxJEAjK/9ntQynZ5py+yRgvoLXtwrKMGswDRuyMeQGUxGRt3tun8z7yuiS8DSABDW
         OoKOgABaR2kiA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U8LGWI2906069;
        Thu, 30 May 2019 01:21:16 -0700
Date:   Thu, 30 May 2019 01:21:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-c7b4f15ff79b539fed4c382e52e988548081bc9d@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@redhat.com,
        tglx@linutronix.de, mingo@kernel.org, adrian.hunter@intel.com,
        hpa@zytor.com
Reply-To: tglx@linutronix.de, jolsa@redhat.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, acme@redhat.com,
          adrian.hunter@intel.com, hpa@zytor.com
In-Reply-To: <20190412113830.4126-8-adrian.hunter@intel.com>
References: <20190412113830.4126-8-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Improve sync_switch by processing
 PERF_RECORD_SWITCH* in events
Git-Commit-ID: c7b4f15ff79b539fed4c382e52e988548081bc9d
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

Commit-ID:  c7b4f15ff79b539fed4c382e52e988548081bc9d
Gitweb:     https://git.kernel.org/tip/c7b4f15ff79b539fed4c382e52e988548081bc9d
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Fri, 12 Apr 2019 14:38:29 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:45 -0300

perf intel-pt: Improve sync_switch by processing PERF_RECORD_SWITCH* in events

sync_switch is a facility to synchronize decoding more closely with the
point in the kernel when the context actually switched.

Improve it by processing "context switch in" events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190412113830.4126-8-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 40 +++++++++++++++++++++++++++++++++++++++-
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
