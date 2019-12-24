Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0AAC2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DB32053B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 12:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfLXMol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 07:44:41 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51810 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726206AbfLXMol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 07:44:41 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5F26D71D9B931032672C;
        Tue, 24 Dec 2019 20:44:37 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 20:44:29 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] f2fs: remove set but not used variable 'cs_block'
Date:   Tue, 24 Dec 2019 20:43:59 +0800
Message-ID: <20191224124359.15040-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fs/f2fs/segment.c: In function fix_curseg_write_pointer:
fs/f2fs/segment.c:4485:35: warning: variable cs_block set but not used [-Wunused-but-set-variable]

It is never used since commit 362d8a920384 ("f2fs: Check
write pointer consistency of open zones") , so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/f2fs/segment.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a951953..72cf257 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4482,14 +4482,13 @@ static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
 	struct f2fs_dev_info *zbd;
 	struct blk_zone zone;
 	unsigned int cs_section, wp_segno, wp_blkoff, wp_sector_off;
-	block_t cs_zone_block, wp_block, cs_block;
+	block_t cs_zone_block, wp_block;
 	unsigned int log_sectors_per_block = sbi->log_blocksize - SECTOR_SHIFT;
 	sector_t zone_sector;
 	int err;
 
 	cs_section = GET_SEC_FROM_SEG(sbi, cs->segno);
 	cs_zone_block = START_BLOCK(sbi, GET_SEG_FROM_SEC(sbi, cs_section));
-	cs_block = START_BLOCK(sbi, cs->segno) + cs->next_blkoff;
 
 	zbd = get_target_zoned_dev(sbi, cs_zone_block);
 	if (!zbd)
-- 
2.7.4


