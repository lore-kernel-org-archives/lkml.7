Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70499C2D0CE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 09:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D00F2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 09:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfL3JmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 04:42:00 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:37368 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727162AbfL3JmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 04:42:00 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BC6A7B9F093DF35E5D34;
        Mon, 30 Dec 2019 17:41:57 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Mon, 30 Dec 2019 17:41:51 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix memleak of kobject
Date:   Mon, 30 Dec 2019 17:41:41 +0800
Message-ID: <20191230094141.14141-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If kobject_init_and_add() failed, caller needs to invoke kobject_put()
to release kobject explicitly.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/sysfs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index f698ec883034..5152a7487335 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -740,10 +740,12 @@ int __init f2fs_init_sysfs(void)
 
 	ret = kobject_init_and_add(&f2fs_feat, &f2fs_feat_ktype,
 				   NULL, "features");
-	if (ret)
+	if (ret) {
+		kobject_put(&f2fs_feat);
 		kset_unregister(&f2fs_kset);
-	else
+	} else {
 		f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
+	}
 	return ret;
 }
 
@@ -764,8 +766,11 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 	init_completion(&sbi->s_kobj_unregister);
 	err = kobject_init_and_add(&sbi->s_kobj, &f2fs_sb_ktype, NULL,
 				"%s", sb->s_id);
-	if (err)
+	if (err) {
+		kobject_put(&sbi->s_kobj);
+		wait_for_completion(&sbi->s_kobj_unregister);
 		return err;
+	}
 
 	if (f2fs_proc_root)
 		sbi->s_proc = proc_mkdir(sb->s_id, f2fs_proc_root);
-- 
2.18.0.rc1

