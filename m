Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BA5C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B999320720
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfKWIQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 03:16:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36254 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfKWIPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 03:15:11 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iYQZN-0002ZZ-3g; Sat, 23 Nov 2019 09:15:05 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A72281C1AD2;
        Sat, 23 Nov 2019 09:15:01 +0100 (CET)
Date:   Sat, 23 Nov 2019 08:15:01 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf record: Add support for AUX area sampling
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191115124225.5247-7-adrian.hunter@intel.com>
References: <20191115124225.5247-7-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <157449690160.21853.4410247253219938717.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c0a6de06c446f8d173ef53fba361acedd5880b20
Gitweb:        https://git.kernel.org/tip/c0a6de06c446f8d173ef53fba361acedd5880b20
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Fri, 15 Nov 2019 14:42:16 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 22 Nov 2019 10:48:13 -03:00

perf record: Add support for AUX area sampling

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
index ebcba1f..e216d7b 100644
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
index 7ab3110..b5063d3 100644
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
