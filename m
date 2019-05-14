Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11735C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6F32086A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfENTLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 15:11:06 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:38878 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfENTLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 15:11:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 5F0911809AD8F;
        Tue, 14 May 2019 21:11:04 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/2] ubifs: Use correct config name for encryption
Date:   Tue, 14 May 2019 21:10:49 +0200
Message-Id: <20190514191050.13181-1-richard@nod.at>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_UBIFS_FS_ENCRYPTION is gone, fscrypt is now
controlled via CONFIG_FS_ENCRYPTION.
This problem slipped into the tree because of a mis-merge on
my side.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Fixes: eea2c05d927b ("ubifs: Remove #ifdef around CONFIG_FS_ENCRYPTION")
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/sb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/sb.c b/fs/ubifs/sb.c
index 2afc8b1d4c3b..3ca41965db6e 100644
--- a/fs/ubifs/sb.c
+++ b/fs/ubifs/sb.c
@@ -748,7 +748,7 @@ int ubifs_read_superblock(struct ubifs_info *c)
 		goto out;
 	}
 
-	if (!IS_ENABLED(CONFIG_UBIFS_FS_ENCRYPTION) && c->encrypted) {
+	if (!IS_ENABLED(CONFIG_FS_ENCRYPTION) && c->encrypted) {
 		ubifs_err(c, "file system contains encrypted files but UBIFS"
 			     " was built without crypto support.");
 		err = -EINVAL;
@@ -941,7 +941,7 @@ int ubifs_enable_encryption(struct ubifs_info *c)
 	int err;
 	struct ubifs_sb_node *sup = c->sup_node;
 
-	if (!IS_ENABLED(CONFIG_UBIFS_FS_ENCRYPTION))
+	if (!IS_ENABLED(CONFIG_FS_ENCRYPTION))
 		return -EOPNOTSUPP;
 
 	if (c->encrypted)
-- 
2.16.4

