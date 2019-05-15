Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B5AC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0E221773
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557918422;
	bh=bwHylVj0ErEJHQPF8euYO/g3Rci2yeuJf2Agq0D/d+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wKW9nz5n+ew6wCV19v5r21V0DDcFBMAo7wgJ/ZzByNiaSJn44iWvMXI20PipAfqLp
	 7M6MSnsOQF0yJYvNGK6ytheGjY+bxbUhWs4htF40R2MZjHXO5SZjlQ96V1t7J5vFlL
	 O9gkvu4k63Ux08Xcrt7JaVhdE375Dv6NsaNftkzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfEOLHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:07:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728831AbfEOLG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:06:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD0E821743;
        Wed, 15 May 2019 11:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918417;
        bh=bwHylVj0ErEJHQPF8euYO/g3Rci2yeuJf2Agq0D/d+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rFK0jHEgK0zNNG2hXEXPUHyHcsmMphG2HpgIK2lAhDFI8OrNLuc0TT2vEF2t8FAFL
         O1Ddhq317js7FUPv2uSdr9PXD1YdEpPohEvSDPBxyssvhCzBp69y5rRoBeCcNt77hR
         FexGzEqGTjyyiDrXvJBnynpMJ6jA11WUXPl4zcRY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 124/266] jffs2: fix use-after-free on symlink traversal
Date:   Wed, 15 May 2019 12:53:51 +0200
Message-Id: <20190515090726.906825560@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090722.696531131@linuxfoundation.org>
References: <20190515090722.696531131@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.20.1



