Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3ACBC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 23:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36C3217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 23:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myvngQH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgABXey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 18:34:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38223 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgABXey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 18:34:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id u2so7160622wmc.3;
        Thu, 02 Jan 2020 15:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HJKcKqhF6EndJ3K/SOkcnH//Glb3mCrBWZRIITdekaw=;
        b=myvngQH+bGgME9aE3dFxbrsLYM4l11YoWQncJfW0ByxwgYs3xYMDijGhtet8rtAb8s
         Kgcf8a8rFyWWGuorgdNWJDE6UnfOdhq9Ij9zEHFMr20KmF1BdrlRXQUGZjzIIE8zf7ej
         qNOH631tHALJ3cCyW6flND9PVN0Xpzt5l7wsj/OaT9ny1x9O9no/+KTY+YFGKVSvSwJE
         fKszWmpI0sY5lKE7pNlyePf2lB0Np4wCiPxDGsqPHnNQgW/t+0AcrLIRpJusosXFjVSj
         yU7/P0iUCdoBEi5j+z+C9BEULMCIxpun1mgkuO6AxbPixkX9x4/Mw0u53qdrkgGxIeao
         +GZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HJKcKqhF6EndJ3K/SOkcnH//Glb3mCrBWZRIITdekaw=;
        b=Up7uCMVviDK2EuIRiUUJcugRKXlPuTMNhVMXCkb9DBksk6TdCNt7yPJ8O+S4MEGTng
         WaECWeyKIvC4o8J+um81OF5GOWWEqyZw6WOtbdtHwpqmEuzXolei52pT8iY32zAfDckT
         8clxLiIhK+PPgSAi3bSWL29zDEAVnVBVM3Y+tW5kSamvu68XtZXkyixsW4vT/A1a5o0Y
         cHrLNd773maUBAj+J5OlQoyrQv6bv4epOKm1V9hfXQVurl1Mgct3gmhUcFhi0+00/Rzv
         ZQW9j+nDnRDun0F27AUDQivTLHj3DGS/8CQoNX34+e+qRZBaw/PIpBIk4GXxvAmEd8Td
         QujA==
X-Gm-Message-State: APjAAAVfiA0FKVZJWNwVdXj4NSNA7cPGbBC4KOSMLDGawmDRQrSZXfQV
        m3fXKELmrM15I6HFlDTfI/2y6QuD
X-Google-Smtp-Source: APXvYqwOw/UXQRkdJarshWQfqmR7Unu/fbptx5t5OzHYqxbDRqEmyZU0sM8uck7ed2ZuvTC/naBOmA==
X-Received: by 2002:a05:600c:2409:: with SMTP id 9mr15057732wmp.109.1578008091904;
        Thu, 02 Jan 2020 15:34:51 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id i5sm9990217wml.31.2020.01.02.15.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 15:34:51 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     paweldembicki@gmail.com, linus.walleij@linaro.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: dsa: vsc73xx: Remove dependency on CONFIG_OF
Date:   Thu,  2 Jan 2020 15:34:45 -0800
Message-Id: <20200102233445.12764-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no build time dependency on CONFIG_OF, but we do need to make
sure we gate the initialization of the gpio_chip::of_node member with a
proper check on CONFIG_OF_GPIO. This enables the driver to build on
platforms that do not have CONFIG_OF enabled.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/dsa/Kconfig                | 3 ---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index cbd74a72d0a1..2d38dbc9dd8c 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -105,7 +105,6 @@ config NET_DSA_SMSC_LAN9303_MDIO
 
 config NET_DSA_VITESSE_VSC73XX
 	tristate
-	depends on OF
 	depends on NET_DSA
 	select FIXED_PHY
 	select VITESSE_PHY
@@ -116,7 +115,6 @@ config NET_DSA_VITESSE_VSC73XX
 
 config NET_DSA_VITESSE_VSC73XX_SPI
 	tristate "Vitesse VSC7385/7388/7395/7398 SPI mode support"
-	depends on OF
 	depends on NET_DSA
 	depends on SPI
 	select NET_DSA_VITESSE_VSC73XX
@@ -126,7 +124,6 @@ config NET_DSA_VITESSE_VSC73XX_SPI
 
 config NET_DSA_VITESSE_VSC73XX_PLATFORM
 	tristate "Vitesse VSC7385/7388/7395/7398 Platform mode support"
-	depends on OF
 	depends on NET_DSA
 	depends on HAS_IOMEM
 	select NET_DSA_VITESSE_VSC73XX
diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 42c1574d45f2..69fc0110ce04 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -1111,7 +1111,9 @@ static int vsc73xx_gpio_probe(struct vsc73xx *vsc)
 	vsc->gc.ngpio = 4;
 	vsc->gc.owner = THIS_MODULE;
 	vsc->gc.parent = vsc->dev;
+#if IS_ENABLED(CONFIG_OF_GPIO)
 	vsc->gc.of_node = vsc->dev->of_node;
+#endif
 	vsc->gc.base = -1;
 	vsc->gc.get = vsc73xx_gpio_get;
 	vsc->gc.set = vsc73xx_gpio_set;
-- 
2.17.1

