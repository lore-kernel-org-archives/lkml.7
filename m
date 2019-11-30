Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E09C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 13:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4598B2072C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 13:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfK3NI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 08:08:59 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:49697 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725811AbfK3NI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 08:08:59 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TjTzGDP_1575119329;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TjTzGDP_1575119329)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 30 Nov 2019 21:08:56 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     xlpang@linux.alibaba.com, Wen Yang <wenyang@linux.alibaba.com>,
        Nick Crews <ncrews@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/chrome: wilco_ec: fix use after free issue
Date:   Sat, 30 Nov 2019 21:08:42 +0800
Message-Id: <20191130130842.33763-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is caused by dereferencing 'dev_data' after put_device() in
the telem_device_remove() function.
This patch just moves the put_device() down a bit to avoid this
issue.

Fixes: 1210d1e6bad1 ("platform/chrome: wilco_ec: Add telemetry char device interface")
Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Benson Leung <bleung@chromium.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Nick Crews <ncrews@chromium.org>
Cc: linux-kernel@vger.kernel.org
---
 drivers/platform/chrome/wilco_ec/telemetry.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/wilco_ec/telemetry.c b/drivers/platform/chrome/wilco_ec/telemetry.c
index b9d03c3..1176d54 100644
--- a/drivers/platform/chrome/wilco_ec/telemetry.c
+++ b/drivers/platform/chrome/wilco_ec/telemetry.c
@@ -406,8 +406,8 @@ static int telem_device_remove(struct platform_device *pdev)
 	struct telem_device_data *dev_data = platform_get_drvdata(pdev);
 
 	cdev_device_del(&dev_data->cdev, &dev_data->dev);
-	put_device(&dev_data->dev);
 	ida_simple_remove(&telem_ida, MINOR(dev_data->dev.devt));
+	put_device(&dev_data->dev);
 
 	return 0;
 }
-- 
1.8.3.1

