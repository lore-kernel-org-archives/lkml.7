Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57333C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2606B2183E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368398;
	bh=cOGDFI3eduanPU7WQB4Sc5tRC6VBg7S9g2FDSprIGZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iDZBuEgaO8HBQ0QnoaoTsXi9Pb+BPOX5ln9rKb196ABnI6h/D6B45VMjG1O+9U5N1
	 s1JAVY1jv65VyjHfgyq5ZiBthwtHmEPRW2sllO0FVwmqFUqG34G1myS6vmsyHt7Xzp
	 Tu4DfI0Z2gLUzznB1cA/FuHRWmYJ99uSYKEOb4bg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbfDDI74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:59:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729877AbfDDI7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:59:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5BB12147C;
        Thu,  4 Apr 2019 08:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368390;
        bh=cOGDFI3eduanPU7WQB4Sc5tRC6VBg7S9g2FDSprIGZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fMtJioHf70mjx0GoBf/+WLd08blR1XJbsLj45EMwTFnpZOCNix0p7mN1+B+qd9NZV
         vKA20wDUiccSLB1jH7kxydPe1CG1Iil8ImCDLVIzNYxUvXskpMh8RX5VPHNfc3uLDD
         FPSxsngZmpaowXIsi6/UgK/9pOfUp+eu+WXTloYs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 007/187] f2fs: fix to adapt small inline xattr space in __find_inline_xattr()
Date:   Thu,  4 Apr 2019 10:45:44 +0200
Message-Id: <20190404084603.436273149@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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



