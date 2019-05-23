Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D81C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3124C206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639889;
	bh=Jfx6KeEU+O9GHSS13gWnKqZraw3gOIgsyaXRRt0RtWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qKwxxig0nxh8sGXPOQ2aRjT96YmQ33h+Db0vY+Tx0RHh5GsCvl095o+fm7jVm+X8o
	 /ofxoSzV/Mnn8AUVHf4yWvKGgMPGxtA5/2I9a7QosQC0mUGYiReMvccJ9vKY0fx4XA
	 I/IeP7jMSC2/lC+3iMNdCH+V/bm/GLtsU1/+RIO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403850AbfEWTb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:31:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392017AbfEWTb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:31:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9C5E2054F;
        Thu, 23 May 2019 19:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639885;
        bh=Jfx6KeEU+O9GHSS13gWnKqZraw3gOIgsyaXRRt0RtWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S1GhhxowjzyHBUGmDvU1/l70m+Pa/MSaIFQI+KwBEIDG4a0Uy4O01qj36AdZgItHW
         UWq1Y5NY7Ws5k08kseqJukBzwvZ8SsjN8v1pdb7hDJKLvFhmZuIY9BulOg/qamysIj
         Gt7Hze7njXTAqtr9eYPDq3xadqkzmdWcNlY28ao8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.1 120/122] btrfs: reloc: Fix NULL pointer dereference due to expanded reloc_root lifespan
Date:   Thu, 23 May 2019 21:07:22 +0200
Message-Id: <20190523181721.457475819@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181705.091418060@linuxfoundation.org>
References: <20190523181705.091418060@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

commit 10995c0491204c861948c9850939a7f4e90760a4 upstream.

Commit d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after
merge_reloc_roots()") expands the life span of root->reloc_root.

This breaks certain checs of fs_info->reloc_ctl.  Before that commit, if
we have a root with valid reloc_root, then it's ensured to have
fs_info->reloc_ctl.

But now since reloc_root doesn't always mean a valid fs_info->reloc_ctl,
such check is unreliable and can cause the following NULL pointer
dereference:

  BUG: unable to handle kernel NULL pointer dereference at 00000000000005c1
  IP: btrfs_reloc_pre_snapshot+0x20/0x50 [btrfs]
  PGD 0 P4D 0
  Oops: 0000 [#1] SMP PTI
  CPU: 0 PID: 10379 Comm: snapperd Not tainted
  Call Trace:
   create_pending_snapshot+0xd7/0xfc0 [btrfs]
   create_pending_snapshots+0x8e/0xb0 [btrfs]
   btrfs_commit_transaction+0x2ac/0x8f0 [btrfs]
   btrfs_mksubvol+0x561/0x570 [btrfs]
   btrfs_ioctl_snap_create_transid+0x189/0x190 [btrfs]
   btrfs_ioctl_snap_create_v2+0x102/0x150 [btrfs]
   btrfs_ioctl+0x5c9/0x1e60 [btrfs]
   do_vfs_ioctl+0x90/0x5f0
   SyS_ioctl+0x74/0x80
   do_syscall_64+0x7b/0x150
   entry_SYSCALL_64_after_hwframe+0x3d/0xa2
  RIP: 0033:0x7fd7cdab8467

Fix it by explicitly checking fs_info->reloc_ctl other than using the
implied root->reloc_root.

Fixes: d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after merge_reloc_roots")
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/relocation.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4667,14 +4667,12 @@ int btrfs_reloc_cow_block(struct btrfs_t
 void btrfs_reloc_pre_snapshot(struct btrfs_pending_snapshot *pending,
 			      u64 *bytes_to_reserve)
 {
-	struct btrfs_root *root;
-	struct reloc_control *rc;
+	struct btrfs_root *root = pending->root;
+	struct reloc_control *rc = root->fs_info->reloc_ctl;
 
-	root = pending->root;
-	if (!root->reloc_root)
+	if (!root->reloc_root || !rc)
 		return;
 
-	rc = root->fs_info->reloc_ctl;
 	if (!rc->merge_reloc_tree)
 		return;
 
@@ -4703,10 +4701,10 @@ int btrfs_reloc_post_snapshot(struct btr
 	struct btrfs_root *root = pending->root;
 	struct btrfs_root *reloc_root;
 	struct btrfs_root *new_root;
-	struct reloc_control *rc;
+	struct reloc_control *rc = root->fs_info->reloc_ctl;
 	int ret;
 
-	if (!root->reloc_root)
+	if (!root->reloc_root || !rc)
 		return 0;
 
 	rc = root->fs_info->reloc_ctl;


