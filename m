Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551A3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2651B2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257860;
	bh=Hx0bkBdvuhlnnCiHmrgqAIyv2QbbSqanMWsD7GZ2mmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mEKF7YYPiPb7xFKDaDcA98DV8RwDogtraz58gKd+oRxKbpZTiq3T4R2W9byD/jXKO
	 vSXGPLn1IFdY79bF04F3ZVa8MrDssBT0sLFvtToDR23VL8rtn8prUKH8x5Xb5A7xPE
	 NaJO+fvVfRqIsxmnbJwkPyArC1yuTG4x0ETmgvEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390431AbfCVMRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:17:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389940AbfCVMRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:17:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4693B2082C;
        Fri, 22 Mar 2019 12:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257069;
        bh=Hx0bkBdvuhlnnCiHmrgqAIyv2QbbSqanMWsD7GZ2mmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qzY2KOspswp81ZDev/gHofKBKm5VzS00NWnxfr8NkFcI2ocn+NbaCTaabUD1WqyHq
         8JpPW4yrk1INW8IwWwCnFjNylWCL4KxhB/2kY/3+HIuZnsrhHojAxSIG0lCDzTHt+8
         6+mz/fYZBNvTM71bgkDC8rGIgyfkh3ZJvNWU3yWw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, yangerkun <yangerkun@huawei.com>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 5.0 121/238] ext4: update quota information while swapping boot loader inode
Date:   Fri, 22 Mar 2019 12:15:40 +0100
Message-Id: <20190322111305.677644877@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: yangerkun <yangerkun@huawei.com>

commit aa507b5faf38784defe49f5e64605ac3c4425e26 upstream.

While do swap between two inode, they swap i_data without update
quota information. Also, swap_inode_boot_loader can do "revert"
somtimes, so update the quota while all operations has been finished.

Signed-off-by: yangerkun <yangerkun@huawei.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/ioctl.c |   56 +++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 13 deletions(-)

--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -68,8 +68,6 @@ static void swap_inode_data(struct inode
 	ei2 = EXT4_I(inode2);
 
 	swap(inode1->i_version, inode2->i_version);
-	swap(inode1->i_blocks, inode2->i_blocks);
-	swap(inode1->i_bytes, inode2->i_bytes);
 	swap(inode1->i_atime, inode2->i_atime);
 	swap(inode1->i_mtime, inode2->i_mtime);
 
@@ -115,6 +113,9 @@ static long swap_inode_boot_loader(struc
 	int err;
 	struct inode *inode_bl;
 	struct ext4_inode_info *ei_bl;
+	qsize_t size, size_bl, diff;
+	blkcnt_t blocks;
+	unsigned short bytes;
 
 	inode_bl = ext4_iget(sb, EXT4_BOOT_LOADER_INO, EXT4_IGET_SPECIAL);
 	if (IS_ERR(inode_bl))
@@ -180,6 +181,13 @@ static long swap_inode_boot_loader(struc
 			memset(ei_bl->i_data, 0, sizeof(ei_bl->i_data));
 	}
 
+	err = dquot_initialize(inode);
+	if (err)
+		goto err_out1;
+
+	size = (qsize_t)(inode->i_blocks) * (1 << 9) + inode->i_bytes;
+	size_bl = (qsize_t)(inode_bl->i_blocks) * (1 << 9) + inode_bl->i_bytes;
+	diff = size - size_bl;
 	swap_inode_data(inode, inode_bl);
 
 	inode->i_ctime = inode_bl->i_ctime = current_time(inode);
@@ -193,24 +201,46 @@ static long swap_inode_boot_loader(struc
 
 	err = ext4_mark_inode_dirty(handle, inode);
 	if (err < 0) {
+		/* No need to update quota information. */
 		ext4_warning(inode->i_sb,
 			"couldn't mark inode #%lu dirty (err %d)",
 			inode->i_ino, err);
 		/* Revert all changes: */
 		swap_inode_data(inode, inode_bl);
 		ext4_mark_inode_dirty(handle, inode);
-	} else {
-		err = ext4_mark_inode_dirty(handle, inode_bl);
-		if (err < 0) {
-			ext4_warning(inode_bl->i_sb,
-				"couldn't mark inode #%lu dirty (err %d)",
-				inode_bl->i_ino, err);
-			/* Revert all changes: */
-			swap_inode_data(inode, inode_bl);
-			ext4_mark_inode_dirty(handle, inode);
-			ext4_mark_inode_dirty(handle, inode_bl);
-		}
+		goto err_out1;
+	}
+
+	blocks = inode_bl->i_blocks;
+	bytes = inode_bl->i_bytes;
+	inode_bl->i_blocks = inode->i_blocks;
+	inode_bl->i_bytes = inode->i_bytes;
+	err = ext4_mark_inode_dirty(handle, inode_bl);
+	if (err < 0) {
+		/* No need to update quota information. */
+		ext4_warning(inode_bl->i_sb,
+			"couldn't mark inode #%lu dirty (err %d)",
+			inode_bl->i_ino, err);
+		goto revert;
+	}
+
+	/* Bootloader inode should not be counted into quota information. */
+	if (diff > 0)
+		dquot_free_space(inode, diff);
+	else
+		err = dquot_alloc_space(inode, -1 * diff);
+
+	if (err < 0) {
+revert:
+		/* Revert all changes: */
+		inode_bl->i_blocks = blocks;
+		inode_bl->i_bytes = bytes;
+		swap_inode_data(inode, inode_bl);
+		ext4_mark_inode_dirty(handle, inode);
+		ext4_mark_inode_dirty(handle, inode_bl);
 	}
+
+err_out1:
 	ext4_journal_stop(handle);
 	ext4_double_up_write_data_sem(inode, inode_bl);
 


