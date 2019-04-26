Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673C1C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337862077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWs0cvhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfDZVWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:22:01 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41900 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfDZVWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 17:22:00 -0400
Received: by mail-lf1-f68.google.com with SMTP id t30so3367099lfd.8;
        Fri, 26 Apr 2019 14:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HuTfsELryJeSOY4MM09GUQ0yVJxmBTXdJs2bbc9UtQ4=;
        b=QWs0cvhxo5b6XSgSdS+sL0FkETgDk9wVJO+3SCyV6VtAexcZ4ePKFY3IwTZOF1CBLQ
         ZtDZ3GmBviqPXmPdmBRVEyU4xM6GzEr9CNbXWMlp1ygdnGElcHpCNVl09NybErS/zqVw
         b1mHWfbNWUnJtI1r6bv7NZOJib5Jkyy3DiR9VPXHONtw2ps/GDnqaL8keavMQqTSSHjf
         aMbGWPZmKp751hgHS9IFJ/6KNpIzE1jeDYiXemP5nPL81lFq6vbAHKYPNYk6jaX6PNTZ
         v/WBFY1ASmBS/3lOuLFLNPE5C9EhTHLqQ+DaR1YKWzH0yfgbUNzVitIB1jr4Js6JNzMO
         bqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HuTfsELryJeSOY4MM09GUQ0yVJxmBTXdJs2bbc9UtQ4=;
        b=fqDxg5XbIkhl77J6iFcatUJ09J36/JghUL5NtQ2EDf8uxoG9i5FCqaQv60aOxiE8vv
         +a3SIpsX+ezdlM4C7gmNhbFeWexnDxkfhuk3yqnClWkFBLuOrJjX+xJYuIQHW5Aa4b0G
         PP5Eb5raB4f82Io2dcZdBxeBWSExycDDUmMKCIHcfwoGreeyQJhZtFPd7X8Z4nacsyLr
         DVlL9QdKxI1v94MmMu4rbV+KvrR8TWOhV2BWlDurUrIE7SoHrzlHtkc4x65oBqq6ZY0H
         EYWYuBjjBsR/u2rJWlj2zKt0Xaf5A5DmIPubDb5SQ53IRpncAhgsfsObqwU4VTCutOGL
         cCsQ==
X-Gm-Message-State: APjAAAWrMKX2V3MN1GGvppiPZPqZCeTlzDcjBx/63H6Vk6azf8K3UuQt
        hYf/GsY4/sRMmMqlstjTU7s=
X-Google-Smtp-Source: APXvYqw0C0uzMaVDs8uD0fDbbPTLP3dbgXbiXbhlTBr0JqkTaqPxQWbEn/w/Z8hD9yFZdSFxMkh6SQ==
X-Received: by 2002:a19:6b0d:: with SMTP id d13mr25324260lfa.79.1556313718342;
        Fri, 26 Apr 2019 14:21:58 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id a28sm7097173lfk.54.2019.04.26.14.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 14:21:57 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] net: phy: realtek: Change TX-delay setting for RGMII modes only
Date:   Sat, 27 Apr 2019 00:21:12 +0300
Message-Id: <20190426212112.5624-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426093010.9609-1-fancer.lancer@gmail.com>
References: <20190426212112.5624-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's prone to problems if delay is cleared out for other than RGMII
modes. So lets set/clear the TX-delay in the config register only
if actually RGMII-like interface mode is requested.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---
 drivers/net/phy/realtek.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index ab567a1923ad..a18cb01158f9 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -163,16 +163,24 @@ static int rtl8211c_config_init(struct phy_device *phydev)
 static int rtl8211f_config_init(struct phy_device *phydev)
 {
 	int ret;
-	u16 val = 0;
+	u16 val;
 
 	ret = genphy_config_init(phydev);
 	if (ret < 0)
 		return ret;
 
-	/* enable TX-delay for rgmii-id and rgmii-txid, otherwise disable it */
-	if (phydev->interface == PHY_INTERFACE_MODE_RGMII_ID ||
-	    phydev->interface == PHY_INTERFACE_MODE_RGMII_TXID)
+	/* enable TX-delay for rgmii-id/rgmii-txid, and disable it for rgmii */
+	switch (phydev->interface) {
+	case PHY_INTERFACE_MODE_RGMII:
+		val = 0;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
 		val = RTL8211F_TX_DELAY;
+		break;
+	default: /* the rest of the modes imply leaving delay as is. */
+		return 0;
+	}
 
 	return phy_modify_paged(phydev, 0xd08, 0x11, RTL8211F_TX_DELAY, val);
 }
-- 
2.21.0

