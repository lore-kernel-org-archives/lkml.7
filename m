Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BE8C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8052089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IqRwxNai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbfG3SUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:20:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35376 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfG3SQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id s1so24174420pgr.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uWcMorJDwKvnrZ+uFe5615N3dWxPyAPY0OX9n+4Id+U=;
        b=IqRwxNaiIXDJJtbYw7DiEMUc+d5JpdIqrrNmI5fHyEZMcEfNGlbeZP0qj071ZF9ERk
         NhQgILZE6EIxY5vdmrPVbatPz/ofis+5bIxBmNcTrPnJ70H18iPErl5x0M3NeO7mT/r8
         ZSdnz3azkXYLfEizn/S5D8obQtm5avg4Cbt5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uWcMorJDwKvnrZ+uFe5615N3dWxPyAPY0OX9n+4Id+U=;
        b=tV/Qi6LLPm21laoZWjs2qQDhxhSGG8Ko7gLFu4+U4xjiy4dfSiB21KyWGVtjLmyf1Z
         biqa4OY5EXaKYcSuejrIqeSatMD0NRCiUPhw+XxZFPQzD2zE8Kd9o4Q9E8IeUhvjG41Q
         sNQ9Ru44o71aKY8FEMNrKTDMXrxSMJSbxCoz2lYOfpxBkwUQI+FhdQPhGiy5zGxYkxOo
         P2z+ya1ZE1CpjJ86LA9cTunAKUDhEFLkJeZ5V/ZXhhyyybnX9Sq5FXfdOi4ol6c3sthU
         rs1G62Vrho5CeRVXzTGafUq2qaszxxztyHV4MDvTPRyLQRGGqtFaZPxUMc55BkYJPcqO
         XXvA==
X-Gm-Message-State: APjAAAU2T6Mdqp/27Y2H2GNUtcbxtq/nn/M8EEot2cUBaTKijzCKBfft
        HJCn9Ed5SzPUWjhTGEd4ORGifY4Thd4=
X-Google-Smtp-Source: APXvYqy3Laes9SZ2LYMflp8n6VEUsNJXR98M73zWazTRqJV7pActIO5nc49uiCDhB1obHw4BF99Xww==
X-Received: by 2002:a62:303:: with SMTP id 3mr42925303pfd.118.1564510561568;
        Tue, 30 Jul 2019 11:16:01 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:00 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH v6 03/57] hwrng: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:03 -0700
Message-Id: <20190730181557.90391-4-swboyd@chromium.org>
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

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matt Mackall <mpm@selenic.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/char/hw_random/imx-rngc.c  | 4 +---
 drivers/char/hw_random/omap-rng.c  | 5 +----
 drivers/char/hw_random/xgene-rng.c | 4 +---
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index 69f537980004..d996875862cc 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -216,10 +216,8 @@ static int imx_rngc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(&pdev->dev, "Couldn't get irq %d\n", irq);
+	if (irq <= 0)
 		return irq;
-	}
 
 	ret = clk_prepare_enable(rngc->clk);
 	if (ret)
diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/omap-rng.c
index e9b6ac61fb7f..82261f1c4d63 100644
--- a/drivers/char/hw_random/omap-rng.c
+++ b/drivers/char/hw_random/omap-rng.c
@@ -385,11 +385,8 @@ static int of_get_omap_rng_device_details(struct omap_rng_dev *priv,
 	if (of_device_is_compatible(dev->of_node, "ti,omap4-rng") ||
 	    of_device_is_compatible(dev->of_node, "inside-secure,safexcel-eip76")) {
 		irq = platform_get_irq(pdev, 0);
-		if (irq < 0) {
-			dev_err(dev, "%s: error getting IRQ resource - %d\n",
-				__func__, irq);
+		if (irq < 0)
 			return irq;
-		}
 
 		err = devm_request_irq(dev, irq, omap4_rng_irq,
 				       IRQF_TRIGGER_NONE, dev_name(dev), priv);
diff --git a/drivers/char/hw_random/xgene-rng.c b/drivers/char/hw_random/xgene-rng.c
index 8c6f9f63da5e..b1439a3aaa1d 100644
--- a/drivers/char/hw_random/xgene-rng.c
+++ b/drivers/char/hw_random/xgene-rng.c
@@ -330,10 +330,8 @@ static int xgene_rng_probe(struct platform_device *pdev)
 		return PTR_ERR(ctx->csr_base);
 
 	rc = platform_get_irq(pdev, 0);
-	if (rc < 0) {
-		dev_err(&pdev->dev, "No IRQ resource\n");
+	if (rc < 0)
 		return rc;
-	}
 	ctx->irq = rc;
 
 	dev_dbg(&pdev->dev, "APM X-Gene RNG BASE %p ALARM IRQ %d",
-- 
Sent by a computer through tubes

