Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E721EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7772171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731865AbfB1IAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:00:34 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55931 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730399AbfB1IAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:00:34 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S80CDS2952606
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Feb 2019 00:00:12 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S80BgC2952601;
        Thu, 28 Feb 2019 00:00:11 -0800
Date:   Thu, 28 Feb 2019 00:00:11 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-05a486593977bfcf71de6bf5cad6d045c18829c6@git.kernel.org>
Cc:     adrian.hunter@intel.com, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, eranian@google.com,
        alexey.budankov@linux.intel.com, mingo@kernel.org,
        peterz@infradead.org, jolsa@kernel.org, namhyung@kernel.org,
        hpa@zytor.com, acme@redhat.com
Reply-To: tglx@linutronix.de, alexander.shishkin@linux.intel.com,
          ak@linux.intel.com, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, namhyung@kernel.org, hpa@zytor.com,
          acme@redhat.com, peterz@infradead.org, jolsa@kernel.org,
          mingo@kernel.org, eranian@google.com,
          alexey.budankov@linux.intel.com
In-Reply-To: <20190224190656.30163-2-jolsa@kernel.org>
References: <20190224190656.30163-2-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Add depth checking to rm_rf
Git-Commit-ID: 05a486593977bfcf71de6bf5cad6d045c18829c6
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

Commit-ID:  05a486593977bfcf71de6bf5cad6d045c18829c6
Gitweb:     https://git.kernel.org/tip/05a486593977bfcf71de6bf5cad6d045c18829c6
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 24 Feb 2019 20:06:37 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Feb 2019 10:32:11 -0300

perf tools: Add depth checking to rm_rf

Adding depth argument to rm_rf (and renaming it to rm_rf_depth) to
specify the depth we will go searching for files to remove.

It will be used to specify single depth for perf.data directory removal
in following patch.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190224190656.30163-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/util.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 3ee410fc047a..bcf436892155 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -117,7 +117,12 @@ int mkdir_p(char *path, mode_t mode)
 	return (stat(path, &st) && mkdir(path, mode)) ? -1 : 0;
 }
 
-int rm_rf(const char *path)
+/*
+ * The depth specify how deep the removal will go.
+ * 0       - will remove only files under the 'path' directory
+ * 1 .. x  - will dive in x-level deep under the 'path' directory
+ */
+static int rm_rf_depth(const char *path, int depth)
 {
 	DIR *dir;
 	int ret;
@@ -155,7 +160,7 @@ int rm_rf(const char *path)
 		}
 
 		if (S_ISDIR(statbuf.st_mode))
-			ret = rm_rf(namebuf);
+			ret = depth ? rm_rf_depth(namebuf, depth - 1) : 0;
 		else
 			ret = unlink(namebuf);
 	}
@@ -167,6 +172,11 @@ int rm_rf(const char *path)
 	return rmdir(path);
 }
 
+int rm_rf(const char *path)
+{
+	return rm_rf_depth(path, INT_MAX);
+}
+
 /* A filter which removes dot files */
 bool lsdir_no_dot_filter(const char *name __maybe_unused, struct dirent *d)
 {
