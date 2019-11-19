Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9FEC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A6620872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574143274;
	bh=CblsfOa4ImQQFEaNqUn3K8K/yi1ZGlhGRYKFVXGUr8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DW1zMOXdbrPrB2lWfsrrrHBSCBux2k0NzHOmMErtZmIde7r8JRstwHG8XbF52vW7I
	 obJGC2qxcWHZWaTHn46QM9495cXCOpLJBAdn4oza8HqFKqf09lD4hCBnBar/Y/zXWI
	 eU9/qHnI2qzWGX9WLPQkUprhNISPLafDDucgO28Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfKSGBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 01:01:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730841AbfKSFoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:44:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0238B208C3;
        Tue, 19 Nov 2019 05:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142264;
        bh=CblsfOa4ImQQFEaNqUn3K8K/yi1ZGlhGRYKFVXGUr8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N5gLBJcBI9V2//AmAyk6a3aCIY05IOt6YVYwNTMJ7hOIxaD/98TObdJRVelK/bChT
         /7vIh5Rbprpve2PZJignMWtGXBYas3iyBcY+LgIL736f0yYWzL6pLhgVS0mC2xtc3L
         P/y+hYL8vPPKlrBVqqfc+/M51Eu4ieK8FZ2y4DUs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.14 022/239] ecryptfs_lookup_interpose(): lower_dentry->d_inode is not stable
Date:   Tue, 19 Nov 2019 06:17:02 +0100
Message-Id: <20191119051301.789712716@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

commit e72b9dd6a5f17d0fb51f16f8685f3004361e83d0 upstream.

lower_dentry can't go from positive to negative (we have it pinned),
but it *can* go from negative to positive.  So fetching ->d_inode
into a local variable, doing a blocking allocation, checking that
now ->d_inode is non-NULL and feeding the value we'd fetched
earlier to a function that won't accept NULL is not a good idea.

Cc: stable@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ecryptfs/inode.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -326,7 +326,7 @@ static int ecryptfs_i_size_read(struct d
 static struct dentry *ecryptfs_lookup_interpose(struct dentry *dentry,
 				     struct dentry *lower_dentry)
 {
-	struct inode *inode, *lower_inode = d_inode(lower_dentry);
+	struct inode *inode, *lower_inode;
 	struct ecryptfs_dentry_info *dentry_info;
 	struct vfsmount *lower_mnt;
 	int rc = 0;
@@ -349,7 +349,15 @@ static struct dentry *ecryptfs_lookup_in
 	dentry_info->lower_path.mnt = lower_mnt;
 	dentry_info->lower_path.dentry = lower_dentry;
 
-	if (d_really_is_negative(lower_dentry)) {
+	/*
+	 * negative dentry can go positive under us here - its parent is not
+	 * locked.  That's OK and that could happen just as we return from
+	 * ecryptfs_lookup() anyway.  Just need to be careful and fetch
+	 * ->d_inode only once - it's not stable here.
+	 */
+	lower_inode = READ_ONCE(lower_dentry->d_inode);
+
+	if (!lower_inode) {
 		/* We want to add because we couldn't find in lower */
 		d_add(dentry, NULL);
 		return NULL;


