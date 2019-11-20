Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853A4C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1652251D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="idf7kk/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbfKTNSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:18:16 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:32916 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730053AbfKTNSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:18:12 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAKDI4AL033449;
        Wed, 20 Nov 2019 07:18:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574255884;
        bh=D7ZpGl2GOQVl1LRPY+tj5e7FhNzsNfXiSHrb52YKorU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=idf7kk/SKW+n+VPi6VHNfUmXqbu9DunvBJm74dYACuYsioLK7uY7gjc0QrJTTvGQV
         6awdD6aj6/IarAZvQTEXJmushWd5CIxh7TH5nklx43Q20QnZcvwMVUXCVAFpTmwSar
         mqhEZNWAqWqKLE8iYTa/VvjaUBhlx3LIhpN7NTkU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAKDI4OI092105
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Nov 2019 07:18:04 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 20
 Nov 2019 07:18:02 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 20 Nov 2019 07:18:02 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAKDHru7067880;
        Wed, 20 Nov 2019 07:17:59 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <kuninori.morimoto.gx@renesas.com>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ASoC: pcm3168a: Update the RST gpio handling to align with documentation
Date:   Wed, 20 Nov 2019 15:17:53 +0200
Message-ID: <20191120131753.6831-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120131753.6831-1-peter.ujfalusi@ti.com>
References: <20191120131753.6831-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RST (reset-gpios) is low active so the driver must handle it
accordingly.

Add comments to explain clearly how the line is used.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/pcm3168a.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index f3475134b519..9711fab296eb 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -707,11 +707,15 @@ int pcm3168a_probe(struct device *dev, struct regmap *regmap)
 	dev_set_drvdata(dev, pcm3168a);
 
 	/*
-	 * Request the RST gpio line as non exclusive as the same reset line
-	 * might be connected to multiple pcm3168a codec
+	 * Request the reset (connected to RST pin) gpio line as non exclusive
+	 * as the same reset line might be connected to multiple pcm3168a codec
+	 *
+	 * The RST is low active, we want the GPIO line to be high initially, so
+	 * request the initial level to LOW which in practice means DEASSERTED:
+	 * The deasserted level of GPIO_ACTIVE_LOW is HIGH.
 	 */
-	pcm3168a->gpio_rst = devm_gpiod_get_optional(dev, "rst",
-						GPIOD_OUT_HIGH |
+	pcm3168a->gpio_rst = devm_gpiod_get_optional(dev, "reset",
+						GPIOD_OUT_LOW |
 						GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	if (IS_ERR(pcm3168a->gpio_rst)) {
 		ret = PTR_ERR(pcm3168a->gpio_rst);
@@ -814,7 +818,13 @@ void pcm3168a_remove(struct device *dev)
 {
 	struct pcm3168a_priv *pcm3168a = dev_get_drvdata(dev);
 
-	gpiod_set_value_cansleep(pcm3168a->gpio_rst, 0);
+	/*
+	 * The RST is low active, we want the GPIO line to be low when the
+	 * driver is removed, so set level to 1 which in practice means
+	 * ASSERTED:
+	 * The asserted level of GPIO_ACTIVE_LOW is LOW.
+	 */
+	gpiod_set_value_cansleep(pcm3168a->gpio_rst, 1);
 	pm_runtime_disable(dev);
 #ifndef CONFIG_PM
 	pcm3168a_disable(dev);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

