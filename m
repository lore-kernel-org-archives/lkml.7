Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9300C5B57F
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 07:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82639208E3
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 07:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktK1glWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfF3H5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 03:57:53 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41060 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfF3H5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 03:57:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id m7so5618075pls.8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 00:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nxftnCjIEQpWbwgWZSx8BIfGJCBns1iLh6SzpZmtbiE=;
        b=ktK1glWWrBl226F3ADBsgn7Lebms57E7xib2RJiCjFKx64NaTK2hFsFR/JmdqKEl3K
         0H/VsU/2Vt+wALUGFhlHPGe955ps59+k20huhws6WNy2/tcFKHi1bM0bQVGxOFFbkGMH
         OeYXJ6FsBk4teBCvUHV24lcsS9ArxDZvgZsKgK7BdeTg9unipJT4Sb5o7Pno6rv+Ofbv
         ly4zBkDt6K4aH1aaQBwkkt+PsZtSk00TkIPMhi21ioC4p2GSIgv/b55rPt2y3Qn8sMch
         KNAA+zIwi33UgucUZMIQ3Waxm2rMkERm25v/J4o7+L+nkaEKzAmD1WI1WYQab57vgliN
         4XTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nxftnCjIEQpWbwgWZSx8BIfGJCBns1iLh6SzpZmtbiE=;
        b=SUqy75ccLHkPvsu0Op9yJVecmOZoIEmDN+KGmQfmnbvWwqpAAykAkh38j4OlJDz9VQ
         U1yZ7O2AkJa3N1X8ZJtpP/KlY+7vPLklJcjks7rkMEmqer5pW9AlFDuvB/AY9fqcJ1EP
         qZA6M4s9XklmKvW8ZG6yugOfC6ZfyneurYD/LFbCNAq2/egU6pe+zf7LNizt6o/OnpYY
         LoiaPVDldOJvlM4EkUgMfy3O9MCShb0pM8D59VOYQZLrmEqBaNvjIbnJzzgKTgSVY5WX
         Ns0JGT1T6vIxI8E7S7SpiK5T1guMZm+XSm8npdL9b/+CAWb8veYzpUeFwh8AibBjq0It
         sEXw==
X-Gm-Message-State: APjAAAX18g3dBCJpru2IltxTUU6jOLJdjRmSYt6UqzlBDfJlM6jjoJaY
        Tr5Jaux3ACBbPdqNC8b8uCExa6lDxuc=
X-Google-Smtp-Source: APXvYqydlAs6fVf6yumM50GFkwLzEfVrLeuFejNMuXa2BOnpV7IlTmQr7c4pwH7JkUCuqBMJH6xI1g==
X-Received: by 2002:a17:902:fe0e:: with SMTP id g14mr6149249plj.250.1561881472818;
        Sun, 30 Jun 2019 00:57:52 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:648:b8c3:8577:bf2f:2])
        by smtp.gmail.com with ESMTPSA id w10sm5989637pgs.32.2019.06.30.00.57.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 00:57:52 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org, peterz@infradead.org, urezki@gmail.com
Cc:     rpenyaev@suse.de, mhocko@suse.com, guro@fb.com,
        aryabinin@virtuozzo.com, rppt@linux.ibm.com, mingo@kernel.org,
        rick.p.edgecombe@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH 4/5] mm/vmalloc.c: Modify function merge_or_add_vmap_area() for readability
Date:   Sun, 30 Jun 2019 15:56:49 +0800
Message-Id: <20190630075650.8516-5-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630075650.8516-1-lpf.vector@gmail.com>
References: <20190630075650.8516-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since function merge_or_add_vmap_area() is only used to
merge or add vmap area to the *FREE* tree, so rename it
to merge_or_add_va_to_free_tree.

Then this is obvious, merge_or_add_vmap_area() does not
need parameters root and head, so remove them.

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
---
 mm/vmalloc.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 1beb5bcfb450..4148d6fdfb6d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -688,8 +688,7 @@ insert_va_to_free_tree(struct vmap_area *va, struct rb_node *from)
  * freed.
  */
 static __always_inline void
-merge_or_add_vmap_area(struct vmap_area *va,
-	struct rb_root *root, struct list_head *head)
+merge_or_add_va_to_free_tree(struct vmap_area *va)
 {
 	struct vmap_area *sibling;
 	struct list_head *next;
@@ -701,7 +700,7 @@ merge_or_add_vmap_area(struct vmap_area *va,
 	 * Find a place in the tree where VA potentially will be
 	 * inserted, unless it is merged with its sibling/siblings.
 	 */
-	link = find_va_links(va, root, NULL, &parent);
+	link = find_va_links(va, &free_vmap_area_root, NULL, &parent);
 
 	/*
 	 * Get next node of VA to check if merging can be done.
@@ -717,7 +716,7 @@ merge_or_add_vmap_area(struct vmap_area *va,
 	 *                  |                |
 	 *                  start            end
 	 */
-	if (next != head) {
+	if (next != &free_vmap_area_list) {
 		sibling = list_entry(next, struct vmap_area, list);
 		if (sibling->va_start == va->va_end) {
 			sibling->va_start = va->va_start;
@@ -725,9 +724,6 @@ merge_or_add_vmap_area(struct vmap_area *va,
 			/* Check and update the tree if needed. */
 			augment_tree_propagate_from(sibling);
 
-			/* Remove this VA, it has been merged. */
-			unlink_va(va, root);
-
 			/* Free vmap_area object. */
 			kmem_cache_free(vmap_area_cachep, va);
 
@@ -744,7 +740,7 @@ merge_or_add_vmap_area(struct vmap_area *va,
 	 *                  |                |
 	 *                  start            end
 	 */
-	if (next->prev != head) {
+	if (next->prev != &free_vmap_area_list) {
 		sibling = list_entry(next->prev, struct vmap_area, list);
 		if (sibling->va_end == va->va_start) {
 			sibling->va_end = va->va_end;
@@ -753,7 +749,8 @@ merge_or_add_vmap_area(struct vmap_area *va,
 			augment_tree_propagate_from(sibling);
 
 			/* Remove this VA, it has been merged. */
-			unlink_va(va, root);
+			if (merged)
+				unlink_va(va, &free_vmap_area_root);
 
 			/* Free vmap_area object. */
 			kmem_cache_free(vmap_area_cachep, va);
@@ -764,7 +761,8 @@ merge_or_add_vmap_area(struct vmap_area *va,
 
 insert:
 	if (!merged) {
-		link_va(va, root, parent, link, head);
+		link_va(va, &free_vmap_area_root, parent, link,
+			&free_vmap_area_list);
 		augment_tree_propagate_from(va);
 	}
 }
@@ -1141,8 +1139,7 @@ static void __free_vmap_area(struct vmap_area *va)
 	/*
 	 * Merge VA with its neighbors, otherwise just add it.
 	 */
-	merge_or_add_vmap_area(va,
-		&free_vmap_area_root, &free_vmap_area_list);
+	merge_or_add_va_to_free_tree(va);
 }
 
 /*
-- 
2.21.0

