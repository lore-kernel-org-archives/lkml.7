Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3A1C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 03:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E941D2173C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 03:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405001AbfHIDND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 23:13:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46900 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404958AbfHIDND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 23:13:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id z1so96836744wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 20:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uonr7JGvdCWxCXj+k6k7pRPYOSgXIk19KhW6G51a7QQ=;
        b=d0tecrJwZbMRlnIIPBH4bv10bWdENjG3fbgjRip0V+KitFqb7bUx8cyREvjX409UCE
         +hDBjlEVikIN6fbCio/ls4+jwfBqPihfxo1H2RrUKFexNo1xGzx9RRYA2vclntJUsoR2
         s/oomIkAPaceMRLwaLo/4i4yH+gX7+EmP9V8kg0rQslO9XuV3j3O9OvKaWDNs0ss0zWb
         PSUFdyXwoLKJ7PfrKvpoUQ5l9HtYoy4qWUOvpsIBd5JGflscmqm1zOwAIaumGqXPfklq
         WBHo1AgErUXKw20pdKaX8FofvM/3R47seTBj676kwD2Zfkvukz8XLrQschqfmv4l2bmI
         9i4g==
X-Gm-Message-State: APjAAAVjS2+zT1WE+u7vjp50CXn4FxkCaAmsS4o/dMoJJz/XQA9mta42
        FpLLRXVCECDA168edyOau3fzKJIv8sw3WA==
X-Google-Smtp-Source: APXvYqxTo5Q9T2mOXycuvfbxR4lb1X0KpEpQKQKLAhovI4Yky74FgaZTgY7LTdrzkcmNh0U1VAJxjQ==
X-Received: by 2002:adf:fe10:: with SMTP id n16mr20512822wrr.92.1565320380703;
        Thu, 08 Aug 2019 20:13:00 -0700 (PDT)
Received: from tfsielt31850.garage.tyco.com ([79.97.20.138])
        by smtp.gmail.com with ESMTPSA id l14sm119815wrn.42.2019.08.08.20.12.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 20:13:00 -0700 (PDT)
From:   =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: imx: stop adjusting ar8031 phy tx delay
Date:   Fri,  9 Aug 2019 04:12:56 +0100
Message-Id: <20190809031256.3594-1-git@andred.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent changes to the Atheros at803x driver cause
the approach taken here to stop working because
commit 6d4cd041f0af
("net: phy: at803x: disable delay only for RGMII mode")
and commit cd28d1d6e52e
("net: phy: at803x: Disable phy delay for RGMII mode")
fix the AR8031 driver to configure the phy's (RX/TX)
delays as per the 'phy-mode' in the device tree.

In particular, the phy tx (and rx) delays are updated
again as per the 'phy-mode' *after* the code in here
runs.

Things worked before above commits, because the AR8031
comes out of reset with RX delay enabled, and the
at803x driver didn't touch the delay configuration at
all when "rgmii" mode was selected.

It appears the code in here tries to make device
trees work that incorrectly specify "rgmii", but
that can't work any more and it is imperative since
above commits to have the phy-mode configured
correctly in the device tree.

I suspect there are a few imx7d based boards using
the ar8031 phy and phy-mode = "rgmii", but given I
don't know which ones exactly, I am not in a
position to update the respective device trees.

Hence this patch is simply removing the superfluous
code from the imx7d initialisation. An alternative
could be to add a warning instead, but that would
penalize all boards that have been updated already.

Signed-off-by: André Draszik <git@andred.net>
CC: Russell King <linux@armlinux.org.uk>
CC: Shawn Guo <shawnguo@kernel.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>
CC: Pengutronix Kernel Team <kernel@pengutronix.de>
CC: Fabio Estevam <festevam@gmail.com>
CC: NXP Linux Team <linux-imx@nxp.com>
CC: Kate Stewart <kstewart@linuxfoundation.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Leonard Crestez <leonard.crestez@nxp.com>
CC: linux-arm-kernel@lists.infradead.org
---
 arch/arm/mach-imx/mach-imx7d.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx7d.c b/arch/arm/mach-imx/mach-imx7d.c
index 95713450591a..ebb27592a9f7 100644
--- a/arch/arm/mach-imx/mach-imx7d.c
+++ b/arch/arm/mach-imx/mach-imx7d.c
@@ -30,12 +30,6 @@ static int ar8031_phy_fixup(struct phy_device *dev)
 	val &= ~(0x1 << 8);
 	phy_write(dev, 0xe, val);
 
-	/* introduce tx clock delay */
-	phy_write(dev, 0x1d, 0x5);
-	val = phy_read(dev, 0x1e);
-	val |= 0x0100;
-	phy_write(dev, 0x1e, val);
-
 	return 0;
 }
 
-- 
2.20.1

