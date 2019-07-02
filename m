Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF08C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7123206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034497;
	bh=41GNa/T8HHn+m8L/+OJ7P1C9YyZxDuxwGcxk9QS+4aE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y67Z30AJrEc83C8NxlKiwRQuM3XQB0rwkDsXxloNN3142Yjtj5PJsneL6PfEt61WP
	 /BovoV2CnWaO80cs2k50wrwI3eG4EIifrsvapOm3QlnJFp4FDBg2tuZqZkeZ4XLokH
	 LnfT1dfa8oIISddUfzJUNmMNEbiXVPBUo7frMbOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfGBC2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:28:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbfGBC2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:28:14 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBA3621852;
        Tue,  2 Jul 2019 02:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034494;
        bh=41GNa/T8HHn+m8L/+OJ7P1C9YyZxDuxwGcxk9QS+4aE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nEfLPO/hEIGy1o2SPTJCnigEhYMyL8DqFztETPug/tNTCMqdtVOwsZt3fzifAgY33
         DcpKzPoF+9cAuiD0xyIk/L4mX5GkZYkHQmQiu2OlnzuNk3YjXRarUby55XHX9htMDP
         qh6EB0FokNeLWA1LLshc3g5PTuF/D1B2UkYwTsdI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 33/43] perf tools: Remove trim() implementation, use tools/lib's strim()
Date:   Mon,  1 Jul 2019 23:26:06 -0300
Message-Id: <20190702022616.1259-34-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.20.1

