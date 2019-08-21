Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B6AC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2191922CE3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfHUMKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:10:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1631 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfHUMKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:10:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 08DF22F30D9;
        Wed, 21 Aug 2019 12:10:32 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-105.ams2.redhat.com [10.36.116.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 521D35C541;
        Wed, 21 Aug 2019 12:10:26 +0000 (UTC)
From:   Eric Auger <eric.auger@redhat.com>
To:     eric.auger.pro@gmail.com, eric.auger@redhat.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        dwmw2@infradead.org, shameerali.kolothum.thodi@huawei.com,
        alex.williamson@redhat.com, robin.murphy@arm.com, hch@infradead.org
Subject: [PATCH v3] iommu: revisit iommu_insert_resv_region() implementation
Date:   Wed, 21 Aug 2019 14:09:40 +0200
Message-Id: <20190821120940.22337-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 21 Aug 2019 12:10:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current implementation is recursive and in case of allocation
failure the existing @regions list is altered. A non recursive
version looks better for maintainability and simplifies the
error handling. We use a separate stack for overlapping segment
merging. The elements are sorted by start address and then by
type, if their start address match.

Note this new implementation may change the region order of
appearance in /sys/kernel/iommu_groups/<n>/reserved_regions
files but this order has never been documented, see
commit bc7d12b91bd3 ("iommu: Implement reserved_regions
iommu-group sysfs file").

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v2 -> v3:
- use LIST_HEAD(stack)
- remove found local variables

v1 -> v2:
- adapt the algo so that we don't need to move elements of
  other types to different list and sort by address and then by
  type
---
 drivers/iommu/iommu.c | 96 +++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 49 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0c674d80c37f..edd622525796 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -229,60 +229,58 @@ static ssize_t iommu_group_show_name(struct iommu_group *group, char *buf)
  * @new: new region to insert
  * @regions: list of regions
  *
- * The new element is sorted by address with respect to the other
- * regions of the same type. In case it overlaps with another
- * region of the same type, regions are merged. In case it
- * overlaps with another region of different type, regions are
- * not merged.
+ * Elements are sorted by start address and overlapping segments
+ * of the same type are merged.
  */
-static int iommu_insert_resv_region(struct iommu_resv_region *new,
-				    struct list_head *regions)
+int iommu_insert_resv_region(struct iommu_resv_region *new,
+			     struct list_head *regions)
 {
-	struct iommu_resv_region *region;
-	phys_addr_t start = new->start;
-	phys_addr_t end = new->start + new->length - 1;
-	struct list_head *pos = regions->next;
+	struct iommu_resv_region *iter, *tmp, *nr, *top;
+	LIST_HEAD(stack);
 
-	while (pos != regions) {
-		struct iommu_resv_region *entry =
-			list_entry(pos, struct iommu_resv_region, list);
-		phys_addr_t a = entry->start;
-		phys_addr_t b = entry->start + entry->length - 1;
-		int type = entry->type;
-
-		if (end < a) {
-			goto insert;
-		} else if (start > b) {
-			pos = pos->next;
-		} else if ((start >= a) && (end <= b)) {
-			if (new->type == type)
-				return 0;
-			else
-				pos = pos->next;
-		} else {
-			if (new->type == type) {
-				phys_addr_t new_start = min(a, start);
-				phys_addr_t new_end = max(b, end);
-				int ret;
-
-				list_del(&entry->list);
-				entry->start = new_start;
-				entry->length = new_end - new_start + 1;
-				ret = iommu_insert_resv_region(entry, regions);
-				kfree(entry);
-				return ret;
-			} else {
-				pos = pos->next;
-			}
-		}
-	}
-insert:
-	region = iommu_alloc_resv_region(new->start, new->length,
-					 new->prot, new->type);
-	if (!region)
+	nr = iommu_alloc_resv_region(new->start, new->length,
+				     new->prot, new->type);
+	if (!nr)
 		return -ENOMEM;
 
-	list_add_tail(&region->list, pos);
+	/* First add the new element based on start address sorting */
+	list_for_each_entry(iter, regions, list) {
+		if (nr->start < iter->start ||
+		    (nr->start == iter->start && nr->type <= iter->type))
+			break;
+	}
+	list_add_tail(&nr->list, &iter->list);
+
+	/* Merge overlapping segments of type nr->type in @regions, if any */
+	list_for_each_entry_safe(iter, tmp, regions, list) {
+		phys_addr_t top_end, iter_end = iter->start + iter->length - 1;
+
+		/* no merge needed on elements of different types than @nr */
+		if (iter->type != nr->type) {
+			list_move_tail(&iter->list, &stack);
+			continue;
+		}
+
+		/* look for the last stack element of same type as @iter */
+		list_for_each_entry_reverse(top, &stack, list)
+			if (top->type == iter->type)
+				goto check_overlap;
+
+		list_move_tail(&iter->list, &stack);
+		continue;
+
+check_overlap:
+		top_end = top->start + top->length - 1;
+
+		if (iter->start > top_end + 1) {
+			list_move_tail(&iter->list, &stack);
+		} else {
+			top->length = max(top_end, iter_end) - top->start + 1;
+			list_del(&iter->list);
+			kfree(iter);
+		}
+	}
+	list_splice(&stack, regions);
 	return 0;
 }
 
-- 
2.20.1

