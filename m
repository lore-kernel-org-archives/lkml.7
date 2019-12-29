Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29002C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0334D20748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577643125;
	bh=lgjsUH1UaErPcRtHPJmQgEs/duTqCRqG4fyGowx74+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Eoh+DjIedBqU3DAtag/7Wrh/PUCr+/uIqPjj7fwdxzhfMMq37T1MCqzUarS7HDlrk
	 3D654D/9tEyXXmd9aKDWqvN5c3l6zYfAW7Tz/EypuHhAinweg5WX9AWapE5jRb73wG
	 0ug1bzGwCRCwJ1zmYrUK3Sc2i8aL7S3bCKl46cVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733017AbfL2SMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 13:12:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730299AbfL2Rm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:42:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAE9820718;
        Sun, 29 Dec 2019 17:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641348;
        bh=lgjsUH1UaErPcRtHPJmQgEs/duTqCRqG4fyGowx74+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1T/7COL+b9bHgAu3b8Cp7VRckaQIzTaA7ZodLK/G+XiZY7CeNgzCiBrLzZ0rZMSye
         zYC75BM6KRVTkHH8wOAg7J5qkyMIoSxQVH446v6U47hiezTYJa2/R0j87cMP+GcZqQ
         tWaITiej9Xsg5c2ATkoJwy8u9NfTNWnuKA8dyWW8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.4 029/434] btrfs: do not call synchronize_srcu() in inode_tree_del
Date:   Sun, 29 Dec 2019 18:21:22 +0100
Message-Id: <20191229172703.983729188@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

commit f72ff01df9cf5db25c76674cac16605992d15467 upstream.

Testing with the new fsstress uncovered a pretty nasty deadlock with
lookup and snapshot deletion.

Process A
unlink
 -> final iput
   -> inode_tree_del
     -> synchronize_srcu(subvol_srcu)

Process B
btrfs_lookup  <- srcu_read_lock() acquired here
  -> btrfs_iget
    -> find inode that has I_FREEING set
      -> __wait_on_freeing_inode()

We're holding the srcu_read_lock() while doing the iget in order to make
sure our fs root doesn't go away, and then we are waiting for the inode
to finish freeing.  However because the free'ing process is doing a
synchronize_srcu() we deadlock.

Fix this by dropping the synchronize_srcu() in inode_tree_del().  We
don't need people to stop accessing the fs root at this point, we're
only adding our empty root to the dead roots list.

A larger much more invasive fix is forthcoming to address how we deal
with fs roots, but this fixes the immediate problem.

Fixes: 76dda93c6ae2 ("Btrfs: add snapshot/subvolume destroy ioctl")
CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/inode.c |    2 --
 1 file changed, 2 deletions(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5697,7 +5697,6 @@ static void inode_tree_add(struct inode
 
 static void inode_tree_del(struct inode *inode)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	int empty = 0;
 
@@ -5710,7 +5709,6 @@ static void inode_tree_del(struct inode
 	spin_unlock(&root->inode_lock);
 
 	if (empty && btrfs_root_refs(&root->root_item) == 0) {
-		synchronize_srcu(&fs_info->subvol_srcu);
 		spin_lock(&root->inode_lock);
 		empty = RB_EMPTY_ROOT(&root->inode_tree);
 		spin_unlock(&root->inode_lock);


