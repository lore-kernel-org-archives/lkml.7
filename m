Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367F4C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CF220700
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 10:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="RhwG9Dn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbfCaKHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 06:07:51 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:35699 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbfCaKHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 06:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1554026860;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=WxZnJkYr+RpcZujgOEbS+hE99NSDvAcFrNV8O6sUCf4=;
        b=RhwG9Dn7a7nnN6St8SjMRncOUFHGPuxFv2IS9nBJ45B6hudE62tZxz2ceHT/6shRT0
        g0/ODe2lXe8/wKhP2tkHAZKA6g/eO65lkena/IkSpgnWJqhR6y/1j81hfHsmYJKiEbnd
        xjshhA3+MCm1M9bDuRgr2BUNvWqArXBpTwhA3F82serOeHhFf2qEUdeVdJOlQFoAevEK
        qa7fYj4/mstXzYL7Sec2+CNPpcNak5iXUsheY4f9/ObRYeRaUFKhQRCV1Ed2zf0zN5mY
        2i+0itphEe0RfFO113T1OvoHiH9txxq1qc/7pJ07WNNWbLaXUz0pakwY5T7sBMgqQZEB
        F8Zw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2AyPQjXtNgX"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
        with ESMTPSA id K07648v2VA7PX1q
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 31 Mar 2019 12:07:25 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [BUG/PATCH 4/4] gpiolib: spi-cs-high is checking the wrong node (the controller and not the SPI slave device)
Date:   Sun, 31 Mar 2019 12:07:23 +0200
Message-Id: <d62f14663194f3a5fc967cd238e93846a563a4e2.1554026842.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1554026842.git.hns@goldelico.com>
References: <cover.1554026842.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings say:

All slave nodes can contain the following optional properties:
- spi-cs-high     - Empty property indicating device requires chip select
		    active high.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpio/gpiolib-of.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index a22d2233458b..82e7a1f63b0a 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -143,16 +143,16 @@ static void of_gpio_flags_quirks(struct device_node *np,
 				 * conflict and the "spi-cs-high" flag will
 				 * take precedence.
 				 */
-				if (of_property_read_bool(np, "spi-cs-high")) {
+				if (of_property_read_bool(child, "spi-cs-high")) {
 					if (*flags & OF_GPIO_ACTIVE_LOW) {
 						pr_warn("%s GPIO handle specifies active low - ignored\n",
-							of_node_full_name(np));
+							of_node_full_name(child));
 						*flags &= ~OF_GPIO_ACTIVE_LOW;
 					}
 				} else {
 					if (!(*flags & OF_GPIO_ACTIVE_LOW))
 						pr_info("%s enforce active low on chipselect handle\n",
-							of_node_full_name(np));
+							of_node_full_name(child));
 					*flags |= OF_GPIO_ACTIVE_LOW;
 				}
 				break;
-- 
2.19.1

