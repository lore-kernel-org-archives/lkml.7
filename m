Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C908C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36629206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389997AbfHBKQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 06:16:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47978 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732472AbfHBKQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 06:16:17 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F15548CA8EEC0A7AC45B;
        Fri,  2 Aug 2019 18:16:15 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Fri, 2 Aug 2019 18:16:05 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] Revert "f2fs: avoid out-of-range memory access"
Date:   Fri, 2 Aug 2019 18:15:48 +0800
Message-ID: <20190802101548.96543-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Pavel Machek reported:

"We normally use -EUCLEAN to signal filesystem corruption. Plus, it is
good idea to report it to the syslog and mark filesystem as "needing
fsck" if filesystem can do that."

Still we need improve the original patch with:
- use unlikely keyword
- add message print
- return EUCLEAN

However, after rethink this patch, I don't think we should add such
condition check here as below reasons:
- We have already checked the field in f2fs_sanity_check_ckpt(),
- If there is fs corrupt or security vulnerability, there is nothing
to guarantee the field is integrated after the check, unless we do
the check before each of its use, however no filesystem does that.
- We only have similar check for bitmap, which was added due to there
is bitmap corruption happened on f2fs' runtime in product.
- There are so many key fields in SB/CP/NAT did have such check
after f2fs_sanity_check_{sb,cp,..}.

So I propose to revert this unneeded check.

This reverts commit 56f3ce675103e3fb9e631cfb4131fc768bc23e9a.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9693fa4c8971..2eff9c008ae0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3492,11 +3492,6 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
 		seg_i = CURSEG_I(sbi, i);
 		segno = le32_to_cpu(ckpt->cur_data_segno[i]);
 		blk_off = le16_to_cpu(ckpt->cur_data_blkoff[i]);
-		if (blk_off > ENTRIES_IN_SUM) {
-			f2fs_bug_on(sbi, 1);
-			f2fs_put_page(page, 1);
-			return -EFAULT;
-		}
 		seg_i->next_segno = segno;
 		reset_curseg(sbi, i, 0);
 		seg_i->alloc_type = ckpt->alloc_type[i];
-- 
2.18.0.rc1

