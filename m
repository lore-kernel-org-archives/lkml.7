Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1016FC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F6A2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117881;
	bh=F9T/FtYXnbbZzGASU5Trxu76QVW6WM1/e7VxBu3vtuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NjToPX0WyUilC8N6r8wNSVds2+n9wtW4h2a96Zk1JbYvfJeSgmM5na4tEu99zRSFx
	 GXhH4+Ma5twomQSd/XjiIJb2BowYcNgocmEsqYl4u0Be595XU9IomAqAMAC7J9CQ57
	 yVZF9xH+HUvoiMeo8JQgBG8ZBuUX0Ai8wKeepqwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733048AbfDXO6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:58:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731628AbfDXOrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:47:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4A5B218FD;
        Wed, 24 Apr 2019 14:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117266;
        bh=F9T/FtYXnbbZzGASU5Trxu76QVW6WM1/e7VxBu3vtuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pvNvq6dM4f0yRzWGNUfT6YQvmdet+be/UZSvSZ8yOvJAlDpo1gJhyLomUbq/XQxX7
         clGETf6Zdclg+BGR2tOcg/QZFnczy5PL0cfR8inpnYSgWd/xMBwSgHx7JMT7VJ5mqQ
         9n2kwn0BPbBVZYhkYU5lreDEqLFaSU8Pdy8rszgg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Sasha Levin <sashal@kernel.org>,
        linux-mtd@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 16/35] jffs2: fix use-after-free on symlink traversal
Date:   Wed, 24 Apr 2019 10:46:50 -0400
Message-Id: <20190424144709.30215-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424144709.30215-1-sashal@kernel.org>
References: <20190424144709.30215-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
index 83340496645b..9a9f30eddbbb 100644
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

