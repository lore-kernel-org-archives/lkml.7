Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF43BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6627222C7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="dH9qKRoz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfKSN1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 08:27:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43224 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfKSN1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 08:27:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id n1so23796153wra.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 05:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=EGefV7mNK+kl1gbQFeTNeXk1t+zkh+oZ0TH06o9BTAQ=;
        b=dH9qKRozXP3KGtiH9uJ20dq843ddNU4Kp6buGyZNiWSli31NjWeasZ0fjM9+/WH6rG
         cuXqvAacyuw+TjejZTJakkXuiEfx9r2oI0FYPibxm93297dDQxRQFAfwQnrwHTIeFpqT
         3PMWvCYoLXzw8e8VkV/cPIo+iwOgTSngc+huCnwRSTv9ikP2Z9+Y/OYnGS0CJmKdLKU6
         NsmwoeF1aS9rzaESFzr1AX5jAbX1oABu0xzYOipU79jfDeE6szLLhKS13Edomi2fnLCp
         J0r4b2EoPpIsDvCaHYy729/KBUdjTZVbfqxBZegxB4aRwkas5t2Hc4Gx9w4MEYn16huL
         /Cpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=EGefV7mNK+kl1gbQFeTNeXk1t+zkh+oZ0TH06o9BTAQ=;
        b=h+l1RQSHCkdUelUAe30wN0QxaxPjNG8fDH0zlg6oJz2LCa8FINa8EBWohEW8P1JjiO
         Q5EiGv9m5HNgMXRyatEHjX7aiHzmHQrFV3h403YgcmJqvJ0a5vXQiEMWh3vYlw7Oe+SG
         w14dX0vH8ejOsRC14Q3/D1bkvvOuf9f44Z3+MaIP24yDQLqpS7LpX4wt8V0L7ollMefX
         GtRjf8emcjHWnsWZOw/HLYmGr4LYtIB9PT/QQtqPPjMvQwy/8bRgBLyROE85mILSrKJF
         MnkhjXoD7S/2YQEn0xygLOB8WSMcahwe9xQW6aT58l3A29/jdwGk45TCX98Jq+YH/kuv
         bpzA==
X-Gm-Message-State: APjAAAWaasnJBqPSKI9y3WEtvfEi8O5n2QRlIYUR1aelS2I1ZAJRADjf
        zRH5CxSnIrtV5d9rgHqXcUn5DniGXsHcdg==
X-Google-Smtp-Source: APXvYqwWMrQSCn0yw+DxOB4jlYK+39UBztYpH/0OFf16lTrP8qAvd7dbA5m+dfTHLEaP9PMowm96Mg==
X-Received: by 2002:adf:f147:: with SMTP id y7mr29780144wro.236.1574170033042;
        Tue, 19 Nov 2019 05:27:13 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id t185sm3334612wmf.45.2019.11.19.05.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Nov 2019 05:27:12 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org
Subject: [PATCH] phy: mdio_bus: Check ENOTSUPP instead of ENOSYS in mdiobus_register_reset
Date:   Tue, 19 Nov 2019 14:27:11 +0100
Message-Id: <8712e54912598b3ca6f00d00ff8fbfdd1c53e7e8.1574170028.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Origin patch was using ENOTSUPP instead of ENOSYS. Silently changing error
value ends up in an access to bad area on Microblaze with axi ethernet
driver.

Fixes: 1d4639567d97 ("mdio_bus: Fix PTR_ERR applied after initialization to constant")
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

I didn't track it down where exactly that access happens but the patch is
clearly just changing something without description.

The origin patch has been merged between rc7 and rc8 and would be good to
get this fix to v5.4.
---
 drivers/net/phy/mdio_bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 35876562e32a..dbacb0031877 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -65,7 +65,7 @@ static int mdiobus_register_reset(struct mdio_device *mdiodev)
 		reset = devm_reset_control_get_exclusive(&mdiodev->dev,
 							 "phy");
 	if (IS_ERR(reset)) {
-		if (PTR_ERR(reset) == -ENOENT || PTR_ERR(reset) == -ENOSYS)
+		if (PTR_ERR(reset) == -ENOENT || PTR_ERR(reset) == -ENOTSUPP)
 			reset = NULL;
 		else
 			return PTR_ERR(reset);
-- 
2.17.1

