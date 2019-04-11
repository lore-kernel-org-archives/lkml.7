Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01CDC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BFA217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfDKDsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:48:17 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2525 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726564AbfDKDsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:48:17 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id C92DE312FB42AC07EC94;
        Thu, 11 Apr 2019 11:48:15 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 11 Apr 2019 11:48:15 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 11 Apr 2019 11:48:14 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: fix to retrieve inline xattr space
Date:   Thu, 11 Apr 2019 11:48:09 +0800
Message-ID: <20190411034810.12283-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With below mkfs and mount option, generic/339 of fstest will report that
scratch image becomes corrupted.

MKFS_OPTIONS  -- -O extra_attr -O project_quota -O inode_checksum -O flexible_inline_xattr -O inode_crtime -f /dev/zram1
MOUNT_OPTIONS -- -o acl,user_xattr -o discard,noinline_xattr /dev/zram1 /mnt/scratch_f2fs

[ASSERT] (f2fs_check_dirent_position:1315)  --> Wrong position of dirent pino:1970, name: (...)
level:8, dir_level:0, pgofs:951, correct range:[900, 901]

In old kernel, inline data and directory always reserved 200 bytes in
inode layout, even if inline_xattr is disabled, then new kernel tries
to retrieve that space for non-inline xattr inode, but for inline dentry,
its layout size should be fixed, so we just keep that reserved space.

But the problem here is that, after inline dentry conversion, inline
dentry layout no longer exists, if we still reserve inline xattr space,
after dents updates, there will be a hole in inline xattr space, which
can break hierarchy hash directory structure.

This patch fixes this issue by retrieving inline xattr space after
inline dentry conversion.

Fixes: 6afc662e68b5 ("f2fs: support flexible inline xattr size")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/inline.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index bb6a152310ef..404d2462a0fe 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -420,6 +420,14 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct page *ipage,
 	stat_dec_inline_dir(dir);
 	clear_inode_flag(dir, FI_INLINE_DENTRY);
 
+	/*
+	 * should retrieve reserved space which was used to keep
+	 * inline_dentry's structure for backward compatibility.
+	 */
+	if (!f2fs_sb_has_flexible_inline_xattr(F2FS_I_SB(dir)) &&
+			!f2fs_has_inline_xattr(dir))
+		F2FS_I(dir)->i_inline_xattr_size = 0;
+
 	f2fs_i_depth_write(dir, 1);
 	if (i_size_read(dir) < PAGE_SIZE)
 		f2fs_i_size_write(dir, PAGE_SIZE);
@@ -501,6 +509,15 @@ static int f2fs_move_rehashed_dirents(struct inode *dir, struct page *ipage,
 
 	stat_dec_inline_dir(dir);
 	clear_inode_flag(dir, FI_INLINE_DENTRY);
+
+	/*
+	 * should retrieve reserved space which was used to keep
+	 * inline_dentry's structure for backward compatibility.
+	 */
+	if (!f2fs_sb_has_flexible_inline_xattr(F2FS_I_SB(dir)) &&
+			!f2fs_has_inline_xattr(dir))
+		F2FS_I(dir)->i_inline_xattr_size = 0;
+
 	kvfree(backup_dentry);
 	return 0;
 recover:
-- 
2.18.0.rc1

