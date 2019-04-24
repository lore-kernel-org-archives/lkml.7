Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7708BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C43218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116507;
	bh=KyUK2gqzDF9Mot5ZtixrTjwo3of8+wqm6mhiVro5AH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZXHhtLDQxgp/5EPU3kms/WX2nymcA0fN+XagXjya+5d7V6h3x3gBvCpPW5XRY3WXA
	 5X8l9oH4iImjxyc4bqvNHWFcPwknE4q4J06mINaLjthXBIHFgQERhzRu9d9RISrcbz
	 hv3lRBxZNt90FdWMcPS2qgRcKHKV0g4RYnq5oUXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbfDXOfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731267AbfDXOfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:35:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 133DA21900;
        Wed, 24 Apr 2019 14:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116504;
        bh=KyUK2gqzDF9Mot5ZtixrTjwo3of8+wqm6mhiVro5AH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cM3pXvtm/rRXXIeU+bepEPB/XUVWbJm5GP5tm5Jv4TC05gcQiD5Ncmi3c90CPzFWH
         rOiGMg/P2VShCwncvP1mayCbuSYHJytEq/H0OfqDg5rdEDRyOGQTTo6lyg9kx2zs8M
         L/noiavD9JRfQZbMyYq8uVXjSJT0ZsLgweRhRZoY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Sasha Levin <sashal@kernel.org>,
        linux-mtd@lists.infradead.org
Subject: [PATCH AUTOSEL 5.0 33/66] jffs2: fix use-after-free on symlink traversal
Date:   Wed, 24 Apr 2019 10:33:07 -0400
Message-Id: <20190424143341.27665-33-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143341.27665-1-sashal@kernel.org>
References: <20190424143341.27665-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 4fdcfab5b5537c21891e22e65996d4d0dd8ab4ca ]

free the symlink body after the same RCU delay we have for freeing the
struct inode itself, so that traversal during RCU pathwalk wouldn't step
into freed memory.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 fs/jffs2/readinode.c | 5 -----
 fs/jffs2/super.c     | 5 ++++-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/jffs2/readinode.c b/fs/jffs2/readinode.c
index 389ea53ea487..bccfc40b3a74 100644
--- a/fs/jffs2/readinode.c
+++ b/fs/jffs2/readinode.c
@@ -1414,11 +1414,6 @@ void jffs2_do_clear_inode(struct jffs2_sb_info *c, struct jffs2_inode_info *f)
 
 	jffs2_kill_fragtree(&f->fragtree, deleted?c:NULL);
 
-	if (f->target) {
-		kfree(f->target);
-		f->target = NULL;
-	}
-
 	fds = f->dents;
 	while(fds) {
 		fd = fds;
diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index bb6ae387469f..05d892c79339 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -47,7 +47,10 @@ static struct inode *jffs2_alloc_inode(struct super_block *sb)
 static void jffs2_i_callback(struct rcu_head *head)
 {
 	struct inode *inode = container_of(head, struct inode, i_rcu);
-	kmem_cache_free(jffs2_inode_cachep, JFFS2_INODE_INFO(inode));
+	struct jffs2_inode_info *f = JFFS2_INODE_INFO(inode);
+
+	kfree(f->target);
+	kmem_cache_free(jffs2_inode_cachep, f);
 }
 
 static void jffs2_destroy_inode(struct inode *inode)
-- 
2.19.1

