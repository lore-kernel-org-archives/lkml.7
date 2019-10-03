Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8318C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9CE2070B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570120506;
	bh=BfTwByiLBOEtLAiKrDFm0+a1C2cPRfgHJQH9uMU+AJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2lB8764oe5IP3JPT7O2i3Wg45IFvKF7/DJLOH5UmfAJsvjsETMsB9LitBgKtjfxok
	 xPtTgqz2+o0xQ86GjTov0w2s9060x9ioHr6l59Br4cuNFdi55RTU9TG+i72FPNdx4u
	 PpPoRnQ0lcRdTtP37fbO3agW0UDZ5/WSEWbCoD0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404240AbfJCQfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392182AbfJCQfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:35:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BADFF215EA;
        Thu,  3 Oct 2019 16:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120500;
        bh=BfTwByiLBOEtLAiKrDFm0+a1C2cPRfgHJQH9uMU+AJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pgjrIsC850x8vGQIQydt8JWvnQLLCzFrcoZwtlTWQKdztQu+Ol7pz8vzROXM287p0
         LDIhcmendBiDlgjU2QTHDdvaOf2w10vztqG8iBXZN632SficUYvpVskj2JAeaDQLcL
         nAwQUXvd3CROzoi1BMUmQh4Oo8V9ndTyjMOwVB9E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 206/313] btrfs: delayed-inode: Kill the BUG_ON() in btrfs_delete_delayed_dir_index()
Date:   Thu,  3 Oct 2019 17:53:04 +0200
Message-Id: <20191003154553.282845831@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 933c22a7512c5c09b1fdc46b557384efe8d03233 ]

There is one report of fuzzed image which leads to BUG_ON() in
btrfs_delete_delayed_dir_index().

Although that fuzzed image can already be addressed by enhanced
extent-tree error handler, it's still better to hunt down more BUG_ON().

This patch will hunt down two BUG_ON()s in
btrfs_delete_delayed_dir_index():
- One for error from btrfs_delayed_item_reserve_metadata()
  Instead of BUG_ON(), we output an error message and free the item.
  And return the error.
  All callers of this function handles the error by aborting current
  trasaction.

- One for possible EEXIST from __btrfs_add_delayed_deletion_item()
  That function can return -EEXIST.
  We already have a good enough error message for that, only need to
  clean up the reserved metadata space and allocated item.

To help above cleanup, also modifiy __btrfs_remove_delayed_item() called
in btrfs_release_delayed_item(), to skip unassociated item.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=203253
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/delayed-inode.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 43fdb2992956a..6858a05606dd3 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -474,6 +474,9 @@ static void __btrfs_remove_delayed_item(struct btrfs_delayed_item *delayed_item)
 	struct rb_root_cached *root;
 	struct btrfs_delayed_root *delayed_root;
 
+	/* Not associated with any delayed_node */
+	if (!delayed_item->delayed_node)
+		return;
 	delayed_root = delayed_item->delayed_node->root->fs_info->delayed_root;
 
 	BUG_ON(!delayed_root);
@@ -1525,7 +1528,12 @@ int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
 	 * we have reserved enough space when we start a new transaction,
 	 * so reserving metadata failure is impossible.
 	 */
-	BUG_ON(ret);
+	if (ret < 0) {
+		btrfs_err(trans->fs_info,
+"metadata reservation failed for delayed dir item deltiona, should have been reserved");
+		btrfs_release_delayed_item(item);
+		goto end;
+	}
 
 	mutex_lock(&node->mutex);
 	ret = __btrfs_add_delayed_deletion_item(node, item);
@@ -1534,7 +1542,8 @@ int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
 			  "err add delayed dir index item(index: %llu) into the deletion tree of the delayed node(root id: %llu, inode id: %llu, errno: %d)",
 			  index, node->root->root_key.objectid,
 			  node->inode_id, ret);
-		BUG();
+		btrfs_delayed_item_release_metadata(dir->root, item);
+		btrfs_release_delayed_item(item);
 	}
 	mutex_unlock(&node->mutex);
 end:
-- 
2.20.1



