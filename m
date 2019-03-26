Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAFDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6838A2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbfCZX4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:56:05 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:41008 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731666AbfCZX4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:56:04 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id B40239CDBA527FE662B0;
        Wed, 27 Mar 2019 07:56:02 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x2QNtxhs093440;
        Wed, 27 Mar 2019 07:55:59 +0800 (GMT-8)
        (envelope-from huang.zijiang@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019032707561816-6463566 ;
          Wed, 27 Mar 2019 07:56:18 +0800 
From:   Huang Zijiang <huang.zijiang@zte.com.cn>
To:     jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        Huang Zijiang <huang.zijiang@zte.com.cn>
Subject: [PATCH] scsi: sun_esp: : Fix object reference leaks in esp_sbus_probe
Date:   Wed, 27 Mar 2019 07:55:57 +0800
Message-Id: <1553644557-35817-1-git-send-email-huang.zijiang@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-03-27 07:56:18,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-03-27 07:55:51,
        Serialize complete at 2019-03-27 07:55:51
X-MAIL: mse01.zte.com.cn x2QNtxhs093440
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_find_device_by_node() takes a reference to the underlying device
structure, we should release that reference whatever of_find_device_by_node
reutrns.

Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>
---
 drivers/scsi/sun_esp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/sun_esp.c b/drivers/scsi/sun_esp.c
index a11efbc..a74605a 100644
--- a/drivers/scsi/sun_esp.c
+++ b/drivers/scsi/sun_esp.c
@@ -543,9 +543,8 @@ static int esp_sbus_probe(struct platform_device *op)
 		return -ENODEV;
 
 	ret = esp_sbus_probe_one(op, dma_of, hme);
-	if (ret)
-		put_device(&dma_of->dev);
 
+	put_device(&dma_of->dev);
 	return ret;
 }
 
-- 
1.8.3.1

