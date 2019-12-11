Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D5CC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2763B22527
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576078766;
	bh=J/qoveuYteBmsPJjOkskLUfNQQIkAnrf3tL2OcDzgJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QUVt202OAXgUyrc7AIXj6m0OxGW+zf1bn1nwZtVVAK9cOJvLfo0uoWMoMt2VJPeIV
	 NUIAbSFqAo9JM6dmhbw0m17VK/1PxPp1wtZbViVF2M2nAN07p6oVSAFDTy79Nn6eW2
	 t2hNl9wdBVqFs2tEMYICTYChxoSaybZ4OPGHBZfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388572AbfLKPjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:39:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:49440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388467AbfLKPir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:38:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72C3C21556;
        Wed, 11 Dec 2019 15:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576078726;
        bh=J/qoveuYteBmsPJjOkskLUfNQQIkAnrf3tL2OcDzgJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rhliA7fcQ8CDMRIMigowKZlZ335RKJcw4EXugKsyLV36H4E4SF1loLLJiw4OE09pt
         uSjMBkF0MbMbWcTnO7bA17M0XEPyo+GG4EHLOzqcbJ27QBqhGPHsY17Y8vQ+iRO7U3
         vacONmGsiGvZSp84PGeweu1Aaf6O7F/KhpiV5Ir0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 30/37] gpio: mpc8xxx: Don't overwrite default irq_set_type callback
Date:   Wed, 11 Dec 2019 10:38:06 -0500
Message-Id: <20191211153813.24126-30-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211153813.24126-1-sashal@kernel.org>
References: <20191211153813.24126-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 4e50573f39229d5e9c985fa3b4923a8b29619ade ]

The per-SoC devtype structures can contain their own callbacks that
overwrite mpc8xxx_gpio_devtype_default.

The clear intention is that mpc8xxx_irq_set_type is used in case the SoC
does not specify a more specific callback. But what happens is that if
the SoC doesn't specify one, its .irq_set_type is de-facto NULL, and
this overwrites mpc8xxx_irq_set_type to a no-op. This means that the
following SoCs are affected:

- fsl,mpc8572-gpio
- fsl,ls1028a-gpio
- fsl,ls1088a-gpio

On these boards, the irq_set_type does exactly nothing, and the GPIO
controller keeps its GPICR register in the hardware-default state. On
the LS1028A, that is ACTIVE_BOTH, which means 2 interrupts are raised
even if the IRQ client requests LEVEL_HIGH. Another implication is that
the IRQs are not checked (e.g. level-triggered interrupts are not
rejected, although they are not supported).

Fixes: 82e39b0d8566 ("gpio: mpc8xxx: handle differences between incarnations at a single place")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://lore.kernel.org/r/20191115125551.31061-1-olteanv@gmail.com
Tested-by: Michael Walle <michael@walle.cc>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-mpc8xxx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
index 9e02cb6afb0bb..ce6e15167d0b2 100644
--- a/drivers/gpio/gpio-mpc8xxx.c
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -409,7 +409,8 @@ static int mpc8xxx_probe(struct platform_device *pdev)
 	 * It's assumed that only a single type of gpio controller is available
 	 * on the current machine, so overwriting global data is fine.
 	 */
-	mpc8xxx_irq_chip.irq_set_type = devtype->irq_set_type;
+	if (devtype->irq_set_type)
+		mpc8xxx_irq_chip.irq_set_type = devtype->irq_set_type;
 
 	gc->direction_output = devtype->gpio_dir_out ?: mpc8xxx_gpio_dir_out;
 	gc->get = devtype->gpio_get ?: mpc8xxx_gpio_get;
-- 
2.20.1

