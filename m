Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB32C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1F3206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nNCFLy71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfC2OP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:15:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40412 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729523AbfC2OP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:15:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so2792150wre.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 07:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gSe5MubfDDFMdYdBkB1bnX6EGj1Asq+NDs4nOR6+nzA=;
        b=nNCFLy71Xa6tRPJm4FKbbPkUtQBCXU0qXOFc/MaRzVDdhl1WZD5FT8H9zfyTwQ/Gx5
         t6ncWGK7oFbDFULtZXI036nkABx3sCqG8z+LmDW4GGz9G4AaKFzkRIzpgkm/FQ6RSUw9
         WqtD0yb8O8UDBpDgl8tuCDVcGzkC0tKIQVTo0N1YyBYAgZDaD3QyCCUov7gzDDA96pEB
         KQ1u4Q7YwEAoRK3/8e20NuGEGiYRkJ/7DEqnduq9Gi2JVqEPEGz9XsBVh5htTTBGx5BU
         4wCqy7H7kj2AkmOWKJFmMhNdmnRLNpOKvOrlBnvYxQVZ5Z0oG2Y6bnIZhbnYE0iBKDBm
         zAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gSe5MubfDDFMdYdBkB1bnX6EGj1Asq+NDs4nOR6+nzA=;
        b=KH1ZXIwhXO+XAFc9YXPZPs4IG6/4f3j2EW8uL3+hFa+0XWSeeWRuXLzpRFxbEfvCKV
         rxj2pb+YwvnIzE2O1tXaIq9+okJ7EtkNldaLgawuVK0n4V/LkFZ0R2v7QL/rUHCqY9+o
         9XV0QX+tKd9PhoIlwvz65+AvtCfqlDkJyIiD4UuS7ws3veZXXxHJKxW3Jiz+WurBbFFe
         sE7Q/8B+w38AyTmgteMVFjmVP2MUoaWHvl3WDXaxdXcj1fT1J5g8aW3DdWKAsRtWmAnH
         ORyz/v8zlCnd9W2sTnoLhtqjtSVjs1sBNYq5pBkMj8Dd03dRn03YtXqvGd2DjDe40av7
         sz1w==
X-Gm-Message-State: APjAAAUYD6B62klbaly4r9/D7KkzCvYgvSxh5swzGg4QY4RoYiYPdGTi
        qxVh1o1vG3J1/pIW4iMto4Y61Q==
X-Google-Smtp-Source: APXvYqzen2VR+W18Mc/lnJd0tpThij1hXdlUhEPX2/aN3JHhaHX5BQm2HqG0pfdCSTies/Cl6naetA==
X-Received: by 2002:adf:e692:: with SMTP id r18mr33703384wrm.231.1553868924508;
        Fri, 29 Mar 2019 07:15:24 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id 67sm2464333wmz.41.2019.03.29.07.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 07:15:23 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH net-next v2 3/3] net: phy: meson-gxl: add g12a support
Date:   Fri, 29 Mar 2019 15:15:12 +0100
Message-Id: <20190329141512.29867-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329141512.29867-1-jbrunet@baylibre.com>
References: <20190329141512.29867-1-jbrunet@baylibre.com>
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

