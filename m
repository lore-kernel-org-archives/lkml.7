Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94728C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6668E2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553709961;
	bh=YwqxMsNUsCI5zqPkmbPECmgbv7W5UwBh0BcdPZFv+S4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sqdPVRNxFUgEOmEA4sK7ySFunmy36kMTXx/qj9E/huxRojqlPg3Y4oiQXjNlahqvJ
	 bibkWe8u+NU2bCxBnfAmrL/+NFk2dYZqmtGLkdLTyj1UoHFYiVmVcg6cheeMlSim4i
	 I2X7hdRl67HAb+4X6H7MQ8MGlZWomM9DEX5S3Ui4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387834AbfC0SGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:06:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387801AbfC0SFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:05:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 120622075C;
        Wed, 27 Mar 2019 18:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709954;
        bh=YwqxMsNUsCI5zqPkmbPECmgbv7W5UwBh0BcdPZFv+S4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0R6NUSEHArzqM7A5iBadthDRTJWx2bIc523juxEf+IBjf5og0HZ82DlH+Y9dKBJIC
         fG6B8N76Qd6VndSqZz7GeAmDT/w67awCAAtXLQf9gcyGLhYfTVgN+SIP0HMgjVuzeo
         xVC7OMbTkG0LiNoz9hVQJAGZiudV+KGMsoXtu2JE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jan Kotas <jank@cadence.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 129/262] gpio: of: Apply regulator-gpio quirk only to enable-gpios
Date:   Wed, 27 Mar 2019 13:59:44 -0400
Message-Id: <20190327180158.10245-129-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

[ Upstream commit 0e7d6f94016407fd7e1ae472e254d64d4454e9c8 ]

Since commit d6cd33ad7102 ("regulator: gpio: Convert to use descriptors")
the GPIO regulator had inverted the polarity of the control GPIO. This
problem manifested itself on systems with DT containing the following
description (snippet from salvator-common.dtsi):

	gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
	gpios-states = <1>;
	states = <3300000 1
		  1800000 0>;

Prior to the aforementioned commit, the gpio-regulator code used
gpio_request_array() to claim the GPIO(s) specified in the "gpios"
DT node, while the commit changed that to devm_gpiod_get_index().

The legacy gpio_request_array() calls gpio_request_one() and then
gpiod_request(), which parses the DT flags of the "gpios" node and
populates the GPIO descriptor flags field accordingly.

The new devm_gpiod_get_index() calls gpiod_get_index(), then
of_find_gpio(), of_get_named_gpiod_flags() with flags != NULL,
and then of_gpio_flags_quirks(). Since commit a603a2b8d86e
("gpio: of: Add special quirk to parse regulator flags"),
of_gpio_flags_quirks() contains a quirk for regulator-gpio
which was never triggered by the legacy gpio_request_array()
code path, but is triggered by devm_gpiod_get_index() code
path.

This quirk checks whether a GPIO is associated with a fixed
or gpio-regulator and if so, checks two additional conditions.
First, whether such GPIO is active-low, and if so, ignores the
active-low flag. Second, whether the regulator DT node does
have an "enable-active-high" property and if the property is
NOT present, sets the GPIO flags as active-low.

The second check triggers a problem, since it is applied to all
GPIOs associated with a gpio-regulator, rather than only on the
"enable" GPIOs, as the old code did. This changes the way the
gpio-regulator interprets the DT description of the control
GPIOs.

The old code using gpio_request_array() explicitly parsed the
"enable-active-high" DT property and only applied it to the
GPIOs described in the "enable-gpios" DT node, and only if
those were present.

This patch fixes the quirk code by only applying the quirk
to "enable-gpios", thus restoring the old behavior.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jan Kotas <jank@cadence.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org
To: linux-gpio@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib-of.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index a6e1891217e2..30542a10014f 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -84,6 +84,7 @@ static void of_gpio_flags_quirks(struct device_node *np,
 	 * Note that active low is the default.
 	 */
 	if (IS_ENABLED(CONFIG_REGULATOR) &&
+	    !strcmp(propname, "enable-gpio") &&
 	    (of_device_is_compatible(np, "regulator-fixed") ||
 	     of_device_is_compatible(np, "reg-fixed-voltage") ||
 	     of_device_is_compatible(np, "regulator-gpio"))) {
-- 
2.19.1

