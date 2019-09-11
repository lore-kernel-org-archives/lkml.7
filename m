Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119A6C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 22:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0C820CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 22:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MKCb5mvq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfIKWTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 18:19:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38767 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729094AbfIKWTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 18:19:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id h195so14591820pfe.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 15:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=6COMbNYiBAH3DK2IekDUzK6LyWxPCeshYdSnc/L9JbE=;
        b=MKCb5mvqx7vPVDdvPX6sQfysgXJv0ZZJl6EQ2OfyWJs4KKhQeIz+B5sY8CGkAWe3mr
         WLLmqjsA62JkEmSYcKh9IBNCO5nQso0zq79qJrBlQAJmaW0S5IAnKvrcnzq40sGoS9fj
         Thwp/O6v/DqgKe76f6Z/ADzXrx88+AIR8oKZ3M8cWyMWwh6Q2LF85onrjItleYz8UGWh
         h4lTXaIxEHBMSA9jLY5z/8YCeJ409s0es7VB4Usz3wWUBWqFHOR069KpMZN42JNP1vuj
         C09KT4kazMZogjTUByrzFV8gjkhdl2Cy95jtqmoC4mm48r0qtR/TblXm8+DreAIqVFUq
         4nFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=6COMbNYiBAH3DK2IekDUzK6LyWxPCeshYdSnc/L9JbE=;
        b=orvOuP8/anHCaubEhLlC1v8gJaxYgE+3qVsI/WYuG6Cw3gLSirVAzdDdCc+qOwcX6g
         wFaufYdxN9eRND41/1xO9soWdKWL1XDyFaa/ZjM13DlqH1r5g7Um9PiOnkbqy2xUN82Y
         drUx8qAsPeWtB3EgRmDr00tCqRGHk3hCQPI2AHcBlfEBXRlHnr13SGCcjdGYGjWFCfR2
         TDjIS0/K4VpBp6bGsxUH9wnNwYfpt9mJc+PiBpGm7yJyD5AqMxceCizmGr6a66ocrOt2
         xghzP4yIA+w24bfV4nKB+W+O+2h/zi2zonAsgqVkP3gX7+06EKMj+wUNFThaRDSwen4a
         tNzA==
X-Gm-Message-State: APjAAAUAU49rieLtBcrGb9EPSgV1BWodTSZgTIKMrOh82CXK70G/6bkK
        50YKFC4zI8+I4fZTr2DCWIYLwXO+s+goTg==
X-Google-Smtp-Source: APXvYqz+YhEdUNHVYAJHHVB+HxkousclqJcLJHmh0ogARlkU8Fktq7uSORReGl5PSbO3udOKXbq3uQ==
X-Received: by 2002:a65:6102:: with SMTP id z2mr34643771pgu.391.1568240341618;
        Wed, 11 Sep 2019 15:19:01 -0700 (PDT)
Received: from localhost ([49.248.179.160])
        by smtp.gmail.com with ESMTPSA id i194sm4085709pgc.0.2019.09.11.15.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 15:19:01 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arm@kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH 2/4] arm64: Kconfig: Fix BRCMSTB driver dependencies
Date:   Thu, 12 Sep 2019 03:48:46 +0530
Message-Id: <21b9dd0bf0bbc80b69bc81a7efb88243e4981c56.1568239378.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1568239378.git.amit.kucheria@linaro.org>
References: <cover.1568239378.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1568239378.git.amit.kucheria@linaro.org>
References: <cover.1568239378.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Push various BRCMSTB drivers behind ARCH_BRCMSTB dependency so that it
doesn't get enabled by default on other platforms.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/bus/Kconfig         | 1 +
 drivers/power/reset/Kconfig | 1 +
 drivers/soc/bcm/Kconfig     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 1851112ccc29..d80e8d70bf10 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -22,6 +22,7 @@ config ARM_CCI400_PORT_CTRL
 
 config BRCMSTB_GISB_ARB
 	bool "Broadcom STB GISB bus arbiter"
+	depends on ARCH_BRCMSTB
 	depends on ARM || ARM64 || MIPS
 	default ARCH_BRCMSTB || BMIPS_GENERIC
 	help
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 651b763f80cd..6f0b1ed1a05a 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -59,6 +59,7 @@ config POWER_RESET_BRCMKONA
 
 config POWER_RESET_BRCMSTB
 	bool "Broadcom STB reset driver"
+	depends on ARCH_BRCMSTB
 	depends on ARM || ARM64 || MIPS || COMPILE_TEST
 	depends on MFD_SYSCON
 	default ARCH_BRCMSTB || BMIPS_GENERIC
diff --git a/drivers/soc/bcm/Kconfig b/drivers/soc/bcm/Kconfig
index 648e32693b7e..5a8ff33241ae 100644
--- a/drivers/soc/bcm/Kconfig
+++ b/drivers/soc/bcm/Kconfig
@@ -24,6 +24,7 @@ config RASPBERRYPI_POWER
 
 config SOC_BRCMSTB
 	bool "Broadcom STB SoC drivers"
+	depends on ARCH_BRCMSTB
 	depends on ARM || ARM64 || BMIPS_GENERIC || COMPILE_TEST
 	select SOC_BUS
 	help
-- 
2.17.1

