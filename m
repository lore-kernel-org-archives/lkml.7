Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2719C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A444F217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbfH0I0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:26:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42873 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730277AbfH0I0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:26:45 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2WoC-0007z4-8R; Tue, 27 Aug 2019 10:26:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E65DC1C0DE1;
        Tue, 27 Aug 2019 10:26:25 +0200 (CEST)
Date:   Tue, 27 Aug 2019 08:26:25 -0000
From:   tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Rename perf_missing_features::bpf_event to ::bpf
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-bvc83f380dva83wlg52yd10t@git.kernel.org>
References: <tip-bvc83f380dva83wlg52yd10t@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156689438585.24571.7548307954512637240.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     74a1e863eb73dcc9f069b671dfb40650f3832116
Gitweb:        https://git.kernel.org/tip/74a1e863eb73dcc9f069b671dfb40650f3832116
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 26 Aug 2019 19:31:06 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 26 Aug 2019 19:39:11 -03:00

perf evsel: Rename perf_missing_features::bpf_event to ::bpf

No need for that _event suffix, do just like all the other meta events
and do away with that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: https://lkml.kernel.org/n/tip-bvc83f380dva83wlg52yd10t@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c |  9 ++++-----
 tools/perf/util/evsel.h |  2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index b3cfe12..fa67635 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1072,8 +1072,7 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
 	attr->mmap2 = track && !perf_missing_features.mmap2;
 	attr->comm  = track;
 	attr->ksymbol = track && !perf_missing_features.ksymbol;
-	attr->bpf_event = track && !opts->no_bpf_event &&
-		!perf_missing_features.bpf_event;
+	attr->bpf_event = track && !opts->no_bpf_event && !perf_missing_features.bpf;
 
 	if (opts->record_namespaces)
 		attr->namespaces  = track;
@@ -1803,7 +1802,7 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		evsel->core.attr.read_format &= ~(PERF_FORMAT_GROUP|PERF_FORMAT_ID);
 	if (perf_missing_features.ksymbol)
 		evsel->core.attr.ksymbol = 0;
-	if (perf_missing_features.bpf_event)
+	if (perf_missing_features.bpf)
 		evsel->core.attr.bpf_event = 0;
 retry_sample_id:
 	if (perf_missing_features.sample_id_all)
@@ -1920,8 +1919,8 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		perf_missing_features.aux_output = true;
 		pr_debug2("Kernel has no attr.aux_output support, bailing out\n");
 		goto out_close;
-	} else if (!perf_missing_features.bpf_event && evsel->core.attr.bpf_event) {
-		perf_missing_features.bpf_event = true;
+	} else if (!perf_missing_features.bpf && evsel->core.attr.bpf_event) {
+		perf_missing_features.bpf = true;
 		pr_debug2("switching off bpf_event\n");
 		goto fallback_missing_features;
 	} else if (!perf_missing_features.ksymbol && evsel->core.attr.ksymbol) {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 77e07f2..fd60cac 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -194,7 +194,7 @@ struct perf_missing_features {
 	bool write_backward;
 	bool group_read;
 	bool ksymbol;
-	bool bpf_event;
+	bool bpf;
 	bool aux_output;
 };
 
