Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A98C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1651F21739
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xLaNPUaU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfK1QuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 11:50:13 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43789 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbfK1QuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:50:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id h14so3190739pfe.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 08:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6rU2ZvHsnSzYwMs7Z05xUbhf11jabY6wDKJCR5AZiJ8=;
        b=xLaNPUaUIKXCW9bn1eGbhGpqCq44pw7uvqUvbHWA4HXNCC3j8wDWHuHJOglsgXtqSk
         WHKtLL/F++cUfpC9UOFnfKeZYczymLgalUAVwkbj2XQewDTZaY49MRx4nJHwuX2LQ22g
         hZCd2n+Fs45bxCw09A83bpNdll58/D85vKQUfLvPhdLeJGezwl2ddQlfKf/glagBUdp8
         1m8c/kJuqMChbyaZPNkYaMtKvkiReM3ynaPvfVHGYkjtbrEIXiSF6jmuEjWy5hUisEd3
         Mo7glQ+8H5q3aaptBsBgrOKcyZoZ596KJiz3lV9SYRpWfxNey2AXYAhCR4YSM6ExV8xq
         OwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6rU2ZvHsnSzYwMs7Z05xUbhf11jabY6wDKJCR5AZiJ8=;
        b=OawF4reN3XpXYevuCvTsuJ85dUCG60pyi1oGQAv9WYV96Cg/kh1Sc51+2ur3MQ6rYQ
         nJO4pLSlEu7aLvMxZFb7N9rgLfNnW0B+wsFxLiYge6FPfD+3L7W3IFJeefOtXR8fyBJ4
         GEoj4s3tySv/X9cj6vl7thYwt59wHz/k/M7twHLARTVZ7ebmuhcdOKgLNTBzYNlNz0Nt
         +yoEIBFcXkRkNgnKtfYBX0s9ZNBGJ4xE1XcjtjYsqZtb5SnRWFjmeGYCbC4Xzd3htGTb
         RDBl708tBEPshkI3baDzdG1mZUC7vmw3gDoDCdWXN0rOKdS9QUkY9VfKPa1NdOLnrrfL
         N9jA==
X-Gm-Message-State: APjAAAWDqIh7nMweaHnZcyLewfVIdwkigaI54L37wlR8IPGgzGbQhahy
        vvS6qEhPKM6xQ53Z/OpRneF7Mw==
X-Google-Smtp-Source: APXvYqwwS5sB68lbDlyVrgeTCJ16HYifOS/3Hk6LpNS+0KYfnvpq3hykK4GUDY5gN7r2/bWGXWlThQ==
X-Received: by 2002:a63:4547:: with SMTP id u7mr12360882pgk.423.1574959809102;
        Thu, 28 Nov 2019 08:50:09 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a15sm2450343pfh.169.2019.11.28.08.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 08:50:08 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19][PATCH 05/17] hwrng: stm32 - fix unbalanced pm_runtime_enable
Date:   Thu, 28 Nov 2019 09:49:50 -0700
Message-Id: <20191128165002.6234-6-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128165002.6234-1-mathieu.poirier@linaro.org>
References: <20191128165002.6234-1-mathieu.poirier@linaro.org>
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
Cc: stable <stable@vger.kernel.org> # 4.19
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

