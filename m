Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B045C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5FC208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 15:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551799549;
	bh=xdfuO3KcmfHBPobkwsPQXueU22hhZbgGPlwmvJR8SNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o3HuLKYWHrcV4ibqxGAgMQlKOFSJfUcadvofde8D4kOV9d1v3nggBbEZ8143gd+LK
	 PO3Y+mU5DSreQh0M/Ji8GEs1Qfvwcqs2L+QTqljDlnzBG0zd2X6ryVmuHi4EnE4o8K
	 iC/vz0Sa7tu/DnnuW7r5kPzqo4DUBSbt+f+8hSdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfCEPZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 10:25:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbfCEPZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 10:25:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E8CA1C04BD37;
        Tue,  5 Mar 2019 15:25:44 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B78C71001E7C;
        Tue,  5 Mar 2019 15:25:42 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Nageswara R Sastry <nasastry@in.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 2/8] perf tools: Add error path into hist_entry__init
Date:   Tue,  5 Mar 2019 16:25:30 +0100
Message-Id: <20190305152536.21035-3-jolsa@kernel.org>
In-Reply-To: <20190305152536.21035-1-jolsa@kernel.org>
References: <20190305152536.21035-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 05 Mar 2019 15:25:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding error path into hist_entry__init to unify error
handling, so every new member does not need to free
everything else.

Link: http://lkml.kernel.org/n/tip-v0ssws4hsr0tozb7lm0k5f70@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.17.2

