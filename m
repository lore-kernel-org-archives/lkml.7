Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4120C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE26021900
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2a17HMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfCUXfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:35:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37033 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfCUXfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 19:35:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id q206so140402pgq.4;
        Thu, 21 Mar 2019 16:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8Y/sYzOaRwSDCFgPlote6xLZYO5rH7gg46+3VaWbz0g=;
        b=T2a17HMmg+gnra/eUBa8nfarG5lBspo9DoYVX371NcV5YRuL4VM0wcEtkIU1FUPYZa
         dyqtsT70PlfbK/WGUhPIA91Dbyyikv8H+ylTIcgUKKgqXycWM8rZcJgd2hQClkj5CJGc
         2nvKQHQgLF+B/exCrkAORWg9mb3kYKKpWI9hlYPGasn3LOO+C5VUDKr8MOX3F4KePQlp
         NWO15h9iHptIyoOarmFJzq2eq87zmCywFxvVAeKEcDGZ7qnqYwlmbTeaqXMAcwVfMjSD
         2B/sTTtTxHjX7x9OLgWbMCV77hAg1a8ee3aGSIxoFNeAMF8UYqpqgQ6vHrHSALydvJGj
         RYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8Y/sYzOaRwSDCFgPlote6xLZYO5rH7gg46+3VaWbz0g=;
        b=iBacOHYl3ggPEN5l3aBYOSOpLZBuusYFV6sXhLBLdLUMhWBjRBWhU9JOCWQgXakshh
         ODBZwvNrfp5FikNXcQ90uknuf913UjFlrmACvODszkbDsdseHZzgSJXki802kOJ1Pc9N
         F71VE0pWkxG+0VJl+ahIy/ebs3Qrj7dFHFwLzPXEvemCEfaquWmeyNjr+sF5Qpil0iGy
         /cO8Eqlu5xR+tSPNBvJigJI7BGd1eNQg5B42WZKuDNVXANZ00jLMt8IDRiHuKH1KhS8X
         Z2N6bA8wxPWmpppEDnAJlt2E5LESCrQd2w+nli5FTczGOTZxBf3rQU9R/e65OWi7CBgZ
         puGg==
X-Gm-Message-State: APjAAAUw/rcTRvC9jicvz3EH6NJmFpHaQlHDZCLxYxUBnrY4KWtgONHh
        acFE+MBhfcW1A7td/3H1e2H+TWAJ
X-Google-Smtp-Source: APXvYqyotsigtsTrpw7u0Q2WJnen02uu0Q4SZQt/LP2qkmd87+Ac3bma4Ieh7/mwzcqOnIus7a0Jgg==
X-Received: by 2002:a17:902:1125:: with SMTP id d34mr6431435pla.75.1553211303770;
        Thu, 21 Mar 2019 16:35:03 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id s5sm7910116pfm.184.2019.03.21.16.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 16:35:03 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: phy: Re-parent menus for MDIO bus drivers correctly
Date:   Thu, 21 Mar 2019 16:34:44 -0700
Message-Id: <20190321233445.11526-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After 90eff9096c01 ("net: phy: Allow splitting MDIO bus/device support
from PHYs") the various MDIO bus drivers were no longer parented with
config PHYLIB but with config MDIO_BUS which is not a menuconfig, fix
this by depending on MDIO_DEVICE which is a menuconfig.

This is visually nicer and less confusing for users.

Fixes: 90eff9096c01 ("net: phy: Allow splitting MDIO bus/device support from PHYs")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/phy/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 071869db44cf..520657945b82 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -7,6 +7,8 @@ menuconfig MDIO_DEVICE
 	help
 	  MDIO devices and driver infrastructure code.
 
+if MDIO_DEVICE
+
 config MDIO_BUS
 	tristate
 	default m if PHYLIB=m
@@ -179,6 +181,7 @@ config MDIO_XGENE
 	  APM X-Gene SoC's.
 
 endif
+endif
 
 config PHYLINK
 	tristate
-- 
2.17.1

