Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADE0C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B80E2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="kJv1i14Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfHPUwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:52:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50289 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfHPUwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:52:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7GKqB1F2959374
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 16 Aug 2019 13:52:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7GKqB1F2959374
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565988731;
        bh=YMDAjOVDCZnheX4/ASdyjXBr7yxeB2UjYds+e/O6/uA=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=kJv1i14Ztb+6izS1l+YtYxNnuwARBDd3C2JwvaG4n0c8GENbnQYD5h4PH1/s9XJFa
         pa+rLBTD5QPiZXN8IaG6zW5OLe7esH9Ti53Bhvm12dzFo7NBDY0gAOSmDgt6V9SdGv
         jeFb2FyPDYKHQm4V9aZd+vTMyu/iUixnnDHFrlE2zNqQVx0xumxhqIvQ5JTBT3MeIU
         1GgPL0fzAdkL+im+vqkQWEXXAriDxAFtYqsELty4b0HPgZdfB96GIxYBtmRrF8Oi0d
         T+w/HXY69YNdnCQNcUZdM+P29fqtv+rJePMptHXpBFd1CVdGfbXJ4diboAlndS86DQ
         KgLLxqzAvZhVg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7GKqAAE2959371;
        Fri, 16 Aug 2019 13:52:10 -0700
Date:   Fri, 16 Aug 2019 13:52:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-z0cyi9ifzlr37cedr9xztc1k@git.kernel.org>
Cc:     fweimer@redhat.com, adrian.hunter@intel.com, tglx@linutronix.de,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com,
        hpa@zytor.com, jolsa@kernel.org, wcohen@redhat.com,
        mingo@kernel.org
Reply-To: wcohen@redhat.com, jolsa@kernel.org, mingo@kernel.org,
          tglx@linutronix.de, adrian.hunter@intel.com, fweimer@redhat.com,
          acme@redhat.com, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evswitch: Move struct to a separate header to
 use in other tools
Git-Commit-ID: d2360442725fd29b3189887476c57059854a398c
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

Commit-ID:  d2360442725fd29b3189887476c57059854a398c
Gitweb:     https://git.kernel.org/tip/d2360442725fd29b3189887476c57059854a398c
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 15 Aug 2019 10:37:24 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 15 Aug 2019 12:24:24 -0300

perf evswitch: Move struct to a separate header to use in other tools

Now that we see that the simple userspace-based "slicing" of events
using delimiter events ("markers") works, lets move it to a separate
header to make it available to other tools, next step will be having
the switch on/off check done at the PERF_RECORD_SAMPLE processing
function moved too.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: William Cohen <wcohen@redhat.com>
Link: https://lkml.kernel.org/n/tip-z0cyi9ifzlr37cedr9xztc1k@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c |  8 +-------
 tools/perf/util/evswitch.h  | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b6eed0f7e835..fff02e0d70c4 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -16,6 +16,7 @@
 #include "util/trace-event.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
+#include "util/evswitch.h"
 #include "util/sort.h"
 #include "util/data.h"
 #include "util/auxtrace.h"
@@ -1616,13 +1617,6 @@ static int perf_sample__fprintf_synth(struct perf_sample *sample,
 	return 0;
 }
 
-struct evswitch {
-	struct evsel *on,
-		     *off;
-	bool	     discarding;
-	bool	     show_on_off_events;
-};
-
 struct perf_script {
 	struct perf_tool	tool;
 	struct perf_session	*session;
diff --git a/tools/perf/util/evswitch.h b/tools/perf/util/evswitch.h
new file mode 100644
index 000000000000..bb88e8002f39
--- /dev/null
+++ b/tools/perf/util/evswitch.h
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2019, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+#ifndef __PERF_EVSWITCH_H
+#define __PERF_EVSWITCH_H 1
+
+#include <stdbool.h>
+
+struct evsel;
+
+struct evswitch {
+	struct evsel *on, *off;
+	bool	     discarding;
+	bool	     show_on_off_events;
+};
+
+#endif /* __PERF_EVSWITCH_H */
