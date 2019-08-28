Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D3EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BA4208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfH1Jd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 05:33:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5678 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726378AbfH1Jdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:33:54 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id ABE88777571745BBBA9B;
        Wed, 28 Aug 2019 17:33:51 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Wed, 28 Aug 2019 17:33:42 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4/4] f2fs: fix to add missing F2FS_IO_ALIGNED() condition
Date:   Wed, 28 Aug 2019 17:33:38 +0800
Message-ID: <20190828093338.29446-4-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20190828093338.29446-1-yuchao0@huawei.com>
References: <20190828093338.29446-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In f2fs_allocate_data_block(), we will reset fio.retry for IO
alignment feature instead of IO serialization feature.

In addition, spread F2FS_IO_ALIGNED() to check IO alignment
feature status explicitly.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c    | 6 +++++-
 fs/f2fs/segment.c | 4 +++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 777888ba171a..4764fdcb34d0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -294,6 +294,9 @@ static inline void __submit_bio(struct f2fs_sb_info *sbi,
 		if (test_opt(sbi, LFS) && current->plug)
 			blk_finish_plug(current->plug);
 
+		if (F2FS_IO_ALIGNED(sbi))
+			goto submit_io;
+
 		start = bio->bi_iter.bi_size >> F2FS_BLKSIZE_BITS;
 		start %= F2FS_IO_SIZE(sbi);
 
@@ -607,7 +610,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 		__submit_merged_bio(io);
 alloc_new:
 	if (io->bio == NULL) {
-		if ((fio->type == DATA || fio->type == NODE) &&
+		if (F2FS_IO_ALIGNED(sbi) &&
+				(fio->type == DATA || fio->type == NODE) &&
 				fio->new_blkaddr & F2FS_IO_SIZE_MASK(sbi)) {
 			dec_page_count(sbi, WB_DATA_TYPE(bio_page));
 			fio->retry = true;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 18584d4c078a..4887e2ff0ff8 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3129,12 +3129,14 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 		f2fs_inode_chksum_set(sbi, page);
 	}
 
+	if (F2FS_IO_ALIGNED(sbi))
+		fio->retry = false;
+
 	if (add_list) {
 		struct f2fs_bio_info *io;
 
 		INIT_LIST_HEAD(&fio->list);
 		fio->in_list = true;
-		fio->retry = false;
 		io = sbi->write_io[fio->type] + fio->temp;
 		spin_lock(&io->io_lock);
 		list_add_tail(&fio->list, &io->io_list);
-- 
2.18.0.rc1

