Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7DFC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15652070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="niTQpUNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfFVGj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 02:39:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:32907 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfFVGj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 02:39:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M6dWbH2005577
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 21 Jun 2019 23:39:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M6dWbH2005577
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561185572;
        bh=bpKADK8JovXN9Pr+3prUqHZnJ7Y6bR9v6t7WRHlA85Q=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=niTQpUNsPTOLUd5Ie/ZcgM/Q04MWruypzKXzTkKhQ281JEGEC16RqHeACy09eAnN0
         6pmgB6eZgZl++CnIQNCll/20eptxtwOTRLNl7mqgpTAVYEFKKD1Wk4/jDfZjJY73d7
         TjUro9GCvC7iBltCLQJkxh4V+OM+K2UTDYtB/FtavxqIpZgxw9gAGbC9tGzvWbFM3u
         vu5cu4DENjjTTuFxJvamgnkw6XGuwy6YiiMFOrzY6x0cKyuMKlXtJkeHxg0CUSKS2W
         ITIxUkHHw/i8BwKb0aTbqpdVN7xgYkfLmh9qgV8fpKC1lgwmeqNFY+35ER2WNIL3D+
         GqY6YyDTmT1LQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M6dWkH2005574;
        Fri, 21 Jun 2019 23:39:32 -0700
Date:   Fri, 21 Jun 2019 23:39:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-9d0bc53e35b82e429ab698d112f7af4336578735@git.kernel.org>
Cc:     jolsa@redhat.com, acme@redhat.com, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        adrian.hunter@intel.com
Reply-To: jolsa@redhat.com, acme@redhat.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          adrian.hunter@intel.com
In-Reply-To: <20190610072803.10456-7-adrian.hunter@intel.com>
References: <20190610072803.10456-7-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf intel-pt: Synthesize PEBS sample basic
 information
Git-Commit-ID: 9d0bc53e35b82e429ab698d112f7af4336578735
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

Commit-ID:  9d0bc53e35b82e429ab698d112f7af4336578735
Gitweb:     https://git.kernel.org/tip/9d0bc53e35b82e429ab698d112f7af4336578735
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Mon, 10 Jun 2019 10:27:58 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Jun 2019 15:57:18 -0300

perf intel-pt: Synthesize PEBS sample basic information

Synthesize a PEBS sample using basic information (ip, timestamp) only.
Other PEBS information will be added in later patches.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190610072803.10456-7-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 52 ++++++++++++++++++++++++++++++++++++++++++++--
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
