Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05965C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 21:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C355420989
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 21:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xrX4j64+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfELVNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 17:13:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45919 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfELVNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 17:13:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id b18so3045300wrq.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 14:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/MF03Yk8qHs4qIsb2AOZr0tzgKoY7lMlH2WlfSDwuOY=;
        b=xrX4j64+HMUtsk4h0npiVMTngyq5aDotfuTPiLl3pkn4irKm66Tib/0yHHrTgZgITz
         6kHKZN2IPzjRNZEipner79yUCaRKmqnmIPIt4mMaO1WCjOjlb4LRLjFIeupDmm910TsW
         5luX379Yau3bRAZ18bQZ3Y3XhG6LZrq1MP8UH2TRBz1hBPGluEd5v343HsHc3xJi+7HY
         OYdEtFF7pebGsEzZDsTl89mkx2Lbs4fwiBqez4uIHtQsxK6bvUzaww5LK9e+JGUH6Y0H
         O+2tXanD20mVNk1BlS6yiiuC21tD/K6Tc3jbGHK2RO/A7P/490SRYG3OGJjGbVG1mq+O
         Ll4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/MF03Yk8qHs4qIsb2AOZr0tzgKoY7lMlH2WlfSDwuOY=;
        b=kjZvAvDy+teiTbDcy9CyDZEiNQ1QtROQHc3047ulDxxYPZrDKh4CJiElBQcSQff/9X
         FrD4vgg0+9iBB7H7Re9BNhGVSJtGeZMNuyrqMUZObBcv9jz/vWHstvJwydtT23CapejW
         7XpRvg+rXayPkvZV28AYpR0Di+4DRiTcu48QWIrSKqgffwQHUSyYVkq9nCQ/cah7LdcE
         HJm9LwqaE2HvpqjAyefFIFavLACjJNZ/K3a8xd6kmvuFGbsN4PdQBLaoxlJPQzCfSxdm
         l7izp0kOJ/aYkJzA3qmYaY+ObSUtiN14Q4+FltjDJhuE04tSX8i4yUPJREepJt4gL2MI
         OG/w==
X-Gm-Message-State: APjAAAUuzw6PWZAfg2C+y1h4ZD/6YzVIMPzGF+yIGBkc1VQQ30xhfyyj
        sSAMp+PVxbPsBZ8sPQxJufqQyg==
X-Google-Smtp-Source: APXvYqzDPd24huacRw8Qk3w1mk0rGWk2Xq0y5p5KauUXLdG7pc6JEEPiBt3rS+2AlR7Ph19ZbxRFzg==
X-Received: by 2002:adf:b6a5:: with SMTP id j37mr12136969wre.4.1557695583710;
        Sun, 12 May 2019 14:13:03 -0700 (PDT)
Received: from boomer.baylibre.com (uluru.liltaz.com. [163.172.81.188])
        by smtp.googlemail.com with ESMTPSA id j46sm30499951wre.54.2019.05.12.14.13.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 May 2019 14:13:02 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Qi Duan <qi.duan@amlogic.com>
Subject: [PATCH net] net: meson: fixup g12a glue ephy id
Date:   Sun, 12 May 2019 23:12:37 +0200
Message-Id: <20190512211237.24571-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phy id chosen by Amlogic is incorrectly set in the mdio mux and
does not match the phy driver.

It was not detected before because DT forces the use the correct driver
for the internal PHY.

Fixes: 7090425104db ("net: phy: add amlogic g12a mdio mux support")
Reported-by: Qi Duan <qi.duan@amlogic.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/net/phy/mdio-mux-meson-g12a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mdio-mux-meson-g12a.c b/drivers/net/phy/mdio-mux-meson-g12a.c
index 6fa29ea8e2a3..6644762ff2ab 100644
--- a/drivers/net/phy/mdio-mux-meson-g12a.c
+++ b/drivers/net/phy/mdio-mux-meson-g12a.c
@@ -33,7 +33,7 @@
 #define ETH_PLL_CTL7		0x60
 
 #define ETH_PHY_CNTL0		0x80
-#define   EPHY_G12A_ID		0x33000180
+#define   EPHY_G12A_ID		0x33010180
 #define ETH_PHY_CNTL1		0x84
 #define  PHY_CNTL1_ST_MODE	GENMASK(2, 0)
 #define  PHY_CNTL1_ST_PHYADD	GENMASK(7, 3)
-- 
2.20.1

