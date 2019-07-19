Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3C1C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1A6206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563511207;
	bh=rfp2mhSWp3ECQi2RiDeADP41GduMWU6Ii4yw3ZaWYKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=apvqe2JQ+U7sOdhymGjTieVtwlxloCbvaRidY3cw5xqeWPEAJtHt5HWNaEgnj8KFH
	 Zd7+216Q+G82WhnayhUH/a6cYuXRzErQyl18q2vDejwtZByRd33CEUH9YojX0osIt2
	 a/H+5Pt7eJQ+ODwzTtnp0BuA+aZ3zsuS4XzwnLSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfGSD6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 23:58:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbfGSD6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 23:58:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E5FC2186A;
        Fri, 19 Jul 2019 03:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508698;
        bh=rfp2mhSWp3ECQi2RiDeADP41GduMWU6Ii4yw3ZaWYKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g1ByPGDcIhqTW/FW7oPHcBZx+jxkENw3/9A2qpJZSm4BGHM5cKy92IWmix+koJmEN
         Xe+icS4gvHyNFa6Eo9nue0Q/c1hQbyDEEVct0hdjuTHeI0Ia7x9wCz0jiDLp+otmTs
         g7OvH4ik5d7Aof1jpAzC2VQanq6306nQaOcHNrMw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Rosenberg <drosen@google.com>, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.2 038/171] f2fs: Fix accounting for unusable blocks
Date:   Thu, 18 Jul 2019 23:54:29 -0400
Message-Id: <20190719035643.14300-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Rosenberg <drosen@google.com>

[ Upstream commit a4c3ecaaadac5693f555cfef1c9eecf4c39df818 ]

Fixes possible underflows when dealing with unusable blocks.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d1b64cb77326..9e6721e15b24 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1767,8 +1767,12 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 
 	if (!__allow_reserved_blocks(sbi, inode, true))
 		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
-	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
-		avail_user_block_count -= sbi->unusable_block_count;
+	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
+		if (avail_user_block_count > sbi->unusable_block_count)
+			avail_user_block_count -= sbi->unusable_block_count;
+		else
+			avail_user_block_count = 0;
+	}
 	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
 		diff = sbi->total_valid_block_count - avail_user_block_count;
 		if (diff > *count)
@@ -1968,7 +1972,7 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 					struct inode *inode, bool is_inode)
 {
 	block_t	valid_block_count;
-	unsigned int valid_node_count;
+	unsigned int valid_node_count, user_block_count;
 	int err;
 
 	if (is_inode) {
@@ -1995,10 +1999,11 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 
 	if (!__allow_reserved_blocks(sbi, inode, false))
 		valid_block_count += F2FS_OPTION(sbi).root_reserved_blocks;
+	user_block_count = sbi->user_block_count;
 	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
-		valid_block_count += sbi->unusable_block_count;
+		user_block_count -= sbi->unusable_block_count;
 
-	if (unlikely(valid_block_count > sbi->user_block_count)) {
+	if (unlikely(valid_block_count > user_block_count)) {
 		spin_unlock(&sbi->stat_lock);
 		goto enospc;
 	}
-- 
2.20.1

