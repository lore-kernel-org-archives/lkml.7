Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F37C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308FE2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbfDBNkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:40:16 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43114 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731413AbfDBNkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:04 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdw-0002nu-NC; Tue, 02 Apr 2019 14:40:01 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdv-0004tL-Nk; Tue, 02 Apr 2019 14:39:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Chris Mason" <clm@fb.com>, "Miao Xie" <miaoxie@huawei.com>,
        "Yang Dongsheng" <yangds.fnst@cn.fujitsu.com>
Date:   Tue, 02 Apr 2019 14:38:27 +0100
Message-ID: <lsq.1554212307.662996047@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 36/99] Btrfs: fill ->last_trans for delayed inode in
 btrfs_fill_inode.
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Dongsheng <yangds.fnst@cn.fujitsu.com>

commit 6e17d30bfaf43e04d991392d8484f1c556810c33 upstream.

We need to fill inode when we found a node for it in delayed_nodes_tree.
But we did not fill the ->last_trans currently, it will cause the test
of xfstest/generic/311 fail. Scenario of the 311 is shown as below:

Problem:
	(1). test_fd = open(fname, O_RDWR|O_DIRECT)
	(2). pwrite(test_fd, buf, 4096, 0)
	(3). close(test_fd)
	(4). drop_all_caches()	<-------- "echo 3 > /proc/sys/vm/drop_caches"
	(5). test_fd = open(fname, O_RDWR|O_DIRECT)
	(6). fsync(test_fd);
				<-------- we did not get the correct log entry for the file
Reason:
	When we re-open this file in (5), we would find a node
in delayed_nodes_tree and fill the inode we are lookup with the
information. But the ->last_trans is not filled, then the fsync()
will check the ->last_trans and found it's 0 then say this inode
is already in our tree which is commited, not recording the extents
for it.

Fix:
	This patch fill the ->last_trans properly and set the
runtime_flags if needed in this situation. Then we can get the
log entries we expected after (6) and generic/311 passed.

Signed-off-by: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
Reviewed-by: Miao Xie <miaoxie@huawei.com>
Signed-off-by: Chris Mason <clm@fb.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/delayed-inode.c |  2 ++
 fs/btrfs/inode.c         | 21 ++++++++++++---------
 2 files changed, 14 insertions(+), 9 deletions(-)

--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1801,6 +1801,8 @@ int btrfs_fill_inode(struct inode *inode
 	set_nlink(inode, btrfs_stack_inode_nlink(inode_item));
 	inode_set_bytes(inode, btrfs_stack_inode_nbytes(inode_item));
 	BTRFS_I(inode)->generation = btrfs_stack_inode_generation(inode_item);
+        BTRFS_I(inode)->last_trans = btrfs_stack_inode_transid(inode_item);
+
 	inode->i_version = btrfs_stack_inode_sequence(inode_item);
 	inode->i_rdev = 0;
 	*rdev = btrfs_stack_inode_rdev(inode_item);
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3511,25 +3511,28 @@ static void btrfs_read_locked_inode(stru
 	BTRFS_I(inode)->generation = btrfs_inode_generation(leaf, inode_item);
 	BTRFS_I(inode)->last_trans = btrfs_inode_transid(leaf, inode_item);
 
+	inode->i_version = btrfs_inode_sequence(leaf, inode_item);
+	inode->i_generation = BTRFS_I(inode)->generation;
+	inode->i_rdev = 0;
+	rdev = btrfs_inode_rdev(leaf, inode_item);
+
+	BTRFS_I(inode)->index_cnt = (u64)-1;
+	BTRFS_I(inode)->flags = btrfs_inode_flags(leaf, inode_item);
+
+cache_index:
 	/*
 	 * If we were modified in the current generation and evicted from memory
 	 * and then re-read we need to do a full sync since we don't have any
 	 * idea about which extents were modified before we were evicted from
 	 * cache.
+	 *
+	 * This is required for both inode re-read from disk and delayed inode
+	 * in delayed_nodes_tree.
 	 */
 	if (BTRFS_I(inode)->last_trans == root->fs_info->generation)
 		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
 			&BTRFS_I(inode)->runtime_flags);
 
-	inode->i_version = btrfs_inode_sequence(leaf, inode_item);
-	inode->i_generation = BTRFS_I(inode)->generation;
-	inode->i_rdev = 0;
-	rdev = btrfs_inode_rdev(leaf, inode_item);
-
-	BTRFS_I(inode)->index_cnt = (u64)-1;
-	BTRFS_I(inode)->flags = btrfs_inode_flags(leaf, inode_item);
-
-cache_index:
 	path->slots[0]++;
 	if (inode->i_nlink != 1 ||
 	    path->slots[0] >= btrfs_header_nritems(leaf))

