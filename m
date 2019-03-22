Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6D2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B59F21934
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254479;
	bh=Ohw06WhEaAl7XqqGNpfuxEsao6piMaLebrJFIHPHMNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dpmK7czfyF+lDYNXzsm83Vk6k6cfp0hMsVIr0e2vW3gRluAv0WK1jkNtpg2w6I4bN
	 MuoePKsgUu1Ve8F2cQmK9kHMOuxz0Q7ZgiW4vq9smi22enCzT5W/WhANnu9JWBhDHA
	 tA8EkYAg0VPcBufamk3RvS2OTybZpHLcJ3XQypPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbfCVLei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:34:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730037AbfCVLef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:34:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DCEF21917;
        Fri, 22 Mar 2019 11:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254474;
        bh=Ohw06WhEaAl7XqqGNpfuxEsao6piMaLebrJFIHPHMNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cTVvWg83mxWtW3c+VMjXG5oMEHGOR1Z0cZ+YHhjdkvo0F93SbeTBw1Yyh4rfielph
         Jx7eQII7Fjm3dnw1nrIkEkKZT82Eq3YHsyMUgw0m2UxrEFuUmEpi2RJKy15kJIkPUj
         ZeTgGqQMXH8nOzLnhk0nC+eFhf83vbQ/tJaEJCRw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sasha.levin@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Emil Karlson <jkarlson@tuxera.com>
Subject: [PATCH 4.4 147/230] fs/9p: use fscache mutex rather than spinlock
Date:   Fri, 22 Mar 2019 12:14:45 +0100
Message-Id: <20190322111246.959130531@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sasha Levin <sasha.levin@oracle.com>

commit 8f5fed1e917588f946ad8882bd47a4093db0ff4c upstream.

We may sleep inside a the lock, so use a mutex rather than spinlock.

Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Cc: Emil Karlson <jkarlson@tuxera.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/9p/cache.c     |    8 ++++----
 fs/9p/v9fs.h      |    2 +-
 fs/9p/vfs_inode.c |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

--- a/fs/9p/cache.c
+++ b/fs/9p/cache.c
@@ -243,14 +243,14 @@ void v9fs_cache_inode_set_cookie(struct
 	if (!v9inode->fscache)
 		return;
 
-	spin_lock(&v9inode->fscache_lock);
+	mutex_lock(&v9inode->fscache_lock);
 
 	if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
 		v9fs_cache_inode_flush_cookie(inode);
 	else
 		v9fs_cache_inode_get_cookie(inode);
 
-	spin_unlock(&v9inode->fscache_lock);
+	mutex_unlock(&v9inode->fscache_lock);
 }
 
 void v9fs_cache_inode_reset_cookie(struct inode *inode)
@@ -264,7 +264,7 @@ void v9fs_cache_inode_reset_cookie(struc
 
 	old = v9inode->fscache;
 
-	spin_lock(&v9inode->fscache_lock);
+	mutex_lock(&v9inode->fscache_lock);
 	fscache_relinquish_cookie(v9inode->fscache, 1);
 
 	v9ses = v9fs_inode2v9ses(inode);
@@ -274,7 +274,7 @@ void v9fs_cache_inode_reset_cookie(struc
 	p9_debug(P9_DEBUG_FSC, "inode %p revalidating cookie old %p new %p\n",
 		 inode, old, v9inode->fscache);
 
-	spin_unlock(&v9inode->fscache_lock);
+	mutex_unlock(&v9inode->fscache_lock);
 }
 
 int __v9fs_fscache_release_page(struct page *page, gfp_t gfp)
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -123,7 +123,7 @@ struct v9fs_session_info {
 
 struct v9fs_inode {
 #ifdef CONFIG_9P_FSCACHE
-	spinlock_t fscache_lock;
+	struct mutex fscache_lock;
 	struct fscache_cookie *fscache;
 #endif
 	struct p9_qid qid;
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -244,7 +244,7 @@ struct inode *v9fs_alloc_inode(struct su
 		return NULL;
 #ifdef CONFIG_9P_FSCACHE
 	v9inode->fscache = NULL;
-	spin_lock_init(&v9inode->fscache_lock);
+	mutex_init(&v9inode->fscache_lock);
 #endif
 	v9inode->writeback_fid = NULL;
 	v9inode->cache_validity = 0;


