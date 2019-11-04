Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4740FCA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB0C217F5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572905060;
	bh=gQfdSseJIHTjOoyUiK2pAFA1G+4rHT3VQvtfGLrK9No=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=My+FJXO5pApA2UDoz1HdTPXlC6J/+Rv/SVZT78l98weYVY3pBlrzn/OvAQZL37JfI
	 JFN8zirr2NODsbNyy1IPGLvwM67arBeJGZFaDnygooAm29r6pyJXa+Zp5a3TvT6ixA
	 NJPYr2gXyubGa9WFw5hq1E0EI73yhRTRWuBl8jlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387751AbfKDWET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:04:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:34922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388315AbfKDWER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:04:17 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E561205C9;
        Mon,  4 Nov 2019 22:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572905056;
        bh=gQfdSseJIHTjOoyUiK2pAFA1G+4rHT3VQvtfGLrK9No=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GZVP06ZiFQXRyOAiBlMbCaOuJbEyVR3CnX3i8nUFqNZs1kuG6HdzVE/9RMulmlKmA
         QutF3QUK9ntebgW3ezuSH891hGrAaAi3aDuPoTnpqyA+5SB3tQEj91DOg50yXzqVae
         ktPOSF7gkZOHsc/0qte2uszoblXRPV+N06k8j2YM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Elie Roudninski <xademax@gmail.com>,
        Remi Pommarel <repk@triplefau.lt>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 006/163] iio: adc: meson_saradc: Fix memory allocation order
Date:   Mon,  4 Nov 2019 22:43:16 +0100
Message-Id: <20191104212140.921155290@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212140.046021995@linuxfoundation.org>
References: <20191104212140.046021995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Remi Pommarel <repk@triplefau.lt>

[ Upstream commit de10ac47597e7a3596b27631d0d5ce5f48d2c099 ]

meson_saradc's irq handler uses priv->regmap so make sure that it is
allocated before the irq get enabled.

This also fixes crash when CONFIG_DEBUG_SHIRQ is enabled, as device
managed resources are freed in the inverted order they had been
allocated, priv->regmap was freed before the spurious fake irq that
CONFIG_DEBUG_SHIRQ adds called the handler.

Fixes: 3af109131b7eb8 ("iio: adc: meson-saradc: switch from polling to interrupt mode")
Reported-by: Elie Roudninski <xademax@gmail.com>
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Tested-by: Elie ROUDNINSKI <xademax@gmail.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/meson_saradc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 7b28d045d2719..7b27306330a35 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -1219,6 +1219,11 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	priv->regmap = devm_regmap_init_mmio(&pdev->dev, base,
+					     priv->param->regmap_config);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
 	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
 	if (!irq)
 		return -EINVAL;
@@ -1228,11 +1233,6 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	priv->regmap = devm_regmap_init_mmio(&pdev->dev, base,
-					     priv->param->regmap_config);
-	if (IS_ERR(priv->regmap))
-		return PTR_ERR(priv->regmap);
-
 	priv->clkin = devm_clk_get(&pdev->dev, "clkin");
 	if (IS_ERR(priv->clkin)) {
 		dev_err(&pdev->dev, "failed to get clkin\n");
-- 
2.20.1



