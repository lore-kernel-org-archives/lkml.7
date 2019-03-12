Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7449AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5D32087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfCLQnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:43:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:38180 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfCLQnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:43:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 09:43:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,471,1544515200"; 
   d="scan'208";a="327940394"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga005.fm.intel.com with ESMTP; 12 Mar 2019 09:43:49 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 6653730162C; Tue, 12 Mar 2019 09:43:49 -0700 (PDT)
Date:   Tue, 12 Mar 2019 09:43:49 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 05/10] perf, report: Show all sort keys in help output
Message-ID: <20190312164349.GA24002@tassilo.jf.intel.com>
References: <20190311202446.10210-1-andi@firstfloor.org>
 <20190311202446.10210-6-andi@firstfloor.org>
 <20190312103027.GB13071@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312103027.GB13071@krava>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> that line goes forever now, please provide some formating
> into multiple lines

Here's an updated patch with line wrapping.

---

perf report: Show all sort keys in help output

Show all the supported sort keys in the command line help output,
so that it's not needed to refer to the manpage.

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---

v2: Now line wrap output.
---
 tools/perf/builtin-report.c |  5 ++--
 tools/perf/util/sort.c      | 52 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/sort.h      |  2 ++
 3 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 1532ebde6c4b..6317c38762dd 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1044,10 +1044,9 @@ int cmd_report(int argc, const char **argv)
 	OPT_BOOLEAN(0, "header-only", &report.header_only,
 		    "Show only data header."),
 	OPT_STRING('s', "sort", &sort_order, "key[,key2...]",
-		   "sort by key(s): pid, comm, dso, symbol, parent, cpu, srcline, ..."
-		   " Please refer the man page for the complete list."),
+		   sort_help("sort by key(s):")),
 	OPT_STRING('F', "fields", &field_order, "key[,keys...]",
-		   "output field(s): overhead, period, sample plus all of sort keys"),
+		   sort_help("output field(s): overhead, period, sample,")),
 	OPT_BOOLEAN(0, "show-cpu-utilization", &symbol_conf.show_cpu_utilization,
 		    "Show sample percentage for different cpu modes"),
 	OPT_BOOLEAN_FLAG(0, "showcpuutilization", &symbol_conf.show_cpu_utilization,
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index d2299e912e59..ea71d3732a50 100644
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
@@ -3068,3 +3069,54 @@ void reset_output_field(void)
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

