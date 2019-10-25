Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE017CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F57221D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408868AbfJYJnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:43:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39366 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408858AbfJYJnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:43:00 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 02B03FEEB462496965CC;
        Fri, 25 Oct 2019 17:42:59 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Fri, 25 Oct 2019
 17:42:49 +0800
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] perf c2c: Fix memory leak in c2c_he_zalloc()
Message-ID: <9d5f26f8-9429-bcb6-d491-cb789f761ea2@huawei.com>
Date:   Fri, 25 Oct 2019 17:42:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A memory leak in c2c_he_zalloc() is found by visual inspection.

Fix this by adding memory free on the error paths in c2c_he_zalloc().

Fixes: 7f834c2e84bb ("perf c2c report: Display node for cacheline address")
Fixes: 1e181b92a2da ("perf c2c report: Add 'node' sort key")
Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 tools/perf/builtin-c2c.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index e69f44941aad..ad7d38a9dcbe 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -138,21 +138,29 @@ static void *c2c_he_zalloc(size_t size)

 	c2c_he->cpuset = bitmap_alloc(c2c.cpus_cnt);
 	if (!c2c_he->cpuset)
-		return NULL;
+		goto free_c2c_he;

 	c2c_he->nodeset = bitmap_alloc(c2c.nodes_cnt);
 	if (!c2c_he->nodeset)
-		return NULL;
+		goto free_cpuset;

 	c2c_he->node_stats = zalloc(c2c.nodes_cnt * sizeof(*c2c_he->node_stats));
 	if (!c2c_he->node_stats)
-		return NULL;
+		goto free_nodeset;

 	init_stats(&c2c_he->cstats.lcl_hitm);
 	init_stats(&c2c_he->cstats.rmt_hitm);
 	init_stats(&c2c_he->cstats.load);

 	return &c2c_he->he;
+
+free_nodeset:
+	free(c2c_he->nodeset);
+free_cpuset:
+	free(c2c_he->cpuset);
+free_c2c_he:
+	free(c2c_he);
+	return NULL;
 }

 static void c2c_he_free(void *he)
-- 
2.7.4

