Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DA4C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 09:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC3F20732
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 09:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfK3Jda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 04:33:30 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:50427 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725811AbfK3Jda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 04:33:30 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TjSu.65_1575106399;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TjSu.65_1575106399)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 30 Nov 2019 17:33:26 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     xlpang@linux.alibaba.com, Wen Yang <wenyang@linux.alibaba.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] UBI: fix use after free in ubi_remove_volume()
Date:   Sat, 30 Nov 2019 17:33:17 +0800
Message-Id: <20191130093317.31352-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't use "vol" after it has been freed.

Fixes: 493cfaeaa0c9 ("mtd: utilize new cdev_device_add helper function")
Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/mtd/ubi/vmt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
index 139ee13..8ff1478 100644
--- a/drivers/mtd/ubi/vmt.c
+++ b/drivers/mtd/ubi/vmt.c
@@ -375,7 +375,6 @@ int ubi_remove_volume(struct ubi_volume_desc *desc, int no_vtbl)
 	}
 
 	cdev_device_del(&vol->cdev, &vol->dev);
-	put_device(&vol->dev);
 
 	spin_lock(&ubi->volumes_lock);
 	ubi->rsvd_pebs -= reserved_pebs;
@@ -388,6 +387,8 @@ int ubi_remove_volume(struct ubi_volume_desc *desc, int no_vtbl)
 	if (!no_vtbl)
 		self_check_volumes(ubi);
 
+	put_device(&vol->dev);
+
 	return 0;
 
 out_err:
-- 
1.8.3.1

