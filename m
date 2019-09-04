Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8764FC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E6C20820
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbfIDM0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:26:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5759 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbfIDM0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:26:44 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4A74BF3FA70A6108B030;
        Wed,  4 Sep 2019 20:26:42 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
 20:26:33 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <linux@prisktech.co.nz>, <b.zolnierkie@samsung.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] fbdev: wm8505fb: use devm_platform_ioremap_resource() to simplify code
Date:   Wed, 4 Sep 2019 20:01:32 +0800
Message-ID: <20190904120132.25524-1-yuehaibing@huawei.com>
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
 drivers/video/fbdev/wm8505fb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/wm8505fb.c b/drivers/video/fbdev/wm8505fb.c
index 17c7803..351d27b 100644
--- a/drivers/video/fbdev/wm8505fb.c
+++ b/drivers/video/fbdev/wm8505fb.c
@@ -261,7 +261,6 @@ static struct fb_ops wm8505fb_ops = {
 static int wm8505fb_probe(struct platform_device *pdev)
 {
 	struct wm8505fb_info	*fbi;
-	struct resource	*res;
 	struct display_timings *disp_timing;
 	void			*addr;
 	int ret;
@@ -299,8 +298,7 @@ static int wm8505fb_probe(struct platform_device *pdev)
 	addr = addr + sizeof(struct wm8505fb_info);
 	fbi->fb.pseudo_palette	= addr;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	fbi->regbase = devm_ioremap_resource(&pdev->dev, res);
+	fbi->regbase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(fbi->regbase))
 		return PTR_ERR(fbi->regbase);
 
-- 
2.7.4


