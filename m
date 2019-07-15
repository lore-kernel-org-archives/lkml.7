Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A24C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B2C2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563198740;
	bh=zSr+PhVnnzNTlPs+DoJCWiHQV8sw3NLgTGTniOxTuTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uX+/m0ycu9yOKN/h+8G5p1mTPVMrKOsE5qdegJ+Ha7+4zygVDh3B8D3EW8YkX9aqw
	 BK4X7g/kopB8FDxiHHVEh4xE5MXAoAZLMWAYLEehDxAssiT4D4qik4E5dC3a/B4dip
	 4Jthnad3p0rPIMaH8gomvWb9i+nYG4TkucCiZBTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732123AbfGONvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:51:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732116AbfGONvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:51:42 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C12320651;
        Mon, 15 Jul 2019 13:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563198701;
        bh=zSr+PhVnnzNTlPs+DoJCWiHQV8sw3NLgTGTniOxTuTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=14R6xhUtEgoeBu1dGDUhcKXWznmmJymrNdoBJe7szR6UKxqb9QFxqFNSz1DAZ9O0+
         knnSm8BcWh4TtqTBYMKF1G2R6xg5SdQUX3QflNMC4ATriZOS4OtUv5sgMXQnqhR99t
         IG6W+cB/FAtEKXu9kQoiVOLl2Xazr2whzOJwA5gM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xingyu Chen <xingyu.chen@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 5.2 086/249] irqchip/meson-gpio: Add support for Meson-G12A SoC
Date:   Mon, 15 Jul 2019 09:44:11 -0400
Message-Id: <20190715134655.4076-86-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
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
index 8eb92eb98f54..dcdc23b9dce6 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -60,6 +60,7 @@ static const struct of_device_id meson_irq_gpio_matches[] = {
 	{ .compatible = "amlogic,meson-gxbb-gpio-intc", .data = &gxbb_params },
 	{ .compatible = "amlogic,meson-gxl-gpio-intc", .data = &gxl_params },
 	{ .compatible = "amlogic,meson-axg-gpio-intc", .data = &axg_params },
+	{ .compatible = "amlogic,meson-g12a-gpio-intc", .data = &axg_params },
 	{ }
 };
 
-- 
2.20.1

