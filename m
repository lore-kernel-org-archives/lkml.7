Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC961C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F96206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 20:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qzcz7Cl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbfGaUaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 16:30:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52259 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730811AbfGaUaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 16:30:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so62144622wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 13:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yjwyF8h24+6MkrK2XCkddWq6ewDMefY3p/JkUhfcGxo=;
        b=qzcz7Cl6t4xg8YUv9zpXFmqkJhMi78y34+n3ItM5RM3vnuvyjB8v36KL6skLRPl1ST
         s06JvtshN15JWJg4/St3iS9Z0/Rg0NPCEszd7U+ijuu30Hu/8+Z6yXLfLnhCIvqnF3Oi
         JSgta8K8mMlRlPHlkBqTlIccnqXCMp2penXjc+q2Nb2fHmNWPiTgTtkuozyLQEfIq6Oa
         FOdJcwQzal3USJs9/3CYN6CHs3JYnb2TvvjR6iII4E2HD5EXpwqMHBkcZAr9QVEj76fa
         YWJ9VY7e8YpVSpVpAejGPGkBtSCZ7ZQOGC+voq0I+kw+vMMTzPvd2JX2c1LumyOWOsGf
         T5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yjwyF8h24+6MkrK2XCkddWq6ewDMefY3p/JkUhfcGxo=;
        b=QEWAatNRUYSa3Y0mNWbQjq0TQ+vi8rrLuWnaYD1Xe6p9qV4qHASPvcs5ZxUNlzMZ+0
         F0fSxWHHYvdkt5sh3kcmMzlNZ55CaJcvcZGZEoOCdOGnkR7brOeGjSr+0t6Mjc3C4yQj
         QwCbhwRA8fVf4XQgNWYraVG/vqJN53xB3ct4sORIj7ysfgwvYE5q75voj9oGUXpyZAY3
         Ww/70H1qgSllT/Z2/ys/pdrTQ7rO6CwAf/mf964h2xFhXpVyC1lL6/NvIpijUdV32HXh
         6fhAuSnq2OJVKmM78L+vS+KtgxlprSK+CbqxHI60q6dyQfQnxsXUnW3n3gAQBc6d771n
         JAgA==
X-Gm-Message-State: APjAAAUB7bzELvnHsNPl7RWglCL7hEGXHNXyF6uvMqOFD4X5quFS6rJi
        QkG3pWM8icfb6gHndbVTn/MD3g==
X-Google-Smtp-Source: APXvYqwTYu0Ia5Oacgfvy6EXO0KAmKGEQZx1LX6+bJ4LHOQNL65LwwWoyMz5BQ/0ICXimEC4Sbzm9A==
X-Received: by 2002:a05:600c:da:: with SMTP id u26mr108777580wmm.108.1564604998460;
        Wed, 31 Jul 2019 13:29:58 -0700 (PDT)
Received: from localhost.localdomain (19.red-176-86-136.dynamicip.rima-tde.net. [176.86.136.19])
        by smtp.gmail.com with ESMTPSA id i18sm91905591wrp.91.2019.07.31.13.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 13:29:58 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, bjorn.andersson@linaro.org,
        sboyd@kernel.org, david.brown@linaro.org, jassisinghbrar@gmail.com,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        will.deacon@arm.com, arnd@arndb.de, horms+renesas@verge.net.au,
        heiko@sntech.de, sibis@codeaurora.org,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net
Cc:     vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Subject: [PATCH v4 13/13] arm64: defconfig: Enable HFPLL
Date:   Wed, 31 Jul 2019 22:29:29 +0200
Message-Id: <20190731202929.16443-14-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731202929.16443-1-jorge.ramirez-ortiz@linaro.org>
References: <20190731202929.16443-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The high frequency pll is required on compatible Qualcomm SoCs to
support the CPU frequency scaling feature.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 34c3ac4e4b79..04b7fb26a942 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -698,6 +698,7 @@ CONFIG_MSM_MMCC_8996=y
 CONFIG_MSM_GCC_8998=y
 CONFIG_QCS_GCC_404=y
 CONFIG_SDM_GCC_845=y
+CONFIG_QCOM_HFPLL=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_ARM_MHU=y
-- 
2.22.0

