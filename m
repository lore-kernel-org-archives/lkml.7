Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF13C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268D42087E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfEOUbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 16:31:22 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:55244 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfEOUbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 16:31:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 5E18B1801442F;
        Wed, 15 May 2019 22:31:20 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH] ubifs: Check link count of inodes when killing orphans.
Date:   Wed, 15 May 2019 22:31:13 +0200
Message-Id: <20190515203113.19398-1-richard@nod.at>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

O_TMPFILE files can change their link count back to non-zero.
This corner case needs to get addressed in the orphans subsystem
too.

Fixes: 474b93704f32 ("ubifs: Implement O_TMPFILE")
Reported-by: Lars Persson <lists@bofh.nu>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/orphan.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/fs/ubifs/orphan.c b/fs/ubifs/orphan.c
index 2f1618f300fb..575c36dfd751 100644
--- a/fs/ubifs/orphan.c
+++ b/fs/ubifs/orphan.c
@@ -642,6 +642,7 @@ static int do_kill_orphans(struct ubifs_info *c, struct ubifs_scan_leb *sleb,
 {
 	struct ubifs_scan_node *snod;
 	struct ubifs_orph_node *orph;
+	struct ubifs_ino_node *ino = NULL;
 	unsigned long long cmt_no;
 	ino_t inum;
 	int i, n, err, first = 1;
@@ -688,23 +689,40 @@ static int do_kill_orphans(struct ubifs_info *c, struct ubifs_scan_leb *sleb,
 		if (first)
 			first = 0;
 
+		ino = kmalloc(UBIFS_MAX_INO_NODE_SZ, GFP_NOFS);
+		if (!ino)
+			return -ENOMEM;
+
 		n = (le32_to_cpu(orph->ch.len) - UBIFS_ORPH_NODE_SZ) >> 3;
 		for (i = 0; i < n; i++) {
 			union ubifs_key key1, key2;
 
 			inum = le64_to_cpu(orph->inos[i]);
-			dbg_rcvry("deleting orphaned inode %lu",
-				  (unsigned long)inum);
 
-			lowest_ino_key(c, &key1, inum);
-			highest_ino_key(c, &key2, inum);
-
-			err = ubifs_tnc_remove_range(c, &key1, &key2);
+			ino_key_init(c, &key1, inum);
+			err = ubifs_tnc_lookup(c, &key1, ino);
 			if (err)
-				return err;
+				goto out_free;
+
+			/*
+			 * Check whether an inode can really get deleted.
+			 * linkat() with O_TMPFILE allows rebirth of an inode.
+			 */
+			if (ino->nlink == 0) {
+				dbg_rcvry("deleting orphaned inode %lu",
+					  (unsigned long)inum);
+
+				lowest_ino_key(c, &key1, inum);
+				highest_ino_key(c, &key2, inum);
+
+				err = ubifs_tnc_remove_range(c, &key1, &key2);
+				if (err)
+					goto out_err;
+			}
+
 			err = insert_dead_orphan(c, inum);
 			if (err)
-				return err;
+				goto out_err;
 		}
 
 		*last_cmt_no = cmt_no;
@@ -716,7 +734,10 @@ static int do_kill_orphans(struct ubifs_info *c, struct ubifs_scan_leb *sleb,
 			*last_flagged = 0;
 	}
 
-	return 0;
+	err = 0;
+out_free:
+	kfree(ino);
+	return err;
 }
 
 /**
-- 
2.16.4

