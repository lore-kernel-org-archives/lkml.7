Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ED2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07712183E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368884;
	bh=L03sWGSzCRI33CQfZq6LqjYjqSkFPf6cQEBw6oms8lE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ejKt+ZiRkHLeRS6QjiLrb0flIPEm/VBYg54JSG2cW9djMM2o8pxWMjkiPvAf6PXiZ
	 usPyR4nHI2Wy5pMSLjR8KmfYi17J4lO+kawz6nHsa2jEai5NpZKgP/XzlOooCUIXDk
	 C+HMdLofry86wLV27jqxMdYUVz5QhqByQoE24xwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732603AbfDDJID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:08:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731445AbfDDJHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:07:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5341C214AF;
        Thu,  4 Apr 2019 09:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368874;
        bh=L03sWGSzCRI33CQfZq6LqjYjqSkFPf6cQEBw6oms8lE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQwUgq+e83TrI9vU8v+Eetohuc6pnHndy+JQu7y6lCUWuG9Mx/3GlSFXZEBJBEMGU
         dqCztXhoOAUNWH7g/fzywFwKUQMZjfKPi1eAbhwlMeEy2Zbxiv0lErX0K1pl9D9jEf
         fMp25Owe5Gqn9J+IBydTy9AZsplxOcVF04RoQkP8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 006/246] f2fs: fix to adapt small inline xattr space in __find_inline_xattr()
Date:   Thu,  4 Apr 2019 10:45:06 +0200
Message-Id: <20190404084619.453213450@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 18d5ffbc5e8c..73b92985198b 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -224,11 +224,11 @@ static struct f2fs_xattr_entry *__find_inline_xattr(struct inode *inode,
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
@@ -239,6 +239,13 @@ static struct f2fs_xattr_entry *__find_inline_xattr(struct inode *inode,
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



