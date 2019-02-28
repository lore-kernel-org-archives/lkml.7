Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4925C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8462171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731859AbfB1ICy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:02:54 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57059 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731184AbfB1ICx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:02:53 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S81TUp2952729
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Feb 2019 00:01:29 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S81ScF2952726;
        Thu, 28 Feb 2019 00:01:28 -0800
Date:   Thu, 28 Feb 2019 00:01:28 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-c69e4c37b37c816c7dbd307a6e7d2d2a5cfe8788@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com,
        alexey.budankov@linux.intel.com, mingo@kernel.org, acme@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, adrian.hunter@intel.com,
        hpa@zytor.com, jolsa@kernel.org, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, eranian@google.com,
        tglx@linutronix.de
Reply-To: alexey.budankov@linux.intel.com,
          alexander.shishkin@linux.intel.com, acme@redhat.com,
          mingo@kernel.org, adrian.hunter@intel.com, hpa@zytor.com,
          jolsa@kernel.org, namhyung@kernel.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          eranian@google.com, ak@linux.intel.com
In-Reply-To: <20190224190656.30163-4-jolsa@kernel.org>
References: <20190224190656.30163-4-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Add rm_rf_perf_data function
Git-Commit-ID: c69e4c37b37c816c7dbd307a6e7d2d2a5cfe8788
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

Commit-ID:  c69e4c37b37c816c7dbd307a6e7d2d2a5cfe8788
Gitweb:     https://git.kernel.org/tip/c69e4c37b37c816c7dbd307a6e7d2d2a5cfe8788
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 24 Feb 2019 20:06:39 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Feb 2019 10:33:51 -0300

perf tools: Add rm_rf_perf_data function

To remove perf.data including the directory, with checking on expected
files and no other directories inside.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Suggested-by: Andi Kleen <ak@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190224190656.30163-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/util.c | 11 +++++++++++
 tools/perf/util/util.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 02b7a38f98ce..706818693086 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -202,6 +202,17 @@ static int rm_rf_depth_pat(const char *path, int depth, const char **pat)
 	return rmdir(path);
 }
 
+int rm_rf_perf_data(const char *path)
+{
+	const char *pat[] = {
+		"header",
+		"data.*",
+		NULL,
+	};
+
+	return rm_rf_depth_pat(path, 0, pat);
+}
+
 int rm_rf(const char *path)
 {
 	return rm_rf_depth_pat(path, INT_MAX, NULL);
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index ece040b799f6..01c538027c6f 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -31,6 +31,7 @@ struct strlist;
 
 int mkdir_p(char *path, mode_t mode);
 int rm_rf(const char *path);
+int rm_rf_perf_data(const char *path);
 struct strlist *lsdir(const char *name, bool (*filter)(const char *, struct dirent *));
 bool lsdir_no_dot_filter(const char *name, struct dirent *d);
 int copyfile(const char *from, const char *to);
