Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAC9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783FB214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfCKUYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:24:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:37489 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728270AbfCKUYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:24:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 13:24:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="306300711"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga005.jf.intel.com with ESMTP; 11 Mar 2019 13:24:48 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id BEEEA301E31; Mon, 11 Mar 2019 13:24:48 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 05/10] perf, report: Show all sort keys in help output
Date:   Mon, 11 Mar 2019 13:24:41 -0700
Message-Id: <20190311202446.10210-6-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311202446.10210-1-andi@firstfloor.org>
References: <20190311202446.10210-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Show all the supported sort keys in the command line help output,
so that it's not needed to refer to the manpage.

The output is not line wrapped, so it can be fairly long.

Before:

% perf report -h
...
     -s, --sort <key[,key2...]>
                          sort by key(s): pid, comm, dso, symbol, parent, cpu, srcline, ... Please refer the man page for the complete list.

After:

% perf report -h
...
    -s, --sort <key[,key2...]>
                          sort by key(s): overhead overhead_sys overhead_us overhead_guest_sys overhead_guest_us overhead_children sample period pid comm dso symbol parent cpu ...

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/builtin-report.c |  5 ++---
 tools/perf/util/sort.c      | 41 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/sort.h      |  2 ++
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 05c8dd41106c..03eb8f4a6c13 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1083,10 +1083,9 @@ int cmd_report(int argc, const char **argv)
 	OPT_BOOLEAN(0, "header-only", &report.header_only,
 		    "Show only data header."),
 	OPT_STRING('s', "sort", &sort_order, "key[,key2...]",
-		   "sort by key(s): pid, comm, dso, symbol, parent, cpu, srcline, ..."
-		   " Please refer the man page for the complete list."),
+		   sort_help("sort by key(s):")),
 	OPT_STRING('F', "fields", &field_order, "key[,keys...]",
-		   "output field(s): overhead, period, sample plus all of sort keys"),
+		   sort_help("output field(s): overhead, period, sample, ")),
 	OPT_BOOLEAN(0, "show-cpu-utilization", &symbol_conf.show_cpu_utilization,
 		    "Show sample percentage for different cpu modes"),
 	OPT_BOOLEAN_FLAG(0, "showcpuutilization", &symbol_conf.show_cpu_utilization,
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index d2299e912e59..4e1531c6cdb9 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -12,6 +12,7 @@
 #include "evsel.h"
 #include "evlist.h"
 #include "strlist.h"
+#include "strbuf.h"
 #include <traceevent/event-parse.h>
 #include "mem-events.h"
 #include "annotate.h"
@@ -3068,3 +3069,43 @@ void reset_output_field(void)
 	reset_dimensions();
 	perf_hpp__reset_output_field(&perf_hpp_list);
 }
+
+static void add_sort_string(struct strbuf *sb, struct sort_dimension *s, int n)
+{
+	int i;
+
+	for (i = 0; i < n; i++) {
+		strbuf_addch(sb, ' ');
+		strbuf_addstr(sb, s[i].name);
+	}
+}
+
+static void add_hpp_sort_string(struct strbuf *sb, struct hpp_dimension *s, int n)
+{
+	int i;
+
+	for (i = 0; i < n; i++) {
+		strbuf_addch(sb, ' ');
+		strbuf_addstr(sb, s[i].name);
+	}
+}
+
+const char *sort_help(const char *prefix)
+{
+	struct strbuf sb;
+	char *s;
+
+	strbuf_init(&sb, 300);
+	strbuf_addstr(&sb, prefix);
+	add_hpp_sort_string(&sb, hpp_sort_dimensions,
+			    ARRAY_SIZE(hpp_sort_dimensions));
+	add_sort_string(&sb, common_sort_dimensions,
+			    ARRAY_SIZE(common_sort_dimensions));
+	add_sort_string(&sb, bstack_sort_dimensions,
+			    ARRAY_SIZE(bstack_sort_dimensions));
+	add_sort_string(&sb, memory_sort_dimensions,
+			    ARRAY_SIZE(memory_sort_dimensions));
+	s = strbuf_detach(&sb, NULL);
+	strbuf_release(&sb);
+	return s;
+}
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 2fbee0b1011c..93d1b25da341 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -286,6 +286,8 @@ void reset_output_field(void);
 void sort__setup_elide(FILE *fp);
 void perf_hpp__set_elide(int idx, bool elide);
 
+const char *sort_help(const char *prefix);
+
 int report_parse_ignore_callees_opt(const struct option *opt, const char *arg, int unset);
 
 bool is_strict_order(const char *order);
-- 
2.20.1

