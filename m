Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B4DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1129E2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfK0M1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:27:31 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6724 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726383AbfK0M1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 07:27:31 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A8175FC9E2CAF370E365;
        Wed, 27 Nov 2019 20:27:29 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 27 Nov 2019
 20:27:20 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <airlied@linux.ie>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <torvalds@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH] agp: remove set but not used variable 'size'
Date:   Wed, 27 Nov 2019 20:48:41 +0800
Message-ID: <20191127124841.36732-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/char/agp/generic.c: In function ‘agp_generic_create_gatt_table’:
drivers/char/agp/generic.c:853:6: warning: variable ‘size’ set but not
used [-Wunused-but-set-variable]

It is never used, so can be removed.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/char/agp/generic.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
index df1edb5ec0ad..174849491a49 100644
--- a/drivers/char/agp/generic.c
+++ b/drivers/char/agp/generic.c
@@ -850,7 +850,6 @@ int agp_generic_create_gatt_table(struct agp_bridge_data *bridge)
 {
 	char *table;
 	char *table_end;
-	int size;
 	int page_order;
 	int num_entries;
 	int i;
@@ -864,25 +863,22 @@ int agp_generic_create_gatt_table(struct agp_bridge_data *bridge)
 	table = NULL;
 	i = bridge->aperture_size_idx;
 	temp = bridge->current_size;
-	size = page_order = num_entries = 0;
+	page_order = num_entries = 0;
 
 	if (bridge->driver->size_type != FIXED_APER_SIZE) {
 		do {
 			switch (bridge->driver->size_type) {
 			case U8_APER_SIZE:
-				size = A_SIZE_8(temp)->size;
 				page_order =
 				    A_SIZE_8(temp)->page_order;
 				num_entries =
 				    A_SIZE_8(temp)->num_entries;
 				break;
 			case U16_APER_SIZE:
-				size = A_SIZE_16(temp)->size;
 				page_order = A_SIZE_16(temp)->page_order;
 				num_entries = A_SIZE_16(temp)->num_entries;
 				break;
 			case U32_APER_SIZE:
-				size = A_SIZE_32(temp)->size;
 				page_order = A_SIZE_32(temp)->page_order;
 				num_entries = A_SIZE_32(temp)->num_entries;
 				break;
@@ -890,7 +886,6 @@ int agp_generic_create_gatt_table(struct agp_bridge_data *bridge)
 			case FIXED_APER_SIZE:
 			case LVL2_APER_SIZE:
 			default:
-				size = page_order = num_entries = 0;
 				break;
 			}
 
@@ -920,7 +915,6 @@ int agp_generic_create_gatt_table(struct agp_bridge_data *bridge)
 			}
 		} while (!table && (i < bridge->driver->num_aperture_sizes));
 	} else {
-		size = ((struct aper_size_info_fixed *) temp)->size;
 		page_order = ((struct aper_size_info_fixed *) temp)->page_order;
 		num_entries = ((struct aper_size_info_fixed *) temp)->num_entries;
 		table = alloc_gatt_pages(page_order);
-- 
2.17.2

