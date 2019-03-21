Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A80C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DEDF218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgBL8ktY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfCUXYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:24:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35567 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfCUXYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 19:24:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id g8so131662pgf.2;
        Thu, 21 Mar 2019 16:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=X6h/ACjlcbFAweA0RLB+zosl0TSavjMSYhL4oWZJJjg=;
        b=jgBL8ktYiP1rIcdhNV/AxisOXE4nZPPuIXQOt/aBfVSouuWLLtzZ+pxgA+iTBLi7Kj
         IbzBHiuJidxjQz8ncdRsEMTqDvLnKZf5c/ISWKeLccEina1+0zgqQ/Tqa76WUTpQKbGp
         9UKh0iAUqOQQa8qIzBDgpLd6QZLs0K3ZtswRnv1aUrXIsC4w+bI7c0mZRNeWBwJHRW3C
         cgNg2riXDzW/rq2botuUlwVlJKW18RzoBbIPGEwvqDMJF09l1rw8tMr/73gO8a3JWo6H
         YRITrtDW8130+StdPkmCKsryAnQL5E0257/HsG/yisbgzi8EfWAuvl8CI/lGM+WmXcDG
         S3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X6h/ACjlcbFAweA0RLB+zosl0TSavjMSYhL4oWZJJjg=;
        b=n47DqiTjeaA0LygSLeDL+Hk6wSaa+czcmx2Q8hUZ23cauVWeOuzC5qHo0yFkPrWNbE
         x79SNy4hIjBNPorYeK22WFk2Cv1xHjLgGl7DqDZOCvx8WrsXrIP9NU7VY4pF8+yPSVyI
         jOjnQq9F22XheUPXLQ9mdMxITKCTtwXe1LwQDltPbDWp2T4hvU+q8QHsOnJ5/Kb/LiSz
         oPHsk1f1WSO6Zdg7ZgvlSZ0mx5zIFDqtMBvwhiKxOZ0osRI8HHMvuUBtdX0Wq6sQzKQI
         JNN/3hqNaD/NoIDTgvq0KZ4f8p53ucM/j56Gb+IDsfJM+F6SnnBMan4tuQSMAL9NSh1U
         hgjg==
X-Gm-Message-State: APjAAAWfGCZaemy5j31ovolVARNb5hIeblJ+43K2KlVqyhl4fR3QxUZ8
        YliEJSVmhNV0g/93WRCvTs30xUea
X-Google-Smtp-Source: APXvYqy0zep7VfJXwpnYX2mMJ9wOTMahDh3A5GhXJslIHRmw9QkE3ob4EmN/frytcMPuyfeod7cP+Q==
X-Received: by 2002:a63:614c:: with SMTP id v73mr5908900pgb.395.1553210659808;
        Thu, 21 Mar 2019 16:24:19 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 13sm6798221pgq.66.2019.03.21.16.24.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 16:24:19 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, Stephen Rothwell <sfr@canb.auug.org.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: phy: Correct Cygnus/Omega PHY driver prompt
Date:   Thu, 21 Mar 2019 16:23:30 -0700
Message-Id: <20190321232331.22584-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tristate prompt should have been replaced rather than defined a few
lines below, rebase mistake.

Fixes: 17cc9821766c ("net: phy: Move Omega PHY entry to Cygnus PHY driver")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 0973f0b81ce4..e493db5e8744 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -270,10 +270,9 @@ config BCM87XX_PHY
 	  Currently supports the BCM8706 and BCM8727 10G Ethernet PHYs.
 
 config BCM_CYGNUS_PHY
-	tristate "Broadcom Cygnus SoC internal PHY"
+	tristate "Broadcom Cygnus/Omega SoC internal PHY"
 	depends on ARCH_BCM_IPROC || COMPILE_TEST
 	depends on MDIO_BCM_IPROC
-	tristate "Broadcom Cygnus/Omega SoC internal PHY"
 	select BCM_NET_PHYLIB
 	---help---
 	  This PHY driver is for the 1G internal PHYs of the Broadcom
-- 
2.17.1

