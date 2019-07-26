Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC51C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4826722CD8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564148966;
	bh=xDfCWhVDseD5mMcFkZluXYrX2Kjuu5L7Kf1DwzxIokc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vyUWAN3zs+TK8WIrqjgQfWFPTNK7/9g23oAzkAYIiC5XHuzQbJixFHM7w1fcltnMq
	 H5HErhSXM8QnIvjtgphyyf1P2dCLVsrWslPJ10n26ndeCQOcA0loC4XVTBovHdJI/X
	 c8/i7NPbUW6Wvco26/ZCTpO0MvZXYlBaWbfWs28E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388167AbfGZNtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:49:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387657AbfGZNop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:44:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE1F822CD0;
        Fri, 26 Jul 2019 13:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148685;
        bh=xDfCWhVDseD5mMcFkZluXYrX2Kjuu5L7Kf1DwzxIokc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yk6Ai07vMVP0fxCisyx72EW3NnLhe74QccezAVvX37vcT6YL0B+lPIgglZMvXTmIy
         Ve291i1YGQNRmvYCnA0+X/NNZ4ZKmjtqcWoEI2KsKcCTqf+fEo9CS/gNaM2YZKTVvz
         5brzwea6dv795hldL3R8/aEUFslPSaN+7U7RETJ8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 09/30] fs/adfs: super: fix use-after-free bug
Date:   Fri, 26 Jul 2019 09:44:11 -0400
Message-Id: <20190726134432.12993-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726134432.12993-1-sashal@kernel.org>
References: <20190726134432.12993-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 5808b14a1f52554de612fee85ef517199855e310 ]

Fix a use-after-free bug during filesystem initialisation, where we
access the disc record (which is stored in a buffer) after we have
released the buffer.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/adfs/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index c9fdfb112933..e42c30001509 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -368,6 +368,7 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 	struct buffer_head *bh;
 	struct object_info root_obj;
 	unsigned char *b_data;
+	unsigned int blocksize;
 	struct adfs_sb_info *asb;
 	struct inode *root;
 	int ret = -EINVAL;
@@ -419,8 +420,10 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 		goto error_free_bh;
 	}
 
+	blocksize = 1 << dr->log2secsize;
 	brelse(bh);
-	if (sb_set_blocksize(sb, 1 << dr->log2secsize)) {
+
+	if (sb_set_blocksize(sb, blocksize)) {
 		bh = sb_bread(sb, ADFS_DISCRECORD / sb->s_blocksize);
 		if (!bh) {
 			adfs_error(sb, "couldn't read superblock on "
-- 
2.20.1

