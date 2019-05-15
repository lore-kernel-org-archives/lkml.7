Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74B9C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F512087E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfEOTwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 15:52:44 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:54328 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfEOTwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 15:52:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 1C3A01809AD8D;
        Wed, 15 May 2019 21:52:42 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH] ubifs: Don't leak orphans on memory during commit
Date:   Wed, 15 May 2019 21:52:34 +0200
Message-Id: <20190515195234.17090-1-richard@nod.at>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an orphan has child orphans (xattrs), and due
to a commit the parent orpahn cannot get free()'ed immediately,
put also all child orphans on the erase list.
Otherwise UBIFS will free() them only upon unmount and we
waste memory.

Fixes: 988bec41318f ("ubifs: orphan: Handle xattrs like files")
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/orphan.c | 50 ++++++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/fs/ubifs/orphan.c b/fs/ubifs/orphan.c
index 2f1618f300fb..7ae835d3f17a 100644
--- a/fs/ubifs/orphan.c
+++ b/fs/ubifs/orphan.c
@@ -138,25 +138,11 @@ static void __orphan_drop(struct ubifs_info *c, struct ubifs_orphan *o)
 	kfree(o);
 }
 
-static void orphan_delete(struct ubifs_info *c, ino_t inum)
+static void orphan_delete(struct ubifs_info *c, struct ubifs_orphan *orph)
 {
-	struct ubifs_orphan *orph, *child_orph, *tmp_o;
-
-	spin_lock(&c->orphan_lock);
-
-	orph = lookup_orphan(c, inum);
-	if (!orph) {
-		spin_unlock(&c->orphan_lock);
-		ubifs_err(c, "missing orphan ino %lu", (unsigned long)inum);
-		dump_stack();
-
-		return;
-	}
-
 	if (orph->del) {
 		spin_unlock(&c->orphan_lock);
-		dbg_gen("deleted twice ino %lu",
-			(unsigned long)inum);
+		dbg_gen("deleted twice ino %lu", orph->inum);
 		return;
 	}
 
@@ -165,19 +151,11 @@ static void orphan_delete(struct ubifs_info *c, ino_t inum)
 		orph->dnext = c->orph_dnext;
 		c->orph_dnext = orph;
 		spin_unlock(&c->orphan_lock);
-		dbg_gen("delete later ino %lu",
-			(unsigned long)inum);
+		dbg_gen("delete later ino %lu", orph->inum);
 		return;
 	}
 
-	list_for_each_entry_safe(child_orph, tmp_o, &orph->child_list, child_list) {
-		list_del(&child_orph->child_list);
-		__orphan_drop(c, child_orph);
-	}
-
 	__orphan_drop(c, orph);
-
-	spin_unlock(&c->orphan_lock);
 }
 
 /**
@@ -235,7 +213,27 @@ int ubifs_add_orphan(struct ubifs_info *c, ino_t inum)
  */
 void ubifs_delete_orphan(struct ubifs_info *c, ino_t inum)
 {
-	orphan_delete(c, inum);
+	struct ubifs_orphan *orph, *child_orph, *tmp_o;
+
+	spin_lock(&c->orphan_lock);
+
+	orph = lookup_orphan(c, inum);
+	if (!orph) {
+		spin_unlock(&c->orphan_lock);
+		ubifs_err(c, "missing orphan ino %lu", (unsigned long)inum);
+		dump_stack();
+
+		return;
+	}
+
+	orphan_delete(c, orph);
+
+	list_for_each_entry_safe(child_orph, tmp_o, &orph->child_list, child_list) {
+		list_del(&child_orph->child_list);
+		orphan_delete(c, child_orph);
+	}
+
+	spin_unlock(&c->orphan_lock);
 }
 
 /**
-- 
2.16.4

