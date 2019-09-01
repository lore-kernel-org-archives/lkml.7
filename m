Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DFEC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885E5233A2
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340719;
	bh=XPDvsZoWDHRc5VE1euBlISV0BzSxaZbETG5MJCQv7dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PqOtlhqObU0JAWtLcJBDoW870w/Wvy9+SaVVxzdj3MWFwPCyyRyapE+kAgSdjGzcc
	 DtNctJjvGVd3NYV5/Ksuj3WbZmddftyNrRKQm3F9aJboNJi8xubDp4mkyUxx7uVLOK
	 N272y3U5eXG6d5wf3DGYN5aYveXkotQO9TBFG994=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbfIAMZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:25:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729217AbfIAMZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:25:15 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D63652342C;
        Sun,  1 Sep 2019 12:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340714;
        bh=XPDvsZoWDHRc5VE1euBlISV0BzSxaZbETG5MJCQv7dU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qyA1DZOZf9xKxENy8+oljZCKqxvIdZIWKmmACygJ4O5y8Hh2EzO5D/pDIJAX+hZyF
         XhyFR8g/MF3l8B0KPVvbl5NrW/Az6p/5eahi9mmhMamcMI4yzXmptCnh++SPI+s89W
         q3otJpEH6FPzXAq2Rw34gZHBlhmqltcSr0yDTF3s=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 34/47] perf tools: Remove needless evlist.h include directives
Date:   Sun,  1 Sep 2019 09:23:13 -0300
Message-Id: <20190901122326.5793-35-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Now that evlist.h isn't included by any other header, we can check where
it is really needed, i.e. we can remove it and be sure that it isn't
being obtained indirectly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-6d7kape36m94a266md0d3xbh@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-lock.c       | 2 +-
 tools/perf/builtin-timechart.c  | 2 +-
 tools/perf/tests/hists_common.c | 1 -
 tools/perf/tests/sdt.c          | 3 ++-
 tools/perf/ui/gtk/browser.c     | 1 -
 tools/perf/util/arm-spe.c       | 3 ++-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 38500bff4423..b0ff952be9db 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -4,7 +4,7 @@
 #include "builtin.h"
 #include "perf.h"
 
-#include "util/evlist.h"
+#include "util/evlist.h" // for struct evsel_str_handler
 #include "util/evsel.h"
 #include "util/cache.h"
 #include "util/symbol.h"
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 1a74499f3311..65560a86f643 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -15,7 +15,7 @@
 #include "util/color.h"
 #include <linux/list.h>
 #include "util/cache.h"
-#include "util/evlist.h"
+#include "util/evlist.h" // for struct evsel_str_handler
 #include "util/evsel.h"
 #include <linux/kernel.h>
 #include <linux/rbtree.h>
diff --git a/tools/perf/tests/hists_common.c b/tools/perf/tests/hists_common.c
index cdde41c03056..de110d8f169b 100644
--- a/tools/perf/tests/hists_common.c
+++ b/tools/perf/tests/hists_common.c
@@ -6,7 +6,6 @@
 #include "util/symbol.h"
 #include "util/sort.h"
 #include "util/evsel.h"
-#include "util/evlist.h"
 #include "util/machine.h"
 #include "util/thread.h"
 #include "tests/hists_common.h"
diff --git a/tools/perf/tests/sdt.c b/tools/perf/tests/sdt.c
index dbc35a8912ed..cf1bd57d3023 100644
--- a/tools/perf/tests/sdt.c
+++ b/tools/perf/tests/sdt.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
+#include <limits.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <sys/epoll.h>
-#include <util/evlist.h>
 #include <util/symbol.h>
 #include <linux/filter.h>
 #include "tests.h"
diff --git a/tools/perf/ui/gtk/browser.c b/tools/perf/ui/gtk/browser.c
index 4820e25ac68d..06a6a1ebaef0 100644
--- a/tools/perf/ui/gtk/browser.c
+++ b/tools/perf/ui/gtk/browser.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "../evlist.h"
 #include "../cache.h"
 #include "../evsel.h"
 #include "../sort.h"
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 6bee59946c4f..8a7340f6a2a2 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -8,6 +8,8 @@
 #include <errno.h>
 #include <byteswap.h>
 #include <inttypes.h>
+#include <unistd.h>
+#include <stdlib.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/bitops.h>
@@ -17,7 +19,6 @@
 #include "cpumap.h"
 #include "color.h"
 #include "evsel.h"
-#include "evlist.h"
 #include "machine.h"
 #include "session.h"
 #include "debug.h"
-- 
2.21.0

