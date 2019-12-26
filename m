Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD34C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 18:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6042080D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 18:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dzubA5Q/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfLZSwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 13:52:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39731 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfLZSw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 13:52:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id 20so6637890wmj.4;
        Thu, 26 Dec 2019 10:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x80gT8L6krNF+9q96em5zX1Sz/Pb6+ffOrcGcaNiV2I=;
        b=dzubA5Q/bP9JGW03rXEB2xgJBONTjnk90Gaqw8Xd75WRrxE36LVRreoijnawEFTUHf
         DDryavfjJzYHttwaFOOXcc21cuY+YRaaqxUdhqZvgpegkIwdfiGrTBQkkgFE5Hp/bhU6
         42kSNg0S6zBQJ7OLYQyb/yg8gEz1FeeRkbTbl/NQimD91lNBSe+x7kevSbOUk/iYZqvG
         ok7gvy8Voe8/bkeAfE300zF+P7tHlMPAWKVHDM0Dxnvnm8jl10Vu9OkfoAOeEyS2ciTC
         +gOYAV3PV9S8rdVLz18MtAjgpn553+JekUCetTU232Gin6YCs9D90bQs/lI3WDn3n9Tk
         OJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x80gT8L6krNF+9q96em5zX1Sz/Pb6+ffOrcGcaNiV2I=;
        b=LcnkNICXLMkSFkPJW8IKQ8j4xNNL2H9fZgx1157x7mQ+73MGd2JhzbsNzPAM36ThgU
         ydk33a8ZtlT1bfqScBbDWIaV/VjdbLigjP8W2LaYAz/AhK5jjifErEi6wKrOiPe05z4o
         sb2J1WhefNh7vbmdNTr/iUS2KT8shlZ0eKST186QNNlXaUlWOAEE1I9vuZ7h5dUplkkB
         apgq5u3h7dzkCng/wM1ByNJiutaxpE7SBaHvF0SEWyNiA7r632Wp4kQyjk7dpJcbubdO
         lOOHc2j7TX/fj/9xsj5aheIJw8x9Fk2ckDRy5gj2NOW/N82M5GQ30iYKqlMppAkXx9rY
         Fv1w==
X-Gm-Message-State: APjAAAXnxGt6kxJKmrDKLCTIKeMTkn76/dSNumjflm/miJydzS/fCqFJ
        pw6mSSeqK50gtVEFLnIiX5c=
X-Google-Smtp-Source: APXvYqwfeeE+lgRXq7rAUrvNpPD8mvxCgXpVTGpP/coyh/iT0Qzihn8QPQBpi5ZQqw4Lx8FeiLoosQ==
X-Received: by 2002:a05:600c:2549:: with SMTP id e9mr15745082wma.6.1577386347215;
        Thu, 26 Dec 2019 10:52:27 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id j12sm32129352wrt.55.2019.12.26.10.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 10:52:26 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/2] net: phy: realtek: add logging for the RGMII TX delay configuration
Date:   Thu, 26 Dec 2019 19:51:47 +0100
Message-Id: <20191226185148.3764251-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191226185148.3764251-1-martin.blumenstingl@googlemail.com>
References: <20191226185148.3764251-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGMII requires a delay of 2ns between the data and the clock signal.
There are at least three ways this can happen. One possibility is by
having the PHY generate this delay.
This is a common source for problems (for example with slow TX speeds or
packet loss when sending data). The TX delay configuration of the
RTL8211F PHY can be set either by pin-strappping the RXD1 pin (HIGH
means enabled, LOW means disabled) or through configuring a paged
register. The setting from the RXD1 pin is also reflected in the
register.

Add debug logging to the TX delay configuration on RTL8211F so it's
easier to spot these issues (for example if the TX delay is enabled for
both, the RTL8211F PHY and the MAC).
This is especially helpful because there is no public datasheet for the
RTL8211F PHY available with all the RX/TX delay specifics.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/net/phy/realtek.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 476db5345e1a..879ca37c8508 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -171,7 +171,9 @@ static int rtl8211c_config_init(struct phy_device *phydev)
 
 static int rtl8211f_config_init(struct phy_device *phydev)
 {
+	struct device *dev = &phydev->mdio.dev;
 	u16 val;
+	int ret;
 
 	/* enable TX-delay for rgmii-{id,txid}, and disable it for rgmii and
 	 * rgmii-rxid. The RX-delay can be enabled by the external RXDLY pin.
@@ -189,7 +191,22 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 		return 0;
 	}
 
-	return phy_modify_paged(phydev, 0xd08, 0x11, RTL8211F_TX_DELAY, val);
+	ret = phy_modify_paged_changed(phydev, 0xd08, 0x11, RTL8211F_TX_DELAY,
+				       val);
+	if (ret < 0) {
+		dev_err(dev, "Failed to update the TX delay register\n");
+		return ret;
+	} else if (ret) {
+		dev_dbg(dev,
+			"%s 2ns TX delay (and changing the value from pin-strapping RXD1 or the bootloader)\n",
+			val ? "Enabling" : "Disabling");
+	} else {
+		dev_dbg(dev,
+			"2ns TX delay was already %s (by pin-strapping RXD1 or bootloader configuration)\n",
+			val ? "enabled" : "disabled");
+	}
+
+	return 0;
 }
 
 static int rtl8211e_config_init(struct phy_device *phydev)
-- 
2.24.1

