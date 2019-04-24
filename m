Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FA5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FC7218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117684;
	bh=hmYdW0izHINJYOBHn2L29UUICnSc1+fXNT5o+jFrU9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bqHwoAfOzgGl685Jot79U/W1dKoSOGsgUYNm0KE+GJ2IHhtxTDxDjfeYsXZPY9goN
	 LvAQR5ozH32O/M5KiMOTb3WUhlzPwcyLlCrwrx7a24z6Eil0gf7A3pkJP4NV01qDec
	 Mxcmv909o8YRzIkippU83XEnCqMxF0PbvnKB1MmY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732889AbfDXOyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:54:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732365AbfDXOwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:52:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65201218FC;
        Wed, 24 Apr 2019 14:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117526;
        bh=hmYdW0izHINJYOBHn2L29UUICnSc1+fXNT5o+jFrU9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O5E4WQ0oJBb7K0+XQQFeTv1pv74HEaomiFIK0I1Dr4ijUraFxhEkWoOMrGTm9UxEQ
         p0zcUXrSSqzJvzE2394S9qRmUS+K2uWdyCmTTifs9JtcV2X4rwL10zzmXw+J9o0WYP
         IW360PipLFRemvIOSMdxfJmrIwHUZaZAjWMiV0g8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Sasha Levin <sashal@kernel.org>,
        linux-mtd@lists.infradead.org
Subject: [PATCH AUTOSEL 4.4 05/15] jffs2: fix use-after-free on symlink traversal
Date:   Wed, 24 Apr 2019 10:51:42 -0400
Message-Id: <20190424145152.31351-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424145152.31351-1-sashal@kernel.org>
References: <20190424145152.31351-1-sashal@kernel.org>
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
index bfebbf13698c..5b52ea41b84f 100644
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
index 023e7f32ee1b..9fc297df8c75 100644
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

