Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C1FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2866B208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732429AbfCZWSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 18:18:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:55268 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730333AbfCZWS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 18:18:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 15:18:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,274,1549958400"; 
   d="scan'208";a="145482961"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga002.jf.intel.com with ESMTP; 26 Mar 2019 15:18:28 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id C2969301BD4; Tue, 26 Mar 2019 15:18:28 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 4/4] perf, tools, list: Output tool events
Date:   Tue, 26 Mar 2019 15:18:23 -0700
Message-Id: <20190326221823.11518-5-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190326221823.11518-1-andi@firstfloor.org>
References: <20190326221823.11518-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add support to perf list to output tool internal events, currently
only duration_time.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/builtin-list.c      |  6 ++++--
 tools/perf/util/parse-events.c | 20 ++++++++++++++++++++
 tools/perf/util/parse-events.h |  1 +
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index a8394b4f1167..e0312a1c4792 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -70,10 +70,11 @@ int cmd_list(int argc, const char **argv)
 			print_symbol_events(NULL, PERF_TYPE_HARDWARE,
 					event_symbols_hw, PERF_COUNT_HW_MAX, raw_dump);
 		else if (strcmp(argv[i], "sw") == 0 ||
-			 strcmp(argv[i], "software") == 0)
+			 strcmp(argv[i], "software") == 0) {
 			print_symbol_events(NULL, PERF_TYPE_SOFTWARE,
 					event_symbols_sw, PERF_COUNT_SW_MAX, raw_dump);
-		else if (strcmp(argv[i], "cache") == 0 ||
+			print_tool_events(NULL, raw_dump);
+		} else if (strcmp(argv[i], "cache") == 0 ||
 			 strcmp(argv[i], "hwcache") == 0)
 			print_hwcache_events(NULL, raw_dump);
 		else if (strcmp(argv[i], "pmu") == 0)
@@ -113,6 +114,7 @@ int cmd_list(int argc, const char **argv)
 					    event_symbols_hw, PERF_COUNT_HW_MAX, raw_dump);
 			print_symbol_events(s, PERF_TYPE_SOFTWARE,
 					    event_symbols_sw, PERF_COUNT_SW_MAX, raw_dump);
+			print_tool_events(s, raw_dump);
 			print_hwcache_events(s, raw_dump);
 			print_pmu_events(s, raw_dump, !desc_flag,
 						long_desc_flag,
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 98c0fadaedb9..4432bfe039fd 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2457,6 +2457,25 @@ int print_hwcache_events(const char *event_glob, bool name_only)
 	return evt_num;
 }
 
+static void print_tool_event(const char *name, const char *event_glob,
+			     bool name_only)
+{
+	if (event_glob && !strglobmatch(name, event_glob))
+		return;
+	if (name_only)
+		printf("%s ", name);
+	else
+		printf("  %-50s [%s]\n", name, "Tool event");
+
+}
+
+void print_tool_events(const char *event_glob, bool name_only)
+{
+	print_tool_event("duration_time", event_glob, name_only);
+	if (pager_in_use())
+		printf("\n");
+}
+
 void print_symbol_events(const char *event_glob, unsigned type,
 				struct event_symbol *syms, unsigned max,
 				bool name_only)
@@ -2540,6 +2559,7 @@ void print_events(const char *event_glob, bool name_only, bool quiet_flag,
 
 	print_symbol_events(event_glob, PERF_TYPE_SOFTWARE,
 			    event_symbols_sw, PERF_COUNT_SW_MAX, name_only);
+	print_tool_events(event_glob, name_only);
 
 	print_hwcache_events(event_glob, name_only);
 
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 0c1f5b98f636..a052cd6ac63e 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -204,6 +204,7 @@ extern struct event_symbol event_symbols_sw[];
 void print_symbol_events(const char *event_glob, unsigned type,
 				struct event_symbol *syms, unsigned max,
 				bool name_only);
+void print_tool_events(const char *event_glob, bool name_only);
 void print_tracepoint_events(const char *subsys_glob, const char *event_glob,
 			     bool name_only);
 int print_hwcache_events(const char *event_glob, bool name_only);
-- 
2.20.1

