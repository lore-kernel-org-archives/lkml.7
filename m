Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40314C3A59E
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134962133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565986652;
	bh=hbUrAOWCSWMAqzBpCQ54Wgy77hUQBs4MZrfz2d4Q/mQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SNFcu0kCSCuemqBGUliIzQMzA4ZSsx4BL/SwjAUGuNGUw/sQLIvrdMa6+5bjPFSVS
	 yWfabzgylSgxm3IIYpCvBlg7JGVBojNrlGx+kgvDbPK75YX+mTNY2AWO/decRytgIN
	 8K1NxIh3qIS9wJF+AjRr3USFBxSxdyKgOzfgJLGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfHPURb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:17:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbfHPUR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:17:29 -0400
Received: from quaco.ghostprotocols.net (unknown [179.182.221.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4969721721;
        Fri, 16 Aug 2019 20:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565986648;
        bh=hbUrAOWCSWMAqzBpCQ54Wgy77hUQBs4MZrfz2d4Q/mQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OLGfgv7lsnz0jyN4/Cw7ggCeE7UizQYuEuRbb5Tj4k4pkPygbduKzj9y8jD2cAnfP
         IRQMvCm7ox7fpaeqBTxc1en+/G2Bx4+tjSqLG5GN6BTddSEDz1Azo29WxZgQKrqjwi
         vJsOFHtxc4AyNJ/rF/AOfMLVDaKwGGx8ZNXTPybA=
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
Subject: [PATCH 05/17] perf evswitch: Move struct to a separate header to use in other tools
Date:   Fri, 16 Aug 2019 17:16:41 -0300
Message-Id: <20190816201653.19332-6-acme@kernel.org>
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
 create mode 100644 tools/perf/util/evswitch.h

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
-- 
2.21.0

