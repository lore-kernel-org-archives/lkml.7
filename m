Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BB2C2D0DA
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC6652253D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577468477;
	bh=vyKkko4RjY1ywbE95vrfP1JTmbuE9LX0jGxvN//of38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZeT2wudGitYP2w/d+e9SFD+B8v1Sq3b1mE33hBopKsLvrXrTC5oHJTm77YzqSxiDM
	 mWcOvOoXvKqWwaWzAaos0NuL3YCvbzM3ck4tj1VGbdvX+1bpTYKM6L8Pc98mIkgHZy
	 jmlur1BCEWY5R0NqcW/s62payNSQ31SQodlLfHzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfL0RlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:41:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727274AbfL0RlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:41:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 306BD21582;
        Fri, 27 Dec 2019 17:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468470;
        bh=vyKkko4RjY1ywbE95vrfP1JTmbuE9LX0jGxvN//of38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OanEeDZ3n1wj6avgXkL6bl2GSBZxE5IghmNo+Tw1gmtCgxkUBm8Z0fdHe3az2CsBb
         QLd4G8xZw0J6m4QgcGfaY6N31zXiK7I8iq/tLpgbDj9FHW8BjYYmIAJSjfzVwMiEZz
         KtBZf8wC2elPn9PCYvoMFRJN2KqwR1By7RGAQxII=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 012/187] spi: fsl: Handle the single hardwired chipselect case
Date:   Fri, 27 Dec 2019 12:38:00 -0500
Message-Id: <20191227174055.4923-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174055.4923-1-sashal@kernel.org>
References: <20191227174055.4923-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 7251953d784baf7e5416afabe030a0e81de1a938 ]

The Freescale MPC8xxx had a special quirk for handling a
single hardwired chipselect, the case when we're using neither
GPIO nor native chip select: when inspecting the device tree
and finding zero "cs-gpios" on the device node the code would
assume we have a single hardwired chipselect that leaves the
device always selected.

This quirk is not handled by the new core code, so we need
to check the "cs-gpios" explicitly in the driver and set
pdata->max_chipselect = 1 which will later fall through to
the SPI master ->num_chipselect.

Make sure not to assign the chip select handler in this
case: there is no handling needed since the chip is always
selected, and this is what the old code did as well.

Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
Fixes: 0f0581b24bd0 ("spi: fsl: Convert to use CS GPIO descriptors")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Christophe Leroy <christophe.leroy@c-s.fr> (No tested the
Link: https://lore.kernel.org/r/20191128083718.39177-3-linus.walleij@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-fsl-spi.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 75b765f97df5..2155294eaaeb 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -729,8 +729,18 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
 			}
 		}
 #endif
-
-		pdata->cs_control = fsl_spi_cs_control;
+		/*
+		 * Handle the case where we have one hardwired (always selected)
+		 * device on the first "chipselect". Else we let the core code
+		 * handle any GPIOs or native chip selects and assign the
+		 * appropriate callback for dealing with the CS lines. This isn't
+		 * supported on the GRLIB variant.
+		 */
+		ret = gpiod_count(dev, "cs");
+		if (ret <= 0)
+			pdata->max_chipselect = 1;
+		else
+			pdata->cs_control = fsl_spi_cs_control;
 	}
 
 	ret = of_address_to_resource(np, 0, &mem);
-- 
2.20.1

