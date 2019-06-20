Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715D0C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514D620665
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561055380;
	bh=CuS6uZSJ7lgfSoK+W+xGUsXBrvbKOJRcbUYbcj8uS5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vl5CH8RDm6coIyVQ09FC6brPn/Hvl3LdRkQzGp+ALrw7qzHhI5kvK9tM+XbYAVFT2
	 KZGDT/aIN5kGg6yfjMssBFIrY/2iHxkWufdw3rUXnoh8vUZS8lvVeEePLBuT6L3vVi
	 y/lnCmZJe9bP0FgwHEh6HCKgVDG9hXZnPmc8/2TM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfFTS3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:29:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727418AbfFTSCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:02:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D1932084A;
        Thu, 20 Jun 2019 18:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053740;
        bh=CuS6uZSJ7lgfSoK+W+xGUsXBrvbKOJRcbUYbcj8uS5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GeOcTmw+vovFMsj5jM7KfT/96BCBT8jq1/4uH5JevaqBuGifPwU9jQu9bZAp1j87O
         rSjUl2Mg0n1jn4oClKL29Y+xTdJPLYxMwmElhDE2fYYBJU1pGb7rxApfhfb4ZFp+IP
         iYjHG7gY25l7myNUmVZDbrqimCu3qT2isacyER7w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hou Tao <houtao1@huawei.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 002/117] fs/fat/file.c: issue flush after the writeback of FAT
Date:   Thu, 20 Jun 2019 19:55:36 +0200
Message-Id: <20190620174352.105648515@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174351.964339809@linuxfoundation.org>
References: <20190620174351.964339809@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 3d04b124bce0..392ec5641f38 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -160,12 +160,17 @@ static int fat_file_release(struct inode *inode, struct file *filp)
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



