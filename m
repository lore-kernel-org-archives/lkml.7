Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47F4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66E5204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 18:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388244AbfCASsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 13:48:52 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:56172 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbfCASsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 13:48:51 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 6BABA15637; Fri,  1 Mar 2019 18:48:40 +0000 (GMT)
From:   Mans Rullgard <mans@mansr.com>
To:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] auxdisplay: charlcd: simplify init message display
Date:   Fri,  1 Mar 2019 18:48:15 +0000
Message-Id: <20190301184816.784-2-mans@mansr.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190301184816.784-1-mans@mansr.com>
References: <20190301184816.784-1-mans@mansr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_PANEL_CHANGE_MESSAGE is set, CONFIG_PANEL_BOOT_MESSAGE will
also be defined, so the double ifdef is pointless.  Simplify the code
further by using an intermediate macro rather duplicating most of the
line.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/auxdisplay/charlcd.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 60e0b772673f..db0356dca2d7 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -763,6 +763,12 @@ static void charlcd_puts(struct charlcd *lcd, const char *s)
 	}
 }
 
+#ifdef CONFIG_PANEL_BOOT_MESSAGE
+#define LCD_INIT_TEXT CONFIG_PANEL_BOOT_MESSAGE
+#else
+#define LCD_INIT_TEXT "Linux-" UTS_RELEASE "\n"
+#endif
+
 /* initialize the LCD driver */
 static int charlcd_init(struct charlcd *lcd)
 {
@@ -784,13 +790,8 @@ static int charlcd_init(struct charlcd *lcd)
 		return ret;
 
 	/* display a short message */
-#ifdef CONFIG_PANEL_CHANGE_MESSAGE
-#ifdef CONFIG_PANEL_BOOT_MESSAGE
-	charlcd_puts(lcd, "\x1b[Lc\x1b[Lb\x1b[L*" CONFIG_PANEL_BOOT_MESSAGE);
-#endif
-#else
-	charlcd_puts(lcd, "\x1b[Lc\x1b[Lb\x1b[L*Linux-" UTS_RELEASE "\n");
-#endif
+	charlcd_puts(lcd, "\x1b[Lc\x1b[Lb\x1b[L*" LCD_INIT_TEXT);
+
 	/* clear the display on the next device opening */
 	priv->must_clear = true;
 	charlcd_home(lcd);
-- 
2.20.1

