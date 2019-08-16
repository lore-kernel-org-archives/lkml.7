Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18972C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40A22171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="X9owe4xI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfHPUzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:55:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36389 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfHPUzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:55:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7GKt8Q12959913
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 16 Aug 2019 13:55:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7GKt8Q12959913
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565988909;
        bh=LfYD5zaS3ODktyjaaDE2Nl3p3Xk1EhtrZebiMKbtUYc=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=X9owe4xIEkBs2r6OQEfG29FrLJ+v7Yhk/VlO1VTY+rYSfK/oZhjvRRgHDYPgG9Y+q
         sdScgqeoQO3YTu0/xXRWVF9GgPyW0LAQdedDV0WtyiqIRdeEcCIxEJu3T01PRLvWCu
         VloduyL2/27IcvLljlV5GZV1u19RQehTLh0+a7p/P72/h+BZy1y2kp0j7IGDNrKUpB
         uKNZhHQiBSh9dwn/FJ1LQZwxCjgPVUobFqxOLr4n3kT99OlftWz4XtnLFPWsEYzcGU
         XteqQCTlF3Oc7t3c/IDpTqlceP6+9aqk+2VHdwKTitnSSEDzGKJPrwPKwNo2DpMZ/6
         VIwAs1O4v0HoQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7GKt8Ot2959910;
        Fri, 16 Aug 2019 13:55:08 -0700
Date:   Fri, 16 Aug 2019 13:55:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-snreb1wmwyjei3eefwotxp1l@git.kernel.org>
Cc:     hpa@zytor.com, wcohen@redhat.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, mingo@kernel.org,
        tglx@linutronix.de, namhyung@kernel.org, acme@redhat.com,
        fweimer@redhat.com
Reply-To: wcohen@redhat.com, hpa@zytor.com, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          fweimer@redhat.com, namhyung@kernel.org, acme@redhat.com,
          tglx@linutronix.de, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evswitch: Introduce init() method to set the
 on/off evsels from the command line
Git-Commit-ID: 124e02be72fdff05ab5d7f004a3c0d4061569380
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

Commit-ID:  124e02be72fdff05ab5d7f004a3c0d4061569380
Gitweb:     https://git.kernel.org/tip/124e02be72fdff05ab5d7f004a3c0d4061569380
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 15 Aug 2019 11:31:29 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 15 Aug 2019 12:25:55 -0300

perf evswitch: Introduce init() method to set the on/off evsels from the command line

Another step in having all the boilerplate in just one place to then use
in the other tools.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: William Cohen <wcohen@redhat.com>
Link: https://lkml.kernel.org/n/tip-snreb1wmwyjei3eefwotxp1l@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 21 +++------------------
 tools/perf/util/evswitch.c  | 23 +++++++++++++++++++++++
 tools/perf/util/evswitch.h  |  4 ++++
 3 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 2a5b8af80e6b..1764efd16cd4 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3868,24 +3868,9 @@ int cmd_script(int argc, const char **argv)
 						  script.range_num);
 	}
 
-	if (script.evswitch.on_name) {
-		script.evswitch.on = perf_evlist__find_evsel_by_str(session->evlist, script.evswitch.on_name);
-		if (script.evswitch.on == NULL) {
-			fprintf(stderr, "switch-on event not found (%s)\n", script.evswitch.on_name);
-			err = -ENOENT;
-			goto out_delete;
-		}
-		script.evswitch.discarding = true;
-	}
-
-	if (script.evswitch.off_name) {
-		script.evswitch.off = perf_evlist__find_evsel_by_str(session->evlist, script.evswitch.off_name);
-		if (script.evswitch.off == NULL) {
-			fprintf(stderr, "switch-off event not found (%s)\n", script.evswitch.off_name);
-			err = -ENOENT;
-			goto out_delete;
-		}
-	}
+	err = evswitch__init(&script.evswitch, session->evlist, stderr);
+	if (err)
+		goto out_delete;
 
 	err = __cmd_script(&script);
 
diff --git a/tools/perf/util/evswitch.c b/tools/perf/util/evswitch.c
index c87f988d81c8..b57b5f0816f5 100644
--- a/tools/perf/util/evswitch.c
+++ b/tools/perf/util/evswitch.c
@@ -2,6 +2,7 @@
 // Copyright (C) 2019, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
 
 #include "evswitch.h"
+#include "evlist.h"
 
 bool evswitch__discard(struct evswitch *evswitch, struct evsel *evsel)
 {
@@ -29,3 +30,25 @@ bool evswitch__discard(struct evswitch *evswitch, struct evsel *evsel)
 
 	return false;
 }
+
+int evswitch__init(struct evswitch *evswitch, struct evlist *evlist, FILE *fp)
+{
+	if (evswitch->on_name) {
+		evswitch->on = perf_evlist__find_evsel_by_str(evlist, evswitch->on_name);
+		if (evswitch->on == NULL) {
+			fprintf(fp, "switch-on event not found (%s)\n", evswitch->on_name);
+			return -ENOENT;
+		}
+		evswitch->discarding = true;
+	}
+
+	if (evswitch->off_name) {
+		evswitch->off = perf_evlist__find_evsel_by_str(evlist, evswitch->off_name);
+		if (evswitch->off == NULL) {
+			fprintf(fp, "switch-off event not found (%s)\n", evswitch->off_name);
+			return -ENOENT;
+		}
+	}
+
+	return 0;
+}
diff --git a/tools/perf/util/evswitch.h b/tools/perf/util/evswitch.h
index 94220d1bb479..fd30460b6218 100644
--- a/tools/perf/util/evswitch.h
+++ b/tools/perf/util/evswitch.h
@@ -4,8 +4,10 @@
 #define __PERF_EVSWITCH_H 1
 
 #include <stdbool.h>
+#include <stdio.h>
 
 struct evsel;
+struct evlist;
 
 struct evswitch {
 	struct evsel *on, *off;
@@ -14,6 +16,8 @@ struct evswitch {
 	bool	     show_on_off_events;
 };
 
+int evswitch__init(struct evswitch *evswitch, struct evlist *evlist, FILE *fp);
+
 bool evswitch__discard(struct evswitch *evswitch, struct evsel *evsel);
 
 #define OPTS_EVSWITCH(evswitch)								  \
