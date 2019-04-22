Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E15C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 12:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939AF20811
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 12:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfDVMXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 08:23:36 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2989 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727258AbfDVMXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 08:23:34 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 6C8D1677071FAEC67E15;
        Mon, 22 Apr 2019 20:23:25 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 22 Apr 2019 20:23:25 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 22 Apr 2019 20:23:24 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/3] f2fs: fix to be aware of readonly device in write_checkpoint()
Date:   Mon, 22 Apr 2019 20:22:38 +0800
Message-ID: <20190422122238.78062-3-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20190422122238.78062-1-yuchao0@huawei.com>
References: <20190422122238.78062-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Park Ju Hyung reported:

Probably unrelated but a similar issue:
Warning appears upon unmounting a corrupted R/O f2fs loop image.

Should be a trivial issue to fix as well :)

[ 2373.758424] ------------[ cut here ]------------
[ 2373.758428] generic_make_request: Trying to write to read-only
block-device loop1 (partno 0)
[ 2373.758455] WARNING: CPU: 1 PID: 13950 at block/blk-core.c:2174
generic_make_request_checks+0x590/0x630
[ 2373.758556] CPU: 1 PID: 13950 Comm: umount Tainted: G           O
   4.19.35-zen+ #1
[ 2373.758558] Hardware name: System manufacturer System Product
Name/ROG MAXIMUS X HERO (WI-FI AC), BIOS 1704 09/14/2018
[ 2373.758564] RIP: 0010:generic_make_request_checks+0x590/0x630
[ 2373.758567] Code: 5c 03 00 00 48 8d 74 24 08 48 89 df c6 05 b5 cd
36 01 01 e8 c2 90 01 00 48 89 c6 44 89 ea 48 c7 c7 98 64 59 82 e8 d5
9b a7 ff <0f> 0b 48 8b 7b 08 e9 f2 fa ff ff 41 8b 86 98 02 00 00 49 8b
16 89
[ 2373.758570] RSP: 0018:ffff8882bdb43950 EFLAGS: 00010282
[ 2373.758573] RAX: 0000000000000050 RBX: ffff8887244c6700 RCX: 0000000000000006
[ 2373.758575] RDX: 0000000000000007 RSI: 0000000000000086 RDI: ffff88884ec56340
[ 2373.758577] RBP: ffff888849c426c0 R08: 0000000000000004 R09: 00000000000003ba
[ 2373.758579] R10: 0000000000000001 R11: 0000000000000029 R12: 0000000000001000
[ 2373.758581] R13: 0000000000000000 R14: ffff888844a2e800 R15: ffff8882bdb43ac0
[ 2373.758584] FS:  00007fc0d114f8c0(0000) GS:ffff88884ec40000(0000)
knlGS:0000000000000000
[ 2373.758586] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2373.758588] CR2: 00007fc0d1ad12c0 CR3: 00000002bdb82003 CR4: 00000000003606e0
[ 2373.758590] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2373.758592] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 2373.758593] Call Trace:
[ 2373.758602]  ? generic_make_request+0x46/0x3d0
[ 2373.758608]  ? wait_woken+0x80/0x80
[ 2373.758612]  ? mempool_alloc+0xb7/0x1a0
[ 2373.758618]  ? submit_bio+0x30/0x110
[ 2373.758622]  ? bvec_alloc+0x7c/0xd0
[ 2373.758628]  ? __submit_merged_bio+0x68/0x390
[ 2373.758633]  ? f2fs_submit_page_write+0x1bb/0x7f0
[ 2373.758638]  ? f2fs_do_write_meta_page+0x7f/0x160
[ 2373.758642]  ? __f2fs_write_meta_page+0x70/0x140
[ 2373.758647]  ? f2fs_sync_meta_pages+0x140/0x250
[ 2373.758653]  ? f2fs_write_checkpoint+0x5c5/0x17b0
[ 2373.758657]  ? f2fs_sync_fs+0x9c/0x110
[ 2373.758664]  ? sync_filesystem+0x66/0x80
[ 2373.758667]  ? generic_shutdown_super+0x1d/0x100
[ 2373.758670]  ? kill_block_super+0x1c/0x40
[ 2373.758674]  ? kill_f2fs_super+0x64/0xb0
[ 2373.758678]  ? deactivate_locked_super+0x2d/0xb0
[ 2373.758682]  ? cleanup_mnt+0x65/0xa0
[ 2373.758688]  ? task_work_run+0x7f/0xa0
[ 2373.758693]  ? exit_to_usermode_loop+0x9c/0xa0
[ 2373.758698]  ? do_syscall_64+0xc7/0xf0
[ 2373.758703]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 2373.758706] ---[ end trace 5d3639907c56271b ]---
[ 2373.758780] print_req_error: I/O error, dev loop1, sector 143048
[ 2373.758800] print_req_error: I/O error, dev loop1, sector 152200
[ 2373.758808] print_req_error: I/O error, dev loop1, sector 8192
[ 2373.758819] print_req_error: I/O error, dev loop1, sector 12272

This patch adds to detect readonly device in write_checkpoint() to avoid
trigger write IOs on it.

Reported-by: Park Ju Hyung <qkrwngud825@gmail.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 90e1bab86269..ca7da012de68 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1534,6 +1534,9 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	unsigned long long ckpt_ver;
 	int err = 0;
 
+	if (f2fs_readonly(sbi->sb) || f2fs_hw_is_readonly(sbi))
+		return -EROFS;
+
 	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
 		if (cpc->reason != CP_PAUSE)
 			return 0;
@@ -1550,10 +1553,6 @@ int f2fs_write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		err = -EIO;
 		goto out;
 	}
-	if (f2fs_readonly(sbi->sb)) {
-		err = -EROFS;
-		goto out;
-	}
 
 	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, "start block_ops");
 
-- 
2.18.0.rc1

