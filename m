Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E765C41517
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 06:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C5C2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 06:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfG2Gwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 02:52:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56598 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727296AbfG2Gws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 02:52:48 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5B7E54FD6EB467559D91;
        Mon, 29 Jul 2019 14:52:45 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 29 Jul
 2019 14:52:34 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 19/22] staging: erofs: tidy up utils.c
Date:   Mon, 29 Jul 2019 14:51:56 +0800
Message-ID: <20190729065159.62378-20-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190729065159.62378-1-gaoxiang25@huawei.com>
References: <20190729065159.62378-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

keep in line with erofs-outofstaging patchset:
 - Update comments in erofs_try_to_release_workgroup;
 - code style cleanup.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/utils.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/erofs/utils.c b/drivers/staging/erofs/utils.c
index 0e6308b15717..814c2ee037ae 100644
--- a/drivers/staging/erofs/utils.c
+++ b/drivers/staging/erofs/utils.c
@@ -114,8 +114,7 @@ int erofs_register_workgroup(struct super_block *sb,
 	 */
 	__erofs_workgroup_get(grp);
 
-	err = radix_tree_insert(&sbi->workstn_tree,
-				grp->index, grp);
+	err = radix_tree_insert(&sbi->workstn_tree, grp->index, grp);
 	if (unlikely(err))
 		/*
 		 * it's safe to decrease since the workgroup isn't visible
@@ -156,18 +155,18 @@ static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
 					   bool cleanup)
 {
 	/*
-	 * for managed cache enabled, the refcount of workgroups
-	 * themselves could be < 0 (freezed). So there is no guarantee
-	 * that all refcount > 0 if managed cache is enabled.
+	 * If managed cache is on, refcount of workgroups
+	 * themselves could be < 0 (freezed). In other words,
+	 * there is no guarantee that all refcounts > 0.
 	 */
 	if (!erofs_workgroup_try_to_freeze(grp, 1))
 		return false;
 
 	/*
-	 * note that all cached pages should be unlinked
-	 * before delete it from the radix tree.
-	 * Otherwise some cached pages of an orphan old workgroup
-	 * could be still linked after the new one is available.
+	 * Note that all cached pages should be unattached
+	 * before deleted from the radix tree. Otherwise some
+	 * cached pages could be still attached to the orphan
+	 * old workgroup when the new one is available in the tree.
 	 */
 	if (erofs_try_to_free_all_cached_pages(sbi, grp)) {
 		erofs_workgroup_unfreeze(grp, 1);
@@ -175,7 +174,7 @@ static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
 	}
 
 	/*
-	 * it is impossible to fail after the workgroup is freezed,
+	 * It's impossible to fail after the workgroup is freezed,
 	 * however in order to avoid some race conditions, add a
 	 * DBG_BUGON to observe this in advance.
 	 */
@@ -183,8 +182,8 @@ static bool erofs_try_to_release_workgroup(struct erofs_sb_info *sbi,
 						     grp->index)) != grp);
 
 	/*
-	 * if managed cache is enable, the last refcount
-	 * should indicate the related workstation.
+	 * If managed cache is on, last refcount should indicate
+	 * the related workstation.
 	 */
 	erofs_workgroup_unfreeze_final(grp);
 	return true;
@@ -273,9 +272,9 @@ static unsigned long erofs_shrink_scan(struct shrinker *shrink,
 	unsigned long freed = 0;
 
 	spin_lock(&erofs_sb_list_lock);
-	do
+	do {
 		run_no = ++shrinker_run_no;
-	while (run_no == 0);
+	} while (run_no == 0);
 
 	/* Iterate over all mounted superblocks and try to shrink them */
 	p = erofs_sb_list.next;
-- 
2.17.1

