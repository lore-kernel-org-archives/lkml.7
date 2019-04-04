Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48135C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1866120820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369519;
	bh=LH9KQATYIcfvbALTVvNg2xwxOYgCX8D/+++btrLgnXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j5sdwehuIxyEdrAzex6sjnlMLjpmwG8ztdPWxApj8BBiKe+8ze7diFN2vdhd5d+V4
	 tV6Us+MWY0F8HBqCLJG8Wou468Or3CruvOVtNZ8exaJ5RaW0WzCHakrKzdCEDxCTwX
	 t6ea+VW7WBW169Y0NXzI6UEV2bOs5En2wc/RlLDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387753AbfDDJSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:18:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388394AbfDDJSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:18:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1EA42147C;
        Thu,  4 Apr 2019 09:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369513;
        bh=LH9KQATYIcfvbALTVvNg2xwxOYgCX8D/+++btrLgnXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FckXAn4DX3jDFLRXtR15EZh8afx+SY1zrYTYm9hkbAnZDJypKeJa9ILyb/ygeIZSn
         l/DkV1yXgzuLON7HKHe7GyumJrYuzhNYH9+oduq8Aqw4V3+r3xDI7sX7GqiiYPyTzV
         p+eRpMiklK0Wrq/MvjNgO8AFMmDJePex4DpADTwc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 244/246] gpio: of: Restrict enable-gpio quirk to regulator-gpio
Date:   Thu,  4 Apr 2019 10:49:04 +0200
Message-Id: <20190404084627.847159451@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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



