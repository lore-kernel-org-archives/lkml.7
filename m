Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47712C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01482206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713964;
	bh=dzPmHAisZQ9Aa/+kR3y+zmkkQOgFcm9IXQzOqOP/EWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W6A1kOs/YtqpEHTaPYsgMsutqOmsYZaMHqvJtd0g5v4kNKUiddPLzpzxBmFR+wuiJ
	 tINF3UxVZWtEWAFtUPPSJdng9toiOJVTI5v6qlkRY9H6Iqh0HMkOpQj73/O6+ht1Di
	 dXXeLkfPuKwhO2ojSXWK+MdzikKo5R5ZxTlC/JP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389381AbfC0TMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:12:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388793AbfC0SKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:10:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A76CE21738;
        Wed, 27 Mar 2019 18:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710221;
        bh=dzPmHAisZQ9Aa/+kR3y+zmkkQOgFcm9IXQzOqOP/EWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p0WpfBFAh8jEciq4uA08wRdkZb/HtkIvlBHMy65ETeiZmVYjVP6f003ig9G2o5LC+
         iv1HDR8g29wp8/kS6aaIwxmrkGWiVb7zroRuASqOkWHT78ztalJXAvcsvWF08ulIXe
         WE5oPamy2Byy3TjeY9ChDDdKoWlRSUcGLVuCmFf4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 260/262] gpio: of: Restrict enable-gpio quirk to regulator-gpio
Date:   Wed, 27 Mar 2019 14:01:55 -0400
Message-Id: <20190327180158.10245-260-sashal@kernel.org>
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

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit 692ef26e72fcce0c1e73c41683fd3512f3719d55 ]

Commit 0e7d6f940164 ("gpio: of: Apply regulator-gpio quirk only to
enable-gpios") breaks the device tree ABI specified in the device tree
bindings for fixed regulators (compatible "regulator-fixed"). According
to these bindings the polarity of the GPIO is exclusively controlled by
the presence or absence of the enable-active-high property. As such the
polarity quirk implemented in of_gpio_flags_quirks() must be applied to
the GPIO specified for fixed regulators.

However, commit 0e7d6f940164 ("gpio: of: Apply regulator-gpio quirk only
to enable-gpios") restricted the quirk to the enable-gpios property for
fixed regulators as well, whereas according to the commit message itself
it should only apply to "regulator-gpio" compatible device tree nodes.

Fix this by actually implementing what the offending commit intended,
which is to ensure that the quirk is applied to the GPIO specified by
the "enable-gpio" property for the "regulator-gpio" bindings only.

This fixes a regression on Jetson TX1 where the fixed regulator for the
HDMI +5V pin relies on the flags quirk for the proper polarity.

Fixes: 0e7d6f940164 ("gpio: of: Apply regulator-gpio quirk only to enable-gpios")
Signed-off-by: Thierry Reding <treding@nvidia.com>
Tested-by: Marek Vasut <marek.vasut@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib-of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 30542a10014f..a1dd2f1c0d02 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -84,10 +84,10 @@ static void of_gpio_flags_quirks(struct device_node *np,
 	 * Note that active low is the default.
 	 */
 	if (IS_ENABLED(CONFIG_REGULATOR) &&
-	    !strcmp(propname, "enable-gpio") &&
 	    (of_device_is_compatible(np, "regulator-fixed") ||
 	     of_device_is_compatible(np, "reg-fixed-voltage") ||
-	     of_device_is_compatible(np, "regulator-gpio"))) {
+	     (of_device_is_compatible(np, "regulator-gpio") &&
+	      strcmp(propname, "enable-gpio") == 0))) {
 		/*
 		 * The regulator GPIO handles are specified such that the
 		 * presence or absence of "enable-active-high" solely controls
-- 
2.19.1

