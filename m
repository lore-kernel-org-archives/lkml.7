Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA655C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0F8206CC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfKONXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 08:23:49 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6238 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727223AbfKONXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:23:49 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6A39DA0FE08CF0868D82;
        Fri, 15 Nov 2019 21:23:46 +0800 (CST)
Received: from huawei.com (10.175.104.132) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Fri, 15 Nov 2019
 21:23:36 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     Hugh Dickins <hughd@google.com>, <linux-mm@kvack.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>
Subject: [PATCH] mm: Cast the type of unmap_start to u64
Date:   Fri, 15 Nov 2019 20:24:24 -0500
Message-ID: <1573867464-5107-1-git-send-email-chenjun102@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 64bit system. sb->s_maxbytes of shmem filesystem is MAX_LFS_FILESIZE,
which equal LLONG_MAX.
If offset > LLONG_MAX - PAGE_SIZE, offset + len < LLONG_MAX in
shmem_fallocate, which will pass the checking in vfs_fallocate.
	/* Check for wrap through zero too */
	if (((offset + len) > inode->i_sb->s_maxbytes) || ((offset + len) < 0))
		return -EFBIG;

loff_t unmap_start = round_up(offset, PAGE_SIZE) in shmem_fallocate
causes a overflow.

Syzkaller reports a overflow problem in mm/shmem:
UBSAN: Undefined behaviour in mm/shmem.c:2014:10
signed integer overflow:
'9223372036854775807 + 1' cannot be represented in type 'long long int'
CPU: 0 PID:17076 Comm: syz-executor0 Not tainted 4.1.46+ #1
Hardware name: linux, dummy-virt (DT)
Call trace:
[<ffff800000092150>] dump_backtrace+0x0/0x2c8 arch/arm64/kernel/traps.c:100
[<ffff800000092438>] show_stack+0x20/0x30 arch/arm64/kernel/traps.c:238
[<ffff800000f9b134>] __dump_stack lib/dump_stack.c:15 [inline]
[<ffff800000f9b134>] ubsan_epilogue+0x18/0x70 lib/ubsan.c:164
[<ffff800000f9b468>] handle_overflow+0x158/0x1b0 lib/ubsan.c:195
[<ffff800000341280>] shmem_fallocate+0x6d0/0x820 mm/shmem.c:2104
[<ffff8000003ee008>] vfs_fallocate+0x238/0x428 fs/open.c:312
[<ffff8000003ef72c>] SYSC_fallocate fs/open.c:335 [inline]
[<ffff8000003ef72c>] SyS_fallocate+0x54/0xc8 fs/open.c:239

The highest bit of unmap_start will be appended with sign bit 1 (overflow)
when calculate shmem_falloc.start:
shmem_falloc.start = unmap_start >> PAGE_SHIFT.

Fix it by casting the type of unmap_start to u64, when right shifted.

This bug is found in LTS Linux 4.1. It also seems to exist in mainline.

Signed-off-by: Chen Jun <chenjun102@huawei.com>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index e9342c3..82cebbc 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2717,7 +2717,7 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 		}
 
 		shmem_falloc.waitq = &shmem_falloc_waitq;
-		shmem_falloc.start = unmap_start >> PAGE_SHIFT;
+		shmem_falloc.start = (u64)unmap_start >> PAGE_SHIFT;
 		shmem_falloc.next = (unmap_end + 1) >> PAGE_SHIFT;
 		spin_lock(&inode->i_lock);
 		inode->i_private = &shmem_falloc;
-- 
2.7.4

