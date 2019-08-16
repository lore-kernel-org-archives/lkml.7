Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D2BC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD5321721
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565986657;
	bh=Gf+qVUJh0pK5diuoBL7FbN84hO14oLTboFYm6nV3rrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AD0H8Y/4Ux743zAZueH8SnQXr5Jr6GJCYmlotilrpNkPkc5FNyc/UlYIW173qcelh
	 fNijz5e/NSKua2CDnyqvERi3NaeTAi3ZtSlBIvPZup5fbPBgO5MLeRuP7IncrLhHTd
	 0KY2Qg0g7kaqiDCrpv+z8f2YvKm1pUH4/UvhAtpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfHPURg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:17:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbfHPURe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:17:34 -0400
Received: from quaco.ghostprotocols.net (unknown [179.182.221.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA8462173B;
        Fri, 16 Aug 2019 20:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565986653;
        bh=Gf+qVUJh0pK5diuoBL7FbN84hO14oLTboFYm6nV3rrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fFW+ZO80tAf3zURenrImbjBGpHnWEwWTv4WTTfBYamUg3zX4NJyCgYLk2mIIy6hjO
         MmRbfL1INLl9C83pEwosDWurPNuU2kJiijOoJ7ZLE99tUxPea07qEezzpeH3UGX6Xs
         4dAC5xz6qjn0Aszqx1W2MyVC6OjkXZBU7dcCXlTw=
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
Subject: [PATCH 06/17] perf evswitch: Move switch logic to use in other tools
Date:   Fri, 16 Aug 2019 17:16:42 -0300
Message-Id: <20190816201653.19332-7-acme@kernel.org>
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
 create mode 100644 tools/perf/util/evswitch.c

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
-- 
2.21.0

