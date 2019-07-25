Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4854CC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1677B22CD2
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391425AbfGYJ7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 05:59:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55742 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390947AbfGYJ5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 05:57:31 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8D78B74370408627A714;
        Thu, 25 Jul 2019 17:57:26 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 25 Jul
 2019 17:57:18 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>,
        "David Sterba" <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v4 06/24] erofs: support special inode
Date:   Thu, 25 Jul 2019 17:56:40 +0800
Message-ID: <20190725095658.155779-7-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190725095658.155779-1-gaoxiang25@huawei.com>
References: <20190725095658.155779-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds to support special inode, such as
block dev, char, socket, pipe inode.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/inode.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index b6ea997bc4ae..637bf6e4de44 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -34,7 +34,16 @@ static int read_inode(struct inode *inode, void *data)
 		vi->xattr_isize = ondisk_xattr_ibody_size(v2->i_xattr_icount);
 
 		inode->i_mode = le16_to_cpu(v2->i_mode);
-		vi->raw_blkaddr = le32_to_cpu(v2->i_u.raw_blkaddr);
+		if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
+		    S_ISLNK(inode->i_mode))
+			vi->raw_blkaddr = le32_to_cpu(v2->i_u.raw_blkaddr);
+		else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
+			inode->i_rdev =
+				new_decode_dev(le32_to_cpu(v2->i_u.rdev));
+		else if (S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode))
+			inode->i_rdev = 0;
+		else
+			return -EIO;
 
 		i_uid_write(inode, le32_to_cpu(v2->i_uid));
 		i_gid_write(inode, le32_to_cpu(v2->i_gid));
@@ -58,7 +67,16 @@ static int read_inode(struct inode *inode, void *data)
 		vi->xattr_isize = ondisk_xattr_ibody_size(v1->i_xattr_icount);
 
 		inode->i_mode = le16_to_cpu(v1->i_mode);
-		vi->raw_blkaddr = le32_to_cpu(v1->i_u.raw_blkaddr);
+		if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
+		    S_ISLNK(inode->i_mode))
+			vi->raw_blkaddr = le32_to_cpu(v1->i_u.raw_blkaddr);
+		else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
+			inode->i_rdev =
+				new_decode_dev(le32_to_cpu(v1->i_u.rdev));
+		else if (S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode))
+			inode->i_rdev = 0;
+		else
+			return -EIO;
 
 		i_uid_write(inode, le16_to_cpu(v1->i_uid));
 		i_gid_write(inode, le16_to_cpu(v1->i_gid));
@@ -176,6 +194,11 @@ static int fill_inode(struct inode *inode, int isdir)
 			/* by default, page_get_link is used for symlink */
 			inode->i_op = &erofs_symlink_iops;
 			inode_nohighmem(inode);
+		} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
+			S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
+			inode->i_op = &erofs_generic_iops;
+			init_special_inode(inode, inode->i_mode, inode->i_rdev);
+			goto out_unlock;
 		} else {
 			err = -EIO;
 			goto out_unlock;
-- 
2.17.1

