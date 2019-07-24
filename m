Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C89C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320AF21738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbfGXNIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 09:08:11 -0400
Received: from hermes.aosc.io ([199.195.250.187]:51800 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbfGXNIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 09:08:11 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 3227C6DF8F;
        Wed, 24 Jul 2019 13:08:07 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH] f2fs: use EINVAL for invalid superblock
Date:   Wed, 24 Jul 2019 21:06:56 +0800
Message-Id: <20190724130656.29436-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel mount_block_root() function expects -EACESS or -EINVAL for a
unmountable filesystem when trying to mount the root with different
filesystem types.

However, in 5.3-rc1 the behavior when F2FS code cannot find valid block
changed to return -EFSCORRUPTED(-EUCLEAN), and this error code makes
mount_block_root() fail when trying to probe F2FS. As invalid
superblocks mean the filesystem cannot be recognized as F2FS (it might
be another FS), returning -EINVAL seems more reasonable, and other
filesystems also do this.

Change back the return value to -EINVAL when no valid superblocks are
found.

Fixes: 10f966bbf521 ("f2fs: use generic EFSBADCRC/EFSCORRUPTED")
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
This commit fixes a regression introduced in v5.3-rc1, which leads to
btrfs / cannot be mounted if no initrd is used and both f2fs and btrfs
are built-in.

 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6de6cda44031..949309b9f1b8 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2873,7 +2873,7 @@ static int read_raw_super_block(struct f2fs_sb_info *sbi,
 		if (sanity_check_raw_super(sbi, bh)) {
 			f2fs_err(sbi, "Can't find valid F2FS filesystem in %dth superblock",
 				 block + 1);
-			err = -EFSCORRUPTED;
+			err = -EINVAL;
 			brelse(bh);
 			continue;
 		}
-- 
2.21.0

