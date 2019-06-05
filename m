Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D58AC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C50F20866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 09:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XKoGucDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfFEJCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 05:02:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37879 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfFEJCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 05:02:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id v14so960072wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 02:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W0UkzujEUwohNcf3VeH5h/qlE6pjw3A5B8Q608W8mEU=;
        b=XKoGucDRE59ctdALi55KnuMB2pfY4g1Lt2zBA4dvnGGpwv8Z5gwHb05HCPJDTYlsbv
         5TEfJkhJycV628Z7tr8w84ThBaNxy//SPoHYuGOJ0VhosZmyjqvffKiCo1uNMfH2phSz
         4/Z+AWW56a/f6ql6qLBNzuywl75gEeAD102Rkce3ha+JURcmzY76hw5YCbVZat/ARTKv
         VjXv0W9LPviK5+3e65+wQ/+9r0PD/i6Wmq0HNSuHy4K90cwTLPxRfj32qo9BRccs76SB
         tVQbQBCNFgicGamR/5EkDT2QMolDsY0paIHmFUR1OewGP2Mvn3M1z7hZlsdU5/d8O5hX
         WKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W0UkzujEUwohNcf3VeH5h/qlE6pjw3A5B8Q608W8mEU=;
        b=QMgvsPStdZz1DANt1jUOt+ns2sIA8QHuuXkO76GfrWecF8ZvoM1Fmj2CRHSghaf/03
         egofPNmVvSC+K/KOJRR6/OYO58A2QZJaY155Tb0VOCURlKeGlevh+faAGcCbQSbgWH4p
         UkTj30O33mS2J94FTUJs7t4pu2zhRow+DtOoqeeTKfZEF8dJBPGF8Dr2rzrFQVaI2z6/
         +eUNSGI/SoEJuDZaSyHygU/oHVqXRmcc8GpXBr5r0f6m+sXf+uo25UCQb3+fBm25LBGh
         a+O4fDEsqwjygwRhClCoR0wdWkU1qjB9YDj4heysvuUlby3HvOkexgW3BthSj0IGM7Zq
         H4gA==
X-Gm-Message-State: APjAAAXQI5bX/JnZd5NCJFrY2UcwwXC1NMdQJi9lx+yJBBMLl5Nzlz8U
        Y9ismwt5+m/35aGu5d8shYmFNhEB0JowCg==
X-Google-Smtp-Source: APXvYqwa2RNAJJwxMJ6JTg0mjevN5vtgAE668gbRTlJwHBOWetytUnE20xaQcYxq0qE3ERpFLm+yug==
X-Received: by 2002:adf:fc87:: with SMTP id g7mr20918125wrr.229.1559725337237;
        Wed, 05 Jun 2019 02:02:17 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c129sm2697842wma.27.2019.06.05.02.02.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Jun 2019 02:02:16 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v2] phy: meson-g12a-usb3-pcie: disable locking for cr_regmap
Date:   Wed,  5 Jun 2019 11:02:15 +0200
Message-Id: <20190605090215.29905-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Locking is not needed for the phy_g12a_usb3_pcie_cr_bus_read/write() and
currently it causes the following BUG because of the usage of the
regmap_read_poll_timeout() running in spinlock_irq, configured by regmap fast_io.

Simply disable locking in the cr_regmap config since it's only used from the
PHY init callback function.

BUG: sleeping function called from invalid context at drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c:85
in_atomic(): 1, irqs_disabled(): 128, pid: 60, name: kworker/3:1
[snip]
Workqueue: events deferred_probe_work_func
Call trace:
 dump_backtrace+0x0/0x190
 show_stack+0x14/0x20
 dump_stack+0x90/0xb4
 ___might_sleep+0xec/0x110
 __might_sleep+0x50/0x88
 phy_g12a_usb3_pcie_cr_bus_addr.isra.0+0x80/0x1a8
 phy_g12a_usb3_pcie_cr_bus_read+0x34/0x1d8
 _regmap_read+0x60/0xe0
 _regmap_update_bits+0xc4/0x110
 regmap_update_bits_base+0x60/0x90
 phy_g12a_usb3_pcie_init+0xdc/0x210
 phy_init+0x74/0xd0
 dwc3_meson_g12a_probe+0x2cc/0x4d0
 platform_drv_probe+0x50/0xa0
 really_probe+0x20c/0x3b8
 driver_probe_device+0x68/0x150
 __device_attach_driver+0xa8/0x170
 bus_for_each_drv+0x64/0xc8
 __device_attach+0xd8/0x158
 device_initial_probe+0x10/0x18
 bus_probe_device+0x90/0x98
 deferred_probe_work_func+0x94/0xe8
 process_one_work+0x1e0/0x338
 worker_thread+0x230/0x458
 kthread+0x134/0x138
 ret_from_fork+0x10/0x1c

Fixes: 36077e16c050 ("phy: amlogic: Add Amlogic G12A USB3 + PCIE Combo PHY Driver")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
index 6233a7979a93..ac322d643c7a 100644
--- a/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
+++ b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
@@ -188,7 +188,7 @@ static const struct regmap_config phy_g12a_usb3_pcie_cr_regmap_conf = {
 	.reg_read = phy_g12a_usb3_pcie_cr_bus_read,
 	.reg_write = phy_g12a_usb3_pcie_cr_bus_write,
 	.max_register = 0xffff,
-	.fast_io = true,
+	.disable_locking = true,
 };
 
 static int phy_g12a_usb3_init(struct phy *phy)
-- 
2.21.0

