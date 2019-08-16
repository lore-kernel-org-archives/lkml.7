Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27C1C3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 03:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E822086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 03:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfHPDEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 23:04:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726465AbfHPDEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 23:04:00 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 22A01A017554AFE3FD6A;
        Fri, 16 Aug 2019 11:03:57 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Fri, 16 Aug 2019 11:03:50 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to avoid data corruption by forbidding SSR overwrite
Date:   Fri, 16 Aug 2019 11:03:34 +0800
Message-ID: <20190816030334.81035-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is one case can cause data corruption.

- write 4k to fileA
- fsync fileA, 4k data is writebacked to lbaA
- write 4k to fileA
- kworker flushs 4k to lbaB; dnode contain lbaB didn't be persisted yet
- write 4k to fileB
- kworker flush 4k to lbaA due to SSR
- SPOR -> dnode with lbaA will be recovered, however lbaA contains fileB's
data

One solution is tracking all fsynced file's block history, and disallow
SSR overwrite on newly invalidated block on that file.

However, during recovery, no matter the dnode is flushed or fsynced, all
previous dnodes until last fsynced one in node chain can be recovered,
that means we need to record all block change in flushed dnode, which
will cause heavy cost, so let's just use simple fix by forbidding SSR
overwrite directly.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9d9d9a050d59..69b3b553ee6b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2205,9 +2205,11 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 		if (!f2fs_test_and_set_bit(offset, se->discard_map))
 			sbi->discard_blks--;
 
-		/* don't overwrite by SSR to keep node chain */
-		if (IS_NODESEG(se->type) &&
-				!is_sbi_flag_set(sbi, SBI_CP_DISABLED)) {
+		/*
+		 * SSR should never reuse block which is checkpointed
+		 * or newly invalidated.
+		 */
+		if (!is_sbi_flag_set(sbi, SBI_CP_DISABLED)) {
 			if (!f2fs_test_and_set_bit(offset, se->ckpt_valid_map))
 				se->ckpt_valid_blocks++;
 		}
-- 
2.18.0.rc1

