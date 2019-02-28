Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A774C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2222184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731871AbfB1IBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:01:13 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35755 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730399AbfB1IBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:01:13 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S80psY2952660
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Feb 2019 00:00:51 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S80ooP2952657;
        Thu, 28 Feb 2019 00:00:50 -0800
Date:   Thu, 28 Feb 2019 00:00:50 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-cdb6b0235f170a5ffcd74731178efc064bd4d24a@git.kernel.org>
Cc:     adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
        alexey.budankov@linux.intel.com, eranian@google.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        namhyung@kernel.org, peterz@infradead.org, mingo@kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, hpa@zytor.com,
        acme@redhat.com
Reply-To: alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
          eranian@google.com, linux-kernel@vger.kernel.org,
          alexey.budankov@linux.intel.com, mingo@kernel.org,
          tglx@linutronix.de, namhyung@kernel.org, ak@linux.intel.com,
          peterz@infradead.org, acme@redhat.com, hpa@zytor.com,
          jolsa@kernel.org
In-Reply-To: <20190224190656.30163-3-jolsa@kernel.org>
References: <20190224190656.30163-3-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Add pattern name checking to rm_rf
Git-Commit-ID: cdb6b0235f170a5ffcd74731178efc064bd4d24a
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

Commit-ID:  cdb6b0235f170a5ffcd74731178efc064bd4d24a
Gitweb:     https://git.kernel.org/tip/cdb6b0235f170a5ffcd74731178efc064bd4d24a
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 24 Feb 2019 20:06:38 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Feb 2019 10:33:04 -0300

perf tools: Add pattern name checking to rm_rf

Add pattern argument to rm_rf_depth() (and rename it to rm_rf_depth_pat())
to specify the name pattern files need to match inside the directory.

The function fails if we find different file to remove.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190224190656.30163-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/util.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index bcf436892155..02b7a38f98ce 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -21,6 +21,7 @@
 #include <linux/time64.h>
 #include <unistd.h>
 #include "strlist.h"
+#include "string2.h"
 
 /*
  * XXX We need to find a better place for these things...
@@ -117,12 +118,38 @@ int mkdir_p(char *path, mode_t mode)
 	return (stat(path, &st) && mkdir(path, mode)) ? -1 : 0;
 }
 
+static bool match_pat(char *file, const char **pat)
+{
+	int i = 0;
+
+	if (!pat)
+		return true;
+
+	while (pat[i]) {
+		if (strglobmatch(file, pat[i]))
+			return true;
+
+		i++;
+	}
+
+	return false;
+}
+
 /*
  * The depth specify how deep the removal will go.
  * 0       - will remove only files under the 'path' directory
  * 1 .. x  - will dive in x-level deep under the 'path' directory
+ *
+ * If specified the pat is array of string patterns ended with NULL,
+ * which are checked upon every file/directory found. Only matching
+ * ones are removed.
+ *
+ * The function returns:
+ *    0 on success
+ *   -1 on removal failure with errno set
+ *   -2 on pattern failure
  */
-static int rm_rf_depth(const char *path, int depth)
+static int rm_rf_depth_pat(const char *path, int depth, const char **pat)
 {
 	DIR *dir;
 	int ret;
@@ -149,6 +176,9 @@ static int rm_rf_depth(const char *path, int depth)
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
 
+		if (!match_pat(d->d_name, pat))
+			return -2;
+
 		scnprintf(namebuf, sizeof(namebuf), "%s/%s",
 			  path, d->d_name);
 
@@ -160,7 +190,7 @@ static int rm_rf_depth(const char *path, int depth)
 		}
 
 		if (S_ISDIR(statbuf.st_mode))
-			ret = depth ? rm_rf_depth(namebuf, depth - 1) : 0;
+			ret = depth ? rm_rf_depth_pat(namebuf, depth - 1, pat) : 0;
 		else
 			ret = unlink(namebuf);
 	}
@@ -174,7 +204,7 @@ static int rm_rf_depth(const char *path, int depth)
 
 int rm_rf(const char *path)
 {
-	return rm_rf_depth(path, INT_MAX);
+	return rm_rf_depth_pat(path, INT_MAX, NULL);
 }
 
 /* A filter which removes dot files */
