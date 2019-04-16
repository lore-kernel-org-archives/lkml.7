Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDAFC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B452087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbfDPR4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:56:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57678 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbfDPRxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:53:49 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hGSHD-0005ZN-FF; Tue, 16 Apr 2019 17:53:47 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 49/62] dax: make use of ->free_inode()
Date:   Tue, 16 Apr 2019 18:53:27 +0100
Message-Id: <20190416175340.21068-49-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416175340.21068-1-viro@ZenIV.linux.org.uk>
References: <20190416174900.GT2217@ZenIV.linux.org.uk>
 <20190416175340.21068-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

we might want to drop ->destroy_inode() there - it's used only for
WARN_ON() now, and AFAICS that could be moved to ->evict_inode()
if we had one...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/dax/super.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 0a339b85133e..bbd57ca0634a 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -412,11 +412,9 @@ static struct dax_device *to_dax_dev(struct inode *inode)
 	return container_of(inode, struct dax_device, inode);
 }
 
-static void dax_i_callback(struct rcu_head *head)
+static void dax_free_inode(struct inode *inode)
 {
-	struct inode *inode = container_of(head, struct inode, i_rcu);
 	struct dax_device *dax_dev = to_dax_dev(inode);
-
 	kfree(dax_dev->host);
 	dax_dev->host = NULL;
 	if (inode->i_rdev)
@@ -427,16 +425,15 @@ static void dax_i_callback(struct rcu_head *head)
 static void dax_destroy_inode(struct inode *inode)
 {
 	struct dax_device *dax_dev = to_dax_dev(inode);
-
 	WARN_ONCE(test_bit(DAXDEV_ALIVE, &dax_dev->flags),
 			"kill_dax() must be called before final iput()\n");
-	call_rcu(&inode->i_rcu, dax_i_callback);
 }
 
 static const struct super_operations dax_sops = {
 	.statfs = simple_statfs,
 	.alloc_inode = dax_alloc_inode,
 	.destroy_inode = dax_destroy_inode,
+	.free_inode = dax_free_inode,
 	.drop_inode = generic_delete_inode,
 };
 
-- 
2.11.0

