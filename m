Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A43C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3792148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfDXA7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 20:59:32 -0400
Received: from mail2.tencent.com ([163.177.67.195]:50596 "EHLO
        mail2.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbfDXA7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 20:59:32 -0400
Received: from EXHUB-SZMail01.tencent.com (unknown [10.14.6.21])
        by mail2.tencent.com (Postfix) with ESMTP id 007CC8EA23;
        Wed, 24 Apr 2019 08:59:30 +0800 (CST)
Received: from localhost.localdomain (10.35.10.36) by
 EXHUB-SZMail01.tencent.com (10.14.6.21) with Microsoft SMTP Server id
 14.3.408.0; Wed, 24 Apr 2019 08:59:29 +0800
From:   Jiang Biao <benbjiang@tencent.com>
To:     <jack@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <benbjiang@tencent.com>
Subject: [PATCH] fs/quota: erase unused but set variable warning
Date:   Wed, 24 Apr 2019 08:58:57 +0800
Message-ID: <20190424005857.82284-1-benbjiang@tencent.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.35.10.36]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Local variable *reserved* of remove_dquot_ref() is only used if
define CONFIG_QUOTA_DEBUG, but not ebraced in CONFIG_QUOTA_DEBUG
macro, which leads to unused-but-set-variable warning when compiling.

This patch ebrace it into CONFIG_QUOTA_DEBUG macro like what is done
in add_dquot_ref().

Signed-off-by: Jiang Biao <benbjiang@tencent.com>
---
 fs/quota/dquot.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index fc20e06c56ba..14ee4c6deba1 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -1049,7 +1049,9 @@ static void remove_dquot_ref(struct super_block *sb, int type,
 		struct list_head *tofree_head)
 {
 	struct inode *inode;
+#ifdef CONFIG_QUOTA_DEBUG
 	int reserved = 0;
+#endif
 
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
@@ -1061,8 +1063,10 @@ static void remove_dquot_ref(struct super_block *sb, int type,
 		 */
 		spin_lock(&dq_data_lock);
 		if (!IS_NOQUOTA(inode)) {
+#ifdef CONFIG_QUOTA_DEBUG
 			if (unlikely(inode_get_rsv_space(inode) > 0))
 				reserved = 1;
+#endif
 			remove_inode_dquot_ref(inode, type, tofree_head);
 		}
 		spin_unlock(&dq_data_lock);
-- 
2.17.2 (Apple Git-113)

