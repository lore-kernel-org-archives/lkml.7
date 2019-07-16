Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF71C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B2D217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 09:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732395AbfGPJei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 05:34:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2231 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726536AbfGPJei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 05:34:38 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D5EECC6AC6050D760B87;
        Tue, 16 Jul 2019 17:34:36 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Tue, 16 Jul 2019 17:34:26 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>
CC:     Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <gaoxiang25@huawei.com>,
        <chao@kernel.org>
Subject: [PATCH v3] staging: erofs: support bmap
Date:   Tue, 16 Jul 2019 17:32:56 +0800
Message-ID: <20190716093256.108791-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add erofs_bmap() to support FIBMAP ioctl on flatmode inode.

Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v3:
- use erofs_blk_t instead of unsigned int.
- simply judgment condition.
 drivers/staging/erofs/data.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/staging/erofs/data.c b/drivers/staging/erofs/data.c
index cc31c3e5984c..f73e4720cd3e 100644
--- a/drivers/staging/erofs/data.c
+++ b/drivers/staging/erofs/data.c
@@ -392,9 +392,42 @@ static int erofs_raw_access_readpages(struct file *filp,
 	return 0;
 }
 
+static int erofs_get_block(struct inode *inode, sector_t iblock,
+			   struct buffer_head *bh, int create)
+{
+	struct erofs_map_blocks map = {
+		.m_la = iblock << 9,
+	};
+	int err;
+
+	err = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
+	if (err)
+		return err;
+
+	if (map.m_flags & EROFS_MAP_MAPPED)
+		bh->b_blocknr = erofs_blknr(map.m_pa);
+
+	return err;
+}
+
+static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
+{
+	struct inode *inode = mapping->host;
+
+	if (is_inode_flat_inline(inode)) {
+		erofs_blk_t blks = i_size_read(inode) >> LOG_BLOCK_SIZE;
+
+		if (block >> LOG_SECTORS_PER_BLOCK >= blks)
+			return 0;
+	}
+
+	return generic_block_bmap(mapping, block, erofs_get_block);
+}
+
 /* for uncompressed (aligned) files and raw access for other files */
 const struct address_space_operations erofs_raw_access_aops = {
 	.readpage = erofs_raw_access_readpage,
 	.readpages = erofs_raw_access_readpages,
+	.bmap = erofs_bmap,
 };
 
-- 
2.18.0.rc1

