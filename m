Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556A0C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203972654B
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559395410;
	bh=Alw0lthfCLmtbgTfq7jRYqausoeIl0hgDtrnSur8zhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mncgSSNbPMJKE4WQmm18Xc33osyCY0PShfYSkcx3FLqGpi+ME6tqMXG+2v1LOccNf
	 JWyz/MF6TzQmHa65t42R1u/nhM+vrs3PRUOIdM1H57e5VC5SpcrXUpxmQcT9bn4004
	 KblTELaQmh1MfbZa1829t7lN62AsSzUim6Yp5s10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfFANX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:23:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728978AbfFANXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:23:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F58A27357;
        Sat,  1 Jun 2019 13:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395400;
        bh=Alw0lthfCLmtbgTfq7jRYqausoeIl0hgDtrnSur8zhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hp4cRQ1NB9mu2T2Pg8OFkplQ8dUVNqVzbo7aCFURKMW5ZqnJ6LoNFBO7G908HfgGY
         PfCWF6XpSQxdczDYRkpgJLNpriK43TTvClXb3B1ORhvgBXFIdeugM1Jrw+sGnNmoCv
         nScT5/E0JZcrJJ0dOtRnpypV2nsP0DCtx+FyNd4c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 040/141] f2fs: fix to use inline space only if inline_xattr is enable
Date:   Sat,  1 Jun 2019 09:20:16 -0400
Message-Id: <20190601132158.25821-40-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601132158.25821-1-sashal@kernel.org>
References: <20190601132158.25821-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 622927f3b8809206f6da54a6a7ed4df1a7770fce ]

With below mkfs and mount option:

MKFS_OPTIONS  -- -O extra_attr -O project_quota -O inode_checksum -O flexible_inline_xattr -O inode_crtime -f
MOUNT_OPTIONS -- -o noinline_xattr

We may miss xattr data with below testcase:
- mkdir dir
- setfattr -n "user.name" -v 0 dir
- for ((i = 0; i < 190; i++)) do touch dir/$i; done
- umount
- mount
- getfattr -n "user.name" dir

user.name: No such attribute

The root cause is that we persist xattr data into reserved inline xattr
space, even if inline_xattr is not enable in inline directory inode, after
inline dentry conversion, reserved space no longer exists, so that xattr
data missed.

Let's use inline xattr space only if inline_xattr flag is set on inode
to fix this iusse.

Fixes: 6afc662e68b5 ("f2fs: support flexible inline xattr size")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1f3bf039a90e8..51eea636719a2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2486,7 +2486,9 @@ static inline void *inline_xattr_addr(struct inode *inode, struct page *page)
 
 static inline int inline_xattr_size(struct inode *inode)
 {
-	return get_inline_xattr_addrs(inode) * sizeof(__le32);
+	if (f2fs_has_inline_xattr(inode))
+		return get_inline_xattr_addrs(inode) * sizeof(__le32);
+	return 0;
 }
 
 static inline int f2fs_has_inline_data(struct inode *inode)
-- 
2.20.1

