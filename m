Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7F9C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77235208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 15:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfCHPfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 10:35:09 -0500
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:49908 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfCHPfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 10:35:08 -0500
Received: from ios.cs.uni-dortmund.de (ios.cs.uni-dortmund.de [129.217.43.100])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.0.29/8.16.0.41) with ESMTPSA id x28F4lga021937
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 8 Mar 2019 16:05:03 +0100 (CET)
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Lochmann <alexander.lochmann@tu-dortmund.de>,
        Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
Subject: [PATCH 1/1] Updated locking documentation for struct inode
Date:   Fri,  8 Mar 2019 16:04:47 +0100
Message-Id: <20190308150447.96311-1-alexander.lochmann@tu-dortmund.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used LockDoc to derive locking rules for each member
of struct inode.
Based on those results, we extended the existing documentation
by more members of struct inode, and updated the existing
documentation.

Signed-off-by: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Signed-off-by: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
---
 fs/inode.c         | 49 ++++++++++++++++++++++++++++++++++++----------
 include/linux/fs.h |  2 +-
 2 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 0cd47fe0dbe5..ade9d3aa1ada 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -24,17 +24,46 @@
 
 /*
  * Inode locking rules:
+ * (Documentation improved by LockDoc)
  *
- * inode->i_lock protects:
- *   inode->i_state, inode->i_hash, __iget()
- * Inode LRU list locks protect:
- *   inode->i_sb->s_inode_lru, inode->i_lru
- * inode->i_sb->s_inode_list_lock protects:
- *   inode->i_sb->s_inodes, inode->i_sb_list
- * bdi->wb.list_lock protects:
- *   bdi->wb.b_{dirty,io,more_io,dirty_time}, inode->i_io_list
- * inode_hash_lock protects:
- *   inode_hashtable, inode->i_hash
+ * No locks needed for:
+ *   i_data.a_ops, i_data.nrexceptional, i_rdev, i_data.gfp_mask,
+ *   i_generation, i_security, i_nlink, __i_nlink, i_flctx,
+ *   i_size, i_atime, i_mtime, i_data.host, i_sb
+ *
+ * backing_dev_info.wb.list_lock protects:
+ *   dirtied_when, i_io_list
+ *
+ * inode.i_rwsem protects:
+ *   i_flags, i_uid, i_gid, i_version, i_ctime, i_size_seqcount
+ *
+ * inode.i_rwsem -> rcu protects:
+ *   i_default_acl
+ *
+ * block_device.bd_mutex protects:
+ *   i_blkbits
+ *
+ * cdev_lock protects:
+ *   i_cdev, i_devices
+ *
+ * inode.i_data.i_mmap_rwsem protects:
+ *   i_data.i_mmap, i_data.i_mmap
+ *
+ * hardirq -> inode.i_data.tree_lock protects:
+ *   i_data.page_tree, i_wb_list, i_data.nrpages
+ *
+ * hardirq -> super_block.s_inode_wblist_lock protects:
+ *   i_wb_list
+ *
+ * inode.i_lock protects:
+ *   i_pipe, i_fsnotify_mask, i_fsnotify_marks, i_blocks, i_opflags,
+ *   i_state, i_bytes
+ *
+ * super_block.s_inode_list_lock protects:
+ *   i_sb_list
+ *
+ * inode_hash_lock -> inode.i_lock protects:
+ *   i_hash
  *
  * Lock ordering:
  *
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 92966678539d..744e2a817ad3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -639,7 +639,7 @@ struct inode {
 	struct timespec64	i_atime;
 	struct timespec64	i_mtime;
 	struct timespec64	i_ctime;
-	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
+	spinlock_t		i_lock;
 	unsigned short          i_bytes;
 	u8			i_blkbits;
 	u8			i_write_hint;
-- 
2.20.1

