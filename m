Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A486AC10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710CB214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NQgQuCht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbfDDNMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:12:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33094 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729765AbfDDNME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:12:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id q1so3780805wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 06:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C2Np36jjJb1WgC3/59cWHoAfdL0+gseCwYoNIkBU+7U=;
        b=NQgQuChtIdoSiqdDUI/JiMdfrin2nesP+nHhGvk7kbC8hVW7tOFo7cOHjEqyYBu10j
         Va0SyZVG9PAwkJCupFCpS2uqNbIkfkCl7XnE9VF8jiwnwH4Q+iAyanKMbDjKLy76Czgm
         tpOvsR49SukQ45ZGP9bqs9qCzynO2LUR3o23VOoX37jFlnHDTh6bxn8cbAK2ufyvKKFx
         x75UloYi0jXPXonR6xZjZHhyRCLisJGzReG2UqZMayZeqEITcr0Zy72yuTu0DYqCHPAT
         +gu1fDKbnRPy3GUV1Z1Lb1UI2vk8Eqmrlesu0vA2Q4Mx8KFsuN68o9WkmO0LPbwPyyeN
         7e2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C2Np36jjJb1WgC3/59cWHoAfdL0+gseCwYoNIkBU+7U=;
        b=lMkKPOalRNciwzCKqVc+mOfZch1yM9J07aMqDK/az60AsAFhIClam4NKgMhh14MmxJ
         NGYlGBTAxmmVVzdNF2/P+t7p1Np7lAQMg225GfxWIhXalQSl1Da96NoiicuB3HmpQloj
         BVheK0lfTNjfEmvZQahuE6Uqn+LWiZb+GteFb7svIF2BRSRNAkoEGxZTknsQZJuz1MqK
         RuBaeQAJJvKsyKNqC3axSrbO+iEGnm355bh/PexNzY+FDNR2Ja0KCH51LxUmxOCHBdOe
         KvjygxbFPrU8rq9aqZNfRhmIZ7t1z3YaAH5Yy7HegGRSsP+hd44J9KXiEq/0nqnK1/Hm
         oNSw==
X-Gm-Message-State: APjAAAWUh/ZRCoOL/9gjT6q3ol1GWLISPveZ/8PDuB6ZOhPRtmhnuijC
        gooYQps3C6zZOJ2tivKLNUVTvA==
X-Google-Smtp-Source: APXvYqxQl1GGh5tExSlAH4AvtpSgyqpazagc72wWxAq/TU+yuZKlzg1TvaIJXTelAyeL+Hgp7MV4Ew==
X-Received: by 2002:a5d:6181:: with SMTP id j1mr4239923wru.11.1554383522488;
        Thu, 04 Apr 2019 06:12:02 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id y133sm21984923wmd.2.2019.04.04.06.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 06:12:01 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH net-next v3 4/4] net: phy: meson-gxl: clean-up gxl variant driver
Date:   Thu,  4 Apr 2019 15:11:47 +0200
Message-Id: <20190404131147.31156-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404131147.31156-1-jbrunet@baylibre.com>
References: <20190404131147.31156-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this change is to align the gxl and g12a driver
declaration.

Like on the g12a variant, remove genphy_aneg_done() from the driver
declaration as the net phy framework will default to it anyway.

Also, the gxl phy id should be an exact match as well, so let's change
this and use the macro provided.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/net/phy/meson-gxl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index 2033c93a46ca..6d4a8c508ec0 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -224,14 +224,12 @@ static int meson_gxl_config_intr(struct phy_device *phydev)
 
 static struct phy_driver meson_gxl_phy[] = {
 	{
-		.phy_id		= 0x01814400,
-		.phy_id_mask	= 0xfffffff0,
+		PHY_ID_MATCH_EXACT(0x01814400),
 		.name		= "Meson GXL Internal PHY",
 		.features	= PHY_BASIC_FEATURES,
 		.flags		= PHY_IS_INTERNAL,
 		.soft_reset     = genphy_soft_reset,
 		.config_init	= meson_gxl_config_init,
-		.aneg_done      = genphy_aneg_done,
 		.read_status	= meson_gxl_read_status,
 		.ack_interrupt	= meson_gxl_ack_interrupt,
 		.config_intr	= meson_gxl_config_intr,
@@ -251,7 +249,7 @@ static struct phy_driver meson_gxl_phy[] = {
 };
 
 static struct mdio_device_id __maybe_unused meson_gxl_tbl[] = {
-	{ 0x01814400, 0xfffffff0 },
+	{ PHY_ID_MATCH_VENDOR(0x01814400) },
 	{ PHY_ID_MATCH_VENDOR(0x01803301) },
 	{ }
 };
-- 
2.20.1

