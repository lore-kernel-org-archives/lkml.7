Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE09C3F68F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 13:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA5A207FD
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 13:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfLHNyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 08:54:39 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:59924 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726425AbfLHNyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 08:54:39 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1idx1A-0007d5-Sl; Sun, 08 Dec 2019 13:54:36 +0000
Received: from ben by deadeye with local (Exim 4.93-RC1)
        (envelope-from <ben@decadent.org.uk>)
        id 1idx1A-0002Ks-E8; Sun, 08 Dec 2019 13:54:36 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Tomi Valkeinen" <tomi.valkeinen@ti.com>,
        "Prabhakar Lad" <prabhakar.csengg@gmail.com>
Date:   Sun, 08 Dec 2019 13:52:50 +0000
Message-ID: <lsq.1575813165.479482953@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 06/72] fbdev: ssd1307fb: return proper error code if
 write command fails
In-Reply-To: <lsq.1575813164.154362148@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.79-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Prabhakar Lad <prabhakar.csengg@gmail.com>

commit 5b72ae9a901cbfbe632570f278486142b037fe51 upstream.

this patch fixes ssd1307fb_ssd1306_init() function to return
proper error codes in case of failures.

Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/video/fbdev/ssd1307fb.c | 67 ++++++++++++++++++++++++++-------
 1 file changed, 53 insertions(+), 14 deletions(-)

--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -320,7 +320,10 @@ static int ssd1307fb_ssd1306_init(struct
 
 	/* Set initial contrast */
 	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_CONTRAST);
-	ret = ret & ssd1307fb_write_cmd(par->client, 0x7f);
+	if (ret < 0)
+		return ret;
+
+	ret = ssd1307fb_write_cmd(par->client, 0x7f);
 	if (ret < 0)
 		return ret;
 
@@ -336,63 +339,99 @@ static int ssd1307fb_ssd1306_init(struct
 
 	/* Set multiplex ratio value */
 	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_MULTIPLEX_RATIO);
-	ret = ret & ssd1307fb_write_cmd(par->client, par->height - 1);
+	if (ret < 0)
+		return ret;
+
+	ret = ssd1307fb_write_cmd(par->client, par->height - 1);
 	if (ret < 0)
 		return ret;
 
 	/* set display offset value */
 	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_DISPLAY_OFFSET);
+	if (ret < 0)
+		return ret;
+
 	ret = ssd1307fb_write_cmd(par->client, 0x20);
 	if (ret < 0)
 		return ret;
 
 	/* Set clock frequency */
 	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_CLOCK_FREQ);
-	ret = ret & ssd1307fb_write_cmd(par->client, 0xf0);
+	if (ret < 0)
+		return ret;
+
+	ret = ssd1307fb_write_cmd(par->client, 0xf0);
 	if (ret < 0)
 		return ret;
 
 	/* Set precharge period in number of ticks from the internal clock */
 	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_PRECHARGE_PERIOD);
-	ret = ret & ssd1307fb_write_cmd(par->client, 0x22);
+	if (ret < 0)
+		return ret;
+
+	ret = ssd1307fb_write_cmd(par->client, 0x22);
 	if (ret < 0)
 		return ret;
 
 	/* Set COM pins configuration */
 	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_COM_PINS_CONFIG);
-	ret = ret & ssd1307fb_write_cmd(par->client, 0x22);
+	if (ret < 0)
+		return ret;
+
+	ret = ssd1307fb_write_cmd(par->client, 0x22);
 	if (ret < 0)
 		return ret;
 
 	/* Set VCOMH */
 	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_VCOMH);
-	ret = ret & ssd1307fb_write_cmd(par->client, 0x49);
+	if (ret < 0)
+		return ret;
+
+	ret = ssd1307fb_write_cmd(par->client, 0x49);
 	if (ret < 0)
 		return ret;
 
 	/* Turn on the DC-DC Charge Pump */
 	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_CHARGE_PUMP);
-	ret = ret & ssd1307fb_write_cmd(par->client, 0x14);
+	if (ret < 0)
+		return ret;
+
+	ret = ssd1307fb_write_cmd(par->client, 0x14);
 	if (ret < 0)
 		return ret;
 
 	/* Switch to horizontal addressing mode */
 	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_ADDRESS_MODE);
-	ret = ret & ssd1307fb_write_cmd(par->client,
-					SSD1307FB_SET_ADDRESS_MODE_HORIZONTAL);
+	if (ret < 0)
+		return ret;
+
+	ret = ssd1307fb_write_cmd(par->client,
+				  SSD1307FB_SET_ADDRESS_MODE_HORIZONTAL);
 	if (ret < 0)
 		return ret;
 
 	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_COL_RANGE);
-	ret = ret & ssd1307fb_write_cmd(par->client, 0x0);
-	ret = ret & ssd1307fb_write_cmd(par->client, par->width - 1);
+	if (ret < 0)
+		return ret;
+
+	ret = ssd1307fb_write_cmd(par->client, 0x0);
+	if (ret < 0)
+		return ret;
+
+	ret = ssd1307fb_write_cmd(par->client, par->width - 1);
 	if (ret < 0)
 		return ret;
 
 	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_PAGE_RANGE);
-	ret = ret & ssd1307fb_write_cmd(par->client, 0x0);
-	ret = ret & ssd1307fb_write_cmd(par->client,
-					par->page_offset + (par->height / 8) - 1);
+	if (ret < 0)
+		return ret;
+
+	ret = ssd1307fb_write_cmd(par->client, 0x0);
+	if (ret < 0)
+		return ret;
+
+	ret = ssd1307fb_write_cmd(par->client,
+				  par->page_offset + (par->height / 8) - 1);
 	if (ret < 0)
 		return ret;
 

