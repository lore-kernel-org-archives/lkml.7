Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD8DC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 03:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2022147A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 03:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfG2DcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 23:32:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57454 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726320AbfG2DcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 23:32:02 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5D63229DBF6460DB3E5C;
        Mon, 29 Jul 2019 11:16:26 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 29 Jul 2019
 11:16:16 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ronald@innovation.ch>, <dmitry.torokhov@gmail.com>,
        <nikolas@gnu.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] Input: applespi - Fix build error
Date:   Mon, 29 Jul 2019 11:14:55 +0800
Message-ID: <20190729031455.59400-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_KEYBOARD_APPLESPI=y but CONFIG_LEDS_CLASS=m
building fails:

drivers/input/keyboard/applespi.o: In function `applespi_probe':
applespi.c:(.text+0x1fcd): undefined reference to `devm_led_classdev_register_ext'

Wrap it in LEDS_CLASS macro to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 038b1a05eae6 ("Input: add Apple SPI keyboard and trackpad driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/input/keyboard/applespi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index acf34a5..9c50b09 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -1790,11 +1790,13 @@ static int applespi_probe(struct spi_device *spi)
 	applespi->backlight_info.default_trigger = "kbd-backlight";
 	applespi->backlight_info.brightness_set  = applespi_set_bl_level;
 
+#ifdef CONFIG_LEDS_CLASS
 	sts = devm_led_classdev_register(&spi->dev, &applespi->backlight_info);
 	if (sts)
 		dev_warn(&applespi->spi->dev,
 			 "Unable to register keyboard backlight class dev (%d)\n",
 			 sts);
+#endif
 
 	/* set up debugfs entries for touchpad dimensions logging */
 	applespi->debugfs_root = debugfs_create_dir("applespi", NULL);
-- 
2.7.4


