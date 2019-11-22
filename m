Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EB4C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E937A2071F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419144;
	bh=jHCaCThgU4X31QvfveZ85LoX6zHx6CKBd0KHw9g/OJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zVEg6ecYQdEx5xCyhtj+wzeWRlQMkx59l6jLqem79d3qCquxlgwvCjqgcdB8qC7dM
	 WVwLkMTJzXuQb9iguPmVh1+sLyaHA7Q0qz5fYzxIhQLCVruieD5XtsK2wa9ylvfnnx
	 NY10AIkh/6Qy56OumnR/vMQaAJMsBcK2vyjGsua8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfKVKjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:39:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:41730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728729AbfKVKi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:38:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2424620718;
        Fri, 22 Nov 2019 10:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419138;
        bh=jHCaCThgU4X31QvfveZ85LoX6zHx6CKBd0KHw9g/OJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G/cXFOo0DaaFfRe9kBZ8NkXsybmcKAr0ozgEKgnpVrp0hHLX+w+ly/r3OE9S6S0VR
         C32DA9Thhud/O4ghKtbaKdSqXbSMcKE/rpeSwfpBlfrqLfzGSXRTk4ZEzwHGhToeSk
         AHNCfhAETL3gokvubJ6WkflZkG0gd7LKLPfigKcs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.9 011/222] ecryptfs_lookup_interpose(): lower_dentry->d_parent is not stable either
Date:   Fri, 22 Nov 2019 11:25:51 +0100
Message-Id: <20191122100832.981895986@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

commit 762c69685ff7ad5ad7fee0656671e20a0c9c864d upstream.

We need to get the underlying dentry of parent; sure, absent the races
it is the parent of underlying dentry, but there's nothing to prevent
losing a timeslice to preemtion in the middle of evaluation of
lower_dentry->d_parent->d_inode, having another process move lower_dentry
around and have its (ex)parent not pinned anymore and freed on memory
pressure.  Then we regain CPU and try to fetch ->d_inode from memory
that is freed by that point.

dentry->d_parent *is* stable here - it's an argument of ->lookup() and
we are guaranteed that it won't be moved anywhere until we feed it
to d_add/d_splice_alias.  So we safely go that way to get to its
underlying dentry.

Cc: stable@vger.kernel.org # since 2009 or so
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ecryptfs/inode.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -326,9 +326,9 @@ static int ecryptfs_i_size_read(struct d
 static struct dentry *ecryptfs_lookup_interpose(struct dentry *dentry,
 				     struct dentry *lower_dentry)
 {
+	struct path *path = ecryptfs_dentry_to_lower_path(dentry->d_parent);
 	struct inode *inode, *lower_inode;
 	struct ecryptfs_dentry_info *dentry_info;
-	struct vfsmount *lower_mnt;
 	int rc = 0;
 
 	dentry_info = kmem_cache_alloc(ecryptfs_dentry_info_cache, GFP_KERNEL);
@@ -340,13 +340,12 @@ static struct dentry *ecryptfs_lookup_in
 		return ERR_PTR(-ENOMEM);
 	}
 
-	lower_mnt = mntget(ecryptfs_dentry_to_lower_mnt(dentry->d_parent));
 	fsstack_copy_attr_atime(d_inode(dentry->d_parent),
-				d_inode(lower_dentry->d_parent));
+				d_inode(path->dentry));
 	BUG_ON(!d_count(lower_dentry));
 
 	ecryptfs_set_dentry_private(dentry, dentry_info);
-	dentry_info->lower_path.mnt = lower_mnt;
+	dentry_info->lower_path.mnt = mntget(path->mnt);
 	dentry_info->lower_path.dentry = lower_dentry;
 
 	/*


