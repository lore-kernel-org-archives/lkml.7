Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A4BC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0232082E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wujk7OwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfDMKdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 06:33:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38290 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfDMKdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 06:33:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so15157011wro.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 03:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EKaLt/Qv/GqeOI+yNvdF40+sak5nKPqOm7/EXV35iPQ=;
        b=wujk7OwOlABgjEbJys1TyrfzFvnoXD6eYo1OOd1R2KjIF6PJnLFIBh3W5wkOH+Kr9H
         XklKlkWlj25OVMlfzr8FNutdCIUsc70ntt3Kb5LwkypSnaYEL9dJRkQt9odNOfuka11I
         F8kRb8YiFetl5jlCDPh+hzu27FWqNaRxzKWTV+PpKDkCxyUk/cbJ7pxOtqCT/YoWp4KN
         9acUu1ArgvUn7IlIXimkhPNMre/Q6OcdMktzc0psZgdlaOmyRaJfnhHV5l+6SD9Rq7Um
         j3UhzrwkoG8aLS4TAFAWIPGgmNNyJAujWHuNzGD9Xz2J4VUBgPWUvaUi9lGkd8FhoYk2
         2DRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EKaLt/Qv/GqeOI+yNvdF40+sak5nKPqOm7/EXV35iPQ=;
        b=GRqKVSa89ndeTgZ15+qCyocQgtno8WoJzCDZF9iG3ZQ2JSLyxm/Ieq6A7cNtoh60qe
         gHwxBZ2hKCo9Q5ScN/D0T69scOxq421P/jTgfOshVAzloVg0Llrk5cpbDBdKCyrdig6l
         iKpx/CHKcK4kTff3zSqLHYwCXZ9gs2ku4HvaRURNZzvPQrmL7oVkLRfjcuXxeAginkiA
         wKAMq5jTSHH2QUlhapX/VzR9IY1VVtPk5a3OHO06nqGwSXBEoF6gG/aOx9CY7O7ynukh
         Hu3bVZWcU4QTyRGyJ8DfQ1zcLMUFuMcSE7oCtMgpqvvALHoGvp8b7jmpcTw8PvKg2CSw
         /STQ==
X-Gm-Message-State: APjAAAXFmx0EW6YDvHnMXxOMCCXKjzXbFjjiGjABnE/ViWuRXOjiWqqL
        Oxyf2Z+u+wIn1uq6Te2uxsaEiw==
X-Google-Smtp-Source: APXvYqwPXlSBhTRG7qj1BLXO7/LXk6MZDMlGs0ilQHBhGRVcwADXuKIroBYhr+ZypC7Y9t3B3UoTRg==
X-Received: by 2002:adf:97c5:: with SMTP id t5mr22831092wrb.252.1555151603599;
        Sat, 13 Apr 2019 03:33:23 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id u17sm19547303wmu.36.2019.04.13.03.33.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Apr 2019 03:33:22 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: [RESEND PATCH 16/20] nvmem: imx-iim: use devm_platform_ioremap_resource() to simplify code
Date:   Sat, 13 Apr 2019 11:33:01 +0100
Message-Id: <20190413103305.9576-17-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
References: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <anson.huang@nxp.com>

Use the new helper devm_platform_ioremap_resource() which wraps the
platform_get_resource() and devm_ioremap_resource() together, to
simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-iim.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvmem/imx-iim.c b/drivers/nvmem/imx-iim.c
index 6651e4cdc002..34582293b985 100644
--- a/drivers/nvmem/imx-iim.c
+++ b/drivers/nvmem/imx-iim.c
@@ -104,7 +104,6 @@ static int imx_iim_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	struct iim_priv *iim;
 	struct nvmem_device *nvmem;
 	struct nvmem_config cfg = {};
@@ -114,8 +113,7 @@ static int imx_iim_probe(struct platform_device *pdev)
 	if (!iim)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	iim->base = devm_ioremap_resource(dev, res);
+	iim->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(iim->base))
 		return PTR_ERR(iim->base);
 
-- 
2.21.0

