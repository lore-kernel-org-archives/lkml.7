Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5297C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F55D204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbfCASsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 13:48:51 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:56168 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728295AbfCASsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 13:48:51 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 7394F15638; Fri,  1 Mar 2019 18:48:40 +0000 (GMT)
From:   Mans Rullgard <mans@mansr.com>
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] auxdisplay: charlcd: make backlight initial state configurable
Date:   Fri,  1 Mar 2019 18:48:16 +0000
Message-Id: <20190301184816.784-3-mans@mansr.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190301184816.784-1-mans@mansr.com>
References: <20190301184816.784-1-mans@mansr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The charlcd driver currently flashes the backlight once on init.
This may not be desirable.  Thus, add options for turning the
backlight off or on as well.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/auxdisplay/Kconfig   | 21 +++++++++++++++++++++
 drivers/auxdisplay/charlcd.c | 10 +++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index 7d3fe27d6868..c52c738e554a 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -445,6 +445,27 @@ config PANEL_BOOT_MESSAGE
 	  An empty message will only clear the display at driver init time. Any other
 	  printf()-formatted message is valid with newline and escape codes.
 
+choice
+	prompt "Backlight initial state"
+	default CHARLCD_BL_FLASH
+
+	config CHARLCD_BL_OFF
+		bool "Off"
+		help
+		  Backlight is initially turned off
+
+	config CHARLCD_BL_ON
+		bool "On"
+		help
+		  Backlight is initially turned on
+
+	config CHARLCD_BL_FLASH
+		bool "Flash"
+		help
+		  Backlight is flashed briefly on init
+
+endchoice
+
 endif # AUXDISPLAY
 
 config PANEL
diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index db0356dca2d7..ff8c53c082ff 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -769,6 +769,14 @@ static void charlcd_puts(struct charlcd *lcd, const char *s)
 #define LCD_INIT_TEXT "Linux-" UTS_RELEASE "\n"
 #endif
 
+#ifdef CONFIG_CHARLCD_BL_ON
+#define LCD_INIT_BL "\x1b[L+"
+#elif defined (CONFIG_CHARLCD_BL_FLASH)
+#define LCD_INIT_BL "\x1b[L*"
+#else
+#define LCD_INIT_BL "\x1b[L-"
+#endif
+
 /* initialize the LCD driver */
 static int charlcd_init(struct charlcd *lcd)
 {
@@ -790,7 +798,7 @@ static int charlcd_init(struct charlcd *lcd)
 		return ret;
 
 	/* display a short message */
-	charlcd_puts(lcd, "\x1b[Lc\x1b[Lb\x1b[L*" LCD_INIT_TEXT);
+	charlcd_puts(lcd, "\x1b[Lc\x1b[Lb" LCD_INIT_BL LCD_INIT_TEXT);
 
 	/* clear the display on the next device opening */
 	priv->must_clear = true;
-- 
2.20.1

