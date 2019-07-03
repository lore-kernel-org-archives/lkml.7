Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D93DC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39693218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HQ0X8C1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfGCOGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:06:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36859 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCOGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:06:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63E6IrL3320977
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:06:18 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63E6IrL3320977
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562162779;
        bh=2fXwQSP9jDN4PnP+bjFZWYp3IXqkrYIknwyi4/vfJ+0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=HQ0X8C1S/+Hciw2IsdlESasgCKjx2PTXcbrsHXVsNO/cojrrdiPRiHpqL7RcqqjJi
         S8Yc69TZJDMhJamxYqJ6Xup6sZKcidpkT86jl+euvzW6Ym9MtP4EceM7yfB4Z5418o
         wMoDNBaMKHSD3z0XkKOie3keL7c2gUV/bO8fELfn2oOWkAZKYBZtqxlMaVx7t2WWy1
         DzcV7ycbMkz0vwk+BcZE39rw0nP3Ake31UkUCeexMAlr9vSxOoYrUtJxQRTPIYsvPX
         4zrWd6IC52BSGNj+u2WcOw5M8E19LkCkvoMoLCt2RfVyHqvFpe5pZwgXp35qnsQrmg
         Mcw7wq7JUb1SA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63E6HlD3320967;
        Wed, 3 Jul 2019 07:06:17 -0700
Date:   Wed, 3 Jul 2019 07:06:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-5fe2cf7d19c48f2b53b57e6a5786972bc1b8d738@git.kernel.org>
Cc:     jolsa@redhat.com, adrian.hunter@intel.com, mingo@kernel.org,
        acme@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Reply-To: adrian.hunter@intel.com, jolsa@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, acme@redhat.com, mingo@kernel.org,
          hpa@zytor.com
In-Reply-To: <20190622093248.581-5-adrian.hunter@intel.com>
References: <20190622093248.581-5-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Synthesize CBR events when last seen
 value changes
Git-Commit-ID: 5fe2cf7d19c48f2b53b57e6a5786972bc1b8d738
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

Commit-ID:  5fe2cf7d19c48f2b53b57e6a5786972bc1b8d738
Gitweb:     https://git.kernel.org/tip/5fe2cf7d19c48f2b53b57e6a5786972bc1b8d738
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Sat, 22 Jun 2019 12:32:45 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 25 Jun 2019 08:47:10 -0300

perf intel-pt: Synthesize CBR events when last seen value changes

The first core-to-bus ratio (CBR) event will not be shown if --itrace
's' option (skip initial number of events) is used, nor if time
intervals are specified that do not include the start of tracing. Change
the logic to record the last CBR value seen by the user, and synthesize
CBR events whenever that changes.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190622093248.581-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 65 +++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 550db6e77968..470aaae9d930 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -171,6 +171,7 @@ struct intel_pt_queue {
 	u64 last_in_cyc_cnt;
 	u64 last_br_insn_cnt;
 	u64 last_br_cyc_cnt;
+	unsigned int cbr_seen;
 	char insn[INTEL_PT_INSN_BUF_SZ];
 };
 
@@ -1052,6 +1053,8 @@ static int intel_pt_setup_queue(struct intel_pt *pt,
 			ptq->cpu = queue->cpu;
 		ptq->tid = queue->tid;
 
+		ptq->cbr_seen = UINT_MAX;
+
 		if (pt->sampling_mode && !pt->snapshot_mode &&
 		    pt->timeless_decoding)
 			ptq->step_through_buffers = true;
@@ -1184,6 +1187,17 @@ static inline bool intel_pt_skip_event(struct intel_pt *pt)
 	       pt->num_events++ < pt->synth_opts.initial_skip;
 }
 
+/*
+ * Cannot count CBR as skipped because it won't go away until cbr == cbr_seen.
+ * Also ensure CBR is first non-skipped event by allowing for 4 more samples
+ * from this decoder state.
+ */
+static inline bool intel_pt_skip_cbr_event(struct intel_pt *pt)
+{
+	return pt->synth_opts.initial_skip &&
+	       pt->num_events + 4 < pt->synth_opts.initial_skip;
+}
+
 static void intel_pt_prep_a_sample(struct intel_pt_queue *ptq,
 				   union perf_event *event,
 				   struct perf_sample *sample)
@@ -1429,9 +1443,11 @@ static int intel_pt_synth_cbr_sample(struct intel_pt_queue *ptq)
 	struct perf_synth_intel_cbr raw;
 	u32 flags;
 
-	if (intel_pt_skip_event(pt))
+	if (intel_pt_skip_cbr_event(pt))
 		return 0;
 
+	ptq->cbr_seen = ptq->state->cbr;
+
 	intel_pt_prep_p_sample(pt, ptq, event, &sample);
 
 	sample.id = ptq->pt->cbr_id;
@@ -1868,8 +1884,7 @@ static inline bool intel_pt_is_switch_ip(struct intel_pt_queue *ptq, u64 ip)
 }
 
 #define INTEL_PT_PWR_EVT (INTEL_PT_MWAIT_OP | INTEL_PT_PWR_ENTRY | \
-			  INTEL_PT_EX_STOP | INTEL_PT_PWR_EXIT | \
-			  INTEL_PT_CBR_CHG)
+			  INTEL_PT_EX_STOP | INTEL_PT_PWR_EXIT)
 
 static int intel_pt_sample(struct intel_pt_queue *ptq)
 {
@@ -1901,31 +1916,33 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 			return err;
 	}
 
-	if (pt->sample_pwr_events && (state->type & INTEL_PT_PWR_EVT)) {
-		if (state->type & INTEL_PT_CBR_CHG) {
+	if (pt->sample_pwr_events) {
+		if (ptq->state->cbr != ptq->cbr_seen) {
 			err = intel_pt_synth_cbr_sample(ptq);
 			if (err)
 				return err;
 		}
-		if (state->type & INTEL_PT_MWAIT_OP) {
-			err = intel_pt_synth_mwait_sample(ptq);
-			if (err)
-				return err;
-		}
-		if (state->type & INTEL_PT_PWR_ENTRY) {
-			err = intel_pt_synth_pwre_sample(ptq);
-			if (err)
-				return err;
-		}
-		if (state->type & INTEL_PT_EX_STOP) {
-			err = intel_pt_synth_exstop_sample(ptq);
-			if (err)
-				return err;
-		}
-		if (state->type & INTEL_PT_PWR_EXIT) {
-			err = intel_pt_synth_pwrx_sample(ptq);
-			if (err)
-				return err;
+		if (state->type & INTEL_PT_PWR_EVT) {
+			if (state->type & INTEL_PT_MWAIT_OP) {
+				err = intel_pt_synth_mwait_sample(ptq);
+				if (err)
+					return err;
+			}
+			if (state->type & INTEL_PT_PWR_ENTRY) {
+				err = intel_pt_synth_pwre_sample(ptq);
+				if (err)
+					return err;
+			}
+			if (state->type & INTEL_PT_EX_STOP) {
+				err = intel_pt_synth_exstop_sample(ptq);
+				if (err)
+					return err;
+			}
+			if (state->type & INTEL_PT_PWR_EXIT) {
+				err = intel_pt_synth_pwrx_sample(ptq);
+				if (err)
+					return err;
+			}
 		}
 	}
 
