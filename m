Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECF2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7BB2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713939;
	bh=ylOS2rTQstSyp/te4t3ka7xDfNKiaP1hAbYMcOV5Mw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a3HdltzDOPeD6YszjWk3b1QQu1/Au3YCa0YI3Dbhyo5OU4p5fcf9LzYy7jFVukJ66
	 XJfhahJwXzsSa+TiMeB2dVu7pGLqMyz++3VFiZKYpSbeSB0KDgVvBH6nTNfCrjv743
	 tEUjfdqmDRnWrz6lRV/XjLc0bZMtPZ/RjkhZ8bj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389090AbfC0TMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:12:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388822AbfC0SK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:10:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EBD921741;
        Wed, 27 Mar 2019 18:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710229;
        bh=ylOS2rTQstSyp/te4t3ka7xDfNKiaP1hAbYMcOV5Mw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cxPOH6n5rfFq1eNHlKVPevFaq5/7htllLpWtG0QIUrxxll93BCZabG4H+NwXo3BE8
         31wYBedU2xeNVCNSVgR1pL9iZ9C5RiYu2gkIAn0r9EPdRO4rp21XVsJ5+ggm+wMD8M
         +dAW3m7MVj5uJUNT93u/qtVU1S3O9/fLRbq00LkQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 003/192] f2fs: fix to adapt small inline xattr space in __find_inline_xattr()
Date:   Wed, 27 Mar 2019 14:07:15 -0400
Message-Id: <20190327181025.13507-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 2c28aba8b2e2a51749fa66e01b68e1cd5b53e022 ]

With below testcase, we will fail to find existed xattr entry:

1. mkfs.f2fs -O extra_attr -O flexible_inline_xattr /dev/zram0
2. mount -t f2fs -o inline_xattr_size=1 /dev/zram0 /mnt/f2fs/
3. touch /mnt/f2fs/file
4. setfattr -n "user.name" -v 0 /mnt/f2fs/file
5. getfattr -n "user.name" /mnt/f2fs/file

/mnt/f2fs/file: user.name: No such attribute

The reason is for inode which has very small inline xattr size,
__find_inline_xattr() will fail to traverse any entry due to first
entry may not be loaded from xattr node yet, later, we may skip to
check entire xattr datas in __find_xattr(), result in such wrong
condition.

This patch adds condition to check such case to avoid this issue.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/xattr.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 087e53a2d96c..409a637f7a92 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -227,11 +227,11 @@ static struct f2fs_xattr_entry *__find_inline_xattr(struct inode *inode,
 {
 	struct f2fs_xattr_entry *entry;
 	unsigned int inline_size = inline_xattr_size(inode);
+	void *max_addr = base_addr + inline_size;
 
 	list_for_each_xattr(entry, base_addr) {
-		if ((void *)entry + sizeof(__u32) > base_addr + inline_size ||
-			(void *)XATTR_NEXT_ENTRY(entry) + sizeof(__u32) >
-			base_addr + inline_size) {
+		if ((void *)entry + sizeof(__u32) > max_addr ||
+			(void *)XATTR_NEXT_ENTRY(entry) > max_addr) {
 			*last_addr = entry;
 			return NULL;
 		}
@@ -242,6 +242,13 @@ static struct f2fs_xattr_entry *__find_inline_xattr(struct inode *inode,
 		if (!memcmp(entry->e_name, name, len))
 			break;
 	}
+
+	/* inline xattr header or entry across max inline xattr size */
+	if (IS_XATTR_LAST_ENTRY(entry) &&
+		(void *)entry + sizeof(__u32) > max_addr) {
+		*last_addr = entry;
+		return NULL;
+	}
 	return entry;
 }
 
-- 
2.19.1

