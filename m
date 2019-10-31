Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F651CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 22:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43535208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 22:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htzJfnde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfJaWyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 18:54:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35402 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbfJaWym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 18:54:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id l10so8004148wrb.2;
        Thu, 31 Oct 2019 15:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jvZP4IjF+cM+5v4WE1h79kJv8HUsxh1Yd8Tome4anM0=;
        b=htzJfnde8s+BMk9pb0mpvAYix5EFKvP18en6mO87PiCDplLp+sQKVLb+yKDNuErO86
         /7rcaYOoU5IF6Zkv03s/zEZFJEkBxGFEF5F+/a/rTtLmxjnTVq0RuasBjrNhBmJTtbhT
         0uOw0+bhO6rusnbsD22Vrgzf61muVyleb/ppOqLhqdO4XkPNdqg8gp9vmGXhSlFBQAE2
         jZrzOBWeyGnXMduC8Zh1fZW9TEiZSKyuleDSWWw0O9SvGpf6/A5ihPJJaqNwuryHz7sl
         wSl9PQBAEeIuGMgsN36DFEQXpyuiOBfeiDA+OeRUdxD7czl9+I98zMA0/V5ESdjtBX1a
         pnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jvZP4IjF+cM+5v4WE1h79kJv8HUsxh1Yd8Tome4anM0=;
        b=evANuF1GXv1IgJuupUhxxP2oZbJRmNsSznJ8Jqs6Z/elD4j1iIdo7065LxjD8R946D
         B7F8tXRc060vlMyrLfK9W9lV4VYZUZWaidi8vBkWmtnlPgTnkrwrmt3tEiOHVjmcn8ur
         eEZ5fhUi9zcW1GBQPeWLL22OMXjgP19WRRD5QvhpfMiW6SZtjmx6kUg5E7Q9GXhuXFOs
         psAmQ/OG0e3WVPlGheWuQzMQVWZxHyn6quvNtrpnpxxl+9Tl7bGPwCtan/ZY9npZqswM
         SLd8Hct/VheCgqVlMEVN4+YPNLErNWrcjF69bNhul5/9/5koQDAjXmJZmfUFljOwm6BJ
         2lbA==
X-Gm-Message-State: APjAAAWBD67ad61JhTpdph+yUBTqdyuq0cVuuSi/a56HZRB1y0erqC3c
        ku6o7gtFDCDg9SO+T1J/aDL3J9q7
X-Google-Smtp-Source: APXvYqxSJrKNjifanLUViX+WFi/sfi721m6BzBU6ZA5ERaJq0D2RC8yb+ijRRx8uyjZscWM/RNJK7A==
X-Received: by 2002:a05:6000:351:: with SMTP id e17mr7431902wre.96.1572562481045;
        Thu, 31 Oct 2019 15:54:41 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o189sm6496202wmo.23.2019.10.31.15.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:54:40 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: dsa: bcm_sf2: Fix IMP setup for port different than 8
Date:   Thu, 31 Oct 2019 15:54:05 -0700
Message-Id: <20191031225406.10576-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since it became possible for the DSA core to use a CPU port different
than 8, our bcm_sf2_imp_setup() function was broken because it assumes
that registers are applicable to port 8. In particular, the port's MAC
is going to stay disabled, so make sure we clear the RX_DIS and TX_DIS
bits if we are not configured for port 8.

Fixes: 9f91484f6fcc ("net: dsa: make "label" property optional for dsa2")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/bcm_sf2.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 26509fa37a50..d44651ad520c 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -37,22 +37,11 @@ static void bcm_sf2_imp_setup(struct dsa_switch *ds, int port)
 	unsigned int i;
 	u32 reg, offset;
 
-	if (priv->type == BCM7445_DEVICE_ID)
-		offset = CORE_STS_OVERRIDE_IMP;
-	else
-		offset = CORE_STS_OVERRIDE_IMP2;
-
 	/* Enable the port memories */
 	reg = core_readl(priv, CORE_MEM_PSM_VDD_CTRL);
 	reg &= ~P_TXQ_PSM_VDD(port);
 	core_writel(priv, reg, CORE_MEM_PSM_VDD_CTRL);
 
-	/* Enable Broadcast, Multicast, Unicast forwarding to IMP port */
-	reg = core_readl(priv, CORE_IMP_CTL);
-	reg |= (RX_BCST_EN | RX_MCST_EN | RX_UCST_EN);
-	reg &= ~(RX_DIS | TX_DIS);
-	core_writel(priv, reg, CORE_IMP_CTL);
-
 	/* Enable forwarding */
 	core_writel(priv, SW_FWDG_EN, CORE_SWMODE);
 
@@ -71,10 +60,27 @@ static void bcm_sf2_imp_setup(struct dsa_switch *ds, int port)
 
 	b53_brcm_hdr_setup(ds, port);
 
-	/* Force link status for IMP port */
-	reg = core_readl(priv, offset);
-	reg |= (MII_SW_OR | LINK_STS);
-	core_writel(priv, reg, offset);
+	if (port == 8) {
+		if (priv->type == BCM7445_DEVICE_ID)
+			offset = CORE_STS_OVERRIDE_IMP;
+		else
+			offset = CORE_STS_OVERRIDE_IMP2;
+
+		/* Force link status for IMP port */
+		reg = core_readl(priv, offset);
+		reg |= (MII_SW_OR | LINK_STS);
+		core_writel(priv, reg, offset);
+
+		/* Enable Broadcast, Multicast, Unicast forwarding to IMP port */
+		reg = core_readl(priv, CORE_IMP_CTL);
+		reg |= (RX_BCST_EN | RX_MCST_EN | RX_UCST_EN);
+		reg &= ~(RX_DIS | TX_DIS);
+		core_writel(priv, reg, CORE_IMP_CTL);
+	} else {
+		reg = core_readl(priv, CORE_G_PCTL_PORT(port));
+		reg &= ~(RX_DIS | TX_DIS);
+		core_writel(priv, reg, CORE_G_PCTL_PORT(port));
+	}
 }
 
 static void bcm_sf2_gphy_enable_set(struct dsa_switch *ds, bool enable)
-- 
2.17.1

