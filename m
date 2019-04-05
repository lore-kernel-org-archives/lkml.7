Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB911C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACDE2186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbfDELkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:40:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38529 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730596AbfDELkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:40:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35BecYW2734849
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 04:40:38 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35BecDf2734846;
        Fri, 5 Apr 2019 04:40:38 -0700
Date:   Fri, 5 Apr 2019 04:40:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-5e0861baa3fa73e8bd861a4b7ba7fa992b1dff82@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com,
        jolsa@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        ak@linux.intel.com
Reply-To: hpa@zytor.com, tglx@linutronix.de, ak@linux.intel.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com,
          jolsa@kernel.org
In-Reply-To: <20190326221823.11518-5-andi@firstfloor.org>
References: <20190326221823.11518-5-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf list: Output tool events
Git-Commit-ID: 5e0861baa3fa73e8bd861a4b7ba7fa992b1dff82
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

Commit-ID:  5e0861baa3fa73e8bd861a4b7ba7fa992b1dff82
Gitweb:     https://git.kernel.org/tip/5e0861baa3fa73e8bd861a4b7ba7fa992b1dff82
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Tue, 26 Mar 2019 15:18:23 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Apr 2019 14:49:25 -0300

perf list: Output tool events

Add support in 'perf list' to output tool internal events, currently
only 'duration_time'.

Committer testing:

  $ perf list dur*

  List of pre-defined events (to be used in -e):

    duration_time                                      [Tool event]

  Metric Groups:

  $ perf list sw

  List of pre-defined events (to be used in -e):

    alignment-faults                                   [Software event]
    bpf-output                                         [Software event]
    context-switches OR cs                             [Software event]
    cpu-clock                                          [Software event]
    cpu-migrations OR migrations                       [Software event]
    dummy                                              [Software event]
    emulation-faults                                   [Software event]
    major-faults                                       [Software event]
    minor-faults                                       [Software event]
    page-faults OR faults                              [Software event]
    task-clock                                         [Software event]

    duration_time                                      [Tool event]

  $ perf list | grep duration
    duration_time                                      [Tool event]
         [L1D miss outstandings duration in cycles]
          page walk duration are excluded in Skylake]
          load. EPT page walk duration are excluded in Skylake]
          page walk duration are excluded in Skylake]
          store. EPT page walk duration are excluded in Skylake]
          (instruction fetch) request. EPT page walk duration are excluded in
          instruction fetch request. EPT page walk duration are excluded in
  $

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190326221823.11518-5-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
@@ -2457,6 +2457,25 @@ out_enomem:
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
