Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27EBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0EA20842
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 02:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSGmwFEO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfCDCco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 21:32:44 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51552 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfCDCco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 21:32:44 -0500
Received: by mail-it1-f195.google.com with SMTP id e24so5199730itl.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 18:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=olrGrguTANru5m8GnasPP53gJKln6NKiwNBzK7JJ5lE=;
        b=dSGmwFEOeukjGZHUUt1xstj/+9ksJZ9ejWG65BnFnHToPHWWMb32Gp2qIr8zYnQoV2
         bDcA60y1BnfVxKS7/h7vzrRfukuCAJ5K1gGjq+izToJPsNRbtXPeeNDDJfZQRnaJRwaN
         k0+M+x2ZzG6djajD0pmIdu2NsyLLhMiftJkn/s8Dwc5IV1p6xEufNPUa89FI61aAfDHs
         swByLoBKbDq05mC7KvLl36FOX6Vwu8Nsy1Jevz8HCLyDhQm06LZPkNTBnsIZjdxBbFoe
         pg2a6UJzBsESPJmplFw3unlD/U/Gc6Xw1ZOofneF9GIsLzcDLgz9nlA5PuhGBuGAkXF2
         J2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=olrGrguTANru5m8GnasPP53gJKln6NKiwNBzK7JJ5lE=;
        b=THnS6f1fQ8b+991XIxXNZndh2ibicQYFWwkk+/RudvGz2vggAQHtGSqRxYvsOwTzGu
         +QDHPt5Uz9Ka7Z4pdrXr0xo27NpNP/XhFshhsWfsY8I2yKWTRZSC8mNblopEfoEAsplh
         e/JZLcdsoGgfBMHpg157j02RDVKYtUip7u+ReTjjvTglM+Tlz2OkuI5f2OatP46OXrzh
         t0bnl7kBOEHU09c53el5hFoTnCrZpVeDi/ATQFe3RBa5TsmbT/im4nviwSSmZZAKkwFU
         IwCvlE0XafldMG2jZmS9sAvZiqSSP36Qni6mnOFEWMCigBp4IKcPidH/+ArFxcpH9g8t
         r7qQ==
X-Gm-Message-State: AHQUAuaEkH2hdX5hTJQl66twAz5Pj+/TCYMs2CSYjwerA64qa9zWaXI4
        up4j4Zl2XIaRuQloBb3E5c8=
X-Google-Smtp-Source: APXvYqwwEmKw6RfapU17tf5ZC0Fk7Ty8ZoSD2BUkWNKa9qCjZCDcL2xhRJReDT9rQ7uf4y1o1m5VLg==
X-Received: by 2002:a24:2546:: with SMTP id g67mr8507134itg.18.1551666763153;
        Sun, 03 Mar 2019 18:32:43 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id i14sm2730035itc.34.2019.03.03.18.32.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 18:32:42 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     adam.ford@logicpd.com, Adam Ford <aford173@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Add GPIO_PCF857X
Date:   Sun,  3 Mar 2019 20:32:30 -0600
Message-Id: <20190304023231.19232-1-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx6q-logicpd board has a PCF8575 connected to it, so this
patch turns it on my default now.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 5586a5074a96..1872dacbbe9b 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -214,6 +214,7 @@ CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_MAX732X=y
 CONFIG_GPIO_MC9S08DZ60=y
 CONFIG_GPIO_PCA953X=y
+CONFIG_GPIO_PCF857X=y
 CONFIG_GPIO_STMPE=y
 CONFIG_GPIO_74X164=y
 CONFIG_POWER_RESET=y
-- 
2.17.1

