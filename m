Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD377C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79B8214DE
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573921327;
	bh=On0GqOyxsloTEVa6hsuBGk6Zfg6op1AFEmlN8rwIm8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1J9fFvBhbQUs/WoYl2cHsRZJttjzdVbDYRiw9Mx0Zs++jK5q3b6WHSNeSN8KcvQpj
	 H0F9aHhRemO43uT0ikkJL6p8spgLWfezn4MFZrS9uryrwzXpabvJY9kLyD2JrKJA5F
	 lfHESKXIQzYHd24n6cK0was3IgBbq1sZCTUieqZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbfKPQWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:22:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:47352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728693AbfKPPnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:43:22 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5523207DD;
        Sat, 16 Nov 2019 15:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919002;
        bh=On0GqOyxsloTEVa6hsuBGk6Zfg6op1AFEmlN8rwIm8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QApM3epZXKxZXlA3fT7DxgTL1u3w5bzuDDYzbzjDfTkG1C5msEW1bh+iLgmUfqZoO
         QJnR29TAM4WdmTlmGGuwlVAxQ/866kOeqBJhLMzSqI8T7a7aX94mTwbma1UqWCBycz
         S53UZ2SP99xY14cZVCyp+ztDEeyKtzx0rCxksteM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 105/237] f2fs: spread f2fs_set_inode_flags()
Date:   Sat, 16 Nov 2019 10:39:00 -0500
Message-Id: <20191116154113.7417-105-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 9149a5eb606152df158eb7d7da5a34e84b574189 ]

This patch changes codes as below:
- use f2fs_set_inode_flags() to update i_flags atomically to avoid
potential race.
- synchronize F2FS_I(inode)->i_flags to inode->i_flags in
f2fs_new_inode().
- use f2fs_set_inode_flags() to simply codes in f2fs_quota_{on,off}.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h  | 2 +-
 fs/f2fs/namei.c | 2 ++
 fs/f2fs/super.c | 5 ++---
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index fb216488d67a9..c9d19832426b1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3387,7 +3387,7 @@ static inline void f2fs_set_encrypted_inode(struct inode *inode)
 {
 #ifdef CONFIG_F2FS_FS_ENCRYPTION
 	file_set_encrypt(inode);
-	inode->i_flags |= S_ENCRYPTED;
+	f2fs_set_inode_flags(inode);
 #endif
 }
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 1f67e389169f5..6b23dcbf52f45 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -124,6 +124,8 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	if (F2FS_I(inode)->i_flags & F2FS_PROJINHERIT_FL)
 		set_inode_flag(inode, FI_PROJ_INHERIT);
 
+	f2fs_set_inode_flags(inode);
+
 	trace_f2fs_new_inode(inode, 0);
 	return inode;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d9106bbe7df63..7aefb2c35c48f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1835,8 +1835,7 @@ static int f2fs_quota_on(struct super_block *sb, int type, int format_id,
 
 	inode_lock(inode);
 	F2FS_I(inode)->i_flags |= F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL;
-	inode_set_flags(inode, S_NOATIME | S_IMMUTABLE,
-					S_NOATIME | S_IMMUTABLE);
+	f2fs_set_inode_flags(inode);
 	inode_unlock(inode);
 	f2fs_mark_inode_dirty_sync(inode, false);
 
@@ -1861,7 +1860,7 @@ static int f2fs_quota_off(struct super_block *sb, int type)
 
 	inode_lock(inode);
 	F2FS_I(inode)->i_flags &= ~(F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL);
-	inode_set_flags(inode, 0, S_NOATIME | S_IMMUTABLE);
+	f2fs_set_inode_flags(inode);
 	inode_unlock(inode);
 	f2fs_mark_inode_dirty_sync(inode, false);
 out_put:
-- 
2.20.1

