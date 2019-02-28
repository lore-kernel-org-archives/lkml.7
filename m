Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B83C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413BA2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zViCAUkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731393AbfB1M1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:27:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35740 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731919AbfB1M1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:27:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id y15so8773106wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 04:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=vXTkCN9XQrYDU1nAIhEf80bjP3QRImM0rvZgjdrLpoM=;
        b=zViCAUkUGygwrPh5ryUIoZlVVC4rFdcAkF9mQh026jMdmcKlqDw0Gkc9YphIoocF3O
         yQodupvAqYJ9DU95uatT7LlRfsD20zkOeIO1bN+VjNXtlRJ/V5B7OdClNCgYioqWkFew
         iyld1qAKnJWsahbkbKAuCwA+s9qSvB6kwe8qW6ZPAl3Cib0/KfDByadChrUuOuHdWdea
         1BjemG1bV3mz5GTay4F+ViN2RhRBPwvVi+7kF++z4Gz6tdND7ys/GXX/qyiURMFIUDKC
         Q9iPM1NDXRHyPmH85PhPNfVPOx6Bwvh8j25bu+Pb8nNjQ+9O0FtdWonazejuTbMDf+zs
         r7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vXTkCN9XQrYDU1nAIhEf80bjP3QRImM0rvZgjdrLpoM=;
        b=qyfHB/LnAu6/SEi6WffbvcBZGXfzhYfD31LsIvrA/NqwD9ipN2tsDyxsMyCW6yUozG
         6Miq6rKPZskR8wKVAeXEPhM8e6uOZttDbphf7HyCcXD+ZHk/n+yeEdoM1or6JcEBYDNL
         UXcc4YFP2OX+bQyUyi0h+Un3l6l2pbjJlwa0ws+1WM6cVjCnkgSx9O3vVhSqwYYkPbEC
         7pByk5L9RWTPRUTQTAErSLfKhnM2SpwQennk6kojfvNEl8pItKN/OmeuX1XwaZ6NM/qV
         lQPlLCCA6yvzHTy6uOa7xZnxBh4Vtp1gXG26P2XsI9cSud3sHjvjc5GUmWAsHspTh+Mk
         p6NA==
X-Gm-Message-State: AHQUAuZFx5lkxCxLe9rpGC0lDpy8xXzWcDSUHuxQXIbwR25OTKc/3+9+
        5RhIqQQMrj72d+cOe5C5mh4nOH2Ijt0=
X-Google-Smtp-Source: APXvYqy9YoiIJPTf/RzaVIpQhMBmnBnn9tFAKiut0Rws8RwpCWNRSvhBEdCqu9Nq/WkkjRz1+n0yzg==
X-Received: by 2002:a1c:2885:: with SMTP id o127mr2953084wmo.135.1551356871384;
        Thu, 28 Feb 2019 04:27:51 -0800 (PST)
Received: from localhost ([49.248.54.130])
        by smtp.gmail.com with ESMTPSA id f196sm10214686wme.36.2019.02.28.04.27.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 04:27:50 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 19/24] drivers: thermal: tsens: Common get_temp() learns to do ADC conversion
Date:   Thu, 28 Feb 2019 17:51:09 +0530
Message-Id: <eecd90d759f3bb837e04072ec745fc177933f243.1551355503.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_temp() learns to return temperature regardless of whether it is
returned as ADC code or direct temperature.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 7bab0e640806..5db1aa441910 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -129,10 +129,15 @@ int get_temp_tsens_valid(struct tsens_priv *priv, int i, int *temp)
 	if (ret)
 		return ret;
 
-	mask = GENMASK(priv->fields[LAST_TEMP_0].msb,
-		       priv->fields[LAST_TEMP_0].lsb);
-	/* Convert temperature from deciCelsius to milliCelsius */
-	*temp = sign_extend32(last_temp, fls(mask) - 1) * 100;
+	if (priv->feat->adc) {
+		/* Convert temperature from ADC code to milliCelsius */
+		*temp = code_to_degc(last_temp, s) * 1000;
+	} else {
+		mask = GENMASK(priv->fields[LAST_TEMP_0].msb,
+			       priv->fields[LAST_TEMP_0].lsb);
+		/* Convert temperature from deciCelsius to milliCelsius */
+		*temp = sign_extend32(last_temp, fls(mask) - 1) * 100;
+	}
 
 	return 0;
 }
-- 
2.17.1

