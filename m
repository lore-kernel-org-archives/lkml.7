Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC7DC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 20:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08FB206BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 20:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfCIUGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 15:06:39 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40589 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfCIUGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 15:06:39 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29K6LB13205991
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 12:06:21 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29K6LZp3205988;
        Sat, 9 Mar 2019 12:06:21 -0800
Date:   Sat, 9 Mar 2019 12:06:21 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-c57589106fd6d996dbf3757708baa4a3fb91850f@git.kernel.org>
Cc:     namhyung@kernel.org, ravi.bangoria@linux.ibm.com,
        peterz@infradead.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com,
        jonas.rabenstein@studium.uni-erlangen.de, ak@linux.intel.com,
        tglx@linutronix.de, mingo@kernel.org, acme@redhat.com,
        nasastry@in.ibm.com, jolsa@kernel.org
Reply-To: ravi.bangoria@linux.ibm.com, namhyung@kernel.org,
          peterz@infradead.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org,
          jonas.rabenstein@studium.uni-erlangen.de,
          alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          ak@linux.intel.com, jolsa@kernel.org, nasastry@in.ibm.com,
          acme@redhat.com, mingo@kernel.org
In-Reply-To: <20190305152536.21035-3-jolsa@kernel.org>
References: <20190305152536.21035-3-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf hist: Add error path into hist_entry__init
Git-Commit-ID: c57589106fd6d996dbf3757708baa4a3fb91850f
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

Commit-ID:  c57589106fd6d996dbf3757708baa4a3fb91850f
Gitweb:     https://git.kernel.org/tip/c57589106fd6d996dbf3757708baa4a3fb91850f
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Tue, 5 Mar 2019 16:25:30 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Mar 2019 18:16:30 -0300

perf hist: Add error path into hist_entry__init

Adding error path into hist_entry__init to unify error handling, so
every new member does not need to free everything else.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: nageswara r sastry <nasastry@in.ibm.com>
Link: http://lkml.kernel.org/r/20190305152536.21035-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 669f961316f0..74e307d17c49 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -396,11 +396,8 @@ static int hist_entry__init(struct hist_entry *he,
 		 * adding new entries.  So we need to save a copy.
 		 */
 		he->branch_info = malloc(sizeof(*he->branch_info));
-		if (he->branch_info == NULL) {
-			map__zput(he->ms.map);
-			free(he->stat_acc);
-			return -ENOMEM;
-		}
+		if (he->branch_info == NULL)
+			goto err;
 
 		memcpy(he->branch_info, template->branch_info,
 		       sizeof(*he->branch_info));
@@ -419,21 +416,8 @@ static int hist_entry__init(struct hist_entry *he,
 
 	if (he->raw_data) {
 		he->raw_data = memdup(he->raw_data, he->raw_size);
-
-		if (he->raw_data == NULL) {
-			map__put(he->ms.map);
-			if (he->branch_info) {
-				map__put(he->branch_info->from.map);
-				map__put(he->branch_info->to.map);
-				free(he->branch_info);
-			}
-			if (he->mem_info) {
-				map__put(he->mem_info->iaddr.map);
-				map__put(he->mem_info->daddr.map);
-			}
-			free(he->stat_acc);
-			return -ENOMEM;
-		}
+		if (he->raw_data == NULL)
+			goto err_infos;
 	}
 	INIT_LIST_HEAD(&he->pairs.node);
 	thread__get(he->thread);
@@ -444,6 +428,21 @@ static int hist_entry__init(struct hist_entry *he,
 		he->leaf = true;
 
 	return 0;
+
+err_infos:
+	if (he->branch_info) {
+		map__put(he->branch_info->from.map);
+		map__put(he->branch_info->to.map);
+		free(he->branch_info);
+	}
+	if (he->mem_info) {
+		map__put(he->mem_info->iaddr.map);
+		map__put(he->mem_info->daddr.map);
+	}
+err:
+	map__zput(he->ms.map);
+	free(he->stat_acc);
+	return -ENOMEM;
 }
 
 static void *hist_entry__zalloc(size_t size)
