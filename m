Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C155FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897A420883
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfCVWVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:21:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57839 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCVWVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:21:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMKwWN750286
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:20:58 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMKwkp750283;
        Fri, 22 Mar 2019 15:20:58 -0700
Date:   Fri, 22 Mar 2019 15:20:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-9r3uz2ch4izoi1uln3f889co@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, ak@linux.intel.com, jolsa@kernel.org,
        acme@redhat.com, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de
Reply-To: ak@linux.intel.com, linux-kernel@vger.kernel.org,
          acme@redhat.com, jolsa@kernel.org, tglx@linutronix.de,
          hpa@zytor.com, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf report: Show all sort keys in help output
Git-Commit-ID: 702fb9b415e7c99bd671fc0d1da26574c125471a
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

Commit-ID:  702fb9b415e7c99bd671fc0d1da26574c125471a
Gitweb:     https://git.kernel.org/tip/702fb9b415e7c99bd671fc0d1da26574c125471a
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Thu, 14 Mar 2019 15:49:57 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 16:15:42 -0300

perf report: Show all sort keys in help output

Show all the supported sort keys in the command line help output, so
that it's not needed to refer to the manpage.

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
Acked-by: Jiri Olsa <jolsa@kernel.org>
LPU-Reference: 20190314225002.30108-5-andi@firstfloor.org
Link: https://lkml.kernel.org/n/tip-9r3uz2ch4izoi1uln3f889co@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c |  5 ++---
 tools/perf/util/sort.c      | 52 +++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/sort.h      |  2 ++
 3 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 1921aaa9cece..4054eb1f98ac 100644
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
+		   sort_help("output field(s): overhead period sample ")),
 	OPT_BOOLEAN(0, "show-cpu-utilization", &symbol_conf.show_cpu_utilization,
 		    "Show sample percentage for different cpu modes"),
 	OPT_BOOLEAN_FLAG(0, "showcpuutilization", &symbol_conf.show_cpu_utilization,
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index bdd30cab51cb..5d2518e89fc4 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -13,6 +13,7 @@
 #include "evsel.h"
 #include "evlist.h"
 #include "strlist.h"
+#include "strbuf.h"
 #include <traceevent/event-parse.h>
 #include "mem-events.h"
 #include "annotate.h"
@@ -3107,3 +3108,54 @@ void reset_output_field(void)
 	reset_dimensions();
 	perf_hpp__reset_output_field(&perf_hpp_list);
 }
+
+#define INDENT (3*8 + 1)
+
+static void add_key(struct strbuf *sb, const char *str, int *llen)
+{
+	if (*llen >= 75) {
+		strbuf_addstr(sb, "\n\t\t\t ");
+		*llen = INDENT;
+	}
+	strbuf_addf(sb, " %s", str);
+	*llen += strlen(str) + 1;
+}
+
+static void add_sort_string(struct strbuf *sb, struct sort_dimension *s, int n,
+			    int *llen)
+{
+	int i;
+
+	for (i = 0; i < n; i++)
+		add_key(sb, s[i].name, llen);
+}
+
+static void add_hpp_sort_string(struct strbuf *sb, struct hpp_dimension *s, int n,
+				int *llen)
+{
+	int i;
+
+	for (i = 0; i < n; i++)
+		add_key(sb, s[i].name, llen);
+}
+
+const char *sort_help(const char *prefix)
+{
+	struct strbuf sb;
+	char *s;
+	int len = strlen(prefix) + INDENT;
+
+	strbuf_init(&sb, 300);
+	strbuf_addstr(&sb, prefix);
+	add_hpp_sort_string(&sb, hpp_sort_dimensions,
+			    ARRAY_SIZE(hpp_sort_dimensions), &len);
+	add_sort_string(&sb, common_sort_dimensions,
+			    ARRAY_SIZE(common_sort_dimensions), &len);
+	add_sort_string(&sb, bstack_sort_dimensions,
+			    ARRAY_SIZE(bstack_sort_dimensions), &len);
+	add_sort_string(&sb, memory_sort_dimensions,
+			    ARRAY_SIZE(memory_sort_dimensions), &len);
+	s = strbuf_detach(&sb, NULL);
+	strbuf_release(&sb);
+	return s;
+}
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index bb9442ab7a0c..ce376a73f964 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -296,6 +296,8 @@ void reset_output_field(void);
 void sort__setup_elide(FILE *fp);
 void perf_hpp__set_elide(int idx, bool elide);
 
+const char *sort_help(const char *prefix);
+
 int report_parse_ignore_callees_opt(const struct option *opt, const char *arg, int unset);
 
 bool is_strict_order(const char *order);
