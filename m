Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2C6C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AE720868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563200467;
	bh=uD0iJ8pg9FMGfYsCPPx6lt0Ci+QLueRNLz1NcRGd82I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hKZBB+ay8cDhYL3jpYxOyEDFTWbW0TwvF6jmvVhvvF8vI/YYQmdTh+eYNS5EkG+RE
	 ykWO3FXuzQjMAhEG4hz0DeEr55CR8dfMSNG7nYM34r8uew+F7Cm5yMAeMJBVQWz3XL
	 TBbb7jX22rZd1N6yVkzeCjIakEu1uvsUUS4OQ544=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390500AbfGOOVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:21:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390015AbfGOOVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:21:01 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08F71217D8;
        Mon, 15 Jul 2019 14:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563200460;
        bh=uD0iJ8pg9FMGfYsCPPx6lt0Ci+QLueRNLz1NcRGd82I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kMitWB63w9MdMNSIR8AQmkBoIx+Zy5neUdG4WKEFr7S+CpuujOL/A077gOdlYSIi2
         KGQGNp2DA4VqLo0u/wt2tnBlT+2HGy8Ev6tqCfEt52bCIbErJGCdxtrfwQ2F6jpFuP
         cQZx909UCJFySy9fiqkEG0dTgeEBrxQVb+D3fNPA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xingyu Chen <xingyu.chen@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 055/158] irqchip/meson-gpio: Add support for Meson-G12A SoC
Date:   Mon, 15 Jul 2019 10:16:26 -0400
Message-Id: <20190715141809.8445-55-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715141809.8445-1-sashal@kernel.org>
References: <20190715141809.8445-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xingyu Chen <xingyu.chen@amlogic.com>

[ Upstream commit c64a9e804ccf86eb202bfd1c6a8c5233c75a0431 ]

The Meson-G12A SoC uses the same GPIO interrupt controller IP block as the
other Meson SoCs, A totle of 100 pins can be spied on, which is the sum of:

- 223:100 undefined (no interrupt)
- 99:97   3 pins on bank GPIOE
- 96:77   20 pins on bank GPIOX
- 76:61   16 pins on bank GPIOA
- 60:53   8 pins on bank GPIOC
- 52:37   16 pins on bank BOOT
- 36:28   9 pins on bank GPIOH
- 27:12   16 pins on bank GPIOZ
- 11:0    12 pins in the AO domain

Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-meson-gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 7b531fd075b8..7599b10ecf09 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -73,6 +73,7 @@ static const struct of_device_id meson_irq_gpio_matches[] = {
 	{ .compatible = "amlogic,meson-gxbb-gpio-intc", .data = &gxbb_params },
 	{ .compatible = "amlogic,meson-gxl-gpio-intc", .data = &gxl_params },
 	{ .compatible = "amlogic,meson-axg-gpio-intc", .data = &axg_params },
+	{ .compatible = "amlogic,meson-g12a-gpio-intc", .data = &axg_params },
 	{ }
 };
 
-- 
2.20.1

