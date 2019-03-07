Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6BEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE1C208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980817;
	bh=+dGAeyqN/+g+kHvUcbqgVrXgiMzZtCztop45pUegvkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=atvKD2WrbS1sSiYVzASaJy4wDKedXAdr8y6jCxZbvXCnZvDhIyFev/lLJXNn23iou
	 dUhEjp5bMQA0Ynr6xBWdI8CychGCES60tvfRfdZVUDZ64tQpWWjz2cliDtUhOE+KR7
	 LYGcAeTl4ZbQOiuzkIVlK7F2JSTriVwSwVbeEktU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfCGRq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:46:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:39546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfCGRqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:46:55 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B159A2087C;
        Thu,  7 Mar 2019 17:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980814;
        bh=+dGAeyqN/+g+kHvUcbqgVrXgiMzZtCztop45pUegvkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sM2ax7qo6oT6nLNRDGac5aGbG8L058+HGJCv6LQf+1KbWKHfxIapXtgRp5OxLz/RD
         1FcBLZ0+UU+JTMVZaqDLHrF3Uj1ObxiF47dLGtWLMUAO4ZtE2uiR3JPxED+fIn4GtY
         JYpstnFJOpAVbm/S+0BR/+mkvGTNTdOYjr+5Lc5M=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        nageswara r sastry <nasastry@in.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 30/35] perf hist: Add error path into hist_entry__init
Date:   Thu,  7 Mar 2019 14:44:28 -0300
Message-Id: <20190307174433.28819-31-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
-- 
2.20.1

