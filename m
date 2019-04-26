Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8544CC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5ED206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxFTYjmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfDZVVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:21:48 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46483 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfDZVVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 17:21:47 -0400
Received: by mail-lj1-f193.google.com with SMTP id h21so4125558ljk.13;
        Fri, 26 Apr 2019 14:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mCJSBnvi4b8dQK3SMykSsE+hZTbE8xEdDrdNraTKLok=;
        b=fxFTYjmqdo+u+FqN6P3teRK59t/HVoNv8vze9QApfqyX+Al6PF0LH6vl6Vzj5oSDU6
         XoG1k2SDh6KffrLQ+5C4c+sjmAkO1cHo6ginnsrboizxUKR7mougHMWAnLnkiwlYT7e9
         +Bk1aOBJRkksvHwFvEYuN/8ZmDsmRh4NY58Uea7jFzQ1PM68n4xFVQQU2b/Z66PgfkXC
         My/4txScLDn0JtNpPS2lwXMI33jczIzJC0QZlQgIA6fZ3br36NT61IJywy/gtloMlBMv
         SrMXYe4+7oNa1rZuhZrHeeXmG70vcct2R9UthHmk9cf7aQI6be5F8/9oGctlNUZrMAJ8
         6k1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mCJSBnvi4b8dQK3SMykSsE+hZTbE8xEdDrdNraTKLok=;
        b=HptqvFA0WxVFq17pMIhnvVeJJJJASfIcs2X4TBeLln/YGUwUsgurUUZ1S5spXbO18M
         bwgQyc6u1LDUPAShmqq1whAKGzoZg2Dra2bl5N0g8JOy2eGhgs7EKhoCjiKoNi3t1Giu
         GJt+gppY0IjuucKUCNNK4p6fDRK7NxeksioIGAtmngeBRz7bREeDgrGkDGhLDtE8agwL
         IiBQYq6iv+J17lZJlYEasZgKAfv7eHxyUoK61+eFJsomli7DCulJWzabh8XWloiH/G9m
         MWQGiVhG64mjD6C/ZR6ZYMa+J6X7t/rR5c112AFZAWjtxe5LJbqKGu1nu05hhI5AOZDu
         YXbw==
X-Gm-Message-State: APjAAAVsiIbRVeKhHzy5Xw9lcc8sSeh8iSF44npRXsI8mHuhiQKAzGS1
        FiY5wQAgboPZUL3msb4mHn4=
X-Google-Smtp-Source: APXvYqzjFAwjuzxeCHIehELCkwzn20sjXPB8+xD88aJaM+ilWgD4OAqo/l/6jIBx/uwR0cNJC6npMw==
X-Received: by 2002:a2e:7605:: with SMTP id r5mr4584018ljc.161.1556313705099;
        Fri, 26 Apr 2019 14:21:45 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id a28sm7097173lfk.54.2019.04.26.14.21.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 14:21:43 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] net: phy: realtek: Add rtl8211e rx/tx delays config
Date:   Sat, 27 Apr 2019 00:21:11 +0300
Message-Id: <20190426212112.5624-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426093010.9609-1-fancer.lancer@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two chip pins named TXDLY and RXDLY which actually adds the 2ns
delays to TXC and RXC for TXD/RXD latching. Alas this is the only
documented info regarding the RGMII timing control configurations the PHY
provides. It turns out the same settings can be setup via MDIO registers
hidden in the extension pages layout. Particularly the extension page 0xa4
provides a register 0x1c, which bits 1 and 2 control the described delays.
They are used to implement the "rgmii-{id,rxid,txid}" phy-mode.

The hidden RGMII configs register utilization was found in the rtl8211e
U-boot driver:
https://elixir.bootlin.com/u-boot/v2019.01/source/drivers/net/phy/realtek.c#L99

There is also a freebsd-folks discussion regarding this register:
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
Changelog v2
- Disable delays for rgmii mode and leave them as is for the rest of
  the modes.
- Remove genphy_config_init() invocation. It's redundant for rtl8211e phy.
- Fix confused return value checking of extended-page selector call.
- Fix commit message typos.

---
 drivers/net/phy/realtek.c | 50 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 10df52ccddfe..ab567a1923ad 100644
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
@@ -174,6 +177,52 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 	return phy_modify_paged(phydev, 0xd08, 0x11, RTL8211F_TX_DELAY, val);
 }
 
+static int rtl8211e_config_init(struct phy_device *phydev)
+{
+	int ret, oldpage;
+	u16 val;
+
+	/* enable TX/RX delay for rgmii-* modes, and disable them for rgmii. */
+	switch (phydev->interface) {
+	case PHY_INTERFACE_MODE_RGMII:
+		val = 0;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		val = RTL8211E_TX_DELAY | RTL8211E_RX_DELAY;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		val = RTL8211E_RX_DELAY;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		val = RTL8211E_TX_DELAY;
+		break;
+	default: /* the rest of the modes imply leaving delays as is. */
+		return 0;
+	}
+
+	/* According to a sample driver there is a 0x1c config register on the
+	 * 0xa4 extension page (0x7) layout. It can be used to disable/enable
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
+	if (ret)
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
@@ -257,6 +306,7 @@ static struct phy_driver realtek_drvs[] = {
 		PHY_ID_MATCH_EXACT(0x001cc915),
 		.name		= "RTL8211E Gigabit Ethernet",
 		.features	= PHY_GBIT_FEATURES,
+		.config_init	= &rtl8211e_config_init,
 		.ack_interrupt	= &rtl821x_ack_interrupt,
 		.config_intr	= &rtl8211e_config_intr,
 		.suspend	= genphy_suspend,
-- 
2.21.0

