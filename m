Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BE0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 05:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F2320652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 05:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfCGFgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 00:36:19 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:42096 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726059AbfCGFgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 00:36:17 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 50CF3D505EBA99D43C05;
        Thu,  7 Mar 2019 13:36:15 +0800 (CST)
Received: from 138.huawei.com (10.175.124.28) by smtp.huawei.com (10.3.19.206)
 with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 7 Mar 2019 13:36:07
 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Sasha Levin <sashal@kernel.org>
CC:     Chao Yu <yuchao0@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Gao Xiang <gaoxiang25@huawei.com>,
        <stable@vger.kernel.org>
Subject: [PATCH for-4.19] staging: erofs: fix mis-acted TAIL merging behavior
Date:   Thu, 7 Mar 2019 13:34:04 +0800
Message-ID: <20190307053404.29108-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190301212203.5FE0C2084F@mail.kernel.org>
References: <20190301212203.5FE0C2084F@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit a112152f6f3a2a88caa6f414d540bd49e406af60 upstream.

EROFS has an optimized path called TAIL merging, which is designed
to merge multiple reads and the corresponding decompressions into
one if these requests read continuous pages almost at the same time.

In general, it behaves as follows:
 ________________________________________________________________
  ... |  TAIL  .  HEAD  |  PAGE  |  PAGE  |  TAIL    . HEAD | ...
 _____|_combined page A_|________|________|_combined page B_|____
        1  ]  ->  [  2                          ]  ->  [ 3
If the above three reads are requested in the order 1-2-3, it will
generate a large work chain rather than 3 individual work chains
to reduce scheduling overhead and boost up sequential read.

However, if Read 2 is processed slightly earlier than Read 1,
currently it still generates 2 individual work chains (chain 1, 2)
but it does in-place decompression for combined page A, moreover,
if chain 2 decompresses ahead of chain 1, it will be a race and
lead to corrupted decompressed page. This patch fixes it.

Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Cc: <stable@vger.kernel.org> # 4.19+
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
---
 drivers/staging/erofs/unzip_vle.c | 69 +++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 1279241449f4..24bd1d6deb66 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -57,15 +57,30 @@ enum z_erofs_vle_work_role {
 	Z_EROFS_VLE_WORK_SECONDARY,
 	Z_EROFS_VLE_WORK_PRIMARY,
 	/*
-	 * The current work has at least been linked with the following
-	 * processed chained works, which means if the processing page
-	 * is the tail partial page of the work, the current work can
-	 * safely use the whole page, as illustrated below:
-	 * +--------------+-------------------------------------------+
-	 * |  tail page   |      head page (of the previous work)     |
-	 * +--------------+-------------------------------------------+
-	 *   /\  which belongs to the current work
-	 * [  (*) this page can be used for the current work itself.  ]
+	 * The current work was the tail of an exist chain, and the previous
+	 * processed chained works are all decided to be hooked up to it.
+	 * A new chain should be created for the remaining unprocessed works,
+	 * therefore different from Z_EROFS_VLE_WORK_PRIMARY_FOLLOWED,
+	 * the next work cannot reuse the whole page in the following scenario:
+	 *  ________________________________________________________________
+	 * |      tail (partial) page     |       head (partial) page       |
+	 * |  (belongs to the next work)  |  (belongs to the current work)  |
+	 * |_______PRIMARY_FOLLOWED_______|________PRIMARY_HOOKED___________|
+	 */
+	Z_EROFS_VLE_WORK_PRIMARY_HOOKED,
+	/*
+	 * The current work has been linked with the processed chained works,
+	 * and could be also linked with the potential remaining works, which
+	 * means if the processing page is the tail partial page of the work,
+	 * the current work can safely use the whole page (since the next work
+	 * is under control) for in-place decompression, as illustrated below:
+	 *  ________________________________________________________________
+	 * |  tail (partial) page  |          head (partial) page           |
+	 * | (of the current work) |         (of the previous work)         |
+	 * |  PRIMARY_FOLLOWED or  |                                        |
+	 * |_____PRIMARY_HOOKED____|____________PRIMARY_FOLLOWED____________|
+	 *
+	 * [  (*) the above page can be used for the current work itself.  ]
 	 */
 	Z_EROFS_VLE_WORK_PRIMARY_FOLLOWED,
 	Z_EROFS_VLE_WORK_MAX
@@ -234,10 +249,10 @@ static int z_erofs_vle_work_add_page(
 	return ret ? 0 : -EAGAIN;
 }
 
-static inline bool try_to_claim_workgroup(
-	struct z_erofs_vle_workgroup *grp,
-	z_erofs_vle_owned_workgrp_t *owned_head,
-	bool *hosted)
+static enum z_erofs_vle_work_role
+try_to_claim_workgroup(struct z_erofs_vle_workgroup *grp,
+		       z_erofs_vle_owned_workgrp_t *owned_head,
+		       bool *hosted)
 {
 	DBG_BUGON(*hosted == true);
 
@@ -251,6 +266,9 @@ static inline bool try_to_claim_workgroup(
 
 		*owned_head = grp;
 		*hosted = true;
+		/* lucky, I am the followee :) */
+		return Z_EROFS_VLE_WORK_PRIMARY_FOLLOWED;
+
 	} else if (grp->next == Z_EROFS_VLE_WORKGRP_TAIL) {
 		/*
 		 * type 2, link to the end of a existing open chain,
@@ -260,12 +278,11 @@ static inline bool try_to_claim_workgroup(
 		if (Z_EROFS_VLE_WORKGRP_TAIL != cmpxchg(&grp->next,
 			Z_EROFS_VLE_WORKGRP_TAIL, *owned_head))
 			goto retry;
-
 		*owned_head = Z_EROFS_VLE_WORKGRP_TAIL;
-	} else
-		return false;	/* :( better luck next time */
+		return Z_EROFS_VLE_WORK_PRIMARY_HOOKED;
+	}
 
-	return true;	/* lucky, I am the followee :) */
+	return Z_EROFS_VLE_WORK_PRIMARY; /* :( better luck next time */
 }
 
 static struct z_erofs_vle_work *
@@ -337,12 +354,8 @@ z_erofs_vle_work_lookup(struct super_block *sb,
 	*hosted = false;
 	if (!primary)
 		*role = Z_EROFS_VLE_WORK_SECONDARY;
-	/* claim the workgroup if possible */
-	else if (try_to_claim_workgroup(grp, owned_head, hosted))
-		*role = Z_EROFS_VLE_WORK_PRIMARY_FOLLOWED;
-	else
-		*role = Z_EROFS_VLE_WORK_PRIMARY;
-
+	else	/* claim the workgroup if possible */
+		*role = try_to_claim_workgroup(grp, owned_head, hosted);
 	return work;
 }
 
@@ -419,6 +432,9 @@ static inline void __update_workgrp_llen(struct z_erofs_vle_workgroup *grp,
 	}
 }
 
+#define builder_is_hooked(builder) \
+	((builder)->role >= Z_EROFS_VLE_WORK_PRIMARY_HOOKED)
+
 #define builder_is_followed(builder) \
 	((builder)->role >= Z_EROFS_VLE_WORK_PRIMARY_FOLLOWED)
 
@@ -583,7 +599,7 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 	struct z_erofs_vle_work_builder *const builder = &fe->builder;
 	const loff_t offset = page_offset(page);
 
-	bool tight = builder_is_followed(builder);
+	bool tight = builder_is_hooked(builder);
 	struct z_erofs_vle_work *work = builder->work;
 
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
@@ -646,7 +662,7 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 		builder->role = Z_EROFS_VLE_WORK_PRIMARY;
 #endif
 
-	tight &= builder_is_followed(builder);
+	tight &= builder_is_hooked(builder);
 	work = builder->work;
 hitted:
 	cur = end - min_t(unsigned, offset + end - map->m_la, end);
@@ -661,6 +677,9 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 			(tight ? Z_EROFS_PAGE_TYPE_EXCLUSIVE :
 				Z_EROFS_VLE_PAGE_TYPE_TAIL_SHARED));
 
+	if (cur)
+		tight &= builder_is_followed(builder);
+
 retry:
 	err = z_erofs_vle_work_add_page(builder, page, page_type);
 	/* should allocate an additional staging page for pagevec */
-- 
2.14.5

