Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F719C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B1E2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="I179FTGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfCNOCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:02:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42069 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbfCNOCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:02:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so1891434wrr.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 07:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gSe5MubfDDFMdYdBkB1bnX6EGj1Asq+NDs4nOR6+nzA=;
        b=I179FTGHDGQnhvAAcTCZkjupEZ7SeeRUFFIjl6S2EabiorJXAHBhtgYjdMKF/Z5rmp
         +eWJv3f1JZOpJ9f45HNffGXG8X+oyHLYOj1bOtC46hQ1T/8i3FQ/EXF5xCAafTv892Zb
         aIGfJbXtUX4BIPDBhDKp1Io7klF4yRWMhQSevipssy8AxjuDySSX4COz4R8YUeR+mn/S
         sOV/YGgukfZt9pBZojGeFlsmty93cBUxtBL8JM8CXumeV8/JV/CuJ7ZoP0D/0vuOrKgc
         KjSXaMWM9GmqT7p0SzzciTSXWpun9T+2+mclRiLftICwDmQWna3JcVjNZV+s6zMh2I2D
         mSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gSe5MubfDDFMdYdBkB1bnX6EGj1Asq+NDs4nOR6+nzA=;
        b=W/nlef0y6OH99+vOLn8pKVAKOI46nrqNPof4uVzOJegqMQK7Q8e6JcAa9Ezol8FIon
         NOvO1m8S/40P+OK4TtyliaCF9PfdXXTYjYSI9Fdb8AvGBLwZHFWfPNpoMDQ/X54rddBN
         a3LwwFLHbfbdGI6oEMJ+AIOrKuWpTQLhDMT3KPcvrHl734Fxi2IZ61xgMbN24ZJ/sr0I
         pW05P0zUaXHnR4g87eb9vTygrwN9w7b92W79EydTfEpTMZtKnuhmkvofftQGMfrTWFMF
         qXbu86h8N2ZsRklSwbBskVYjqsp7FXKYtR400E52XNp19BS7saSYHkNwNW9FWkXROFK1
         VUjQ==
X-Gm-Message-State: APjAAAUAh84c6GGNSjscjKeqiZRcmtFkXWw0geb/opvUWpsGoifl8jIk
        YYsbRjs6T4Ut23gkimi+OTnMiw==
X-Google-Smtp-Source: APXvYqxOsW0L02QZtLWq3QISHge5mO3XVz+uW+KzndOm8Q1A9D4vhbaWTD5xPJI/b38LcjKpcEsIkw==
X-Received: by 2002:adf:ba84:: with SMTP id p4mr31965743wrg.156.1552572118395;
        Thu, 14 Mar 2019 07:01:58 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id y7sm2661051wmi.34.2019.03.14.07.01.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 07:01:57 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH net-next 3/3] net: phy: meson-gxl: add g12a support
Date:   Thu, 14 Mar 2019 15:01:35 +0100
Message-Id: <20190314140135.19184-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190314140135.19184-1-jbrunet@baylibre.com>
References: <20190314140135.19184-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The g12a SoC family uses the type of internal PHY that was used on the
gxl family. The quirks of gxl family, like the LPA register corruption,
appear to have been resolved on this new SoC generation.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/net/phy/meson-gxl.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index 0eec2913c289..49cad0f4c79b 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -237,11 +237,25 @@ static struct phy_driver meson_gxl_phy[] = {
 		.config_intr	= meson_gxl_config_intr,
 		.suspend        = genphy_suspend,
 		.resume         = genphy_resume,
+	}, {
+		.phy_id		= 0x01803301,
+		.phy_id_mask	= 0xffffffff,
+		.name		= "Meson G12A Internal PHY",
+		.features	= PHY_BASIC_FEATURES,
+		.flags		= PHY_IS_INTERNAL,
+		.soft_reset     = genphy_soft_reset,
+		.aneg_done      = genphy_aneg_done,
+		.read_status	= genphy_read_status,
+		.ack_interrupt	= meson_gxl_ack_interrupt,
+		.config_intr	= meson_gxl_config_intr,
+		.suspend        = genphy_suspend,
+		.resume         = genphy_resume,
 	},
 };
 
 static struct mdio_device_id __maybe_unused meson_gxl_tbl[] = {
 	{ 0x01814400, 0xfffffff0 },
+	{ 0x01803301, 0xffffffff },
 	{ }
 };
 
-- 
2.20.1

