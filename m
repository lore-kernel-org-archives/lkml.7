Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7115C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AAA20665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998862;
	bh=M/sYwooRwtOaqGNwTwa7dsUtjz/pCGemMexCbnT8AKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2lrs8PbgvvnrJTnlDeZFZa1zkqsz13n8MGA1Y7kTepJOk/ecrswAgb/v/grhp8+gD
	 4Cj9MNc+hG43xUYQirO1hceUFnUh9ne9BozNwpZeBFSzvMcuDS2QQREHXGye8uT2jv
	 N5IgqPPJNOhDNmYOadyhXs+Z3z3Lrbz8rL0Qwvsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392389AbfGXUDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:03:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392301AbfGXUDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:03:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA7312147A;
        Wed, 24 Jul 2019 20:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998622;
        bh=M/sYwooRwtOaqGNwTwa7dsUtjz/pCGemMexCbnT8AKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FUR+rSbdnlQJkubY+HtcF251ygzDcoC0y/aEMt8TBooASF6N2lWMUnbUrs3LH90rt
         Qgy64kuKtVIOHFPU4LrDf7d7fW1459gtLV4ODS5TXxIogh9q4AWHjooyOY8l32yIc0
         G/5LK9Mv2s1GjbJ+w2yEYgbYZqYW8Vj4ZkP6qNcw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xingyu Chen <xingyu.chen@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 057/271] irqchip/meson-gpio: Add support for Meson-G12A SoC
Date:   Wed, 24 Jul 2019 21:18:46 +0200
Message-Id: <20190724191700.041133628@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



