Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A571C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 03:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72198207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 03:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iQjWf6PI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfI0DvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 23:51:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39207 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbfI0DvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 23:51:20 -0400
Received: by mail-pl1-f193.google.com with SMTP id s17so509366plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 20:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Ro1weBOfHyrfHvVXj42WLEM+jvzuYy/MP2n8jxoh6Sw=;
        b=iQjWf6PIHd1v1UNoaVAblgCzkNb6Y31PZsclFAtKiEeyxoA/ZBhz42c1wwQb1Uo7sh
         Dezcpm8sod9AV4JS0qdMpF1LSML8dJx1P80ymBuFtN+p8Z8+FPFsgcKTcETG6EPKoLAm
         ED5gILcZrLBEy229SySmbmCw1wrkEtEplTuaYZDAi7TYvPkfu2WzOpzNwxs49jGj+9cD
         j7sLjfC/1lJ7D6z1uPsJ0HuhH5PpcZH3HI9Qk00mmb48QCyu3V3xxStoHzqK4yKnNxIm
         bGaISZM1api+Tb+gqZw4vOqZHjJ9rIW1ohO1CyODBWK1qF1EhtMtxhAgpQefOrSvlOhR
         txAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Ro1weBOfHyrfHvVXj42WLEM+jvzuYy/MP2n8jxoh6Sw=;
        b=jE53nl75f9AAzN2Zl9XjQi257edWC3cOAm6ZFk4bRJ+sIEM4PDN1iZ10olDtbntOqP
         ezTIEMJmvG3V6Rs17a89T+rcLYIVtyQQAndjN6nuaBJem9dhaneb1pwxf77fE3o0xFnF
         XS69ftn+DwfPQ+W7YvwSYbfCWgLK4Vax82h1knkOPuB+43xJvdOETki30QPDOGCZtgH7
         76D8sgG0CXJKlkgqwyK49Xvnu0kEwZuGe1ebheZ7+JnBjlSZBm9jkuH0SP/9KZcc19zW
         GnIUUg8dPE/syV2wrTNoLw4CFI/Xf1OMaqwLaMXCwZ3D2XzAXOV3ZC+boYJKcUu+hxM2
         WETw==
X-Gm-Message-State: APjAAAVvRriTJhMebSxt61yP1C7vT/JFQji7HyLwF7+n7suQSv2pJ9nb
        +GDESBoncpy6VvayEbABXQ3d8Q==
X-Google-Smtp-Source: APXvYqw5yUJIRQ9xSAy1GfOyiVB5qxoFBjwRMN9tsNQOWgJchrf1N4Y2d1kkQrAzmhk5dgjPQZaPiw==
X-Received: by 2002:a17:902:d887:: with SMTP id b7mr2142145plz.297.1569556279194;
        Thu, 26 Sep 2019 20:51:19 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id n66sm753640pfn.90.2019.09.26.20.51.16
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Sep 2019 20:51:18 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] clk: sprd:  Change to use devm_platform_ioremap_resource()
Date:   Fri, 27 Sep 2019 11:50:54 +0800
Message-Id: <64121209a05f6e34b70cf00d9303d13e765f8528.1569555841.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <b7fbe8776703b9d637ab82ad4724353b359f1d04.1569555841.git.baolin.wang@linaro.org>
References: <b7fbe8776703b9d637ab82ad4724353b359f1d04.1569555841.git.baolin.wang@linaro.org>
In-Reply-To: <b7fbe8776703b9d637ab82ad4724353b359f1d04.1569555841.git.baolin.wang@linaro.org>
References: <b7fbe8776703b9d637ab82ad4724353b359f1d04.1569555841.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together, which can simpify the code.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/clk/sprd/common.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/sprd/common.c b/drivers/clk/sprd/common.c
index 7ad5ba2..c0af477 100644
--- a/drivers/clk/sprd/common.c
+++ b/drivers/clk/sprd/common.c
@@ -42,7 +42,6 @@ int sprd_clk_regmap_init(struct platform_device *pdev,
 	void __iomem *base;
 	struct device_node *node = pdev->dev.of_node;
 	struct regmap *regmap;
-	struct resource *res;
 
 	if (of_find_property(node, "sprd,syscon", NULL)) {
 		regmap = syscon_regmap_lookup_by_phandle(node, "sprd,syscon");
@@ -51,8 +50,7 @@ int sprd_clk_regmap_init(struct platform_device *pdev,
 			return PTR_ERR(regmap);
 		}
 	} else {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		base = devm_ioremap_resource(&pdev->dev, res);
+		base = devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(base))
 			return PTR_ERR(base);
 
-- 
1.7.9.5

