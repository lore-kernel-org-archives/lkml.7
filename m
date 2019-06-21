Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2038EC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC23A208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561138793;
	bh=f5HnM7aBnSVS4c/EThY61lSVxdahD4K1ufyVkSXKhSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GNnaZR+zNtU5Bp/j+jS86LgMa3ou7BcLfbSiy94aZXjKKR5fJYDkZJ/5NrRQcXG+a
	 WnbXUplNlUYVK40KdTORE0q9diZy7wNQsGLRcZGZHwaMzygsXioIBLlY5hIvMrXtvp
	 DR/TBiL5W6h+7g74cUA2cH9LoMfoCLbZ324bJ5LM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfFURjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:39:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfFURjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:39:49 -0400
Received: from quaco.ghostprotocols.net (187-26-104-93.3g.claro.net.br [187.26.104.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8F6D21537;
        Fri, 21 Jun 2019 17:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561138788;
        bh=f5HnM7aBnSVS4c/EThY61lSVxdahD4K1ufyVkSXKhSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1/hnvMLFbwld0s8rzWCzcMmmO8BFukaBqBdlfWBxrKDWzu+V6tLd+o1TKq7xRgOBA
         2OsHNBNzkvbKhjLG0lBT99+8eu3RT7LCoI/sNabks0r8mf1TazELWrh8D0O77Px0LM
         uuIHBU751g13bqSWOK7fESvMHQbMQX8L8HzNQBec=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/25] perf intel-pt: Factor out common sample preparation for re-use
Date:   Fri, 21 Jun 2019 14:38:13 -0300
Message-Id: <20190621173831.13780-8-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621173831.13780-1-acme@kernel.org>
References: <20190621173831.13780-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Factor out common sample preparation for re-use when synthesizing PEBS
samples.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190610072803.10456-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index cc91c1413c22..a2d90b2f1f11 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1182,28 +1182,37 @@ static inline bool intel_pt_skip_event(struct intel_pt *pt)
 	       pt->num_events++ < pt->synth_opts.initial_skip;
 }
 
+static void intel_pt_prep_a_sample(struct intel_pt_queue *ptq,
+				   union perf_event *event,
+				   struct perf_sample *sample)
+{
+	event->sample.header.type = PERF_RECORD_SAMPLE;
+	event->sample.header.size = sizeof(struct perf_event_header);
+
+	sample->pid = ptq->pid;
+	sample->tid = ptq->tid;
+	sample->cpu = ptq->cpu;
+	sample->insn_len = ptq->insn_len;
+	memcpy(sample->insn, ptq->insn, INTEL_PT_INSN_BUF_SZ);
+}
+
 static void intel_pt_prep_b_sample(struct intel_pt *pt,
 				   struct intel_pt_queue *ptq,
 				   union perf_event *event,
 				   struct perf_sample *sample)
 {
+	intel_pt_prep_a_sample(ptq, event, sample);
+
 	if (!pt->timeless_decoding)
 		sample->time = tsc_to_perf_time(ptq->timestamp, &pt->tc);
 
 	sample->ip = ptq->state->from_ip;
 	sample->cpumode = intel_pt_cpumode(pt, sample->ip);
-	sample->pid = ptq->pid;
-	sample->tid = ptq->tid;
 	sample->addr = ptq->state->to_ip;
 	sample->period = 1;
-	sample->cpu = ptq->cpu;
 	sample->flags = ptq->flags;
-	sample->insn_len = ptq->insn_len;
-	memcpy(sample->insn, ptq->insn, INTEL_PT_INSN_BUF_SZ);
 
-	event->sample.header.type = PERF_RECORD_SAMPLE;
 	event->sample.header.misc = sample->cpumode;
-	event->sample.header.size = sizeof(struct perf_event_header);
 }
 
 static int intel_pt_inject_event(union perf_event *event,
-- 
2.20.1

