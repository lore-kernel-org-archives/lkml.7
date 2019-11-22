Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D43C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C5F207FA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574434679;
	bh=yJjvxcm9G3TB62mEfCTdxAdiL6k4hLEntr+2DQfdpzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KpJYLYZYwye6D9XTNu6YDeKmhL9BvQxi07WgSY8krpg4dgYo86vbbZyuI7G+gcSg+
	 pBRd2+KtCISvp3oKOnEvrkpPv/4shmOe7HPlVSghuuMIwT8sEPrE7QW0iCu9ZRXH/t
	 PAU66twQ8kyISh2AphIVQ/sDwEOEg6i/I7pwT+xo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfKVO55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:57:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:58878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbfKVO54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:57:56 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B91EF20706;
        Fri, 22 Nov 2019 14:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574434675;
        bh=yJjvxcm9G3TB62mEfCTdxAdiL6k4hLEntr+2DQfdpzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ydQGq/s2mZyuktmM37SxKH1gp9KmlDRsJjRUQVsApn0mD5KDw04/o1rbgWd5Ftkof
         rwRQ7lPQBzVDSBgMl+soofhVkx/upRren6cD10SwduZEMpkUyUfzqqCPuuqMu9z6/w
         Vq3J9l4jz37mV94aGI1N1bH21qcqBsaTVRhZej58=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 13/26] perf record: Add support for AUX area sampling
Date:   Fri, 22 Nov 2019 11:56:58 -0300
Message-Id: <20191122145711.3171-14-acme@kernel.org>
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

Add a 'perf record' option '--aux-sample' to request AUX area sampling.
AUX area sampling uses an overwriting buffer much like snapshot mode, so
adjust the AUX buffer mmapping accordingly. To make it easy to queue
samples for decoding, synthesize an ID index.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20191115124225.5247-7-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-record.txt |  6 ++++++
 tools/perf/builtin-record.c              | 21 ++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index ebcba1f95513..e216d7b529c9 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -433,6 +433,12 @@ can be specified in a string that follows this option:
 In Snapshot Mode trace data is captured only when signal SIGUSR2 is received
 and on exit if the above 'e' option is given.
 
+--aux-sample[=OPTIONS]::
+Select AUX area sampling. At least one of the events selected by the -e option
+must be an AUX area event. Samples on other events will be created containing
+data from the AUX area. Optionally sample size may be specified, otherwise it
+defaults to 4KiB.
+
 --proc-map-timeout::
 When processing pre-existing threads /proc/XXX/mmap, it may take a long time,
 because the file may be huge. A time out is needed in such cases.
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7ab3110b4035..b5063d3b6fd0 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -680,6 +680,11 @@ static int record__auxtrace_init(struct record *rec)
 	if (err)
 		return err;
 
+	err = auxtrace_parse_sample_options(rec->itr, rec->evlist, &rec->opts,
+					    rec->opts.auxtrace_sample_opts);
+	if (err)
+		return err;
+
 	return auxtrace_parse_filters(rec->evlist);
 }
 
@@ -752,6 +757,8 @@ static int record__mmap_evlist(struct record *rec,
 			       struct evlist *evlist)
 {
 	struct record_opts *opts = &rec->opts;
+	bool auxtrace_overwrite = opts->auxtrace_snapshot_mode ||
+				  opts->auxtrace_sample_mode;
 	char msg[512];
 
 	if (opts->affinity != PERF_AFFINITY_SYS)
@@ -759,7 +766,7 @@ static int record__mmap_evlist(struct record *rec,
 
 	if (evlist__mmap_ex(evlist, opts->mmap_pages,
 				 opts->auxtrace_mmap_pages,
-				 opts->auxtrace_snapshot_mode,
+				 auxtrace_overwrite,
 				 opts->nr_cblocks, opts->affinity,
 				 opts->mmap_flush, opts->comp_level) < 0) {
 		if (errno == EPERM) {
@@ -1046,6 +1053,7 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
 		}
 
 		if (map->auxtrace_mmap.base && !rec->opts.auxtrace_snapshot_mode &&
+		    !rec->opts.auxtrace_sample_mode &&
 		    record__auxtrace_mmap_read(rec, map) != 0) {
 			rc = -1;
 			goto out;
@@ -1321,6 +1329,15 @@ static int record__synthesize(struct record *rec, bool tail)
 	if (err)
 		goto out;
 
+	/* Synthesize id_index before auxtrace_info */
+	if (rec->opts.auxtrace_sample_mode) {
+		err = perf_event__synthesize_id_index(tool,
+						      process_synthesized_event,
+						      session->evlist, machine);
+		if (err)
+			goto out;
+	}
+
 	if (rec->opts.full_auxtrace) {
 		err = perf_event__synthesize_auxtrace_info(rec->itr, tool,
 					session, process_synthesized_event);
@@ -2329,6 +2346,8 @@ static struct option __record_options[] = {
 	parse_clockid),
 	OPT_STRING_OPTARG('S', "snapshot", &record.opts.auxtrace_snapshot_opts,
 			  "opts", "AUX area tracing Snapshot Mode", ""),
+	OPT_STRING_OPTARG(0, "aux-sample", &record.opts.auxtrace_sample_opts,
+			  "opts", "sample AUX area", ""),
 	OPT_UINTEGER(0, "proc-map-timeout", &proc_map_timeout,
 			"per thread proc mmap processing timeout in ms"),
 	OPT_BOOLEAN(0, "namespaces", &record.opts.record_namespaces,
-- 
2.21.0

