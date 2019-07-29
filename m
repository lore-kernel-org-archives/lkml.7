Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E67C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 06:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A832075B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 06:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfG2Gw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 02:52:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56098 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726694AbfG2Gw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 02:52:26 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0CD3828D48C5BBEBCF17;
        Mon, 29 Jul 2019 14:52:25 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 29 Jul
 2019 14:52:19 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 05/22] staging: erofs: sunset erofs_workstn_{lock,unlock}
Date:   Mon, 29 Jul 2019 14:51:42 +0800
Message-ID: <20190729065159.62378-6-gaoxiang25@huawei.com>
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

It was used for Linux backward compatibility, and no use
for upstream kernel.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/internal.h |  3 ---
 drivers/staging/erofs/utils.c    | 10 +++++-----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 501429ec0f91..ed487ee56f74 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -179,9 +179,6 @@ static inline void *erofs_kmalloc(struct erofs_sb_info *sbi,
 #define test_opt(sbi, option)	((sbi)->mount_opt & EROFS_MOUNT_##option)
 
 #ifdef CONFIG_EROFS_FS_ZIP
-#define erofs_workstn_lock(sbi)         xa_lock(&(sbi)->workstn_tree)
-#define erofs_workstn_unlock(sbi)       xa_unlock(&(sbi)->workstn_tree)
-
 /* basic unit of the workstation of a super_block */
 struct erofs_workgroup {
 	/* the workgroup index in the workstation */
diff --git a/drivers/staging/erofs/utils.c b/drivers/staging/erofs/utils.c
index a68dbe375fa0..024806003297 100644
--- a/drivers/staging/erofs/utils.c
+++ b/drivers/staging/erofs/utils.c
@@ -102,14 +102,14 @@ int erofs_register_workgroup(struct super_block *sb,
 		return err;
 
 	sbi = EROFS_SB(sb);
-	erofs_workstn_lock(sbi);
+	xa_lock(&sbi->workstn_tree);
 
 	grp = xa_tag_pointer(grp, tag);
 
 	/*
 	 * Bump up reference count before making this workgroup
 	 * visible to other users in order to avoid potential UAF
-	 * without serialized by erofs_workstn_lock.
+	 * without serialized by workstn_lock.
 	 */
 	__erofs_workgroup_get(grp);
 
@@ -122,7 +122,7 @@ int erofs_register_workgroup(struct super_block *sb,
 		 */
 		__erofs_workgroup_put(grp);
 
-	erofs_workstn_unlock(sbi);
+	xa_unlock(&sbi->workstn_tree);
 	radix_tree_preload_end();
 	return err;
 }
@@ -225,7 +225,7 @@ unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
 
 	int i, found;
 repeat:
-	erofs_workstn_lock(sbi);
+	xa_lock(&sbi->workstn_tree);
 
 	found = radix_tree_gang_lookup(&sbi->workstn_tree,
 				       batch, first_index, PAGEVEC_SIZE);
@@ -243,7 +243,7 @@ unsigned long erofs_shrink_workstation(struct erofs_sb_info *sbi,
 		if (unlikely(!--nr_shrink))
 			break;
 	}
-	erofs_workstn_unlock(sbi);
+	xa_unlock(&sbi->workstn_tree);
 
 	if (i && nr_shrink)
 		goto repeat;
-- 
2.17.1

