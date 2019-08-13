Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7B1C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 11:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC8920679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 11:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfHML7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 07:59:00 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:49314 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfHML67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 07:58:59 -0400
Received: from ramsan ([84.194.98.4])
        by xavier.telenet-ops.be with bizsmtp
        id obyx2000H05gfCL01byxtR; Tue, 13 Aug 2019 13:58:57 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hxVS5-0002ty-8C; Tue, 13 Aug 2019 13:58:57 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hxVS5-0007tu-6K; Tue, 13 Aug 2019 13:58:57 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Alexander Shiyan <shc_work@mail.ru>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH resend] video: backlight: Drop default m for {LCD,BACKLIGHT_CLASS_DEVICE}
Date:   Tue, 13 Aug 2019 13:58:53 +0200
Message-Id: <20190813115853.30329-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running "make oldconfig" on a .config where
CONFIG_BACKLIGHT_LCD_SUPPORT is not set, two new config options
("Lowlevel LCD controls" and "Lowlevel Backlight controls") appear, both
defaulting to "m".

Drop the "default m", as options should default to disabled, and because
several driver config options already select LCD_CLASS_DEVICE or
BACKLIGHT_CLASS_DEVICE when needed.

Fixes: 8c5dc8d9f19c7992 ("video: backlight: Remove useless BACKLIGHT_LCD_SUPPORT kernel symbol")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/backlight/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 8b081d61773e21eb..40676be2e46aae61 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -10,7 +10,6 @@ menu "Backlight & LCD device support"
 #
 config LCD_CLASS_DEVICE
         tristate "Lowlevel LCD controls"
-	default m
 	help
 	  This framework adds support for low-level control of LCD.
 	  Some framebuffer devices connect to platform-specific LCD modules
@@ -143,7 +142,6 @@ endif # LCD_CLASS_DEVICE
 #
 config BACKLIGHT_CLASS_DEVICE
         tristate "Lowlevel Backlight controls"
-	default m
 	help
 	  This framework adds support for low-level control of the LCD
           backlight. This includes support for brightness and power.
-- 
2.17.1

