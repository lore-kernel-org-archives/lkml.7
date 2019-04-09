Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7C6C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12AC720883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 02:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfDIC5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 22:57:39 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34756 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725953AbfDIC5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 22:57:39 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2A410D22E15C10132E19;
        Tue,  9 Apr 2019 10:57:37 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Tue, 9 Apr 2019
 10:57:32 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     <hirofumi@mail.parknet.co.jp>
CC:     <linux-fsdevel@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
        <jack@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] fat: issue flush after the writeback of FAT
Date:   Tue, 9 Apr 2019 11:01:58 +0800
Message-ID: <20190409030158.136316-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fsync() needs to make sure the data & meta-data of file are persistent
after the return of fsync(), even when a power-failure occurs later.
In the case of fat-fs, the FAT belongs to the meta-data of file,
so we need to issue a flush after the writeback of FAT instead before.

Also bail out early when any stage of fsync fails.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 fs/fat/file.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/fat/file.c b/fs/fat/file.c
index b3bed32946b1..0e3ed79fcc3f 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -193,12 +193,17 @@ static int fat_file_release(struct inode *inode, struct file *filp)
 int fat_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
 {
 	struct inode *inode = filp->f_mapping->host;
-	int res, err;
+	int err;
+
+	err = __generic_file_fsync(filp, start, end, datasync);
+	if (err)
+		return err;
 
-	res = generic_file_fsync(filp, start, end, datasync);
 	err = sync_mapping_buffers(MSDOS_SB(inode->i_sb)->fat_inode->i_mapping);
+	if (err)
+		return err;
 
-	return res ? res : err;
+	return blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
 }
 
 
-- 
2.16.2.dirty

