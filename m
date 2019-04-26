Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C1FC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BF12077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzhXVdzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbfDZJbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:31:48 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46877 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfDZJbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:31:47 -0400
Received: by mail-lf1-f68.google.com with SMTP id k18so1823220lfj.13;
        Fri, 26 Apr 2019 02:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8XngklsEx7FjQ3aFz/vWthXQwMXtqDaLXO4qZKwIGnM=;
        b=NzhXVdzVLOPW7juNy1wbBPURSp9M0sO5UrNBIZrd8orzYK2rsGL9q2dXf/4Se7chTR
         pOKf8/nwPG6n/Vwc6FhQuSEHAALlprNN2MWJBkNWnSQVLKRj89C8Fa/UaWfchFwHGhrB
         4ECh8+GBJoiikigtIUfsZDAz23VNv/ol6Q2QYowALlAgp9ke4bLRmvPyvzbaRzRxoIkS
         oJlz8aIt8pkV+kWsAIiF+d5Z/ZmnXbb0V45CqayFxDJrFyw6CrvmhD7C4mYLqCVSRXPQ
         UJoh7QrzWzirtHQ6PIJoJ8Ih2BfWzm5B6xl4hduXLSBi72UFStrtgmdAyasnBIBnOK5R
         Dftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8XngklsEx7FjQ3aFz/vWthXQwMXtqDaLXO4qZKwIGnM=;
        b=B7EQbUMButnlJwwjjicNe/ndYCfr7qH43Kx2uzLsDuFmz58FVGHU5rzlFwA84R6gAz
         Vr+qzpxgJSW5/QOUBegk8hFTbYEY8GgncOL0HPp0OIh2PrX8lP7k+y354zPu+spZ9mX8
         otjSRajk/WXCeWPER8k8FC7bTVy2BO4k2VdGcoib27CFTyzF8BSauCM6tdioM3PyNLQs
         w4k23calpSiYEOVU1fTfTodyiuFB1Qe78h03qQ+wy1xbw1JLirtySfWMlaxHa9pK1WgU
         2jNSQZubhfmNSslrYk52sk3TW1tI2sq5UUTRu2oHg2M/+pxNyyg+9j5YwEym0zpVoKRz
         viJg==
X-Gm-Message-State: APjAAAVcQcJChc80IF2oLybG2SBQBgouDEYHq2TuE4TBoPyHYlETQTB5
        GYDBFkuMVOIgur5rHp/cW9jXZZDJOGY=
X-Google-Smtp-Source: APXvYqx3VglXoX4j1jUiw/1sM/w/boItLHSKInk0NTWrB4+05ESU/3qu7Wno/iuBRl5wuUrYBLkqzQ==
X-Received: by 2002:ac2:5a5e:: with SMTP id r30mr10688538lfn.10.1556271105187;
        Fri, 26 Apr 2019 02:31:45 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id a1sm1418767lfc.17.2019.04.26.02.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 02:31:44 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: phy: realtek: Add rtl8211e rx/tx delays config
Date:   Fri, 26 Apr 2019 12:30:10 +0300
Message-Id: <20190426093010.9609-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two chip pins named TXDLY and RXDLY which actually addes
the 2ns delays to TXC and RXC for TXD/RXD latching. Alas it is only
documented info regarding the RGMII timing control configurations
the PHY provides. It turnes out the same settings can be setup
via MDIO registers hidden in the extension pages layout.
Particularly the extension page 0xa4 provides a register 0x1c,
which bits 1 and 2 control the described delays. They are used
to implemet the "rgmii-{id,rxid,txid}" phy-mode.

The hidden RGMII configs register utilization was found in the
rtl8211e U-boot driver:
https://elixir.bootlin.com/u-boot/v2019.01/source/drivers/net/phy/realtek.c#L99

There is also a freebsd discussion regarding this register:
https://reviews.freebsd.org/D13591

It confirms that the register bits field must control the so called
configuration pins described in the table 12-13 of the official PHY
datasheet:
8:6 = PHY Address
5:4 = Auto-Negotiation
3 = Interface Mode Select
2 = RX Delay
1 = TX Delay
0 = SELRGV

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/net/phy/realtek.c | 44 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 10df52ccddfe..8776b94d91ed 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -23,11 +23,14 @@
 
 #define RTL821x_INSR				0x13
 
+#define RTL821x_EXT_PAGE_SELECT			0x1e
 #define RTL821x_PAGE_SELECT			0x1f
 
 #define RTL8211F_INSR				0x1d
 
 #define RTL8211F_TX_DELAY			BIT(8)
+#define RTL8211E_TX_DELAY			BIT(1)
+#define RTL8211E_RX_DELAY			BIT(2)
 
 #define RTL8201F_ISR				0x1e
 #define RTL8201F_IER				0x13
@@ -174,6 +177,46 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 	return phy_modify_paged(phydev, 0xd08, 0x11, RTL8211F_TX_DELAY, val);
 }
 
+static int rtl8211e_config_init(struct phy_device *phydev)
+{
+	int ret, oldpage;
+	u16 val = 0;
+
+	ret = genphy_config_init(phydev);
+	if (ret < 0)
+		return ret;
+
+	/* enable TX/RX delay for rgmii-* modes, otherwise disable it */
+	if (phydev->interface == PHY_INTERFACE_MODE_RGMII_ID)
+		val = RTL8211E_TX_DELAY | RTL8211E_RX_DELAY;
+	else if (phydev->interface == PHY_INTERFACE_MODE_RGMII_TXID)
+		val = RTL8211E_TX_DELAY;
+	else if (phydev->interface == PHY_INTERFACE_MODE_RGMII_RXID)
+		val = RTL8211E_RX_DELAY;
+
+	/* According to a sample driver there is a 0x1c config register on
+	 * a 0xa4 extension page (0x7) layout. It can be used to disable/enable
+	 * the RX/TX delays otherwise controlled by hardware strobes. It can
+	 * also be used to customize the whole configuration register:
+	 * 8:6 = PHY Address, 5:4 = Auto-Negotiation, 3 = Interface Mode Select,
+	 * 2 = RX Delay, 1 = TX Delay, 0 = SELRGV (see original PHY datasheet
+	 * for details).
+	 */
+	oldpage = phy_select_page(phydev, 0x7);
+	if (oldpage < 0)
+		goto err_restore_page;
+
+	ret = phy_write(phydev, RTL821x_EXT_PAGE_SELECT, 0xa4);
+	if (!ret)
+		goto err_restore_page;
+
+	ret = phy_modify(phydev, 0x1c, RTL8211E_TX_DELAY | RTL8211E_RX_DELAY,
+			 val);
+
+err_restore_page:
+	return phy_restore_page(phydev, oldpage, ret);
+}
+
 static int rtl8211b_suspend(struct phy_device *phydev)
 {
 	phy_write(phydev, MII_MMD_DATA, BIT(9));
@@ -257,6 +300,7 @@ static struct phy_driver realtek_drvs[] = {
 		PHY_ID_MATCH_EXACT(0x001cc915),
 		.name		= "RTL8211E Gigabit Ethernet",
 		.features	= PHY_GBIT_FEATURES,
+		.config_init	= &rtl8211e_config_init,
 		.ack_interrupt	= &rtl821x_ack_interrupt,
 		.config_intr	= &rtl8211e_config_intr,
 		.suspend	= genphy_suspend,
-- 
2.21.0

