Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F91C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556A82075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WrHX2k1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbfDDNMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:12:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54544 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729574AbfDDNMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:12:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id c1so3000189wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 06:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R4J+VyhzRh+NhhZy6AkI12ey+VNbuJcXhpbxSA+8ah8=;
        b=WrHX2k1M7DQscuoYArwoPfw+g2BKLwNmNNsfOw7tTQ/IHltBnwKB7AnfSQKn+p75CK
         1a/Wl7b/9V3FXXaIOlVJpexBmCFky93l+yxpXvyZJj+iGmLzEk4vuBe/lCdbt3SzdgPI
         i9+syrihCo6BISLUaj1lsBg1Yw8OYXewl+BYz2t9p7eToeZHrRq6NNdoq3MfGDn1mGoj
         SUKi2QoAnQLIntRdoST/PvqK3baxQScpmd9bfOFMYT0s16TZtPjAs3eMI8ZmITa461fH
         H2gJNZGj9N4uLNaQl9fWPRTbA6Cv7KMhw2ypGsNhtfDXJZs9uoI7AmD8V1UaVPnSQ0vP
         Fr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R4J+VyhzRh+NhhZy6AkI12ey+VNbuJcXhpbxSA+8ah8=;
        b=HM9NXTQ9is3eZuXY1vFkGfehKH38/Z1Qf+96KlL28JFlqOW3GuX06UhZLo0eZJiulL
         bRD3JP//FsK4doXN2QxQhf1HHHs0z+LBk5pO7thAmcInymM9STr9KzEyD5dS9qLzu8Hq
         ApM20XzbHi2q8H4hPq99FITrOHRJ25aSN0A3Y29ruWaBNvy3xUTC6r7CoRdr7C1wXVeh
         xwSxMAk/uscxIyJTMZNS5FMnjgW9b7/XfNIWI093sqcSWK+Als9tPcIPNZkkyzyQ/wLh
         wX5Sgla8Ut+9Y+7ZviGXLvTcolEga/eh37azfDohsOfS4VhZ6PJAZt+QCjNk9H3iJA2N
         68mg==
X-Gm-Message-State: APjAAAVNhz5FpUdgmws0sxb3hQEt0PzRG7wDixPH7/J9obZqE76GvuSZ
        Nu9CQVy7v/jKAu+9rzccgQ6pXA==
X-Google-Smtp-Source: APXvYqxJbUwIuqiE9VkQ/1q6njOBAOxXMB2N5lfwzN62xGUO0RL8WEY9RvyLZkyED/B1YLNbzxAMRQ==
X-Received: by 2002:a05:600c:211a:: with SMTP id u26mr4302195wml.74.1554383521016;
        Thu, 04 Apr 2019 06:12:01 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id y133sm21984923wmd.2.2019.04.04.06.11.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 06:12:00 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH net-next v3 3/4] net: phy: meson-gxl: add g12a support
Date:   Thu,  4 Apr 2019 15:11:46 +0200
Message-Id: <20190404131147.31156-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404131147.31156-1-jbrunet@baylibre.com>
References: <20190404131147.31156-1-jbrunet@baylibre.com>
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
 drivers/net/phy/meson-gxl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index 0eec2913c289..2033c93a46ca 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -237,11 +237,22 @@ static struct phy_driver meson_gxl_phy[] = {
 		.config_intr	= meson_gxl_config_intr,
 		.suspend        = genphy_suspend,
 		.resume         = genphy_resume,
+	}, {
+		PHY_ID_MATCH_EXACT(0x01803301),
+		.name		= "Meson G12A Internal PHY",
+		.features	= PHY_BASIC_FEATURES,
+		.flags		= PHY_IS_INTERNAL,
+		.soft_reset     = genphy_soft_reset,
+		.ack_interrupt	= meson_gxl_ack_interrupt,
+		.config_intr	= meson_gxl_config_intr,
+		.suspend        = genphy_suspend,
+		.resume         = genphy_resume,
 	},
 };
 
 static struct mdio_device_id __maybe_unused meson_gxl_tbl[] = {
 	{ 0x01814400, 0xfffffff0 },
+	{ PHY_ID_MATCH_VENDOR(0x01803301) },
 	{ }
 };
 
-- 
2.20.1

