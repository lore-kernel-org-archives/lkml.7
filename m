Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001D4C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9B6216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfEOTlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 15:41:50 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:54036 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfEOTlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 15:41:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id DA84818186369;
        Wed, 15 May 2019 21:41:47 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Hyunchul Lee <hyc.lee@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] ubifs: Correctly use tnc_next() in search_dh_cookie()
Date:   Wed, 15 May 2019 21:41:40 +0200
Message-Id: <20190515194140.12265-1-richard@nod.at>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c877154d307f fixed an uninitialized variable and optimized
the function to not call tnc_next() in the first iteration of the
loop. While this seemed perfectly legit and wise, it turned out to
be illegal.
If the lookup function does not find an exact match it will rewind
the cursor by 1.
The rewinded cursor will not match the key we are looking for
and this results in a spurious -ENOENT.
So we need to move to the next entry in case of an non-exact match,
but not if the match was exact.

While we are here, update the documentation to avoid further confusion.

Cc: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: c877154d307f ("ubifs: Fix uninitialized variable in search_dh_cookie()")
Fixes: 781f675e2d7e ("ubifs: Fix unlink code wrt. double hash lookups")
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/tnc.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/ubifs/tnc.c b/fs/ubifs/tnc.c
index ebf8c26f5b22..8f3efc6263f0 100644
--- a/fs/ubifs/tnc.c
+++ b/fs/ubifs/tnc.c
@@ -1170,8 +1170,8 @@ static struct ubifs_znode *dirty_cow_bottom_up(struct ubifs_info *c,
  *   o exact match, i.e. the found zero-level znode contains key @key, then %1
  *     is returned and slot number of the matched branch is stored in @n;
  *   o not exact match, which means that zero-level znode does not contain
- *     @key, then %0 is returned and slot number of the closest branch is stored
- *     in @n;
+ *     @key, then %0 is returned and slot number of the closest branch or %-1
+ *     is stored in @n; In this case calling tnc_next() is mandatory.
  *   o @key is so small that it is even less than the lowest key of the
  *     leftmost zero-level node, then %0 is returned and %0 is stored in @n.
  *
@@ -1894,13 +1894,19 @@ int ubifs_tnc_lookup_nm(struct ubifs_info *c, const union ubifs_key *key,
 
 static int search_dh_cookie(struct ubifs_info *c, const union ubifs_key *key,
 			    struct ubifs_dent_node *dent, uint32_t cookie,
-			    struct ubifs_znode **zn, int *n)
+			    struct ubifs_znode **zn, int *n, int exact)
 {
 	int err;
 	struct ubifs_znode *znode = *zn;
 	struct ubifs_zbranch *zbr;
 	union ubifs_key *dkey;
 
+	if (!exact) {
+		err = tnc_next(c, &znode, n);
+		if (err)
+			return err;
+	}
+
 	for (;;) {
 		zbr = &znode->zbranch[*n];
 		dkey = &zbr->key;
@@ -1942,7 +1948,7 @@ static int do_lookup_dh(struct ubifs_info *c, const union ubifs_key *key,
 	if (unlikely(err < 0))
 		goto out_unlock;
 
-	err = search_dh_cookie(c, key, dent, cookie, &znode, &n);
+	err = search_dh_cookie(c, key, dent, cookie, &znode, &n, err);
 
 out_unlock:
 	mutex_unlock(&c->tnc_mutex);
@@ -2735,7 +2741,7 @@ int ubifs_tnc_remove_dh(struct ubifs_info *c, const union ubifs_key *key,
 		if (unlikely(err < 0))
 			goto out_free;
 
-		err = search_dh_cookie(c, key, dent, cookie, &znode, &n);
+		err = search_dh_cookie(c, key, dent, cookie, &znode, &n, err);
 		if (err)
 			goto out_free;
 	}
-- 
2.16.4

