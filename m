Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E3BC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 23:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D8E20838
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 23:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JaPw67OA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405322AbfIFXXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 19:23:53 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37151 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732131AbfIFXXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 19:23:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id r195so8749006wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 16:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mipkxs/K3VQhxvIuUjc7V8qspofVUAqg0yqG9RDRrhA=;
        b=JaPw67OAiUZvfpUlDcvnVfl7MJaj45DXVlS6fFKW0ZOB598Orgq1TgSx5pD4Y9OwwZ
         rrvF/2B0uWVCmZcS2sChE03AJt/7jHrRwR71TuCquzTiCown6sm3kCPV41jYriy51yoB
         k/vVV8l5S/NznpFNLRncX/ac1FPnSECemWAXiH6op/TUB4xTG7fd3CQffV4/YSTpxjrv
         sNnJqykGtElHGgjGjolLHPgCG7YCWFCA8iy5Hrf0wmRk41IohU6/3yIVDKar19CU3pNP
         ejiTyst6VrZX1jlt4TWh0bsUTmvORLoc1cvgflQ39VzVZ58ek1ShzuU3uLOX+s+fHop9
         1fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mipkxs/K3VQhxvIuUjc7V8qspofVUAqg0yqG9RDRrhA=;
        b=L+t83CN8iaMj5AubnRjBwbvzPn1CQgncJCu1hmx5jkqSGQm60QuGPN5GzL/HZ2bGN9
         XEWwfQTxriGuhVNz1Cq3H1P/vv5UjDIqlt6g8Nb2Bc69/UcIChJXoYKkPsVeBuEJVVLo
         ySp0E/tBDL7ZE75snsyaJeGC2dW/0fG/9IKci+FA3gbgUjW948oKqYuFTHkDEqs8jyNz
         py+Cr2yMYNWpHBVJhli9+SQnshsNwx4n+aWpED/78yCZpaex6s7oOaVH+7+wLOP+HbMG
         Vk30zrWRVxQIwPe+naQ+MruvtIa9/x67A32rPxQeljN8lRE1fH95SOK4dEJd7yj+Znrd
         +LMA==
X-Gm-Message-State: APjAAAX1dHG7soWW3aI8jWqwVW/j7STLhgmLt8tkq7PMXmfYQ8kPk4p/
        4IXOrv/5LIHnour2FntooNz5yg==
X-Google-Smtp-Source: APXvYqwqXkZWIKePDvL0sp5Ia/BhDsaQd11TDzBwPdj+Ow9E+ohcnQrkF5KKS1DAmx0ATOmylp+78Q==
X-Received: by 2002:a1c:a796:: with SMTP id q144mr9295015wme.15.1567812230476;
        Fri, 06 Sep 2019 16:23:50 -0700 (PDT)
Received: from localhost.localdomain (124.red-83-36-179.dynamicip.rima-tde.net. [83.36.179.124])
        by smtp.gmail.com with ESMTPSA id q66sm9254919wme.39.2019.09.06.16.23.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 16:23:50 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To:     jorge.ramirez-ortiz@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: qcom: fix QCS404 TuringCC regmap
Date:   Sat,  7 Sep 2019 01:23:46 +0200
Message-Id: <20190906232346.8435-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max register is 0x23004 as per the manual (the current
max_register that this commit is fixing is actually out of bounds).

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/clk/qcom/turingcc-qcs404.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/turingcc-qcs404.c b/drivers/clk/qcom/turingcc-qcs404.c
index aa859e6ec9bd..4cfbbf5bf4d9 100644
--- a/drivers/clk/qcom/turingcc-qcs404.c
+++ b/drivers/clk/qcom/turingcc-qcs404.c
@@ -96,7 +96,7 @@ static const struct regmap_config turingcc_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
 	.val_bits	= 32,
-	.max_register	= 0x30000,
+	.max_register	= 0x23004,
 	.fast_io	= true,
 };
 
-- 
2.23.0

