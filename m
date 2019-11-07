Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2346EC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68D721882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VMo/N9HX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfKGURQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 15:17:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36344 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfKGURO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:17:14 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so4580441wrx.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 12:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3uEMTSxEwniG+GI3vykJ+eUgrkWCmr3tUv0pvMyZgIw=;
        b=VMo/N9HXGvfK31zXdC8J2efmeCXAZkgd9zzvtP9wLfazNjTmQHu5mCxVmhzk+xVbJ2
         PElhp2IzkNIWL3VvKbPcnJseKL5qCfNjPwQm+zvKVq3Mqw43lbPrXdw8jX0LMjCJSdlY
         zr7DvqEbY78cydYhsAj4vHnqc5av7McswfE+2rncbpr8CnTxym0NjhC+hPh4lpcrjicP
         Ehdk8okBRdiOyQ1GZzVGaO8j6EwKaRwFc9yn7B/GOwQupIpPsWFOIf0Khecen5Z0Cp9m
         7ZfCiLf3MJ9u5rViwxfWnhzbMI5yVitvyKlAEWxiaPSGmGbzdVZARRFWKjMqV5Bhn4LA
         xQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3uEMTSxEwniG+GI3vykJ+eUgrkWCmr3tUv0pvMyZgIw=;
        b=QFM2u1YKVdJWJBrtrNQF9zmGOaEEJT3eMrt4fWww5nvg9+9B1Dz3g9kh7N8pIETNLz
         8Rb/Ph9KS6x7wUvQIZbG5X6Bw9djVNNMjOHcPKfDjLgkSlmJvxypctEAdiYVRcQcwaSn
         WMbMueo1GpS1WoA+mG7K2ymPKb/YlhKZxBBQ68T3ICMI5a9YMQ4DAYWTq+ZrDwk9wbag
         3s8cI4PYSdXPnpAFVHsUn3M1CMA4ziYboi+bMeRDUR4yJ4khQkCtCsNlELOiojJlsQ78
         kqOqK0C4WnnsSRTkXCtcr+ALNWwn1NhDRoFDOLPPcu8Ek9EwiQSBKFYF2VZKP8HQv1ca
         5/KQ==
X-Gm-Message-State: APjAAAX5ZiQiaMHNnjjW1BNCJBApJjCoTB1Xk7T9mdQHd5vx0cBQvXfA
        nHFjx5nfYc4Ehphf0DVWsMhW1A==
X-Google-Smtp-Source: APXvYqzkgWzz7JMVKWkHPJp5xKneWHyHnj7XSWrSU92m+gh5RkyIUCHAYpZ3DNuAFNOu8sHi1U60Ag==
X-Received: by 2002:adf:e544:: with SMTP id z4mr5081381wrm.6.1573157831475;
        Thu, 07 Nov 2019 12:17:11 -0800 (PST)
Received: from localhost.localdomain ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id d11sm3215162wrn.28.2019.11.07.12.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 12:17:10 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>, Sasha Levin <sashal@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 06/10] ARM: davinci: da850-evm: call regulator_has_full_constraints()
Date:   Thu,  7 Nov 2019 20:16:58 +0000
Message-Id: <20191107201702.27023-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191107201702.27023-1-lee.jones@linaro.org>
References: <20191107201702.27023-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

[ Upstream commit 0c0c9b5753cd04601b17de09da1ed2885a3b42fe ]

The BB expander at 0x21 i2c bus 1 fails to probe on da850-evm because
the board doesn't set has_full_constraints to true in the regulator
API.

Call regulator_has_full_constraints() at the end of board registration
just like we do in da850-lcdk and da830-evm.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Change-Id: I02d04d302a679996b88868ddb289fc5185f53fa4
---
 arch/arm/mach-davinci/board-da850-evm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 83f579add9e4..85fbf14b956a 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1482,6 +1482,8 @@ static __init void da850_evm_init(void)
 	if (ret)
 		pr_warn("%s: dsp/rproc registration failed: %d\n",
 			__func__, ret);
+
+	regulator_has_full_constraints();
 }
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
-- 
2.24.0

