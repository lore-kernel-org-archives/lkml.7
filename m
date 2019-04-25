Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A893C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B78D206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 13:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="bXrYeNvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbfDYNdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:33:06 -0400
Received: from sender4-pp-o95.zoho.com ([136.143.188.95]:25562 "EHLO
        sender4-pp-o95.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfDYNdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 09:33:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556199135; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=eWqfyXO8bSYbwmTzglfVYw+G/bc6uVPSXgV5zpMbyd7/pGbZhY2C4p6Zx/3xQ07gSQTbQ7QBjDoQztUEN43XbvCoav5utwf4Y6hSejHXI8QxATegVAkffENNvDa+nxC9R8/39YdeutrHh9rcvJ7uLLtQ+tAtMjwhMHecPJgVCGA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1556199135; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=FIxzx8ufezxHUGnlKslImct4gA4BATVr8SFi532iUlo=; 
        b=d9OV3+NJDXlItys5pHhkC/VLL+o7bwgYHmjNITIsiZ9lHIbK8jUot8r9KHTo2t+mUz6UHA1rPC0ytXTUrBkjSH/kQaND7wu1+0KCgbtEjJFg2xGAxQGcH7rZEJg2JeSe9HxyM3AqTr5959b4zOaUNu0+bm/rk3TCgE/+QnvLG18=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=Uu/tQ2GZuXQyCOgwBxFlEy0JwTFbrHsYg9eEvdWDl/0UBeMWleQYQdFsjYNkvxGcnpof3gGumjLR
    oN/jgJT81Dm5XaClA0ViAt0M9a4mqFgo8qhmW/y8R6zvfec7vsko  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1556199135;
        s=default; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        l=3402; bh=FIxzx8ufezxHUGnlKslImct4gA4BATVr8SFi532iUlo=;
        b=bXrYeNvL0TOjnFTMiTnmT+bnNUFNf0hxn8sWUNIyn4/PSq+9HhDK3yaaWAu791FW
        psGIvA6dgbJEMiJeindrjvzrtg8FSwj3Fnv+d4v6fgOSF/dcUTJW4ng55+ASEnPFrpd
        mkiZBmdnm/G2roZhkUVTiXsb7FjRgIMsRNtP6W5k=
Received: from YEHS1XR3054QMS.lenovo.com (123.120.108.196 [123.120.108.196]) by mx.zohomail.com
        with SMTPS id 1556199133111253.18143767731408; Thu, 25 Apr 2019 06:32:13 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     mpatocka@redhat.com, snitzer@redhat.com, agk@redhat.com
Cc:     prarit@redhat.com, chengnt@lenovo.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH v2 4/4] dm writecache: avoid unnecessary lookups in writecache_find_entry
Date:   Thu, 25 Apr 2019 21:31:20 +0800
Message-Id: <20190425133120.13088-5-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
In-Reply-To: <20190425133120.13088-1-yehs2007@zoho.com>
References: <20190425133120.13088-1-yehs2007@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

Only when entry has been found, that would only be necessary to check the
lowest or highest seq-count.

Add local variable "found" in writecache_find_entry, if no entry has been
found, it is meaningless that having a useless rb_prev or rb_next.

This patch is not designed for fixing logical error. That is used for
optimizing the behavior of writecache_find_entry.

Give an example to illustrate the point below.
Suppose that is the case, here is a normal READ bio comes to writecache_map.
And because of bio's direction is READ, writecache_find_entry would be called
with flags WFE_RETURN_FOLLOWING.

Now there are two scenarios,
1. writecache_find_entry successfully get an existing entry by searching
   rb_tree, we could call it HIT. Then the first 'while' will be finished by
   'break'. Next it will move to second 'while' loop, because of the flags
   hasn't been marked as WFE_LOWEST_SEQ. writecache_find_entry will try to
   return an entry with HIGHEST_SEQ, if there are other entries which has same
   original_sector in rb_tree.
   For this situation, the current code is okay to deal with that.

2. writecache_find_entry couldn't get an existing entry from rb_tree, we
   could call it MISS. Because of same flags WFE_RETURN_FOLLOWING,
   writecache_find_entry will get other entry, which's original_sector will
   slightly larger than input parameter block, with big probability.
   For this scenario, function writecache_find_entry doesn't need to enter
   second 'while' loop. But current code would still try to check there were
   other entry with same original_sector.
   So the additional rb_next or rb_prev is unnecessary by this case, also the
   code doesn't need to compare the original_sector of 'e2' with parameter
   'block'.

This patch is designed to optimize the second case. so it could skip the
second 'while' loop when the block is missed from rb_tree.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/md/dm-writecache.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index ddf1732..047ae09 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -537,14 +537,18 @@ static struct wc_entry *writecache_find_entry(struct dm_writecache *wc,
 {
 	struct wc_entry *e;
 	struct rb_node *node = wc->tree.rb_node;
+	bool found = false;
 
 	if (unlikely(!node))
 		return NULL;
 
 	while (1) {
 		e = container_of(node, struct wc_entry, rb_node);
-		if (read_original_sector(wc, e) == block)
+		if (read_original_sector(wc, e) == block) {
+			found = true;
 			break;
+		}
+
 		node = (read_original_sector(wc, e) >= block ?
 			e->rb_node.rb_left : e->rb_node.rb_right);
 		if (unlikely(!node)) {
@@ -564,7 +568,8 @@ static struct wc_entry *writecache_find_entry(struct dm_writecache *wc,
 		}
 	}
 
-	while (1) {
+	/* only need to check lowest or highest seq-count when entry has been found */
+	while (found) {
 		struct wc_entry *e2;
 		if (flags & WFE_LOWEST_SEQ)
 			node = rb_prev(&e->rb_node);
@@ -577,6 +582,9 @@ static struct wc_entry *writecache_find_entry(struct dm_writecache *wc,
 			return e;
 		e = e2;
 	}
+
+	/* no entry has been found, return the following entry */
+	return e;
 }
 
 static void writecache_insert_entry(struct dm_writecache *wc, struct wc_entry *ins)
-- 
1.8.3.1


