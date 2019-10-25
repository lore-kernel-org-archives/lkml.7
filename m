Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCADACA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 03:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA9452166E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 03:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403864AbfJYDQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 23:16:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5176 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732607AbfJYDQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 23:16:14 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BE266CE46B02804BCB4D;
        Fri, 25 Oct 2019 11:16:11 +0800 (CST)
Received: from huawei.com (10.175.104.225) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Fri, 25 Oct 2019
 11:16:05 +0800
From:   Hewenliang <hewenliang4@huawei.com>
To:     <peterz@infradead.org>, <jolsa@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <ilubashe@akamai.com>, <ak@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <hewenliang4@huawei.com>
CC:     <hushiyuan@huawei.com>, <linfeilong@huawei.com>
Subject: [PATCH] perf tools: Call closedir to release the resource before we return
Date:   Thu, 24 Oct 2019 23:16:05 -0400
Message-ID: <20191025031605.23658-1-hewenliang4@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should close the directory on pattern failure before the return
of rm_rf_depth_pat.

Fixes: cdb6b0235f170 ("perf tools: Add pattern name checking to rm_rf")
Signed-off-by: Hewenliang <hewenliang4@huawei.com>
---
 tools/perf/util/util.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 5eda6e19c947..1aadca8c43f3 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -154,8 +154,10 @@ static int rm_rf_depth_pat(const char *path, int depth, const char **pat)
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
 
-		if (!match_pat(d->d_name, pat))
+		if (!match_pat(d->d_name, pat)) {
+			closedir(dir);
 			return -2;
+		}
 
 		scnprintf(namebuf, sizeof(namebuf), "%s/%s",
 			  path, d->d_name);
-- 
2.19.1

