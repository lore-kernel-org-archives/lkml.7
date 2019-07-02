Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC17EC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E7E2187F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbKvkclP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfGBOQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 10:16:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46760 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfGBOQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 10:16:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id 81so8305362pfy.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 07:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IVRfR6NM4S8GzqtG5KCitdmBC8Cn7LE2ANcDk6NxhUc=;
        b=mbKvkclPmFUJfZ2BNiNdItDhjCyGfK7ziPIk8X2MQSOaal0E4QVPb5XGQl0tlGNvxj
         PochgRHedWGDb5LSBTRtwtBSg8FDa6whQjyIIbPU3ehHKvD37K3rj2csePiwSuxleICR
         jfL/0JSTIRE0KNnhs0cUh3Xl/uDQKCaDPIUvJr4k9IJiu25l72kb1HiuUVgex9ZkIJC7
         zu1vmcWbSGSXA2XZQLalwzuM0SxaoLMmXMU5ZeDE35kGus1dI4cLGhroTDfneam3WGtr
         MbNUdyDXTG/5m4z0feZT0K0Ztg5bkD9oQEaM8w7/V177L20h8WorWWVXXq4yOQEDbBYZ
         rpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IVRfR6NM4S8GzqtG5KCitdmBC8Cn7LE2ANcDk6NxhUc=;
        b=mRK3h31G/X4IxEdL+hAMKfCSGNm5ZoYWw0KTqSgw2tkUXXUQ8ScKYxwQ4tBzRMXkoe
         v2CTAG4lKde1jM7FeoL2D5iYvwOeGwrlA7Tk9OoWYGh6ulpefr4j7MjLmu2eB+GVq9R1
         0mERycRMGbsS4cfWd34iVB131OGTGr9qREVujz/Pq5ZpexrTJqg2KTj6G6ZxEGICYj7O
         xHuPulj5sXlRK22W0gUKqSMLNBCH4ivJgKL6qygv84226Na6JThHONc45DnALZp4bv41
         Nbw94Gcpc8WhPONnq4sC+4mD3vPfov/vd/7D2qKHjdGLG++hV++hK32cRy0xpqs1dtKn
         9B5A==
X-Gm-Message-State: APjAAAXhQgShQ7VgyEjlIX+99ERHWDFRefLD/+xbH0hxk7LPCTbad2NI
        yKvJd3ZWlWytWwLrk0V0nLo=
X-Google-Smtp-Source: APXvYqylAAUdACn1rF5L88n+GFa56x8++h4rnLVraMjKleLyTPC2fVgcloQNhaYHZMsu7woqKPmeWg==
X-Received: by 2002:a63:e018:: with SMTP id e24mr30628200pgh.361.1562076998890;
        Tue, 02 Jul 2019 07:16:38 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:648:b8c3:8577:bf2f:2])
        by smtp.gmail.com with ESMTPSA id a5sm744617pjv.21.2019.07.02.07.16.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 07:16:38 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org, peterz@infradead.org, urezki@gmail.com
Cc:     rpenyaev@suse.de, mhocko@suse.com, guro@fb.com,
        aryabinin@virtuozzo.com, rppt@linux.ibm.com, mingo@kernel.org,
        rick.p.edgecombe@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v2 4/5] mm/vmalloc.c: Modify function merge_or_add_vmap_area() for readability
Date:   Tue,  2 Jul 2019 22:15:40 +0800
Message-Id: <20190702141541.12635-5-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702141541.12635-1-lpf.vector@gmail.com>
References: <20190702141541.12635-1-lpf.vector@gmail.com>
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
index b6ea52d6e8f9..ad117d16af34 100644
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

