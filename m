Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD13C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C7E21850
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bm5ihIfI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfGCOYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:24:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52201 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfGCOYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:24:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63EOE9o3326042
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:24:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63EOE9o3326042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562163855;
        bh=SH4xWKH8pElWTfeXoJs1F/bnTBrKG71GuEq36r6ZcEM=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=bm5ihIfIt27MD6k0mi/iTU3Hd3D9ilsenmtsSHYwhG6QEDMkSImISMKqRug29X9Uz
         oxB8VjfF5X5tPxHsMA6n9ICHpMfo4pp5UCyocjCQoY2yz/LP3altPtMH7ZJrMgHY0/
         84/Bru3H65ApKYzpy8UemZbGvJfIkg531Q78gc+XHWHkNA2QAbJ9VZqwLKduC7MG/A
         w/Upo1+yija1H9x6qpJRV4aT9aZ/oWjuo2nbVUwAQhQAmixVLuBgWQvsPc3j0ritun
         SbHr8jUpMk0MkcUqqb/iAwhwoJGPyBlEcsnMC5fSV8PXeGHdBg8jzhF4pDXF7PGyd0
         XHnZ4/1jfOUlQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63EODTT3326039;
        Wed, 3 Jul 2019 07:24:13 -0700
Date:   Wed, 3 Jul 2019 07:24:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-wpj8rktj62yse5dq6ckny6de@git.kernel.org>
Cc:     mingo@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, hpa@zytor.com, jolsa@kernel.org,
        tglx@linutronix.de, adrian.hunter@intel.com
Reply-To: linux-kernel@vger.kernel.org, namhyung@kernel.org, hpa@zytor.com,
          tglx@linutronix.de, adrian.hunter@intel.com, jolsa@kernel.org,
          mingo@kernel.org, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Remove trim() implementation, use
 tools/lib's strim()
Git-Commit-ID: 3ca43b6053c9a5dbbffb02aa010c1ccf8eb460a8
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

Commit-ID:  3ca43b6053c9a5dbbffb02aa010c1ccf8eb460a8
Gitweb:     https://git.kernel.org/tip/3ca43b6053c9a5dbbffb02aa010c1ccf8eb460a8
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 26 Jun 2019 12:06:20 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 26 Jun 2019 12:06:20 -0300

perf tools: Remove trim() implementation, use tools/lib's strim()

Moving more stuff out of tools/perf/util/ and using the kernel idiom.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-wpj8rktj62yse5dq6ckny6de@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c | 3 ++-
 tools/perf/ui/browsers/hists.c  | 3 ++-
 tools/perf/ui/gtk/hists.c       | 5 +++--
 tools/perf/ui/stdio/hist.c      | 2 +-
 tools/perf/util/string2.h       | 5 -----
 5 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index cd72ff0f7658..66a82badc1d1 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -22,6 +22,7 @@
 #include "string2.h"
 #include "symbol.h"
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <subcmd/exec-cmd.h>
 
 static bool dont_fork;
@@ -438,7 +439,7 @@ static const char *shell_test__description(char *description, size_t size,
 	description = fgets(description, size, fp);
 	fclose(fp);
 
-	return description ? trim(description + 1) : NULL;
+	return description ? strim(description + 1) : NULL;
 }
 
 #define for_each_shell_test(dir, base, ent)	\
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 04a56114df92..10243408f3dc 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -6,6 +6,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <linux/rbtree.h>
+#include <linux/string.h>
 #include <sys/ttydefaults.h>
 #include <linux/time64.h>
 
@@ -1686,7 +1687,7 @@ static int hists_browser__scnprintf_hierarchy_headers(struct hist_browser *brows
 			ret = fmt->header(fmt, &dummy_hpp, hists, 0, NULL);
 			dummy_hpp.buf[ret] = '\0';
 
-			start = trim(dummy_hpp.buf);
+			start = strim(dummy_hpp.buf);
 			ret = strlen(start);
 
 			if (start != dummy_hpp.buf)
diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
index 6341c421a8f7..3955ed1d1bd9 100644
--- a/tools/perf/ui/gtk/hists.c
+++ b/tools/perf/ui/gtk/hists.c
@@ -9,6 +9,7 @@
 #include "../string2.h"
 #include "gtk.h"
 #include <signal.h>
+#include <linux/string.h>
 
 #define MAX_COLUMNS			32
 
@@ -459,7 +460,7 @@ static void perf_gtk__add_hierarchy_entries(struct hists *hists,
 			advance_hpp(hpp, ret + 2);
 		}
 
-		gtk_tree_store_set(store, &iter, col_idx, trim(bf), -1);
+		gtk_tree_store_set(store, &iter, col_idx, strim(bf), -1);
 
 		if (!he->leaf) {
 			hpp->buf = bf;
@@ -555,7 +556,7 @@ static void perf_gtk__show_hierarchy(GtkWidget *window, struct hists *hists,
 			first_col = false;
 
 			fmt->header(fmt, &hpp, hists, 0, NULL);
-			strcat(buf, trim(hpp.buf));
+			strcat(buf, strim(hpp.buf));
 		}
 	}
 
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 594e56628904..9eb0131c3ade 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -620,7 +620,7 @@ static int hists__fprintf_hierarchy_headers(struct hists *hists,
 
 			fmt->header(fmt, hpp, hists, 0, NULL);
 
-			header_width += fprintf(fp, "%s", trim(hpp->buf));
+			header_width += fprintf(fp, "%s", strim(hpp->buf));
 		}
 	}
 
diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
index db02059e31c5..5bc3fea52cdc 100644
--- a/tools/perf/util/string2.h
+++ b/tools/perf/util/string2.h
@@ -25,11 +25,6 @@ char *strxfrchar(char *s, char from, char to);
 
 char *rtrim(char *s);
 
-static inline char *trim(char *s)
-{
-	return skip_spaces(rtrim(s));
-}
-
 char *asprintf_expr_inout_ints(const char *var, bool in, size_t nints, int *ints);
 
 static inline char *asprintf_expr_in_ints(const char *var, size_t nints, int *ints)
