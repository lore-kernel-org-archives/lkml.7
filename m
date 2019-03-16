Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420E2C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBA621903
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 22:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="aGw0r9zx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfCPWZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 18:25:58 -0400
Received: from tomli.me ([153.92.126.73]:56126 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbfCPWZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 18:25:56 -0400
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id d33f64ba;
        Sat, 16 Mar 2019 22:25:53 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:6fc7:8b2c)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sat, 16 Mar 2019 22:25:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=tL1XlxqqQGS0BcBlR+n8ModXT/z7WTFVDNOhJyRQHsE=; b=aGw0r9zxbUPvM1nF+5HL+UkX5/43vXrXZ5kQ7r7rl1jYlb/YqMpCSGxPAwprX2amqwnh35nQ2qfSbfxkOI9bK3wlECYgjZD9vAufUjR2uUYC9IPJ0lODMf8R/5IxhySitfeK7juHpYNzxpDPPCwDq9byCk7GCgNanocMNLGZQvjamGQ8yd5e6NTeaEWBmYBl/fv8Eh2p3KRaeJ87THh9E+2mIKF4Pb4vcRUy2/rQaT989TR7W2Hr17UoKHO8mpxtTB4XuTd+0MxjGuCK6uZmauxsXhD0ha0xARTsF+nEIfHvZzdb2waQQn908x7PJyiJkREazuoFUE54A+hDfM0L4A==
From:   Yifeng Li <tomli@tomli.me>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Yifeng Li <tomli@tomli.me>,
        stable@vger.kernel.org
Subject: [PATCH 8/8] fbdev: sm712fb: use 1024x768 by default on non-MIPS, fix garbled display.
Date:   Sun, 17 Mar 2019 06:25:04 +0800
Message-Id: <20190316222504.27170-9-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190316222504.27170-1-tomli@tomli.me>
References: <20190316222504.27170-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loongson MIPS netbooks use 1024x600 LCD panels, which is the original
target platform of this driver, but nearly all old x86 laptops have
1024x768. Lighting 768 panels using 600's timings would partially
garble the display. Since it's not possible to distinguish them reliably,
we change the default to 768, but keep 600 as-is on MIPS.

Further, earlier laptops, such as IBM Thinkpad 240X, has a 800x600 LCD
panel, this driver would probably garbled those display. As we don't
have one for testing, the original behavior of the driver is kept as-is,
but the problem has been documented is the comments.

Signed-off-by: Yifeng Li <tomli@tomli.me>
Cc: stable@vger.kernel.org  # v4.4+
---
 drivers/video/fbdev/sm712.h   |  7 +++--
 drivers/video/fbdev/sm712fb.c | 53 ++++++++++++++++++++++++++---------
 2 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/drivers/video/fbdev/sm712.h b/drivers/video/fbdev/sm712.h
index 2cba1e73ed24..c7ebf03b8d53 100644
--- a/drivers/video/fbdev/sm712.h
+++ b/drivers/video/fbdev/sm712.h
@@ -15,9 +15,10 @@
 
 #define FB_ACCEL_SMI_LYNX 88
 
-#define SCREEN_X_RES      1024
-#define SCREEN_Y_RES      600
-#define SCREEN_BPP        16
+#define SCREEN_X_RES          1024
+#define SCREEN_Y_RES_PC       768
+#define SCREEN_Y_RES_NETBOOK  600
+#define SCREEN_BPP            16
 
 #define dac_reg	(0x3c8)
 #define dac_val	(0x3c9)
diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index c39a2641182a..1e2503b52c6f 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1475,6 +1475,43 @@ static u_long sm7xx_vram_probe(struct smtcfb_info *sfb)
 	return 0;  /* unknown hardware */
 }
 
+static void sm7xx_resolution_probe(struct smtcfb_info *sfb)
+{
+	/* get mode parameter from smtc_scr_info */
+	if (smtc_scr_info.lfb_width != 0) {
+		sfb->fb->var.xres = smtc_scr_info.lfb_width;
+		sfb->fb->var.yres = smtc_scr_info.lfb_height;
+		sfb->fb->var.bits_per_pixel = smtc_scr_info.lfb_depth;
+		goto final;
+	}
+
+	/*
+	 * No parameter, default resolution is 1024x768-16.
+	 *
+	 * FIXME: earlier laptops, such as IBM Thinkpad 240X, has a 800x600
+	 * panel, also see the comments about Thinkpad 240X above.
+	 */
+	sfb->fb->var.xres = SCREEN_X_RES;
+	sfb->fb->var.yres = SCREEN_Y_RES_PC;
+	sfb->fb->var.bits_per_pixel = SCREEN_BPP;
+
+#ifdef CONFIG_MIPS
+	/*
+	 * Loongson MIPS netbooks use 1024x600 LCD panels, which is the original
+	 * target platform of this driver, but nearly all old x86 laptops have
+	 * 1024x768. Lighting 768 panels using 600's timings would partially
+	 * garble the display, so we don't want that. But it's not possible to
+	 * distinguish them reliably.
+	 *
+	 * So we change the default to 768, but keep 600 as-is on MIPS.
+	 */
+	sfb->fb->var.yres = SCREEN_Y_RES_NETBOOK;
+#endif
+
+final:
+	big_pixel_depth(sfb->fb->var.bits_per_pixel, smtc_scr_info.lfb_depth);
+}
+
 static int smtcfb_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *ent)
 {
@@ -1520,19 +1557,6 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 
 	sm7xx_init_hw();
 
-	/* get mode parameter from smtc_scr_info */
-	if (smtc_scr_info.lfb_width != 0) {
-		sfb->fb->var.xres = smtc_scr_info.lfb_width;
-		sfb->fb->var.yres = smtc_scr_info.lfb_height;
-		sfb->fb->var.bits_per_pixel = smtc_scr_info.lfb_depth;
-	} else {
-		/* default resolution 1024x600 16bit mode */
-		sfb->fb->var.xres = SCREEN_X_RES;
-		sfb->fb->var.yres = SCREEN_Y_RES;
-		sfb->fb->var.bits_per_pixel = SCREEN_BPP;
-	}
-
-	big_pixel_depth(sfb->fb->var.bits_per_pixel, smtc_scr_info.lfb_depth);
 	/* Map address and memory detection */
 	mmio_base = pci_resource_start(pdev, 0);
 	pci_read_config_byte(pdev, PCI_REVISION_ID, &sfb->chip_rev_id);
@@ -1594,6 +1618,9 @@ static int smtcfb_pci_probe(struct pci_dev *pdev,
 		goto failed_fb;
 	}
 
+	/* probe and decide resolution */
+	sm7xx_resolution_probe(sfb);
+
 	/* can support 32 bpp */
 	if (sfb->fb->var.bits_per_pixel == 15)
 		sfb->fb->var.bits_per_pixel = 16;
-- 
2.20.1

