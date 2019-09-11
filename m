Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144B4C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 22:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2F920CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 22:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a8PMTBBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbfIKWTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 18:19:12 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45830 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbfIKWTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 18:19:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id x3so10772253plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 15:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=mMNl63FO67KUuEHw42vIWKlthSpMwd5FVOOXIHmqrU4=;
        b=a8PMTBBTeeZyu/Wvz6ibbwLc/1cJ7vElKoSkSXAji0+1n+9jR/t/r7x/pf8m+oNx7I
         7DSzXISCFD+sD00yT2TicutThMC9mFxdIcPpLvxkcBseFcgNlCwSKCbVM20+jp4pQGu3
         CnExwUjzYpA2YT+AfVkJr/xlkDxC8joLHCGhWZBITmmkqldtD8BD3W30lM3IXT6t6Qcc
         Euk0Yp8DJlwSseJv53H0WKPmfZNPCnVsL5Z/CotAsmdO2tFTKSizohPZrDC6a/rbfzmZ
         kQfygH+3vorPTAqv2ENiOYfY5POKMqh2gH6PW3WeAfwSm2RyHHQFxOjzkCHBMgw8Ly1k
         PNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=mMNl63FO67KUuEHw42vIWKlthSpMwd5FVOOXIHmqrU4=;
        b=a0MGrBxaTIu5cqfEMBVy6eQYmUqrQSOSZzHWzZPKGK9tm6IWGiRKBodTjPzMhwWrbg
         QPe07WzETskR0Ynk64CCl7HozIGeGnbkjsawTIn52qI9wz6H4gn+pi54R1lILyVA6DSl
         W1TPDbT6M9dzGE2NYzrpIg8iTJqg/zhIqutLgFnySmajI+//DjKiGOE3vB8/yLVy3nra
         jrteW9pwfakPx8qq8PTcWGGCVUEubfzzwWMYUdWljTEhO7ySu9QIbW8y1VW2EToG0Xcv
         TrQelVf2iW1nLomxX+QQlUC/WS03cmOsb8BFXE9+t1/aDhWLPwKn3Z915R9kW64v39w5
         d7gA==
X-Gm-Message-State: APjAAAU/Pe8FwepeY+1Vjij/M1rAeY2pP5vzknPjj/cYM8d6/4OgKdnh
        Dyb6bZGGAdDa03H8r9TbB/gRxUPG4awMTg==
X-Google-Smtp-Source: APXvYqxywK/VqaJubZy+tpMXHI2hldjrJm9ASPz2i3rYysqWyhJf1sL0Mqz/b5O7hDlKl+2gVQIUJg==
X-Received: by 2002:a17:902:8d81:: with SMTP id v1mr22729125plo.23.1568240348925;
        Wed, 11 Sep 2019 15:19:08 -0700 (PDT)
Received: from localhost ([49.248.179.160])
        by smtp.gmail.com with ESMTPSA id c2sm23999870pfd.66.2019.09.11.15.19.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Sep 2019 15:19:08 -0700 (PDT)
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
Cc:     linux-clk@vger.kernel.org
Subject: [PATCH 4/4] arm64: Kconfig: Fix EXYNOS driver dependencies
Date:   Thu, 12 Sep 2019 03:48:48 +0530
Message-Id: <79755cb29b8c23709e346b5dd290481a36627648.1568239378.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1568239378.git.amit.kucheria@linaro.org>
References: <cover.1568239378.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1568239378.git.amit.kucheria@linaro.org>
References: <cover.1568239378.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Push various EXYNOS drivers behind ARCH_EXYNOS dependency so that it
doesn't get enabled by default on other platforms.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/clk/Kconfig       | 1 +
 drivers/regulator/Kconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 9b2790d3f18a..bdf164a7a7c5 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -194,6 +194,7 @@ config COMMON_CLK_ASPEED
 
 config COMMON_CLK_S2MPS11
 	tristate "Clock driver for S2MPS1X/S5M8767 MFD"
+	depends on ARCH_EXYNOS
 	depends on MFD_SEC_CORE || COMPILE_TEST
 	---help---
 	  This driver supports S2MPS11/S2MPS14/S5M8767 crystal oscillator
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index b57093d7c01f..a4c4f01343fd 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -797,6 +797,7 @@ config REGULATOR_S2MPA01
 
 config REGULATOR_S2MPS11
 	tristate "Samsung S2MPS11/13/14/15/S2MPU02 voltage regulator"
+	depends on ARCH_EXYNOS
 	depends on MFD_SEC_CORE
 	help
 	 This driver supports a Samsung S2MPS11/13/14/15/S2MPU02 voltage
-- 
2.17.1

