Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FC8C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DEF22CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405117AbfHWIv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:51:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5206 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389142AbfHWIv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:51:26 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2BEE91D6379DFCE0A015;
        Fri, 23 Aug 2019 16:51:21 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Fri, 23 Aug 2019 16:51:10 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3 1/2] f2fs: introduce {page,io}_is_mergeable() for readability
Date:   Fri, 23 Aug 2019 16:51:08 +0800
Message-ID: <20190823085108.15652-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap merge condition into function for readability, no logic change.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v3:
- fix wrong merge condition.
 fs/f2fs/data.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f49f243fd54f..0686306ed988 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -481,6 +481,33 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 	return 0;
 }
 
+static bool page_is_mergeable(struct f2fs_sb_info *sbi, struct bio *bio,
+				block_t last_blkaddr, block_t cur_blkaddr)
+{
+	if (last_blkaddr + 1 != cur_blkaddr)
+		return false;
+	return __same_bdev(sbi, cur_blkaddr, bio);
+}
+
+static bool io_type_is_mergeable(struct f2fs_bio_info *io,
+						struct f2fs_io_info *fio)
+{
+	if (io->fio.op != fio->op)
+		return false;
+	return io->fio.op_flags == fio->op_flags;
+}
+
+static bool io_is_mergeable(struct f2fs_sb_info *sbi, struct bio *bio,
+					struct f2fs_bio_info *io,
+					struct f2fs_io_info *fio,
+					block_t last_blkaddr,
+					block_t cur_blkaddr)
+{
+	if (!page_is_mergeable(sbi, bio, last_blkaddr, cur_blkaddr))
+		return false;
+	return io_type_is_mergeable(io, fio);
+}
+
 int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 {
 	struct bio *bio = *fio->bio;
@@ -494,8 +521,8 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	trace_f2fs_submit_page_bio(page, fio);
 	f2fs_trace_ios(fio, 0);
 
-	if (bio && (*fio->last_block + 1 != fio->new_blkaddr ||
-			!__same_bdev(fio->sbi, fio->new_blkaddr, bio))) {
+	if (bio && !page_is_mergeable(fio->sbi, bio, *fio->last_block,
+						fio->new_blkaddr)) {
 		__submit_bio(fio->sbi, bio, fio->type);
 		bio = NULL;
 	}
@@ -568,9 +595,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 
 	inc_page_count(sbi, WB_DATA_TYPE(bio_page));
 
-	if (io->bio && (io->last_block_in_bio != fio->new_blkaddr - 1 ||
-	    (io->fio.op != fio->op || io->fio.op_flags != fio->op_flags) ||
-			!__same_bdev(sbi, fio->new_blkaddr, io->bio)))
+	if (io->bio && !io_is_mergeable(sbi, io->bio, io, fio,
+			io->last_block_in_bio, fio->new_blkaddr))
 		__submit_merged_bio(io);
 alloc_new:
 	if (io->bio == NULL) {
@@ -1642,8 +1668,8 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 	 * This page will go to BIO.  Do we need to send this
 	 * BIO off first?
 	 */
-	if (bio && (*last_block_in_bio != block_nr - 1 ||
-		!__same_bdev(F2FS_I_SB(inode), block_nr, bio))) {
+	if (bio && !page_is_mergeable(F2FS_I_SB(inode), bio,
+				*last_block_in_bio, block_nr)) {
 submit_and_realloc:
 		__submit_bio(F2FS_I_SB(inode), bio, DATA);
 		bio = NULL;
-- 
2.18.0.rc1

