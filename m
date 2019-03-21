Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6899C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77AA521925
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553194375;
	bh=UVhLthFo0WZ93+exjAB4OXx8opxUNzOwv6TlenWkKQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IA4poDYLBCudxqPxXNho6ErlXjggz2nQj/paMH/GN4PsEHqpUROsSRoQVNh/9oyOC
	 fLaMMXLE3J211up1n9AS45fyGGEJK5EldblyPXD2b/pOgs6wQsOyV9Ryqpg2FtoYk2
	 1ntYjs2rUfFgvZvAAHpf5D7ZeYB3RewM/uW7FMXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbfCUSwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:52:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbfCUSwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:52:09 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B2EB21916;
        Thu, 21 Mar 2019 18:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553194328;
        bh=UVhLthFo0WZ93+exjAB4OXx8opxUNzOwv6TlenWkKQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NLDxSUG3q+V1Xr3gm2ixuGzBjQqV3lWP8VioMkyJ1hSMZMComRwW1eCp9H9g2WG30
         gDFP1xuTMwPLjbzlM8F88NHxO6ekM13OpdHNDEEUg3n14tjo5KWzH5FNSrE/k+nn2/
         wlZUHIuyfq0eFYiUOLR2y+jdrxtSi/nuTaHKg48Y=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/44] perf report: Show all sort keys in help output
Date:   Thu, 21 Mar 2019 15:51:02 -0300
Message-Id: <20190321185142.11441-5-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

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
 tools/perf/builtin-report.c |  5 ++--
 tools/perf/util/sort.c      | 52 +++++++++++++++++++++++++++++++++++++
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
-- 
2.20.1

