Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15053C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09A42192B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfCVWEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:04:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59197 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbfCVWEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:04:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MM3tQA745725
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:03:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MM3sBX745721;
        Fri, 22 Mar 2019 15:03:54 -0700
Date:   Fri, 22 Mar 2019 15:03:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-cd3dd8dd8ff62374d90cb3f2e54b8c94106c7810@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        hpa@zytor.com, mingo@kernel.org, jolsa@kernel.org,
        eranian@google.com, alexey.budankov@linux.intel.com,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, acme@redhat.com, ak@linux.intel.com,
        namhyung@kernel.org
Reply-To: hpa@zytor.com, alexander.shishkin@linux.intel.com,
          tglx@linutronix.de, eranian@google.com,
          alexey.budankov@linux.intel.com, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, mingo@kernel.org, jolsa@kernel.org,
          peterz@infradead.org, namhyung@kernel.org, acme@redhat.com,
          ak@linux.intel.com
In-Reply-To: <20190308134745.5057-3-jolsa@kernel.org>
References: <20190308134745.5057-3-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf data: Don't store auxtrace index for
 directory data file
Git-Commit-ID: cd3dd8dd8ff62374d90cb3f2e54b8c94106c7810
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

Commit-ID:  cd3dd8dd8ff62374d90cb3f2e54b8c94106c7810
Gitweb:     https://git.kernel.org/tip/cd3dd8dd8ff62374d90cb3f2e54b8c94106c7810
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 8 Mar 2019 14:47:36 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 11 Mar 2019 11:56:03 -0300

perf data: Don't store auxtrace index for directory data file

We can't store the auxtrace index when we store into multiple files,
because we keep only offset for it, not the file.

The auxtrace data will be processed correctly in the 'pipe' mode.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190308134745.5057-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f3f7f3100336..e983c8d71a79 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -392,7 +392,7 @@ static int record__process_auxtrace(struct perf_tool *tool,
 	size_t padding;
 	u8 pad[8] = {0};
 
-	if (!perf_data__is_pipe(data)) {
+	if (!perf_data__is_pipe(data) && !perf_data__is_dir(data)) {
 		off_t file_offset;
 		int fd = perf_data__fd(data);
 		int err;
