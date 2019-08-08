Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CB4C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174AF21874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565290512;
	bh=fLI/03zmeLHBX1yu5wAffNFPk9vIvmHgwoYZ3BJdamI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1b8kh7n6+O0DMh3roghakZK0eXCyEyvCFSHhPmQCPeIhh/AvTAvkWsr5VbUYE+VcI
	 +YgilFADZlpAcX9orn9KGNU66QqYoec0WL2v15EHRJ7pu+s6mxERGd0LtSIq8Tj2Zy
	 Q+zjjAp5/VH+ofan95gUSXFzi4W5gEBNlRbzOaoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390357AbfHHSzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 14:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390348AbfHHSzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:55:10 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.210.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E895C2184E;
        Thu,  8 Aug 2019 18:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565290510;
        bh=fLI/03zmeLHBX1yu5wAffNFPk9vIvmHgwoYZ3BJdamI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IWalcp/pyGNyXwqwDxfsbSEgxebz3D5izzHczHMbF6Hqzvra2Go2HS4QpVNlb5PzI
         +gWCZPo7copnZPjbAc2Ps201fO3HZxFugEX0BO/Mm3SjjlHogxbyvAIYrdrzC+rjbA
         JxjvwyWA61j9vbblWKRnVq0pQqRoT/t6vmP1oeYg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/10] perf tools: Fix include paths in ui directory
Date:   Thu,  8 Aug 2019 15:53:55 -0300
Message-Id: <20190808185358.20125-8-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190808185358.20125-1-acme@kernel.org>
References: <20190808185358.20125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Rogers <irogers@google.com>

These paths point to the wrong location but still work because they get
picked up by a -I flag that happens to direct to the correct file. Fix
paths to point to the correct location without -I flags.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190731225441.233800-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browser.c      | 9 +++++----
 tools/perf/ui/tui/progress.c | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index f80c51d53565..d227d74b28f8 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "../string2.h"
-#include "../config.h"
-#include "../../perf.h"
+#include "../util/util.h"
+#include "../util/string2.h"
+#include "../util/config.h"
+#include "../perf.h"
 #include "libslang.h"
 #include "ui.h"
 #include "util.h"
@@ -14,7 +15,7 @@
 #include "browser.h"
 #include "helpline.h"
 #include "keysyms.h"
-#include "../color.h"
+#include "../util/color.h"
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
 
diff --git a/tools/perf/ui/tui/progress.c b/tools/perf/ui/tui/progress.c
index bc134b82829d..5a24dd3ce4db 100644
--- a/tools/perf/ui/tui/progress.c
+++ b/tools/perf/ui/tui/progress.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
-#include "../cache.h"
+#include "../../util/cache.h"
 #include "../progress.h"
 #include "../libslang.h"
 #include "../ui.h"
-- 
2.21.0

