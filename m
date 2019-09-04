Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3959C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D8E22CF5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfIDMAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:00:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6643 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726240AbfIDMAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:00:05 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2676FB443D939C8DA4D7;
        Wed,  4 Sep 2019 20:00:03 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
 19:59:54 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <b.zolnierkie@samsung.com>, <maarten.lankhorst@linux.intel.com>,
        <daniel.vetter@ffwll.ch>, <viresh.kumar@linaro.org>,
        <rafael.j.wysocki@intel.com>, <yuehaibing@huawei.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] fbdev/sa1100fb: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 4 Sep 2019 19:57:54 +0800
Message-ID: <20190904115754.21612-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify the code a bit.
This is detected by coccinelle.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/video/fbdev/sa1100fb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
index ae2bcfe..4428cef 100644
--- a/drivers/video/fbdev/sa1100fb.c
+++ b/drivers/video/fbdev/sa1100fb.c
@@ -1156,7 +1156,6 @@ static struct sa1100fb_info *sa1100fb_init_fbinfo(struct device *dev)
 static int sa1100fb_probe(struct platform_device *pdev)
 {
 	struct sa1100fb_info *fbi;
-	struct resource *res;
 	int ret, irq;
 
 	if (!dev_get_platdata(&pdev->dev)) {
@@ -1172,8 +1171,7 @@ static int sa1100fb_probe(struct platform_device *pdev)
 	if (!fbi)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	fbi->base = devm_ioremap_resource(&pdev->dev, res);
+	fbi->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(fbi->base))
 		return PTR_ERR(fbi->base);
 
-- 
2.7.4


