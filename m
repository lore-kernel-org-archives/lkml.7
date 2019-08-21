Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0ABC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F89E20679
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MugviQXw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfHUNfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 09:35:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38461 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbfHUNfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:35:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id m125so2165553wmm.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 06:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0t4aa0Nv5R8QXQNa/4oL6xU4iyivDyRHdq6FaUcWExA=;
        b=MugviQXwXIBfUUUyWP6IHkNeW27sYjjEDQvAu4Kqob99Oy6JHdWu/IdUGUPeGCGfzg
         WFe8n/8fdU5BNw46pZoFnqoh17GFEAWHNYYMB5ey8cmfJyChzzPTerVgUwihnNtzfhsy
         7oabi4p6oa09XswN7VE1sWLIwcfHKwBY3kxU36yVKXTtwqrYIsrKSf3YNHAAECz3jrKp
         HCVNvRt/TRFJX6uK9kuKspP8m1jpIkq5AuZO4qt/oyLDdcgtuYSMq3DbN3nQGmCJxEZC
         E1IwJhAeHhQ7mJ2e3Wx94g3emNxDJKAZ7M2SxHXeXgLDWGP3z7NPXU/m+tUvtVPkA/CB
         EU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0t4aa0Nv5R8QXQNa/4oL6xU4iyivDyRHdq6FaUcWExA=;
        b=QJn6vmuF88zpXBtaTpustCsH3QY2otcAS0KWRGy7LsC6ptR6QWqpREfoQNftsq2+nO
         hQFytQa0B3g1WxWjoXuCPmKnKK+FyRM5yEVhUlw2xmQuEpV88ZhI/SpalN8HhyZblf7a
         Lpr+liTM0NEM30XFoOBdsQL+EX0/rG23TgZfQ/vSRYPeB++64fDq5uo9X9jIZvMYS3Nz
         t5+4cGY2pDqEsU3OVfbU9wvupRFBNMQYX5X8hiJfgDj69JN49nEq9ZVPux09G+OEoUZa
         Py/Q1SV4Fc3OLxahwWFvnXdcDYOLSgovuDqo8aiqnhwBwXcDsr8i4UXfck40WwdRwT+q
         qFlw==
X-Gm-Message-State: APjAAAX003lUhJZ3c+HXJpSFYyL2NolKePtFwJMsqkGdKF2+bIlnILqW
        +g/LALBR/HTZLWqCyV2c3sAirQ==
X-Google-Smtp-Source: APXvYqxyYX1ZXPcqBjaYYNfe+ZtSEDIc5N6dN5EPLYh8OWSHD3tWa0RpsBLVponQYB8w7c0bqO089Q==
X-Received: by 2002:a1c:20c3:: with SMTP id g186mr33178wmg.15.1566394521017;
        Wed, 21 Aug 2019 06:35:21 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id g2sm38941908wru.27.2019.08.21.06.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 06:35:20 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     balbi@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH] usb: dwc3: meson-g12a: fix suspend resume regulator unbalanced disables
Date:   Wed, 21 Aug 2019 15:35:18 +0200
Message-Id: <20190821133518.9671-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When going in suspend, in Device mode, then resuming back leads
to the following:

unbalanced disables for USB_PWR_EN
WARNING: CPU: 0 PID: 163 at ../drivers/regulator/core.c:2590 _regulator_disable+0x104/0x180
Hardware name: Amlogic Meson G12A U200 Development Board (DT)
[...]
pc : _regulator_disable+0x104/0x180
lr : _regulator_disable+0x104/0x180
[...]
Call trace:
 _regulator_disable+0x104/0x180
 regulator_disable+0x40/0x78
 dwc3_meson_g12a_otg_mode_set+0x84/0xb0
 dwc3_meson_g12a_irq_thread+0x58/0xb8
 irq_thread_fn+0x28/0x80
 irq_thread+0x118/0x1b8
 kthread+0xf4/0x120
 ret_from_fork+0x10/0x18

This disables the regulator if enabled on suspend, and the reverse on
resume.

Fixes: c99993376f72 ("usb: dwc3: Add Amlogic G12A DWC3 glue")
Reported-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index bca7e92a10e9..12dda04b004d 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -564,7 +564,13 @@ static int __maybe_unused dwc3_meson_g12a_runtime_resume(struct device *dev)
 static int __maybe_unused dwc3_meson_g12a_suspend(struct device *dev)
 {
 	struct dwc3_meson_g12a *priv = dev_get_drvdata(dev);
-	int i;
+	int i, ret;
+
+	if (priv->vbus && priv->otg_phy_mode == PHY_MODE_USB_HOST) {
+		ret = regulator_disable(priv->vbus);
+		if (ret)
+			return ret;
+	}
 
 	for (i = 0 ; i < PHY_COUNT ; ++i) {
 		phy_power_off(priv->phys[i]);
@@ -599,6 +605,12 @@ static int __maybe_unused dwc3_meson_g12a_resume(struct device *dev)
 			return ret;
 	}
 
+       if (priv->vbus && priv->otg_phy_mode == PHY_MODE_USB_HOST) {
+               ret = regulator_enable(priv->vbus);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.22.0

