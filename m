Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA98C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB0320830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570123666;
	bh=+JxQQyJlmEHfkDkgRN+ua7d4KM9d+lqwrBvX7zCu9o4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tfXUjz//nopyomaE+YCqNexkdrJG2xRilbnQ58YnueJW42aQV43BdNhben9q+Qmnr
	 3YsQ8DmRRFFSeoq5jYPJc3YUyMin1JaOKtJKM5OpvcyA38f5nHF5r2JRMbTGf2LIxA
	 +VGdbzGY/8XXUkdaClyrqpGralRR5LApjSVZcodQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388621AbfJCQOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:14:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388600AbfJCQO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:14:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ED6C21848;
        Thu,  3 Oct 2019 16:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119265;
        bh=+JxQQyJlmEHfkDkgRN+ua7d4KM9d+lqwrBvX7zCu9o4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wgqyWQrz/8/n15iLO1xFLsd6O2gANMEiU6+qkeDfZijuLIc1eivf17NOqKhsj6wNC
         4NsrgtMI6ATwZH+Xane5kHzrL7ZZVSVA+NQsiUXdENC0cQjZwFrTIXZVUCEfLttzj/
         x4c6Z+Mp0tieP7033tqxnIZN1TrmvC5iWe+oeh10=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 168/185] btrfs: Relinquish CPUs in btrfs_compare_trees
Date:   Thu,  3 Oct 2019 17:54:06 +0200
Message-Id: <20191003154517.884667396@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolay Borisov <nborisov@suse.com>

commit 6af112b11a4bc1b560f60a618ac9c1dcefe9836e upstream.

When doing any form of incremental send the parent and the child trees
need to be compared via btrfs_compare_trees. This  can result in long
loop chains without ever relinquishing the CPU. This causes softlockup
detector to trigger when comparing trees with a lot of items. Example
report:

watchdog: BUG: soft lockup - CPU#0 stuck for 24s! [snapperd:16153]
CPU: 0 PID: 16153 Comm: snapperd Not tainted 5.2.9-1-default #1 openSUSE Tumbleweed (unreleased)
Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
pstate: 40000005 (nZcv daif -PAN -UAO)
pc : __ll_sc_arch_atomic_sub_return+0x14/0x20
lr : btrfs_release_extent_buffer_pages+0xe0/0x1e8 [btrfs]
sp : ffff00001273b7e0
Call trace:
 __ll_sc_arch_atomic_sub_return+0x14/0x20
 release_extent_buffer+0xdc/0x120 [btrfs]
 free_extent_buffer.part.0+0xb0/0x118 [btrfs]
 free_extent_buffer+0x24/0x30 [btrfs]
 btrfs_release_path+0x4c/0xa0 [btrfs]
 btrfs_free_path.part.0+0x20/0x40 [btrfs]
 btrfs_free_path+0x24/0x30 [btrfs]
 get_inode_info+0xa8/0xf8 [btrfs]
 finish_inode_if_needed+0xe0/0x6d8 [btrfs]
 changed_cb+0x9c/0x410 [btrfs]
 btrfs_compare_trees+0x284/0x648 [btrfs]
 send_subvol+0x33c/0x520 [btrfs]
 btrfs_ioctl_send+0x8a0/0xaf0 [btrfs]
 btrfs_ioctl+0x199c/0x2288 [btrfs]
 do_vfs_ioctl+0x4b0/0x820
 ksys_ioctl+0x84/0xb8
 __arm64_sys_ioctl+0x28/0x38
 el0_svc_common.constprop.0+0x7c/0x188
 el0_svc_handler+0x34/0x90
 el0_svc+0x8/0xc

Fix this by adding a call to cond_resched at the beginning of the main
loop in btrfs_compare_trees.

Fixes: 7069830a9e38 ("Btrfs: add btrfs_compare_trees function")
CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/ctree.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -5494,6 +5494,7 @@ int btrfs_compare_trees(struct btrfs_roo
 	advance_left = advance_right = 0;
 
 	while (1) {
+		cond_resched();
 		if (advance_left && !left_end_reached) {
 			ret = tree_advance(fs_info, left_path, &left_level,
 					left_root_level,


