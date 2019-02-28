Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2ABC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1413218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbfB1HsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:48:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46205 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfB1HsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:48:03 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S7lqYc2950272
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:47:52 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S7lppS2950269;
        Wed, 27 Feb 2019 23:47:51 -0800
Date:   Wed, 27 Feb 2019 23:47:51 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-b4409ae112caa6315f6ee678e953b9fc93e6919c@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org, acme@redhat.com,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        ak@linux.intel.com, hpa@zytor.com, alexey.budankov@linux.intel.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, namhyung@kernel.org
Reply-To: ak@linux.intel.com, alexander.shishkin@linux.intel.com,
          mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
          acme@redhat.com, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, jolsa@kernel.org,
          alexey.budankov@linux.intel.com, hpa@zytor.com
In-Reply-To: <20190220122800.864-7-jolsa@kernel.org>
References: <20190220122800.864-7-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Make rm_rf() remove single file
Git-Commit-ID: b4409ae112caa6315f6ee678e953b9fc93e6919c
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

Commit-ID:  b4409ae112caa6315f6ee678e953b9fc93e6919c
Gitweb:     https://git.kernel.org/tip/b4409ae112caa6315f6ee678e953b9fc93e6919c
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 20 Feb 2019 13:28:00 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 20 Feb 2019 17:09:28 -0300

perf tools: Make rm_rf() remove single file

Let rm_rf() remove a file if it's provided by path, not just
directories.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190220122800.864-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/util.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 320b0fef249a..3ee410fc047a 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -120,16 +120,26 @@ int mkdir_p(char *path, mode_t mode)
 int rm_rf(const char *path)
 {
 	DIR *dir;
-	int ret = 0;
+	int ret;
 	struct dirent *d;
 	char namebuf[PATH_MAX];
+	struct stat statbuf;
 
+	/* Do not fail if there's no file. */
+	ret = lstat(path, &statbuf);
+	if (ret)
+		return 0;
+
+	/* Try to remove any file we get. */
+	if (!(statbuf.st_mode & S_IFDIR))
+		return unlink(path);
+
+	/* We have directory in path. */
 	dir = opendir(path);
 	if (dir == NULL)
-		return 0;
+		return -1;
 
 	while ((d = readdir(dir)) != NULL && !ret) {
-		struct stat statbuf;
 
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
