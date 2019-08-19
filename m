Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3950DC3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FDB20844
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 10:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfHSKfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 06:35:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5152 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727350AbfHSKfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:35:20 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6A77A4F10E1188DE1E2D;
        Mon, 19 Aug 2019 18:35:17 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 19 Aug
 2019 18:35:08 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-fsdevel@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 4/6] staging: erofs: avoid loop in submit chains
Date:   Mon, 19 Aug 2019 18:34:24 +0800
Message-ID: <20190819103426.87579-5-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819103426.87579-1-gaoxiang25@huawei.com>
References: <20190819080218.GA42231@138>
 <20190819103426.87579-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by erofs-utils fuzzer, 2 conditions
can happen in corrupted images, which can cause
unexpected behaviors.
 - access the same pcluster one more time;
 - access the tail end pcluster again, e.g.
            _ access again (will trigger tail merging)
           |
     1 2 3 1 2             ->   1 2 3 1
     |_ tail end of the chain    \___/ (unexpected behavior)
Let's detect and avoid them now.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/zdata.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/zdata.c b/drivers/staging/erofs/zdata.c
index 23283c97fd3b..aae2f2b8353f 100644
--- a/drivers/staging/erofs/zdata.c
+++ b/drivers/staging/erofs/zdata.c
@@ -132,7 +132,7 @@ enum z_erofs_collectmode {
 struct z_erofs_collector {
 	struct z_erofs_pagevec_ctor vector;
 
-	struct z_erofs_pcluster *pcl;
+	struct z_erofs_pcluster *pcl, *tailpcl;
 	struct z_erofs_collection *cl;
 	struct page **compressedpages;
 	z_erofs_next_pcluster_t owned_head;
@@ -353,6 +353,11 @@ static struct z_erofs_collection *cllookup(struct z_erofs_collector *clt,
 		return NULL;
 
 	pcl = container_of(grp, struct z_erofs_pcluster, obj);
+	if (clt->owned_head == &pcl->next || pcl == clt->tailpcl) {
+		DBG_BUGON(1);
+		erofs_workgroup_put(grp);
+		return ERR_PTR(-EFSCORRUPTED);
+	}
 
 	cl = z_erofs_primarycollection(pcl);
 	if (unlikely(cl->pageofs != (map->m_la & ~PAGE_MASK))) {
@@ -381,6 +386,9 @@ static struct z_erofs_collection *cllookup(struct z_erofs_collector *clt,
 		}
 	}
 	mutex_lock(&cl->lock);
+	/* used to check tail merging loop due to corrupted images */
+	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
+		clt->tailpcl = pcl;
 	clt->mode = try_to_claim_pcluster(pcl, &clt->owned_head);
 	clt->pcl = pcl;
 	clt->cl = cl;
@@ -434,6 +442,9 @@ static struct z_erofs_collection *clregister(struct z_erofs_collector *clt,
 		kmem_cache_free(pcluster_cachep, pcl);
 		return ERR_PTR(-EAGAIN);
 	}
+	/* used to check tail merging loop due to corrupted images */
+	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
+		clt->tailpcl = pcl;
 	clt->owned_head = &pcl->next;
 	clt->pcl = pcl;
 	clt->cl = cl;
-- 
2.17.1

