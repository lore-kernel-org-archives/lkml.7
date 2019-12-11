Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5FEC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502B52173E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576078276;
	bh=wpVZEkabTJ7pmhyTr+HxL/7uQO+PlD2xUkrU60uAKLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VQFejPs7j5LPipZ7XvEBQ1jSgg4tgO9z6HnGsKpYy2Vg7DCrHJ2EMFhqgJAG2p2um
	 Llk0ofiv2C7KPGBCY2ZaLWZLkw/DEgRw5xThUTEGlDbT9ZTYQA3UKp+f4tHvI7DMrC
	 Q+FfgF060jAyialg6k+p80ikLfK0HrBFnQ3cluxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388014AbfLKPbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:31:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:36100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732518AbfLKP3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:29:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31B582465B;
        Wed, 11 Dec 2019 15:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576078160;
        bh=wpVZEkabTJ7pmhyTr+HxL/7uQO+PlD2xUkrU60uAKLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BJVFh/cEVYoKieVh4VbMdIio/fXW5y2MMwAz5D2Rojo1pOMk7L7Yagl3ZGqKZBunk
         BhLK8S1cAxk8PSKm8fRXi2UrNWuOx9D8ZdI7vQ5hWRK86qX2Qz9m/UnxLXScD2hccs
         iMjP1FZwQ738DLrsmLwgcA3jz83nYMUi7PLvTbAo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 45/58] gpio: mpc8xxx: Don't overwrite default irq_set_type callback
Date:   Wed, 11 Dec 2019 10:28:18 -0500
Message-Id: <20191211152831.23507-45-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211152831.23507-1-sashal@kernel.org>
References: <20191211152831.23507-1-sashal@kernel.org>
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
index 8c93dec498fa4..e7783b852d697 100644
--- a/drivers/gpio/gpio-mpc8xxx.c
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -337,7 +337,8 @@ static int mpc8xxx_probe(struct platform_device *pdev)
 	 * It's assumed that only a single type of gpio controller is available
 	 * on the current machine, so overwriting global data is fine.
 	 */
-	mpc8xxx_irq_chip.irq_set_type = devtype->irq_set_type;
+	if (devtype->irq_set_type)
+		mpc8xxx_irq_chip.irq_set_type = devtype->irq_set_type;
 
 	if (devtype->gpio_dir_out)
 		gc->direction_output = devtype->gpio_dir_out;
-- 
2.20.1

