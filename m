Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA68C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C9027452
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559395862;
	bh=tNoRIS4k70wOedviwPoL8m/3q8ML2UORzJJdUGoDJiQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=tGuFaZuD7Qrnty5ue5Y7IPAByfN1RYuZxbbmp8q/yJuDJMUTKdesR4xuXJ2DOOHpm
	 ReOJQfhArs88ilroEZxw5VAXX/UitdmB9QkvM+0UE1gSZu7tfyHdQqS1kGFZ8JSu7g
	 IIH6zBmaxx9RcR82ESUmlNtlhiPVRpzqsybNmuLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbfFANbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:31:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729616AbfFAN0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:26:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD3272739A;
        Sat,  1 Jun 2019 13:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395562;
        bh=tNoRIS4k70wOedviwPoL8m/3q8ML2UORzJJdUGoDJiQ=;
        h=From:To:Cc:Subject:Date:From;
        b=iwj2AJeCdtyG8SWvAN6sBdbx+6onW99sr6wuasRQb3G2Dn6go1bbkmTlOg1WD4Wlx
         pAI+5kdEUdKjpTxHSIRF95vXcm0rkfPA/JjARDAQ+6uOOeRUZu1NVAy1Xr3Cu9xCdl
         ptF4eTkke6Y2tJDowy+QWeoeiK4RjHpRFEPvVMJI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hou Tao <houtao1@huawei.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 01/56] fs/fat/file.c: issue flush after the writeback of FAT
Date:   Sat,  1 Jun 2019 09:25:05 -0400
Message-Id: <20190601132600.27427-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit bd8309de0d60838eef6fb575b0c4c7e95841cf73 ]

fsync() needs to make sure the data & meta-data of file are persistent
after the return of fsync(), even when a power-failure occurs later.  In
the case of fat-fs, the FAT belongs to the meta-data of file, so we need
to issue a flush after the writeback of FAT instead before.

Also bail out early when any stage of fsync fails.

Link: http://lkml.kernel.org/r/20190409030158.136316-1-houtao1@huawei.com
Signed-off-by: Hou Tao <houtao1@huawei.com>
Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fat/file.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/fat/file.c b/fs/fat/file.c
index a08f1039909a7..d3f655ae020b2 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -156,12 +156,17 @@ static int fat_file_release(struct inode *inode, struct file *filp)
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
2.20.1

