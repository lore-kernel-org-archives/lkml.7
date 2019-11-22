Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAA7C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2422420748
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574434687;
	bh=rn/md7MiKENgDHuwx6uCoVY82017vOAurjApBQAXjBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uhuH1ooOiS1gwIsctQq9E2LikmeqNMJTWUNfJVOZ2TgRpQUWrch/3f7sl1TsHQQ81
	 93tCl2FPRL+vCM0RIhnepVe6Zr4Zf4eT7S1AsOj69bgxuqwB5/Dyok0thua8XeYdUA
	 OfhDsDhpqVnFag2l/UDvUTs7uAJAxVBz65DU0Rwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfKVO6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:58:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:59020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727425AbfKVO6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:58:01 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECEC82072D;
        Fri, 22 Nov 2019 14:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574434681;
        bh=rn/md7MiKENgDHuwx6uCoVY82017vOAurjApBQAXjBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=piI6185qZSdkPUGh4tnRDDBhEBKRI6aP3X80o+xMnCEqAIpgLnhpMULsw1D18zk8L
         fj6o312tl4n33z1rD8sRbGhuRe7HZsgvVdhH5+uTuPcU6dg7W9vSPHHEz62F9hIrsP
         gYfSgxqJppj8VDgzuGQ3vwkdenkLXG38iYG9nJKE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 15/26] perf inject: Cut AUX area samples
Date:   Fri, 22 Nov 2019 11:57:00 -0300
Message-Id: <20191122145711.3171-16-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191122145711.3171-1-acme@kernel.org>
References: <20191122145711.3171-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

After decoding AUX area samples, the AUX area data is no longer needed
(having been replaced by synthesized events) so cut it out.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20191115124225.5247-9-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 1e5d28311e14..9664a72a089d 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -45,6 +45,7 @@ struct perf_inject {
 	u64			aux_id;
 	struct list_head	samples;
 	struct itrace_synth_opts itrace_synth_opts;
+	char			event_copy[PERF_SAMPLE_MAX_SIZE];
 };
 
 struct event_entry {
@@ -214,6 +215,28 @@ static int perf_event__drop_aux(struct perf_tool *tool,
 	return 0;
 }
 
+static union perf_event *
+perf_inject__cut_auxtrace_sample(struct perf_inject *inject,
+				 union perf_event *event,
+				 struct perf_sample *sample)
+{
+	size_t sz1 = sample->aux_sample.data - (void *)event;
+	size_t sz2 = event->header.size - sample->aux_sample.size - sz1;
+	union perf_event *ev = (union perf_event *)inject->event_copy;
+
+	if (sz1 > event->header.size || sz2 > event->header.size ||
+	    sz1 + sz2 > event->header.size ||
+	    sz1 < sizeof(struct perf_event_header) + sizeof(u64))
+		return event;
+
+	memcpy(ev, event, sz1);
+	memcpy((void *)ev + sz1, (void *)event + event->header.size - sz2, sz2);
+	ev->header.size = sz1 + sz2;
+	((u64 *)((void *)ev + sz1))[-1] = 0;
+
+	return ev;
+}
+
 typedef int (*inject_handler)(struct perf_tool *tool,
 			      union perf_event *event,
 			      struct perf_sample *sample,
@@ -226,6 +249,9 @@ static int perf_event__repipe_sample(struct perf_tool *tool,
 				     struct evsel *evsel,
 				     struct machine *machine)
 {
+	struct perf_inject *inject = container_of(tool, struct perf_inject,
+						  tool);
+
 	if (evsel && evsel->handler) {
 		inject_handler f = evsel->handler;
 		return f(tool, event, sample, evsel, machine);
@@ -233,6 +259,9 @@ static int perf_event__repipe_sample(struct perf_tool *tool,
 
 	build_id__mark_dso_hit(tool, event, sample, evsel, machine);
 
+	if (inject->itrace_synth_opts.set && sample->aux_sample.size)
+		event = perf_inject__cut_auxtrace_sample(inject, event, sample);
+
 	return perf_event__repipe_synth(tool, event);
 }
 
-- 
2.21.0

