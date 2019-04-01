Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EF7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B9A21929
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138350;
	bh=O8hOAVnI5HL7Ri1DDuMphd1VyBppPCZF299wuTxLlkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=epbXbv1pwIM2xYaAEf6+yKulpOTaF/FQXLM169e1nYF56CDQCQv3H+atZIUf5FOwg
	 jy+RGSNPFhtCz9H4kEo7iU/8Dmy7oBirewV9CLN2AJm2hTvj5Xb3eexrBOC5pQeVCH
	 I1LNTRTcc2dlSc5lEpsQe8WD9uteJIdNPuIFlD2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbfDARFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:05:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbfDARFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:05:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1CC12192C;
        Mon,  1 Apr 2019 17:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138346;
        bh=O8hOAVnI5HL7Ri1DDuMphd1VyBppPCZF299wuTxLlkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2pg22ZE7xdZ/a70lFAjvdgDk26nChoGNAmtq0kfU3bzlWhaCUsdLvxrU8XVbo3iGY
         9Ok3OOvrcu7IpF1ZZ+VFoxFo2Orz9iU7mpjIO/FJDKZ5BqtObX0xI+YLtXDMBXxkPq
         aPOxjHqfjxRlYTAiv4UWH+kU+1bwP+pxSP5RX7X4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Seulbae Kim <seulbae@gatech.edu>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.0 038/146] Btrfs: fix incorrect file size after shrinking truncate and fsync
Date:   Mon,  1 Apr 2019 19:00:50 +0200
Message-Id: <20190401170051.717578902@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

From: Filipe Manana <fdmanana@suse.com>

commit bf504110bc8aa05df48b0e5f0aa84bfb81e0574b upstream.

If we do a shrinking truncate against an inode which is already present
in the respective log tree and then rename it, as part of logging the new
name we end up logging an inode item that reflects the old size of the
file (the one which we previously logged) and not the new smaller size.
The decision to preserve the size previously logged was added by commit
1a4bcf470c886b ("Btrfs: fix fsync data loss after adding hard link to
inode") in order to avoid data loss after replaying the log. However that
decision is only needed for the case the logged inode size is smaller then
the current size of the inode, as explained in that commit's change log.
If the current size of the inode is smaller then the previously logged
size, we know a shrinking truncate happened and therefore need to use
that smaller size.

Example to trigger the problem:

  $ mkfs.btrfs -f /dev/sdb
  $ mount /dev/sdb /mnt

  $ xfs_io -f -c "pwrite -S 0xab 0 8000" /mnt/foo
  $ xfs_io -c "fsync" /mnt/foo
  $ xfs_io -c "truncate 3000" /mnt/foo

  $ mv /mnt/foo /mnt/bar
  $ xfs_io -c "fsync" /mnt/bar

  <power failure>

  $ mount /dev/sdb /mnt
  $ od -t x1 -A d /mnt/bar
  0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
  *
  0008000

Once we rename the file, we log its name (and inode item), and because
the inode was already logged before in the current transaction, we log it
with a size of 8000 bytes because that is the size we previously logged
(with the first fsync). As part of the rename, besides logging the inode,
we do also sync the log, which is done since commit d4682ba03ef618
("Btrfs: sync log after logging new name"), so the next fsync against our
inode is effectively a no-op, since no new changes happened since the
rename operation. Even if did not sync the log during the rename
operation, the same problem (fize size of 8000 bytes instead of 3000
bytes) would be visible after replaying the log if the log ended up
getting synced to disk through some other means, such as for example by
fsyncing some other modified file. In the example above the fsync after
the rename operation is there just because not every filesystem may
guarantee logging/journalling the inode (and syncing the log/journal)
during the rename operation, for example it is needed for f2fs, but not
for ext4 and xfs.

Fix this scenario by, when logging a new name (which is triggered by
rename and link operations), using the current size of the inode instead
of the previously logged inode size.

A test case for fstests follows soon.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202695
CC: stable@vger.kernel.org # 4.4+
Reported-by: Seulbae Kim <seulbae@gatech.edu>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/tree-log.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4481,6 +4481,19 @@ static int logged_inode_size(struct btrf
 		item = btrfs_item_ptr(path->nodes[0], path->slots[0],
 				      struct btrfs_inode_item);
 		*size_ret = btrfs_inode_size(path->nodes[0], item);
+		/*
+		 * If the in-memory inode's i_size is smaller then the inode
+		 * size stored in the btree, return the inode's i_size, so
+		 * that we get a correct inode size after replaying the log
+		 * when before a power failure we had a shrinking truncate
+		 * followed by addition of a new name (rename / new hard link).
+		 * Otherwise return the inode size from the btree, to avoid
+		 * data loss when replaying a log due to previously doing a
+		 * write that expands the inode's size and logging a new name
+		 * immediately after.
+		 */
+		if (*size_ret > inode->vfs_inode.i_size)
+			*size_ret = inode->vfs_inode.i_size;
 	}
 
 	btrfs_release_path(path);


