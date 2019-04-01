Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2866C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED4921924
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138424;
	bh=gJJAVHOwGvb9uVHHNEfWKzybPPpbGXPHZHtGyvsaDQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i+9Ioeg2zVzzceKVOVBVVWHiz5bCwJk/e9NqzfE0BmtFMZdd6Kr9YrXjNAcsX2kCX
	 a/zB7rBUy1FBOxTb1W4xSaQVL6Ofg20ClC78VqCUAgWKmkisB1UeCUdMy6Df+wPluu
	 UqrrQFnDwsZcg9hLXrw9WRj6Jse0CyTQN1kbV4Dw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfDARHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:07:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728889AbfDARHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:07:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDF112192C;
        Mon,  1 Apr 2019 17:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138421;
        bh=gJJAVHOwGvb9uVHHNEfWKzybPPpbGXPHZHtGyvsaDQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zy5JTK93aYfS/VlP9998j23QmGx2aZR8mEpRVH1mWdNu7UyzDkh/xUl5MU+n/gb4/
         lxl//4ikKFV4vMyPHf01Zi1e2nkityCs8ZirB+6ruCjg/Qg9bFevFNWfXQgAEldBhk
         ghRh2lbFHQE6jNbG/OpxOgCGlpup7ykOOGxg+i5w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.0 044/146] Btrfs: fix assertion failure on fsync with NO_HOLES enabled
Date:   Mon,  1 Apr 2019 19:00:56 +0200
Message-Id: <20190401170052.274616432@linuxfoundation.org>
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

commit 0ccc3876e4b2a1559a4dbe3126dda4459d38a83b upstream.

Back in commit a89ca6f24ffe4 ("Btrfs: fix fsync after truncate when
no_holes feature is enabled") I added an assertion that is triggered when
an inline extent is found to assert that the length of the (uncompressed)
data the extent represents is the same as the i_size of the inode, since
that is true most of the time I couldn't find or didn't remembered about
any exception at that time. Later on the assertion was expanded twice to
deal with a case of a compressed inline extent representing a range that
matches the sector size followed by an expanding truncate, and another
case where fallocate can update the i_size of the inode without adding
or updating existing extents (if the fallocate range falls entirely within
the first block of the file). These two expansion/fixes of the assertion
were done by commit 7ed586d0a8241 ("Btrfs: fix assertion on fsync of
regular file when using no-holes feature") and commit 6399fb5a0b69a
("Btrfs: fix assertion failure during fsync in no-holes mode").
These however missed the case where an falloc expands the i_size of an
inode to exactly the sector size and inline extent exists, for example:

 $ mkfs.btrfs -f -O no-holes /dev/sdc
 $ mount /dev/sdc /mnt

 $ xfs_io -f -c "pwrite -S 0xab 0 1096" /mnt/foobar
 wrote 1096/1096 bytes at offset 0
 1 KiB, 1 ops; 0.0002 sec (4.448 MiB/sec and 4255.3191 ops/sec)

 $ xfs_io -c "falloc 1096 3000" /mnt/foobar
 $ xfs_io -c "fsync" /mnt/foobar
 Segmentation fault

 $ dmesg
 [701253.602385] assertion failed: len == i_size || (len == fs_info->sectorsize && btrfs_file_extent_compression(leaf, extent) != BTRFS_COMPRESS_NONE) || (len < i_size && i_size < fs_info->sectorsize), file: fs/btrfs/tree-log.c, line: 4727
 [701253.602962] ------------[ cut here ]------------
 [701253.603224] kernel BUG at fs/btrfs/ctree.h:3533!
 [701253.603503] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
 [701253.603774] CPU: 2 PID: 7192 Comm: xfs_io Tainted: G        W         5.0.0-rc8-btrfs-next-45 #1
 [701253.604054] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
 [701253.604650] RIP: 0010:assfail.constprop.23+0x18/0x1a [btrfs]
 (...)
 [701253.605591] RSP: 0018:ffffbb48c186bc48 EFLAGS: 00010286
 [701253.605914] RAX: 00000000000000de RBX: ffff921d0a7afc08 RCX: 0000000000000000
 [701253.606244] RDX: 0000000000000000 RSI: ffff921d36b16868 RDI: ffff921d36b16868
 [701253.606580] RBP: ffffbb48c186bcf0 R08: 0000000000000000 R09: 0000000000000000
 [701253.606913] R10: 0000000000000003 R11: 0000000000000000 R12: ffff921d05d2de18
 [701253.607247] R13: ffff921d03b54000 R14: 0000000000000448 R15: ffff921d059ecf80
 [701253.607769] FS:  00007f14da906700(0000) GS:ffff921d36b00000(0000) knlGS:0000000000000000
 [701253.608163] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [701253.608516] CR2: 000056087ea9f278 CR3: 00000002268e8001 CR4: 00000000003606e0
 [701253.608880] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 [701253.609250] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 [701253.609608] Call Trace:
 [701253.609994]  btrfs_log_inode+0xdfb/0xe40 [btrfs]
 [701253.610383]  btrfs_log_inode_parent+0x2be/0xa60 [btrfs]
 [701253.610770]  ? do_raw_spin_unlock+0x49/0xc0
 [701253.611150]  btrfs_log_dentry_safe+0x4a/0x70 [btrfs]
 [701253.611537]  btrfs_sync_file+0x3b2/0x440 [btrfs]
 [701253.612010]  ? do_sysinfo+0xb0/0xf0
 [701253.612552]  do_fsync+0x38/0x60
 [701253.612988]  __x64_sys_fsync+0x10/0x20
 [701253.613360]  do_syscall_64+0x60/0x1b0
 [701253.613733]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
 [701253.614103] RIP: 0033:0x7f14da4e66d0
 (...)
 [701253.615250] RSP: 002b:00007fffa670fdb8 EFLAGS: 00000246 ORIG_RAX: 000000000000004a
 [701253.615647] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f14da4e66d0
 [701253.616047] RDX: 000056087ea9c260 RSI: 000056087ea9c260 RDI: 0000000000000003
 [701253.616450] RBP: 0000000000000001 R08: 0000000000000020 R09: 0000000000000010
 [701253.616854] R10: 000000000000009b R11: 0000000000000246 R12: 000056087ea9c260
 [701253.617257] R13: 000056087ea9c240 R14: 0000000000000000 R15: 000056087ea9dd10
 (...)
 [701253.619941] ---[ end trace e088d74f132b6da5 ]---

Updating the assertion again to allow for this particular case would result
in a meaningless assertion, plus there is currently no risk of logging
content that would result in any corruption after a log replay if the size
of the data encoded in an inline extent is greater than the inode's i_size
(which is not currently possibe either with or without compression),
therefore just remove the assertion.

CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/tree-log.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4662,15 +4662,8 @@ static int btrfs_log_trailing_hole(struc
 					struct btrfs_file_extent_item);
 
 		if (btrfs_file_extent_type(leaf, extent) ==
-		    BTRFS_FILE_EXTENT_INLINE) {
-			len = btrfs_file_extent_ram_bytes(leaf, extent);
-			ASSERT(len == i_size ||
-			       (len == fs_info->sectorsize &&
-				btrfs_file_extent_compression(leaf, extent) !=
-				BTRFS_COMPRESS_NONE) ||
-			       (len < i_size && i_size < fs_info->sectorsize));
+		    BTRFS_FILE_EXTENT_INLINE)
 			return 0;
-		}
 
 		len = btrfs_file_extent_num_bytes(leaf, extent);
 		/* Last extent goes beyond i_size, no need to log a hole. */


