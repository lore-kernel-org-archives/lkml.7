Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB299C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA242133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="2fJfREAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfHPUxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:53:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49937 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbfHPUxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:53:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7GKquRa2959426
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 16 Aug 2019 13:52:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7GKquRa2959426
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565988777;
        bh=sW8eudC7pHANvKsJFlKDAPmnf5UlEA6mqyyf1haZ/UQ=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=2fJfREAzy0z+0OvfiTaFmVXW2MTIMVQo3PGn5ywj/WaqKKudKJ1B1SiVGIbBcgnNB
         5Q/6e7GcwqPHz6nHfI6mJne8oh9MYSFMOJaNSI0eWqMVWCS6b0QhVeRzLSe2vkSjvd
         Pm36iLn+DFRaipQskYuPtXHXS1PYFcEdjknUiuHg46lwszKMdpWuSq7XB1/4xPT1Ng
         JCJwx78mlvw7lnN2fOwoYaEqZd/Kj0RGxo8b5och1jew+0xh59KiaW5VgP75ur3yUv
         mXWGGEprqNiOyuzI/JKK4a31ZQVDBtIOIDzFjj0EqtIoXkb4Hpiz3DJJWuVM4cT3OV
         YRGmAlEnOE82g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7GKquFQ2959423;
        Fri, 16 Aug 2019 13:52:56 -0700
Date:   Fri, 16 Aug 2019 13:52:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-b1trj1q97qwfv251l66q3noj@git.kernel.org>
Cc:     adrian.hunter@intel.com, wcohen@redhat.com, fweimer@redhat.com,
        jolsa@kernel.org, tglx@linutronix.de, namhyung@kernel.org,
        mingo@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com
Reply-To: namhyung@kernel.org, mingo@kernel.org, acme@redhat.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          jolsa@kernel.org, adrian.hunter@intel.com, wcohen@redhat.com,
          fweimer@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evswitch: Move switch logic to use in other
 tools
Git-Commit-ID: 8829e56fa050998164e496d380cd69186ae9b8d0
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

Commit-ID:  8829e56fa050998164e496d380cd69186ae9b8d0
Gitweb:     https://git.kernel.org/tip/8829e56fa050998164e496d380cd69186ae9b8d0
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 15 Aug 2019 11:00:11 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 15 Aug 2019 12:24:31 -0300

perf evswitch: Move switch logic to use in other tools

Now other tools that want switching can use an evswitch for that, just
set it up and add it to the PERF_RECORD_SAMPLE processing function.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: William Cohen <wcohen@redhat.com>
Link: https://lkml.kernel.org/n/tip-b1trj1q97qwfv251l66q3noj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 23 ++---------------------
 tools/perf/util/Build       |  1 +
 tools/perf/util/evswitch.c  | 31 +++++++++++++++++++++++++++++++
 tools/perf/util/evswitch.h  |  2 ++
 4 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index fff02e0d70c4..e7b950e977a9 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1807,28 +1807,9 @@ static void process_event(struct perf_script *script,
 	if (!show_event(sample, evsel, thread, al))
 		return;
 
-	if (script->evswitch.on && script->evswitch.discarding) {
-		if (script->evswitch.on != evsel)
-			return;
-
-		script->evswitch.discarding = false;
-
-		if (!script->evswitch.show_on_off_events)
-			return;
-
-		goto print_it;
-	}
-
-	if (script->evswitch.off && !script->evswitch.discarding) {
-		if (script->evswitch.off != evsel)
-			goto print_it;
-
-		script->evswitch.discarding = true;
+	if (evswitch__discard(&script->evswitch, evsel))
+		return;
 
-		if (!script->evswitch.show_on_off_events)
-			return;
-	}
-print_it:
 	++es->samples;
 
 	perf_sample__fprintf_start(sample, thread, evsel,
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 7cda749059a9..b922c8c297ca 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -9,6 +9,7 @@ perf-y += event.o
 perf-y += evlist.o
 perf-y += evsel.o
 perf-y += evsel_fprintf.o
+perf-y += evswitch.o
 perf-y += find_bit.o
 perf-y += get_current_dir_name.o
 perf-y += kallsyms.o
diff --git a/tools/perf/util/evswitch.c b/tools/perf/util/evswitch.c
new file mode 100644
index 000000000000..c87f988d81c8
--- /dev/null
+++ b/tools/perf/util/evswitch.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2019, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+
+#include "evswitch.h"
+
+bool evswitch__discard(struct evswitch *evswitch, struct evsel *evsel)
+{
+	if (evswitch->on && evswitch->discarding) {
+		if (evswitch->on != evsel)
+			return true;
+
+		evswitch->discarding = false;
+
+		if (!evswitch->show_on_off_events)
+			return true;
+
+		return false;
+	}
+
+	if (evswitch->off && !evswitch->discarding) {
+		if (evswitch->off != evsel)
+			return false;
+
+		evswitch->discarding = true;
+
+		if (!evswitch->show_on_off_events)
+			return true;
+	}
+
+	return false;
+}
diff --git a/tools/perf/util/evswitch.h b/tools/perf/util/evswitch.h
index bb88e8002f39..bae3a22ad719 100644
--- a/tools/perf/util/evswitch.h
+++ b/tools/perf/util/evswitch.h
@@ -13,4 +13,6 @@ struct evswitch {
 	bool	     show_on_off_events;
 };
 
+bool evswitch__discard(struct evswitch *evswitch, struct evsel *evsel);
+
 #endif /* __PERF_EVSWITCH_H */
