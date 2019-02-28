Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F97C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E328E2184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbfB1IDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:03:03 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33503 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731184AbfB1IDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:03:02 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S82kSR2952829
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Feb 2019 00:02:46 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S82jYM2952825;
        Thu, 28 Feb 2019 00:02:45 -0800
Date:   Thu, 28 Feb 2019 00:02:45 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-ccb7a71dcea071c7fd68192909c4e54561c88043@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, alexey.budankov@linux.intel.com,
        ak@linux.intel.com, acme@redhat.com, eranian@google.com,
        hpa@zytor.com, namhyung@kernel.org, tglx@linutronix.de,
        adrian.hunter@intel.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        mingo@kernel.org
Reply-To: mingo@kernel.org, eranian@google.com, hpa@zytor.com,
          acme@redhat.com, ak@linux.intel.com,
          alexander.shishkin@linux.intel.com, jolsa@kernel.org,
          peterz@infradead.org, alexey.budankov@linux.intel.com,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          tglx@linutronix.de, adrian.hunter@intel.com
In-Reply-To: <20190224190656.30163-8-jolsa@kernel.org>
References: <20190224190656.30163-8-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf data: Fail check_backup in case of error
Git-Commit-ID: ccb7a71dcea071c7fd68192909c4e54561c88043
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

Commit-ID:  ccb7a71dcea071c7fd68192909c4e54561c88043
Gitweb:     https://git.kernel.org/tip/ccb7a71dcea071c7fd68192909c4e54561c88043
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 24 Feb 2019 20:06:43 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Feb 2019 10:37:01 -0300

perf data: Fail check_backup in case of error

And display the error message from removing the old data file:

  $ perf record ls
  Can't remove old data: Permission denied (perf.data.old)
  Perf session creation failed.

  $ perf record ls
  Can't remove old data: Unknown file found (perf.data.old)
  Perf session creation failed.

Not sure how to make fail the rename (after we successfully remove the
destination file/dir) to show the message, anyway let's have it there.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190224190656.30163-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index bbf9a299615e..d008c3973012 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -41,12 +41,27 @@ static int check_backup(struct perf_data *data)
 		return 0;
 
 	if (!stat(data->path, &st) && st.st_size) {
-		/* TODO check errors properly */
 		char oldname[PATH_MAX];
+		int ret;
+
 		snprintf(oldname, sizeof(oldname), "%s.old",
 			 data->path);
-		rm_rf_perf_data(oldname);
-		rename(data->path, oldname);
+
+		ret = rm_rf_perf_data(oldname);
+		if (ret) {
+			pr_err("Can't remove old data: %s (%s)\n",
+			       ret == -2 ?
+			       "Unknown file found" : strerror(errno),
+			       oldname);
+			return -1;
+		}
+
+		if (rename(data->path, oldname)) {
+			pr_err("Can't move data: %s (%s to %s)\n",
+			       strerror(errno),
+			       data->path, oldname);
+			return -1;
+		}
 	}
 
 	return 0;
