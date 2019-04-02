Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65967C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409B02146E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732267AbfDBNr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:47:59 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42990 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731301AbfDBNkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:03 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdw-0002o0-Lf; Tue, 02 Apr 2019 14:40:01 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdv-0004tU-Sc; Tue, 02 Apr 2019 14:39:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Vijay Chidambaram" <vvijay03@gmail.com>,
        "Filipe Manana" <fdmanana@suse.com>,
        "David Sterba" <dsterba@suse.com>,
        "Jayashree Mohan" <jayashree2912@gmail.com>
Date:   Tue, 02 Apr 2019 14:38:27 +0100
Message-ID: <lsq.1554212307.812106934@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 38/99] Btrfs: fix fsync of files with multiple hard
 links in new directories
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

From: Filipe Manana <fdmanana@suse.com>

commit 41bd60676923822de1df2c50b3f9a10171f4338a upstream.

The log tree has a long standing problem that when a file is fsync'ed we
only check for new ancestors, created in the current transaction, by
following only the hard link for which the fsync was issued. We follow the
ancestors using the VFS' dget_parent() API. This means that if we create a
new link for a file in a directory that is new (or in an any other new
ancestor directory) and then fsync the file using an old hard link, we end
up not logging the new ancestor, and on log replay that new hard link and
ancestor do not exist. In some cases, involving renames, the file will not
exist at all.

Example:

  mkfs.btrfs -f /dev/sdb
  mount /dev/sdb /mnt

  mkdir /mnt/A
  touch /mnt/foo
  ln /mnt/foo /mnt/A/bar
  xfs_io -c fsync /mnt/foo

  <power failure>

In this example after log replay only the hard link named 'foo' exists
and directory A does not exist, which is unexpected. In other major linux
filesystems, such as ext4, xfs and f2fs for example, both hard links exist
and so does directory A after mounting again the filesystem.

Checking if any new ancestors are new and need to be logged was added in
2009 by commit 12fcfd22fe5b ("Btrfs: tree logging unlink/rename fixes"),
however only for the ancestors of the hard link (dentry) for which the
fsync was issued, instead of checking for all ancestors for all of the
inode's hard links.

So fix this by tracking the id of the last transaction where a hard link
was created for an inode and then on fsync fallback to a full transaction
commit when an inode has more than one hard link and at least one new hard
link was created in the current transaction. This is the simplest solution
since this is not a common use case (adding frequently hard links for
which there's an ancestor created in the current transaction and then
fsync the file). In case it ever becomes a common use case, a solution
that consists of iterating the fs/subvol btree for each hard link and
check if any ancestor is new, could be implemented.

This solves many unexpected scenarios reported by Jayashree Mohan and
Vijay Chidambaram, and for which there is a new test case for fstests
under review.

Fixes: 12fcfd22fe5b ("Btrfs: tree logging unlink/rename fixes")
Reported-by: Vijay Chidambaram <vvijay03@gmail.com>
Reported-by: Jayashree Mohan <jayashree2912@gmail.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 3.16:
 - In btrfs_log_inode_parent(), inode is a struct inode pointer not a
   struct btrfs_inode pointer
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/btrfs_inode.h |  6 ++++++
 fs/btrfs/inode.c       | 17 +++++++++++++++++
 fs/btrfs/tree-log.c    | 16 ++++++++++++++++
 3 files changed, 39 insertions(+)

--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -144,6 +144,12 @@ struct btrfs_inode {
 	u64 last_unlink_trans;
 
 	/*
+	 * Track the transaction id of the last transaction used to create a
+	 * hard link for the inode. This is used by the log tree (fsync).
+	 */
+	u64 last_link_trans;
+
+	/*
 	 * Number of bytes outstanding that are going to need csums.  This is
 	 * used in ENOSPC accounting.
 	 */
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3561,6 +3561,21 @@ cache_index:
 	 * inode is not a directory, logging its parent unnecessarily.
 	 */
 	BTRFS_I(inode)->last_unlink_trans = BTRFS_I(inode)->last_trans;
+	/*
+	 * Similar reasoning for last_link_trans, needs to be set otherwise
+	 * for a case like the following:
+	 *
+	 * mkdir A
+	 * touch foo
+	 * ln foo A/bar
+	 * echo 2 > /proc/sys/vm/drop_caches
+	 * fsync foo
+	 * <power failure>
+	 *
+	 * Would result in link bar and directory A not existing after the power
+	 * failure.
+	 */
+	BTRFS_I(inode)->last_link_trans = BTRFS_I(inode)->last_trans;
 
 	path->slots[0]++;
 	if (inode->i_nlink != 1 ||
@@ -6183,6 +6198,7 @@ static int btrfs_link(struct dentry *old
 			if (err)
 				goto fail;
 		}
+		BTRFS_I(inode)->last_link_trans = trans->transid;
 		d_instantiate(dentry, inode);
 		btrfs_log_new_name(trans, inode, NULL, parent);
 	}
@@ -8250,6 +8266,7 @@ struct inode *btrfs_alloc_inode(struct s
 	ei->index_cnt = (u64)-1;
 	ei->dir_index = 0;
 	ei->last_unlink_trans = 0;
+	ei->last_link_trans = 0;
 	ei->last_log_commit = 0;
 
 	spin_lock_init(&ei->lock);
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4430,6 +4430,22 @@ static int btrfs_log_inode_parent(struct
 		goto end_trans;
 	}
 
+	/*
+	 * If a new hard link was added to the inode in the current transaction
+	 * and its link count is now greater than 1, we need to fallback to a
+	 * transaction commit, otherwise we can end up not logging all its new
+	 * parents for all the hard links. Here just from the dentry used to
+	 * fsync, we can not visit the ancestor inodes for all the other hard
+	 * links to figure out if any is new, so we fallback to a transaction
+	 * commit (instead of adding a lot of complexity of scanning a btree,
+	 * since this scenario is not a common use case).
+	 */
+	if (inode->i_nlink > 1 &&
+	    BTRFS_I(inode)->last_link_trans > last_committed) {
+		ret = -EMLINK;
+		goto end_trans;
+	}
+
 	inode_only = LOG_INODE_EXISTS;
 	while (1) {
 		if (!parent || !parent->d_inode || sb != parent->d_inode->i_sb)

