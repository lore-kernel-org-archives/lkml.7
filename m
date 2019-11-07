Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21EBC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC97B2085B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387448AbfKGP6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:58:03 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34606 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729761AbfKGP6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:58:03 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iSkAb-0002FZ-GZ; Thu, 07 Nov 2019 15:58:01 +0000
From:   Colin King <colin.king@canonical.com>
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] squashfs: generate uuid for the superblock rather than leaving it zero
Date:   Thu,  7 Nov 2019 15:58:01 +0000
Message-Id: <20191107155801.345452-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The squashfs superblock uuid is currently all zero and it can be useful
to have this set. Generate the uuid based on some of squashfs superblock
data to produce a reasonable uuid pattern.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/squashfs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 0cc4ceec0562..ac9d17e05fac 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -193,6 +193,12 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	err = -ENOMEM;
 
+	memcpy(&sb->s_uuid.b[0], &sblk->inodes, 4);
+	memcpy(&sb->s_uuid.b[4], &sblk->mkfs_time, 4);
+	memcpy(&sb->s_uuid.b[8], &sblk->fragments, 4);
+	memcpy(&sb->s_uuid.b[12], &sblk->compression, 2);
+	memcpy(&sb->s_uuid.b[14], &sblk->block_log, 2);
+
 	msblk->block_cache = squashfs_cache_init("metadata",
 			SQUASHFS_CACHED_BLKS, SQUASHFS_METADATA_SIZE);
 	if (msblk->block_cache == NULL)
-- 
2.20.1

