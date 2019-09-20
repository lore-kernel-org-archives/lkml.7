Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFF3C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3C020882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437506AbfITGyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:54:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52306 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388940AbfITGyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:54:52 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E8F15104D6EE93A55342;
        Fri, 20 Sep 2019 14:54:50 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Fri, 20 Sep 2019 14:54:42 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <dwmw2@infradead.org>, <dilinger@queued.net>, <richard@nod.at>,
        <houtao1@huawei.com>, <viro@zeniv.linux.org.uk>,
        <bbrezillon@kernel.org>, <daniel.santos@pobox.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <nixiaoming@huawei.com>
Subject: [PATCH] jffs2:freely allocate memory when parameters are invalid
Date:   Fri, 20 Sep 2019 14:54:38 +0800
Message-ID: <1568962478-126260-1-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kzalloc() to allocate memory in jffs2_fill_super().
Freeing memory when jffs2_parse_options() fails will cause
use-after-free and double-free in jffs2_kill_sb()

Reference: commit 92e2921f7eee6345 ("jffs2: free jffs2_sb_info through
 jffs2_kill_sb()")

This makes the code difficult to understand
the code path between memory allocation and free is too long

The reason for this problem is:
Before the jffs2_parse_options() check,
"sb->s_fs_info = c;" has been executed,
so jffs2_sb_info has been assigned to super_block.

we can move "sb->s_fs_info = c;" to the success branch of the
function jffs2_parse_options() and free jffs2_sb_info in the failure branch
make the code easier to understand.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 fs/jffs2/super.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index af4aa65..bbdae72 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -280,11 +280,13 @@ static int jffs2_fill_super(struct super_block *sb, void *data, int silent)
 
 	c->mtd = sb->s_mtd;
 	c->os_priv = sb;
-	sb->s_fs_info = c;
 
 	ret = jffs2_parse_options(c, data);
-	if (ret)
+	if (ret) {
+		kfree(c);
 		return -EINVAL;
+	}
+	sb->s_fs_info = c;
 
 	/* Initialize JFFS2 superblock locks, the further initialization will
 	 * be done later */
-- 
1.8.5.6

