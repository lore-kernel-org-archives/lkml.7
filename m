Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1EFC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 20:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0F0206BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 20:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfCIUIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 15:08:24 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46219 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfCIUIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 15:08:24 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29K750V3206025
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 12:07:05 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29K75Bs3206022;
        Sat, 9 Mar 2019 12:07:05 -0800
Date:   Sat, 9 Mar 2019 12:07:05 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-2634958586368dcbf09c0d2a17dee02d1fc53e0d@git.kernel.org>
Cc:     jolsa@redhat.com, ak@linux.intel.com, hpa@zytor.com,
        jolsa@kernel.org, ravi.bangoria@linux.ibm.com,
        jonas.rabenstein@studium.uni-erlangen.de,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        peterz@infradead.org, acme@redhat.com, nasastry@in.ibm.com,
        tglx@linutronix.de, mingo@kernel.org,
        alexander.shishkin@linux.intel.com
Reply-To: ravi.bangoria@linux.ibm.com,
          jonas.rabenstein@studium.uni-erlangen.de,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          jolsa@redhat.com, ak@linux.intel.com, jolsa@kernel.org,
          hpa@zytor.com, alexander.shishkin@linux.intel.com,
          acme@redhat.com, peterz@infradead.org, nasastry@in.ibm.com,
          tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20190305152536.21035-4-jolsa@kernel.org>
References: <20190305152536.21035-4-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf hist: Fix memory leak of srcline
Git-Commit-ID: 2634958586368dcbf09c0d2a17dee02d1fc53e0d
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

Commit-ID:  2634958586368dcbf09c0d2a17dee02d1fc53e0d
Gitweb:     https://git.kernel.org/tip/2634958586368dcbf09c0d2a17dee02d1fc53e0d
Author:     Jiri Olsa <jolsa@redhat.com>
AuthorDate: Tue, 5 Mar 2019 16:25:31 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Mar 2019 18:16:57 -0300

perf hist: Fix memory leak of srcline

We can't allocate he->srcline unconditionaly, only when new hist_entry
is created. Moving he->srcline allocation into hist_entry__init
function.

Original-patch-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Nageswara R Sastry <nasastry@in.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lkml.kernel.org/r/20190305152536.21035-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 74e307d17c49..f9eb95bf3938 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -419,6 +419,13 @@ static int hist_entry__init(struct hist_entry *he,
 		if (he->raw_data == NULL)
 			goto err_infos;
 	}
+
+	if (he->srcline) {
+		he->srcline = strdup(he->srcline);
+		if (he->srcline == NULL)
+			goto err_rawdata;
+	}
+
 	INIT_LIST_HEAD(&he->pairs.node);
 	thread__get(he->thread);
 	he->hroot_in  = RB_ROOT_CACHED;
@@ -429,6 +436,9 @@ static int hist_entry__init(struct hist_entry *he,
 
 	return 0;
 
+err_rawdata:
+	free(he->raw_data);
+
 err_infos:
 	if (he->branch_info) {
 		map__put(he->branch_info->from.map);
@@ -605,7 +615,7 @@ __hists__add_entry(struct hists *hists,
 			.map	= al->map,
 			.sym	= al->sym,
 		},
-		.srcline = al->srcline ? strdup(al->srcline) : NULL,
+		.srcline = (char *) al->srcline,
 		.socket	 = al->socket,
 		.cpu	 = al->cpu,
 		.cpumode = al->cpumode,
@@ -962,7 +972,7 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 			.map = al->map,
 			.sym = al->sym,
 		},
-		.srcline = al->srcline ? strdup(al->srcline) : NULL,
+		.srcline = (char *) al->srcline,
 		.parent = iter->parent,
 		.raw_data = sample->raw_data,
 		.raw_size = sample->raw_size,
