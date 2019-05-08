Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418DBC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1001F20850
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BjEeDxFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfEHQxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:53:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37822 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbfEHQxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:53:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6so10390863pgc.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 09:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vGDKTNjsKzMe4GW+UPOj5iNxo8t2mh5Da0jHvYPytGE=;
        b=BjEeDxFdWZy8nozBsaPtww861WrWrBCsZoAi/U5uipNG4Uo2q1GEvIRpqNcnicgJCx
         v5ym3NhEtlfi63pFiS7ztgrkJh1Qa5QhuPWm4FzhRjpGEDu3mHQ4+OWXDnWWcbi88234
         w0WY32M6Gpu7Ah33E64tivC1Vx3Wij1aJrpzksSD0/ZgoXEFbgZp4byZTv0FHfFsO03e
         QgVNZsTsJE5gP16LoNi3om57cDm75rYsh+AuZihwdnBAzNXk6wNYH6RhvIqP+2Y8+yR1
         KrkPx/iUJ5iU+JHpxyOzvxLhGDJ+ssnIWhMYKYug5lVqMW1UB/URj6O3ZtHCd6Fe6/Mg
         DLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vGDKTNjsKzMe4GW+UPOj5iNxo8t2mh5Da0jHvYPytGE=;
        b=e8nhW4jmsv6UodRvENzSfB01YlmHOptyfBZ9wlIacMSSTL26twZXUYVPHQ4ICF3RZ6
         VWFBaHLdPbiJs5bUAshtyRpA3yIkR+qZS3FmW258lAeS/wteIfbpAas6UeLlnWiaJB+O
         hhT4J3QGZKWI5AQApmfveP9dsPrqRGPxHO0F9FHneteJS2Ca54ixZ10w8/iB5K2EhoBa
         z7WelUssh4veYS8libbtTIH/suqYfD0bkZKMuDIGfs2mfvoPp+04ggisdbm+913pl4Tf
         jGZRWkWGmaVPhJAEBZpC6onjhLI6t3knPgZCUv071fwkrtbkuZ3ta+/6WRmZM0A4uqgN
         pKZA==
X-Gm-Message-State: APjAAAUDyIbaeeGd2iVqR5qWqqjzIaRj5aSsaV0CXZoDzHsVgYEO4Yl6
        fzyrSR2HBhF4mlWOWK4ch7w1
X-Google-Smtp-Source: APXvYqz1h2XDQ3Sr/TJEA2WqABKrgO6slzUVz4yKbbcqay+LZa8rOLv0DGozXoLFHY72vqchjup3JQ==
X-Received: by 2002:a63:5516:: with SMTP id j22mr45483383pgb.370.1557334423962;
        Wed, 08 May 2019 09:53:43 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6000:7ab1:cd79:1ccc:df38:79c0])
        by smtp.gmail.com with ESMTPSA id m2sm25180676pfi.24.2019.05.08.09.53.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 09:53:43 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 3/4] reset: Add reset controller support for BM1880 SoC
Date:   Wed,  8 May 2019 22:23:18 +0530
Message-Id: <20190508165319.19822-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508165319.19822-1-manivannan.sadhasivam@linaro.org>
References: <20190508165319.19822-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset controller support for Bitmain BM1880 SoC reusing the
reset-simple driver.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/Kconfig        | 3 ++-
 drivers/reset/reset-simple.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 2c8c23db92fb..b25e8d139f0d 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -117,7 +117,7 @@ config RESET_QCOM_PDC
 
 config RESET_SIMPLE
 	bool "Simple Reset Controller Driver" if COMPILE_TEST
-	default ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED
+	default ARCH_STM32 || ARCH_STRATIX10 || ARCH_SUNXI || ARCH_ZX || ARCH_ASPEED || ARCH_BITMAIN
 	help
 	  This enables a simple reset controller driver for reset lines that
 	  that can be asserted and deasserted by toggling bits in a contiguous,
@@ -129,6 +129,7 @@ config RESET_SIMPLE
 	   - RCC reset controller in STM32 MCUs
 	   - Allwinner SoCs
 	   - ZTE's zx2967 family
+	   - Bitmain BM1880 SoC
 
 config RESET_STM32MP157
 	bool "STM32MP157 Reset Driver" if COMPILE_TEST
diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index 77fbba3100c8..5e8c86470e6b 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -129,6 +129,8 @@ static const struct of_device_id reset_simple_dt_ids[] = {
 		.data = &reset_simple_active_low },
 	{ .compatible = "aspeed,ast2400-lpc-reset" },
 	{ .compatible = "aspeed,ast2500-lpc-reset" },
+	{ .compatible = "bitmain,bm1880-reset",
+		.data = &reset_simple_active_low },
 	{ /* sentinel */ },
 };
 
-- 
2.17.1

