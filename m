Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BA8C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 10:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E61920836
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 10:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p8xmjYz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfLIKjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 05:39:47 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:44402 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbfLIKjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 05:39:46 -0500
Received: by mail-pj1-f67.google.com with SMTP id w5so5703668pjh.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 02:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oyUzXNyM2BZIrQqZ39LMNSyb/18SG6bETdmW07jNwB0=;
        b=p8xmjYz9+/qRuCsE2jubkJmIPXSVJTGeWa2NDwHus4k3f4ZldG0Vq0bFf1V5PrEyQG
         HQuoDymz3mp1fi2KLYSLeyj1z2kzVrpZdinWS3sn1KHTC5K23ZvffubzQm8WhXFhpPjA
         0SX7btl097FKvA8yiJN2/cXomEy6+VsitZs06QW2fnH4oKVG3GIkh7BhGCbFxJmAJ1UX
         rvO3nUNHe3eFbT+LXEiPqaYjwshMKmp1z8aht+mk3KgPqf+kNl292mnWJO+C48uDWrb6
         Fwshtu1BLrtrgAO2au90EzaQq9pF2f0v4pwywV2A43/30g/rdd9xUbXV94bXtWnK+5R/
         lrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oyUzXNyM2BZIrQqZ39LMNSyb/18SG6bETdmW07jNwB0=;
        b=V51SJyZP2S56nMhllZLB2RiTlbG9/hogv/zFhk7LUlCcEanRfcP5cG9FzIy2OQI16K
         jBO+2xpvuMUqez+SXqp7uzsxLvZH5yYM+CQ2u+DjDliy9xCbwnT5ltfjiMYa0yq/sY3r
         dA+W3bL3Umw3/q8zMDvJkShizMM7barviphYkxM9lEKc32gBgviEPk3OmMWe0dCZ5hOO
         aJp1d4MSpVfYStLwBtD43pwnhCT3C5rW5fZPDiWqYhF55g7QNtq3XjLHxwqxz1a4OKaz
         2IFUx7eAljT3zScvXchc9El4jQVz7QIBc2krNJrnV26CrISQ6CNBRDFNGtNmdpBFMGwl
         KyRw==
X-Gm-Message-State: APjAAAXT4YnUrtp/PVf/l2Jz1IlFmabBKEIVww0g2o/bf/2PjrV5o+Mh
        G4WtgvO0BXg/2MsuDfDwQOkY4sQVbyX9iA==
X-Google-Smtp-Source: APXvYqwm9MjGf+d0an+Y6Ppay6GY4qS0VROa0W1ir2hQ/FwCcOqlJPjbgFAmJ5pGaNozW081Ihe10g==
X-Received: by 2002:a17:902:9306:: with SMTP id bc6mr29331075plb.132.1575887985839;
        Mon, 09 Dec 2019 02:39:45 -0800 (PST)
Received: from localhost ([14.96.126.41])
        by smtp.gmail.com with ESMTPSA id o184sm8065929pgo.62.2019.12.09.02.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Dec 2019 02:39:45 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, agross@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: defconfig: Enable QCOM PMIC thermal
Date:   Mon,  9 Dec 2019 16:09:42 +0530
Message-Id: <5f193f2a7508d82037e8f04e73150feee1a2583e.1575887866.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCOM_SPMI_ADC5 and SPMI_TEMP_ALARM expose thermistors on the PMIC of
several QCOM platforms through the thermal framework. Enable them.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6a83ba2aea3e..9893795238e0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -447,6 +447,7 @@ CONFIG_BRCMSTB_THERMAL=m
 CONFIG_EXYNOS_THERMAL=y
 CONFIG_TEGRA_BPMP_THERMAL=m
 CONFIG_QCOM_TSENS=y
+CONFIG_QCOM_SPMI_TEMP_ALARM=m
 CONFIG_UNIPHIER_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_ARM_SP805_WATCHDOG=y
@@ -759,6 +760,7 @@ CONFIG_EXTCON_USBC_CROS_EC=y
 CONFIG_MEMORY=y
 CONFIG_IIO=y
 CONFIG_EXYNOS_ADC=y
+CONFIG_QCOM_SPMI_ADC5=m
 CONFIG_ROCKCHIP_SARADC=m
 CONFIG_IIO_CROS_EC_SENSORS_CORE=m
 CONFIG_IIO_CROS_EC_SENSORS=m
-- 
2.17.1

