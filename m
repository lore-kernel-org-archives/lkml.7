Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864C1C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B6320830
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfDOXiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 19:38:08 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:51526 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfDOXiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 19:38:07 -0400
Received: from localhost.localdomain (85-76-110-185-nat.elisa-mobile.fi [85.76.110.185])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 132E5B004D;
        Tue, 16 Apr 2019 02:38:04 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] ARM: OMAP1: ams-delta: fix early boot crash when LED support is disabled
Date:   Tue, 16 Apr 2019 02:37:32 +0300
Message-Id: <20190415233732.3612-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we boot with the LED support (CONFIG_NEW_LEDS) disabled,
gpio_led_register_device() will return a NULL pointer and we try
to dereference it. Fix by checking also for a NULL pointer.

Fixes: 19a2668a8ae3 ("ARM: OMAP1: ams-delta: Provide GPIO lookup table for LED device")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/board-ams-delta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index c4c0a8ea11e4..2b3d1197bb19 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -749,7 +749,7 @@ static void __init ams_delta_init(void)
 				ARRAY_SIZE(ams_delta_gpio_tables));
 
 	leds_pdev = gpio_led_register_device(PLATFORM_DEVID_NONE, &leds_pdata);
-	if (!IS_ERR(leds_pdev)) {
+	if (!IS_ERR_OR_NULL(leds_pdev)) {
 		leds_gpio_table.dev_id = dev_name(&leds_pdev->dev);
 		gpiod_add_lookup_table(&leds_gpio_table);
 	}
-- 
2.17.0

