Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02409C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE5A21479
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 18:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p2Pip4Ll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfEJSqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 14:46:02 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35569 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbfEJSqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 14:46:02 -0400
Received: by mail-pl1-f196.google.com with SMTP id g5so3230903plt.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 11:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vGDKTNjsKzMe4GW+UPOj5iNxo8t2mh5Da0jHvYPytGE=;
        b=p2Pip4Ll9DSrmW0FfFYLYWffhVHDVwjr16LGT6u1ugr+3DzDArCr7Dx/6bhjjxfVoI
         KrK14jqo0hVo5aIzZ2qP+uyYKG3fOu9Gkx9eSnB8J4d8JOVzDlyHN5kz2Nt4EJIOUcY3
         BxRdAO2iUVAprShO5MqiPm/mr/tscFe5kJ24dQ7JwVRdgWz2QaJszP337BuCuV0d0pHq
         0zjeRkpt+VhW/IvdNuTDS1aKC3B/ymdq0wMEhTA7rsFpAJfOvPpm0qpHiH60+SPuUh+H
         4z9NqpXEtqC27/xBNeairhhcWaaMl7Ak5FUGU8VlgnskRY4sYBsFI4z23STp1ywRPAvT
         ItMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vGDKTNjsKzMe4GW+UPOj5iNxo8t2mh5Da0jHvYPytGE=;
        b=e27yYDcO8f4S1fVdRs1Xa3F3MJHO1TlWsXQ//nsOK68tW6uW26lc/lbAMOoQgyBXYa
         5diNlLrE3ZwuouAH2MKCgqY4noMLVFulif8Pas5pY5kolye9VqnXmMbNyQsjQPnGRuBg
         1fpwvZHL2sAsWpSapKvYYy3wD1eaGqTC6s8Q/Q2g95FtlLkvfxI482gn7mBqqSxcTRPj
         eRa7TvlQ/o0Q+/bF7lvJcXN+3Jngdtyg6GjuJzNxImxzkmiTdM/8c3Yr9g/GRGePtBwz
         asHLdbk7yTgX2rkeWzywcqq3ldnMwIQLfaRUrkkG0RX4nNb2Q1mxaMXrK59J/MUZW8Q+
         G+nw==
X-Gm-Message-State: APjAAAVfxjHdVjr9KSCKFf430gLSf0iiguf7hIRKs68DHXhKbgT2zTk4
        GF7Rwt+koCvtljH/OGYi8dSb
X-Google-Smtp-Source: APXvYqwwSkKeD5/Lj1MCuuCxCrpV789NiQqjWlUJyNqEn8UuMn8VzljR7w/AJImCku24GfkBT/7GUQ==
X-Received: by 2002:a17:902:7d83:: with SMTP id a3mr15613197plm.305.1557513961387;
        Fri, 10 May 2019 11:46:01 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:73c1:9991:95b6:5055:2390:bf9b])
        by smtp.gmail.com with ESMTPSA id g188sm8652049pfc.151.2019.05.10.11.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 11:46:00 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 3/4] reset: Add reset controller support for BM1880 SoC
Date:   Sat, 11 May 2019 00:15:24 +0530
Message-Id: <20190510184525.13568-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510184525.13568-1-manivannan.sadhasivam@linaro.org>
References: <20190510184525.13568-1-manivannan.sadhasivam@linaro.org>
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

