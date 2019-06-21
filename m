Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D40C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F89821537
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561138798;
	bh=xE0k9N05ZUGquXZDysVmXTA8LbITFFdKTr5WaTDA5Os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hfAud+wi//34ovJmWPvirDdhtG1RTMu1JOu5YNNhwcZFyagPI8zGvyWm9wuulfJQB
	 34cNFM5jP/VoHOfUSds7JvhAkaYyD2KZfNlahnIgNGiR4K6qWxhsTwsBv1ftVGKgg6
	 qb/LV159yBZ/5r3VObVdxOv/IAGuLySfldqqEu+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfFURj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:39:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbfFURjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:39:55 -0400
Received: from quaco.ghostprotocols.net (187-26-104-93.3g.claro.net.br [187.26.104.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65D552083B;
        Fri, 21 Jun 2019 17:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561138794;
        bh=xE0k9N05ZUGquXZDysVmXTA8LbITFFdKTr5WaTDA5Os=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0zqPEJdP/PXvWy/U4RrJ5cqqSOhf9+a80MEHEXMvnI9yG0Y9F6vZENXcnxrvzJ1CG
         jJQ0/p8dqvJAlA7d8grxUYiS5ou1h4xQ0WBmuPb2yDX3Oig5AWYWIvNDctSlq+m+Cg
         VLHw2U0L0fBDdZ8liHh/26vF7w1ZIpcDKvngTqXo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 08/25] perf intel-pt: Synthesize PEBS sample basic information
Date:   Fri, 21 Jun 2019 14:38:14 -0300
Message-Id: <20190621173831.13780-9-acme@kernel.org>
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

Synthesize a PEBS sample using basic information (ip, timestamp) only.
Other PEBS information will be added in later patches.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190610072803.10456-7-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 52 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index a2d90b2f1f11..979519b00a74 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1547,9 +1547,57 @@ static int intel_pt_synth_pwrx_sample(struct intel_pt_queue *ptq)
 					    pt->pwr_events_sample_type);
 }
 
-static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq __maybe_unused)
+static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 {
-	return 0;
+	const struct intel_pt_blk_items *items = &ptq->state->items;
+	struct perf_sample sample = { .ip = 0, };
+	union perf_event *event = ptq->event_buf;
+	struct intel_pt *pt = ptq->pt;
+	struct perf_evsel *evsel = pt->pebs_evsel;
+	u64 sample_type = evsel->attr.sample_type;
+	u64 id = evsel->id[0];
+	u8 cpumode;
+
+	if (intel_pt_skip_event(pt))
+		return 0;
+
+	intel_pt_prep_a_sample(ptq, event, &sample);
+
+	sample.id = id;
+	sample.stream_id = id;
+
+	if (!evsel->attr.freq)
+		sample.period = evsel->attr.sample_period;
+
+	/* No support for non-zero CS base */
+	if (items->has_ip)
+		sample.ip = items->ip;
+	else if (items->has_rip)
+		sample.ip = items->rip;
+	else
+		sample.ip = ptq->state->from_ip;
+
+	/* No support for guest mode at this time */
+	cpumode = sample.ip < ptq->pt->kernel_start ?
+		  PERF_RECORD_MISC_USER :
+		  PERF_RECORD_MISC_KERNEL;
+
+	event->sample.header.misc = cpumode | PERF_RECORD_MISC_EXACT_IP;
+
+	sample.cpumode = cpumode;
+
+	if (sample_type & PERF_SAMPLE_TIME) {
+		u64 timestamp = 0;
+
+		if (items->has_timestamp)
+			timestamp = items->timestamp;
+		else if (!pt->timeless_decoding)
+			timestamp = ptq->timestamp;
+		if (timestamp)
+			sample.time = tsc_to_perf_time(timestamp, &pt->tc);
+	}
+
+	return intel_pt_deliver_synth_event(pt, ptq, event, &sample, sample_type);
 }
 
 static int intel_pt_synth_error(struct intel_pt *pt, int code, int cpu,
-- 
2.20.1

