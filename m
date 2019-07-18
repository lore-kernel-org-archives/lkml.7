Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDB2C76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D045204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419145;
	bh=UPf/Bz62AZi/U6EjEo8n5k9TNyykIQyFJ1MCulxxGdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lWZimvVBNUj1GdxvVZd8pX08Zlbu33wPvyaKxL64Ye79R5lEyjaS0UT5QgEhDr/vt
	 57beth/O8XAiGGkyUpfJncm1lGwfGyOrWNK6Vjf1mBVLxUviwMrODTJ5sJ8Ac3xsUU
	 Dsbuu+6Cq9uB7EGLne+WtHeMYDeh8Kh2L1iw/tyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390048AbfGRDFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:05:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389995AbfGRDFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:05:39 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E22992173B;
        Thu, 18 Jul 2019 03:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419139;
        bh=UPf/Bz62AZi/U6EjEo8n5k9TNyykIQyFJ1MCulxxGdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yIpBVDSTKOgP9ZBDjxtq+IBQBFV973oX637qkKF1SHaJ9yN+9T3gZQSTYyZGrS763
         7tlEs37R0n9xkET3BMLz5zxDj1uW6wBLDIZPbiMjGkob28kY0bvHUvVJ3zwMCz707H
         TavmoQdcbRnkthELhum6lWgsISoRS2DDxu1cPHK0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 26/54] pinctrl: ocelot: fix gpio direction for pins after 31
Date:   Thu, 18 Jul 2019 12:01:21 +0900
Message-Id: <20190718030055.413873332@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030053.287374640@linuxfoundation.org>
References: <20190718030053.287374640@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f2818ba3a0125670cb9999bb5a65ebb631a8da2f ]

The third argument passed to REG is not the correct one and
ocelot_gpio_set_direction is not working for pins after 31. Fix that by
passing the pin number instead of the modulo 32 value.

Fixes: da801ab56ad8 pinctrl: ocelot: add MSCC Jaguar2 support
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-ocelot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 3b4ca52d2456..d2478db975bd 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -432,7 +432,7 @@ static int ocelot_gpio_set_direction(struct pinctrl_dev *pctldev,
 	struct ocelot_pinctrl *info = pinctrl_dev_get_drvdata(pctldev);
 	unsigned int p = pin % 32;
 
-	regmap_update_bits(info->map, REG(OCELOT_GPIO_OE, info, p), BIT(p),
+	regmap_update_bits(info->map, REG(OCELOT_GPIO_OE, info, pin), BIT(p),
 			   input ? 0 : BIT(p));
 
 	return 0;
-- 
2.20.1



