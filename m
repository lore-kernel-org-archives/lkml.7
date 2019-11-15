Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF40CC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61802073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uq0Rvs0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfKOWfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:35:02 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42529 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfKOWeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:34:05 -0500
Received: by mail-pg1-f193.google.com with SMTP id q17so6617130pgt.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 14:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I8DYLlgbe7crhAhNbwNPqGy2McaZWO3AECdzJYJCCco=;
        b=uq0Rvs0KPR5i9HtlAfbqJ09ftst7366sxovqlgQSCdSMlx7zsOEFlsXzxIZ/RFJepW
         +xNmN50KWjZEmZ4ahwYGYncO2oNSlvlk9+bSZ0uJj5KwnzYGnYwwpJh3Z0U0CVVPUgeF
         WBek2r2DnpcVe5urx/INF76BoO8wqFwuN86lGWJuCvpErfOgoUCoWWPI37s5pI2Uuw9X
         OEj1WNleT7NOb7K1+oFm34vXUlCdixUaNsyhZrrKKyzZ34tRHBi5jpoqITPilNH4uc3A
         cG9Aay+Ra1kWvl+WOeF5ifVv++jVQtvf2AnAcuQ92MtUnevyPsRG5Pf0brxRmVhP9TbT
         u6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I8DYLlgbe7crhAhNbwNPqGy2McaZWO3AECdzJYJCCco=;
        b=V4vVRNPuxWWzblNOyTYR9WPR5e29OdO2kZniH1GJWhXRNpwi57vWbZ1ZoxElOmmPft
         1FvH4MIPxlomyBACid3dpMH88JCdF1tZ8VFO4xX4jgcUtVzIdzmOON7gCa6ll6KRZ1f9
         JHyxagTLWqwkTUrsLRvfDFhYkBfDBOwjujEkZFooFWMAxXkmAhvxSGynDOf0kvZoCt3c
         s6Cgu7V/kFZjaYJEBgqyIIA03RBzJP2ieTgVNUt9osruSfkhnjAoxJT/nzRkYQaEg0eC
         ph2ELxMNeb/+8o8UCE6P7oLDO9fRAijVfaPfKzEGa9LW/1CwvlO1OHWxQ1K4xvpuAU9L
         eY/Q==
X-Gm-Message-State: APjAAAXVu5TaSzNzapuSxdd6Rs83FV3eoFgpl/4XDlzYzdFGxLSwVZAH
        d81iRaBfUss8YWEYozmL15dNCA==
X-Google-Smtp-Source: APXvYqytHqdgYw+McewKp6L1IK0RR+uPnytQnNFy3RGnQfrkQ+RNzORO54L3aq41JZ6v3SKIJheJ4A==
X-Received: by 2002:a63:2e01:: with SMTP id u1mr19770443pgu.25.1573857243342;
        Fri, 15 Nov 2019 14:34:03 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m15sm11699724pfh.19.2019.11.15.14.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 14:34:02 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19+][PATCH 07/20] hwrng: stm32 - fix unbalanced pm_runtime_enable
Date:   Fri, 15 Nov 2019 15:33:43 -0700
Message-Id: <20191115223356.27675-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115223356.27675-1-mathieu.poirier@linaro.org>
References: <20191115223356.27675-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lionel Debieve <lionel.debieve@st.com>

commit af0d4442dd6813de6e77309063beb064fa8e89ae upstream

No remove function implemented yet in the driver.
Without remove function, the pm_runtime implementation
complains when removing and probing again the driver.

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Cc: stable <stable@vger.kernel.org> # 4.19+
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/char/hw_random/stm32-rng.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index 042860d97b15..37b338a76ba4 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -169,6 +169,13 @@ static int stm32_rng_probe(struct platform_device *ofdev)
 	return devm_hwrng_register(dev, &priv->rng);
 }
 
+static int stm32_rng_remove(struct platform_device *ofdev)
+{
+	pm_runtime_disable(&ofdev->dev);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int stm32_rng_runtime_suspend(struct device *dev)
 {
@@ -210,6 +217,7 @@ static struct platform_driver stm32_rng_driver = {
 		.of_match_table = stm32_rng_match,
 	},
 	.probe = stm32_rng_probe,
+	.remove = stm32_rng_remove,
 };
 
 module_platform_driver(stm32_rng_driver);
-- 
2.17.1

