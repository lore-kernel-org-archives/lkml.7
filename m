Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B6AC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 20:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6896622CE9
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 20:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfIAUl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 16:41:28 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:36570 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbfIAUl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 16:41:28 -0400
X-Greylist: delayed 551 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Sep 2019 16:41:26 EDT
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 5F825181821E2;
        Sun,  1 Sep 2019 22:32:14 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Sky_fYp9YhKW; Sun,  1 Sep 2019 22:32:13 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pz2otfvD6dw0; Sun,  1 Sep 2019 22:32:12 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH] ubi: block: Warn if volume size is not multiple of 512
Date:   Sun,  1 Sep 2019 22:32:05 +0200
Message-Id: <20190901203205.13063-1-richard@nod.at>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If volume size is not a multiple of 512, ubi block cuts
off the last bytes of an volume since the block layer works
on 512 byte sectors.
This can happen especially on NOR flash with minimal io
size of 1.

To avoid unpleasant surprises, print a warning.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/ubi/block.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 6025398955a2..e1a2ae21dfd3 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -345,15 +345,36 @@ static const struct blk_mq_ops ubiblock_mq_ops = {
 	.init_request	= ubiblock_init_request,
 };
 
+static int calc_disk_capacity(struct ubi_volume_info *vi, u64 *disk_capacity)
+{
+	u64 size = vi->used_bytes >> 9;
+
+	if (vi->used_bytes % 512) {
+		pr_warn("UBI: block: volume size is not a multiple of 512, "
+			"last %llu bytes are ignored!\n",
+			vi->used_bytes - (size << 9));
+	}
+
+	if ((sector_t)size != size)
+		return -EFBIG;
+
+	*disk_capacity = size;
+
+	return 0;
+}
+
 int ubiblock_create(struct ubi_volume_info *vi)
 {
 	struct ubiblock *dev;
 	struct gendisk *gd;
-	u64 disk_capacity = vi->used_bytes >> 9;
+	u64 disk_capacity;
 	int ret;
 
-	if ((sector_t)disk_capacity != disk_capacity)
-		return -EFBIG;
+	ret = calc_disk_capacity(vi, &disk_capacity);
+	if (ret) {
+		return ret;
+	}
+
 	/* Check that the volume isn't already handled */
 	mutex_lock(&devices_mutex);
 	if (find_dev_nolock(vi->ubi_num, vi->vol_id)) {
@@ -507,7 +528,8 @@ int ubiblock_remove(struct ubi_volume_info *vi)
 static int ubiblock_resize(struct ubi_volume_info *vi)
 {
 	struct ubiblock *dev;
-	u64 disk_capacity = vi->used_bytes >> 9;
+	u64 disk_capacity;
+	int ret;
 
 	/*
 	 * Need to lock the device list until we stop using the device,
@@ -520,11 +542,16 @@ static int ubiblock_resize(struct ubi_volume_info *vi)
 		mutex_unlock(&devices_mutex);
 		return -ENODEV;
 	}
-	if ((sector_t)disk_capacity != disk_capacity) {
+
+	ret = calc_disk_capacity(vi, &disk_capacity);
+	if (ret) {
 		mutex_unlock(&devices_mutex);
-		dev_warn(disk_to_dev(dev->gd), "the volume is too big (%d LEBs), cannot resize",
-			 vi->size);
-		return -EFBIG;
+		if (ret == -EFBIG) {
+			dev_warn(disk_to_dev(dev->gd),
+				 "the volume is too big (%d LEBs), cannot resize",
+				 vi->size);
+		}
+		return ret;
 	}
 
 	mutex_lock(&dev->dev_mutex);
-- 
2.16.4

