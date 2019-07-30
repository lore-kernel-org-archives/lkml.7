Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C71C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E77216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b3mg+KDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfG3SQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:16:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33196 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbfG3SQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so30264694pfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=50VWY4DOvJCsLbogXvcfIy87Phisvb7R/qkulHRQtQE=;
        b=b3mg+KDmpIO81yQrcZUSpzOusHXsPRu2YTZBtorn1AEo3N6GiptcooL6U8tMTo+gTG
         lIYB8l6l6OrtiBRTPCwwVeU7F0QlclDCDwnUbiuFLyyK+81JVEa7Lq5TKHvVQ610YkBF
         neATcqsL6f5giH+IoqxpKjFEtws9P29MaAOJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=50VWY4DOvJCsLbogXvcfIy87Phisvb7R/qkulHRQtQE=;
        b=Ne0omnCWVcG5E5rvd4rFGCEuKIdfR7k3WnjTXMTQoWbUDmXUJvG3L8xnufOoKlyEDI
         iYtz5UaynnUHWNhbIT8zQ3Q1AQdfDBG/dofIcoxsKKj2rx6bJJiZlRI1SZtcjitz6CJm
         w1nRVpRIfBq2LJmrVvht4OyUGiPIwLt1CGsFbrLlalJFFsXmI+y4fXSMih7j66nuL8To
         DhHj/b7zMIJIz2o5452Q0aaCxehce+lsNrFIATSHQuHPvTO4Di1MWqmAmzO2Py6D2647
         l+8hJPfv/bVXnZZ4AbCM0A1xbuPwoZbUKKbxVMJnMSV4/7iaYyZKlkQZidgWOIV5WPnO
         cUUg==
X-Gm-Message-State: APjAAAV2NRxXpZWsSl0XglqPoDK9H4K42g0+tg5LL7LCS9dOPZD2C7Ik
        IVG6Q+XNJKecUv3A53GlJAmCxnFRzzM=
X-Google-Smtp-Source: APXvYqwur07swqKyif5Dp1u0EIDJAkQU8t63hD8i7gGz9LNFXf5yqejN6CfyDWSarneFR2nt+qIVAA==
X-Received: by 2002:a65:64c6:: with SMTP id t6mr112287304pgv.323.1564510565436;
        Tue, 30 Jul 2019 11:16:05 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:05 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 07/57] ARM: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:07 -0700
Message-Id: <20190730181557.90391-8-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Russell King <linux@armlinux.org.uk>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 arch/arm/plat-omap/dma.c    | 1 -
 arch/arm/plat-pxa/ssp.c     | 5 ++---
 arch/arm/plat-samsung/adc.c | 4 +---
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 79f43acf9acb..9386b2e9b332 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1371,7 +1371,6 @@ static int omap_system_dma_probe(struct platform_device *pdev)
 		strcpy(irq_name, "0");
 		dma_irq = platform_get_irq_byname(pdev, irq_name);
 		if (dma_irq < 0) {
-			dev_err(&pdev->dev, "failed: request IRQ %d", dma_irq);
 			ret = dma_irq;
 			goto exit_dma_lch_fail;
 		}
diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index 9a6e4923bd69..88b5dd99f6bc 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -146,10 +146,9 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 	}
 
 	ssp->irq = platform_get_irq(pdev, 0);
-	if (ssp->irq < 0) {
-		dev_err(dev, "no IRQ resource defined\n");
+	if (ssp->irq < 0)
 		return -ENODEV;
-	}
+
 
 	if (dev->of_node) {
 		const struct of_device_id *id =
diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index ee3d5c989a76..4bbeca3cbd9e 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -354,10 +354,8 @@ static int s3c_adc_probe(struct platform_device *pdev)
 	}
 
 	adc->irq = platform_get_irq(pdev, 1);
-	if (adc->irq <= 0) {
-		dev_err(dev, "failed to get adc irq\n");
+	if (adc->irq <= 0)
 		return -ENOENT;
-	}
 
 	ret = devm_request_irq(dev, adc->irq, s3c_adc_irq, 0, dev_name(dev),
 				adc);
-- 
Sent by a computer through tubes

