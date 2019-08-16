Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A098C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E6A2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HKgcXAde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfHPU6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:58:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33435 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfHPU6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:58:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7GKw8Nn2960379
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 16 Aug 2019 13:58:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7GKw8Nn2960379
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565989089;
        bh=hP0pBjeG5VYgDYT4S0plX03QGJ1BholW8goiLFCXLb0=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=HKgcXAdebPimWNAsGffnYUqPJyne9AWhr/Hy+nMLZT/Ao6rdBeAKMmV4uFSGFNwLd
         gW+JSOrU6mk7Q1GXQVEYmAcWxZjqeYtALd9FIdD2Dm2gPWhXuh4eiJ4sbLb+I+v5qJ
         h+Klux2sb6Kg3Ou60DFjhONDuEd+5qM22f7kaYg1X+z3kLWiyUutrJ+0T54ockBcGS
         EuxmyndPPtlcjBSaJEp9WG5pZ/MzaVkQhtHStOYviD3d15/O9cfewcfi9JMuHsSkOZ
         mz5pDzyumZQpBza2bNFM8XHon1txIonuuZyw98i8fGQH93M+/MVET5fHK11D/axBYl
         /Z5OKo8wHJusg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7GKw8Zm2960376;
        Fri, 16 Aug 2019 13:58:08 -0700
Date:   Fri, 16 Aug 2019 13:58:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-c7q7qjeqtyvc9mkeipxza6ne@git.kernel.org>
Cc:     acme@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, fweimer@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, wcohen@redhat.com,
        adrian.hunter@intel.com, jolsa@kernel.org
Reply-To: linux-kernel@vger.kernel.org, wcohen@redhat.com,
          namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
          acme@redhat.com, fweimer@redhat.com, hpa@zytor.com,
          mingo@kernel.org, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf top: Add --switch-on/--switch-off events
Git-Commit-ID: 2f53ae347f597842683c4bde5b9ce76f5efae247
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

Commit-ID:  2f53ae347f597842683c4bde5b9ce76f5efae247
Gitweb:     https://git.kernel.org/tip/2f53ae347f597842683c4bde5b9ce76f5efae247
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 15 Aug 2019 16:03:26 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 15 Aug 2019 16:03:26 -0300

perf top: Add --switch-on/--switch-off events

Just like 'perf trace' and 'perf script', should be useful for instance
to only consider samples after the initialization phase of some
workload.

The man page has some examples and considerations about its current
interface, that still doesn't handle the on/off events in a special way,
behaving just like when multiple events are specified, i.e.:

- In non-group mode (when the event list is not enclosed in {}) show a
  a menu to allow choosing which event the user wants to see in the
  histograms browser

- In group mode, be it using {} or asking for --group, show one column
  per event.

Try for instance:

  # perf top -e '{cycles,instructions,probe:icmp_rcv}' --switch-on=probe:icmp_rcv

Replace probe:icmp_rcv, that I put in place using:

  # perf probe icmp_rcv:59

To hit when broadcast packets arrive, with a probe installed after an
initialization phase is over or after some other point of interest, some
garbage collection, etc, and also use --switch-off, for instance, on a
probe installed after said garbage collection is over.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: William Cohen <wcohen@redhat.com>
Link: https://lkml.kernel.org/n/tip-c7q7qjeqtyvc9mkeipxza6ne@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-top.txt | 38 +++++++++++++++++++++++++++++++++++
 tools/perf/builtin-top.c              | 10 ++++++++-
 tools/perf/util/top.h                 |  2 ++
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index cfea87c6f38e..5596129a71cf 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -266,6 +266,44 @@ Default is to monitor all CPUS.
 	Record events of type PERF_RECORD_NAMESPACES and display it with the
 	'cgroup_id' sort key.
 
+--switch-on EVENT_NAME::
+	Only consider events after this event is found.
+
+	E.g.:
+
+           Find out where broadcast packets are handled
+
+		perf probe -L icmp_rcv
+
+	   Insert a probe there:
+
+		perf probe icmp_rcv:59
+
+	   Start perf top and ask it to only consider the cycles events when a
+           broadcast packet arrives This will show a menu with two entries and
+           will start counting when a broadcast packet arrives:
+
+		perf top -e cycles,probe:icmp_rcv --switch-on=probe:icmp_rcv
+
+	   Alternatively one can ask for --group and then two overhead columns
+           will appear, the first for cycles and the second for the switch-on event.
+
+		perf top --group -e cycles,probe:icmp_rcv --switch-on=probe:icmp_rcv
+
+	This may be interesting to measure a workload only after some initialization
+	phase is over, i.e. insert a perf probe at that point and use the above
+	examples replacing probe:icmp_rcv with the just-after-init probe.
+
+--switch-off EVENT_NAME::
+	Stop considering events after this event is found.
+
+--show-on-off-events::
+	Show the --switch-on/off events too. This has no effect in 'perf top' now
+	but probably we'll make the default not to show the switch-on/off events
+        on the --group mode and if there is only one event besides the off/on ones,
+	go straight to the histogram browser, just like 'perf top' with no events
+	explicitely specified does.
+
 
 INTERACTIVE PROMPTING KEYS
 --------------------------
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 78e7efc597a6..5970723cd55a 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1148,8 +1148,11 @@ static int deliver_event(struct ordered_events *qe,
 	evsel = perf_evlist__id2evsel(session->evlist, sample.id);
 	assert(evsel != NULL);
 
-	if (event->header.type == PERF_RECORD_SAMPLE)
+	if (event->header.type == PERF_RECORD_SAMPLE) {
+		if (evswitch__discard(&top->evswitch, evsel))
+			return 0;
 		++top->samples;
+	}
 
 	switch (sample.cpumode) {
 	case PERF_RECORD_MISC_USER:
@@ -1534,6 +1537,7 @@ int cmd_top(int argc, const char **argv)
 			"number of thread to run event synthesize"),
 	OPT_BOOLEAN(0, "namespaces", &opts->record_namespaces,
 		    "Record namespaces events"),
+	OPTS_EVSWITCH(&top.evswitch),
 	OPT_END()
 	};
 	struct evlist *sb_evlist = NULL;
@@ -1567,6 +1571,10 @@ int cmd_top(int argc, const char **argv)
 		goto out_delete_evlist;
 	}
 
+	status = evswitch__init(&top.evswitch, top.evlist, stderr);
+	if (status)
+		goto out_delete_evlist;
+
 	if (symbol_conf.report_hierarchy) {
 		/* disable incompatible options */
 		symbol_conf.event_group = false;
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 2023e0bf6165..dc4bb6e52a83 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -3,6 +3,7 @@
 #define __PERF_TOP_H 1
 
 #include "tool.h"
+#include "evswitch.h"
 #include "annotate.h"
 #include <linux/types.h>
 #include <stddef.h>
@@ -18,6 +19,7 @@ struct perf_top {
 	struct evlist *evlist;
 	struct record_opts record_opts;
 	struct annotation_options annotation_opts;
+	struct evswitch	   evswitch;
 	/*
 	 * Symbols will be added here in perf_event__process_sample and will
 	 * get out after decayed.
