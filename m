Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FF8C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36252087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfCLOon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:44:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:54009 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbfCLOog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:44:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 07:44:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,471,1544515200"; 
   d="scan'208";a="281971335"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 12 Mar 2019 07:44:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5F62D2E9; Tue, 12 Mar 2019 16:44:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 2/5] auxdisplay: charlcd: Move to_priv() to charlcd namespace
Date:   Tue, 12 Mar 2019 16:44:29 +0200
Message-Id: <20190312144432.7668-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312144432.7668-1-andriy.shevchenko@linux.intel.com>
References: <20190312144432.7668-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be more particular in names, rename to_priv() macro
to charlcd_to_priv().

No functional change intended.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/charlcd.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 60e0b772673f..407acd22efa8 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -91,7 +91,7 @@ struct charlcd_priv {
 	unsigned long long drvdata[0];
 };
 
-#define to_priv(p)	container_of(p, struct charlcd_priv, lcd)
+#define charlcd_to_priv(p)	container_of(p, struct charlcd_priv, lcd)
 
 /* Device single-open policy control */
 static atomic_t charlcd_available = ATOMIC_INIT(1);
@@ -105,7 +105,7 @@ static void long_sleep(int ms)
 /* turn the backlight on or off */
 static void charlcd_backlight(struct charlcd *lcd, int on)
 {
-	struct charlcd_priv *priv = to_priv(lcd);
+	struct charlcd_priv *priv = charlcd_to_priv(lcd);
 
 	if (!lcd->ops->backlight)
 		return;
@@ -134,7 +134,7 @@ static void charlcd_bl_off(struct work_struct *work)
 /* turn the backlight on for a little while */
 void charlcd_poke(struct charlcd *lcd)
 {
-	struct charlcd_priv *priv = to_priv(lcd);
+	struct charlcd_priv *priv = charlcd_to_priv(lcd);
 
 	if (!lcd->ops->backlight)
 		return;
@@ -152,7 +152,7 @@ EXPORT_SYMBOL_GPL(charlcd_poke);
 
 static void charlcd_gotoxy(struct charlcd *lcd)
 {
-	struct charlcd_priv *priv = to_priv(lcd);
+	struct charlcd_priv *priv = charlcd_to_priv(lcd);
 	unsigned int addr;
 
 	/*
@@ -170,7 +170,7 @@ static void charlcd_gotoxy(struct charlcd *lcd)
 
 static void charlcd_home(struct charlcd *lcd)
 {
-	struct charlcd_priv *priv = to_priv(lcd);
+	struct charlcd_priv *priv = charlcd_to_priv(lcd);
 
 	priv->addr.x = 0;
 	priv->addr.y = 0;
@@ -179,7 +179,7 @@ static void charlcd_home(struct charlcd *lcd)
 
 static void charlcd_print(struct charlcd *lcd, char c)
 {
-	struct charlcd_priv *priv = to_priv(lcd);
+	struct charlcd_priv *priv = charlcd_to_priv(lcd);
 
 	if (priv->addr.x < lcd->bwidth) {
 		if (lcd->char_conv)
@@ -211,7 +211,7 @@ static void charlcd_clear_fast(struct charlcd *lcd)
 /* clears the display and resets X/Y */
 static void charlcd_clear_display(struct charlcd *lcd)
 {
-	struct charlcd_priv *priv = to_priv(lcd);
+	struct charlcd_priv *priv = charlcd_to_priv(lcd);
 
 	lcd->ops->write_cmd(lcd, LCD_CMD_DISPLAY_CLEAR);
 	priv->addr.x = 0;
@@ -223,7 +223,7 @@ static void charlcd_clear_display(struct charlcd *lcd)
 static int charlcd_init_display(struct charlcd *lcd)
 {
 	void (*write_cmd_raw)(struct charlcd *lcd, int cmd);
-	struct charlcd_priv *priv = to_priv(lcd);
+	struct charlcd_priv *priv = charlcd_to_priv(lcd);
 	u8 init;
 
 	if (lcd->ifwidth != 4 && lcd->ifwidth != 8)
@@ -369,7 +369,7 @@ static bool parse_xy(const char *s, unsigned long *x, unsigned long *y)
 
 static inline int handle_lcd_special_code(struct charlcd *lcd)
 {
-	struct charlcd_priv *priv = to_priv(lcd);
+	struct charlcd_priv *priv = charlcd_to_priv(lcd);
 
 	/* LCD special codes */
 
@@ -580,7 +580,7 @@ static inline int handle_lcd_special_code(struct charlcd *lcd)
 
 static void charlcd_write_char(struct charlcd *lcd, char c)
 {
-	struct charlcd_priv *priv = to_priv(lcd);
+	struct charlcd_priv *priv = charlcd_to_priv(lcd);
 
 	/* first, we'll test if we're in escape mode */
 	if ((c != '\n') && priv->esc_seq.len >= 0) {
@@ -705,7 +705,7 @@ static ssize_t charlcd_write(struct file *file, const char __user *buf,
 
 static int charlcd_open(struct inode *inode, struct file *file)
 {
-	struct charlcd_priv *priv = to_priv(the_charlcd);
+	struct charlcd_priv *priv = charlcd_to_priv(the_charlcd);
 	int ret;
 
 	ret = -EBUSY;
@@ -766,7 +766,7 @@ static void charlcd_puts(struct charlcd *lcd, const char *s)
 /* initialize the LCD driver */
 static int charlcd_init(struct charlcd *lcd)
 {
-	struct charlcd_priv *priv = to_priv(lcd);
+	struct charlcd_priv *priv = charlcd_to_priv(lcd);
 	int ret;
 
 	if (lcd->ops->backlight) {
@@ -866,7 +866,7 @@ EXPORT_SYMBOL_GPL(charlcd_register);
 
 int charlcd_unregister(struct charlcd *lcd)
 {
-	struct charlcd_priv *priv = to_priv(lcd);
+	struct charlcd_priv *priv = charlcd_to_priv(lcd);
 
 	unregister_reboot_notifier(&panel_notifier);
 	charlcd_puts(lcd, "\x0cLCD driver unloaded.\x1b[Lc\x1b[Lb\x1b[L-");
-- 
2.20.1

