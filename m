Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EBDC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02772171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565986670;
	bh=x35rw798X9aCk49J9BJ85ro6jk2npMgN2E9hWrLYgOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mKe6SMu+TtU6ECsS2JC+SxnHaVK9kzEknKDWrBvsPDnsRX0JqTD30GSkwbm0oNNO5
	 YXdehhUh0f3t3+k6db8huEFR4/rHqBVIiDx6exP6UQy1tV+hY5Y16v4NMNoPL24xzt
	 IcTLIzmpONHTDMLIwam5JnQ4lUnI1mQVE3Pma9ks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfHPURs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:17:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727600AbfHPURq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:17:46 -0400
Received: from quaco.ghostprotocols.net (unknown [179.182.221.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21B672173B;
        Fri, 16 Aug 2019 20:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565986666;
        bh=x35rw798X9aCk49J9BJ85ro6jk2npMgN2E9hWrLYgOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r6mDycDkVNYY6SL03WEMhQrbaNMCcIayO7/0fcO96r58VI7HuIxKg8wPWMiENoYyY
         EBbkG8QnnnAk9ZuLgUv6x7jAV9zx3gsgOIwfw5Vlep6RBX8HITQMYbxtk7EskDz61x
         SXRKXLNIsHq/srqDmRFuTjwJnCbOoAlBbGyoF9Dg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        William Cohen <wcohen@redhat.com>
Subject: [PATCH 09/17] perf evswitch: Introduce init() method to set the on/off evsels from the command line
Date:   Fri, 16 Aug 2019 17:16:45 -0300
Message-Id: <20190816201653.19332-10-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816201653.19332-1-acme@kernel.org>
References: <20190816201653.19332-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.21.0

