Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDCDC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9AE20851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980823;
	bh=WSZ4lY5Uet+kGuhhHhoPdF4N5SazbmegUEP0ahp8Na0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b+YkY67tbVxd41M7o35EOj87YprC6MzgtY0MbVhzCrKE53A3J8fVTUNVWaTSERXRl
	 tTzYLbbdxgXALf1ksqAGr7A0MyhyCrBvqVTzJ+Ow/sPaXU3J+h7tqdtpzaGxgDbp2R
	 U6U78e0KAt0Os0kOFcH5taFFqi1teLY0r/R6BNg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfCGRrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:47:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbfCGRq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:46:59 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9876720661;
        Thu,  7 Mar 2019 17:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980819;
        bh=WSZ4lY5Uet+kGuhhHhoPdF4N5SazbmegUEP0ahp8Na0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KNZHBvSQqaIAJJriA6mu8rEUGiCD9aiPfP9+Tj7BIBmipiQyPvlhk6t9+jGIF/mBI
         sfcUNThkpFClEl5tKjGUVxbb+tQF6OpGxzRQsJGSkoFrCw5MRcj8mjCK0ZLDxwrXkA
         VTab4aYo7sgvplqXv3B6L7rmfj20G72nry86+8r0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@redhat.com>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Nageswara R Sastry <nasastry@in.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 31/35] perf hist: Fix memory leak of srcline
Date:   Thu,  7 Mar 2019 14:44:29 -0300
Message-Id: <20190307174433.28819-32-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

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
-- 
2.20.1

