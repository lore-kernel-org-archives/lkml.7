Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD421C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9388C23401
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566507704;
	bh=7QJeaCM/EmOzx9dCNR4OQrM6Xv9vqQ89oItlIcuFH0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DPKDl6MprHH7O8aJ63z3OKO2qEQnFPoRCtdFjB5IOBkGBOWHiKJyJaf+JDoimkeMv
	 L8KePMLurgn3jeyX0EqFW//gNO5ZfWDxxNv7c8nhhUl2UV+/Xdz31JgbYBl3bvzKve
	 XPaQFBqtST2B7PGHhWiKfVfkyOwR3QTWa9PPpc2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404810AbfHVVBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404733AbfHVVBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:01:41 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.141.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2BC5233FC;
        Thu, 22 Aug 2019 21:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566507701;
        bh=7QJeaCM/EmOzx9dCNR4OQrM6Xv9vqQ89oItlIcuFH0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kR5fjxXNg3YXt5UOg9lctX+pRohSO2iGw04X44ulf3f7ax3pAuDl6uIuNfeWPd/fP
         Bj9Jh628I6XQ4AzQm5pq3LDhuZzHB+ZfkQJu69ZKIrMvwZcCeRmyPTZf/1C13b+9aK
         BXwqVGmbGw8a8aLISck2yjC0sDizAUtDxMu+F7+k=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 07/25] perf metricgroup: Remove needless includes from metricgroup.h
Date:   Thu, 22 Aug 2019 18:00:42 -0300
Message-Id: <20190822210100.3461-8-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
References: <20190822210100.3461-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

There we need just some struct forward declarations, do that instead and
add the includes needed by metricgroup.c.

That should help with needless rebuilds when changing the removed
headers from metricgroup.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-1fkskjws6imir2hhztqhdyb0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/metricgroup.c |  3 ++-
 tools/perf/util/metricgroup.h | 13 ++++++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index fdb0d1c5c5cf..aaf55444f81b 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -7,18 +7,19 @@
 
 #include "metricgroup.h"
 #include "evlist.h"
+#include "evsel.h"
 #include "strbuf.h"
 #include "pmu.h"
 #include "expr.h"
 #include "rblist.h"
 #include <string.h>
-#include <stdbool.h>
 #include <errno.h>
 #include "pmu-events/pmu-events.h"
 #include "strlist.h"
 #include <assert.h>
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
+#include <subcmd/parse-options.h>
 
 struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 					 struct evsel *evsel,
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 500e828533f8..e5092f6404ae 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -1,11 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only
 #ifndef METRICGROUP_H
 #define METRICGROUP_H 1
 
-#include "linux/list.h"
-#include "rblist.h"
-#include <subcmd/parse-options.h>
-#include "evlist.h"
-#include "strbuf.h"
+#include <linux/list.h>
+#include <linux/rbtree.h>
+#include <stdbool.h>
+
+struct evsel;
+struct option;
+struct rblist;
 
 struct metric_event {
 	struct rb_node nd;
-- 
2.21.0

