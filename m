Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43912C17440
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170412196E
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355642;
	bh=WlfZxGvFtSLI+pDvBdYGRlWued5mo0mUhIgQQNCXeqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IYa5BXAIwkAlCj0jUL0ka2on4jsI9ydjO6Voci5EVK78JbqHCXnV7EosKQ6Lfd1mr
	 TplaWi4F5+t4ZdWa5OZMr9fNFNk6usqPbBeGGz4OLqo9rEO6G4upNXoWKO4v67B66E
	 xtiwgP2CYrLqmx8b2UBwEVO3FD0C/yUiUJhCoNm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfKJCmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:42:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:38422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727870AbfKJCm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:42:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEFF5214E0;
        Sun, 10 Nov 2019 02:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353749;
        bh=WlfZxGvFtSLI+pDvBdYGRlWued5mo0mUhIgQQNCXeqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QPn3WViVcnS+QtD7yxdGqBcrqqJKQL2bNe2arfBuIRlCI9CwZHwlgX5kVVa9+Jsyp
         szF0xl3xIVMha+bNVbArT3SOcHosrJPhxVE7nqaXIDFr5mBo7YOPFC+EnpJuOpYD6E
         WVhMniM12gs/RmC2pX+/8cCW3LBeeyYxpW6Op7Ck=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 065/191] f2fs: fix to recover inode's uid/gid during POR
Date:   Sat,  9 Nov 2019 21:38:07 -0500
Message-Id: <20191110024013.29782-65-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit dc4cd1257c86451cec3e8e352cc376348e4f4af4 ]

Step to reproduce this bug:
1. logon as root
2. mount -t f2fs /dev/sdd /mnt;
3. touch /mnt/file;
4. chown system /mnt/file; chgrp system /mnt/file;
5. xfs_io -f /mnt/file -c "fsync";
6. godown /mnt;
7. umount /mnt;
8. mount -t f2fs /dev/sdd /mnt;

After step 8) we will expect file's uid/gid are all system, but during
recovery, these two fields were not been recovered, fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/recovery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 2c3be4c3c626f..2c5d2c25d37e3 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -216,6 +216,8 @@ static void recover_inode(struct inode *inode, struct page *page)
 	char *name;
 
 	inode->i_mode = le16_to_cpu(raw->i_mode);
+	i_uid_write(inode, le32_to_cpu(raw->i_uid));
+	i_gid_write(inode, le32_to_cpu(raw->i_gid));
 	f2fs_i_size_write(inode, le64_to_cpu(raw->i_size));
 	inode->i_atime.tv_sec = le64_to_cpu(raw->i_atime);
 	inode->i_ctime.tv_sec = le64_to_cpu(raw->i_ctime);
-- 
2.20.1

