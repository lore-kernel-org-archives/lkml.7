Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30928C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040F820661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050477;
	bh=cmRrDCP0yk410vOws96NOfIwetHIayultEdjCOMilEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xmotNKLqDVQEInrOt2+3WNHzw+Kgmyyu4B4oABB884FPdvNnVE+rhBekrRQ7QFGsA
	 zfUmvLobET0gbXnDkVMKcWE8oJt87tZG4ephf20x/VsDpcaeeGJRqzVk2QIXMegnD9
	 +8/qG522ULbOIhj1mfXtxuX1PQGkY7P+7QOyOuxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfCHMxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:53:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:57236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727167AbfCHMxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:53:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAFF52085A;
        Fri,  8 Mar 2019 12:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049613;
        bh=cmRrDCP0yk410vOws96NOfIwetHIayultEdjCOMilEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EPXt2I+jWgZAVOnbK7xiI5t49M6hmm/v5mfJoxsB7mAS8JZQBCOW8xOU0zL70PcFP
         9T2CopolIcNYyrDJxVOdncwTk8Nat6vut+zPuDL2hUkSmBqcRERTQWkyqxRqNPPcAZ
         pJUEIPRjAhGoTznv82rKWOF2LqgdFT5lTBhJ8MNo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 4.20 10/76] staging: erofs: fix race of initializing xattrs of a inode at the same time
Date:   Fri,  8 Mar 2019 13:49:22 +0100
Message-Id: <20190308124915.149162065@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
References: <20190308124914.789210760@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <gaoxiang25@huawei.com>

commit 62dc45979f3f8cb0ea67302a93bff686f0c46c5a upstream.

In real scenario, there could be several threads accessing xattrs
of the same xattr-uninitialized inode, and init_inode_xattrs()
almost at the same time.

That's actually an unexpected behavior, this patch closes the race.

Fixes: b17500a0fdba ("staging: erofs: introduce xattr & acl support")
Cc: <stable@vger.kernel.org> # 4.19+
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/erofs/internal.h |   11 +++++++---
 drivers/staging/erofs/xattr.c    |   41 +++++++++++++++++++++++++++------------
 2 files changed, 37 insertions(+), 15 deletions(-)

--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -352,12 +352,17 @@ static inline erofs_off_t iloc(struct er
 	return blknr_to_addr(sbi->meta_blkaddr) + (nid << sbi->islotbits);
 }
 
-#define inode_set_inited_xattr(inode)   (EROFS_V(inode)->flags |= 1)
-#define inode_has_inited_xattr(inode)   (EROFS_V(inode)->flags & 1)
+/* atomic flag definitions */
+#define EROFS_V_EA_INITED_BIT	0
+
+/* bitlock definitions (arranged in reverse order) */
+#define EROFS_V_BL_XATTR_BIT	(BITS_PER_LONG - 1)
 
 struct erofs_vnode {
 	erofs_nid_t nid;
-	unsigned int flags;
+
+	/* atomic flags (including bitlocks) */
+	unsigned long flags;
 
 	unsigned char data_mapping_mode;
 	/* inline size in bytes */
--- a/drivers/staging/erofs/xattr.c
+++ b/drivers/staging/erofs/xattr.c
@@ -44,18 +44,25 @@ static inline void xattr_iter_end_final(
 
 static int init_inode_xattrs(struct inode *inode)
 {
+	struct erofs_vnode *const vi = EROFS_V(inode);
 	struct xattr_iter it;
 	unsigned int i;
 	struct erofs_xattr_ibody_header *ih;
 	struct super_block *sb;
 	struct erofs_sb_info *sbi;
-	struct erofs_vnode *vi;
 	bool atomic_map;
+	int ret = 0;
 
-	if (likely(inode_has_inited_xattr(inode)))
+	/* the most case is that xattrs of this inode are initialized. */
+	if (test_bit(EROFS_V_EA_INITED_BIT, &vi->flags))
 		return 0;
 
-	vi = EROFS_V(inode);
+	if (wait_on_bit_lock(&vi->flags, EROFS_V_BL_XATTR_BIT, TASK_KILLABLE))
+		return -ERESTARTSYS;
+
+	/* someone has initialized xattrs for us? */
+	if (test_bit(EROFS_V_EA_INITED_BIT, &vi->flags))
+		goto out_unlock;
 
 	/*
 	 * bypass all xattr operations if ->xattr_isize is not greater than
@@ -68,13 +75,16 @@ static int init_inode_xattrs(struct inod
 	if (vi->xattr_isize == sizeof(struct erofs_xattr_ibody_header)) {
 		errln("xattr_isize %d of nid %llu is not supported yet",
 		      vi->xattr_isize, vi->nid);
-		return -ENOTSUPP;
+		ret = -ENOTSUPP;
+		goto out_unlock;
 	} else if (vi->xattr_isize < sizeof(struct erofs_xattr_ibody_header)) {
 		if (unlikely(vi->xattr_isize)) {
 			DBG_BUGON(1);
-			return -EIO;	/* xattr ondisk layout error */
+			ret = -EIO;
+			goto out_unlock;	/* xattr ondisk layout error */
 		}
-		return -ENOATTR;
+		ret = -ENOATTR;
+		goto out_unlock;
 	}
 
 	sb = inode->i_sb;
@@ -83,8 +93,10 @@ static int init_inode_xattrs(struct inod
 	it.ofs = erofs_blkoff(iloc(sbi, vi->nid) + vi->inode_isize);
 
 	it.page = erofs_get_inline_page(inode, it.blkaddr);
-	if (IS_ERR(it.page))
-		return PTR_ERR(it.page);
+	if (IS_ERR(it.page)) {
+		ret = PTR_ERR(it.page);
+		goto out_unlock;
+	}
 
 	/* read in shared xattr array (non-atomic, see kmalloc below) */
 	it.kaddr = kmap(it.page);
@@ -97,7 +109,8 @@ static int init_inode_xattrs(struct inod
 						sizeof(uint), GFP_KERNEL);
 	if (vi->xattr_shared_xattrs == NULL) {
 		xattr_iter_end(&it, atomic_map);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out_unlock;
 	}
 
 	/* let's skip ibody header */
@@ -114,7 +127,8 @@ static int init_inode_xattrs(struct inod
 			if (IS_ERR(it.page)) {
 				kfree(vi->xattr_shared_xattrs);
 				vi->xattr_shared_xattrs = NULL;
-				return PTR_ERR(it.page);
+				ret = PTR_ERR(it.page);
+				goto out_unlock;
 			}
 
 			it.kaddr = kmap_atomic(it.page);
@@ -127,8 +141,11 @@ static int init_inode_xattrs(struct inod
 	}
 	xattr_iter_end(&it, atomic_map);
 
-	inode_set_inited_xattr(inode);
-	return 0;
+	set_bit(EROFS_V_EA_INITED_BIT, &vi->flags);
+
+out_unlock:
+	clear_and_wake_up_bit(EROFS_V_BL_XATTR_BIT, &vi->flags);
+	return ret;
 }
 
 /*


