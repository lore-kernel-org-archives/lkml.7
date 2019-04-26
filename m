Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8035FC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA3620B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLdiWg0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfDZQmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:42:42 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36077 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfDZQmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:42:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id l6so3529043ljb.3;
        Fri, 26 Apr 2019 09:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Y+4Tl47IG+lz0BxKQcbzY1Eso3ZPi0a0zQy/pwXSWM=;
        b=GLdiWg0ZkD2A76urU8+cUmH7vu4+Xj4Xr0HWH0tPBVd1h13p5zIa8oOwLyU0z31n4W
         MC/IGXOLu4gAz/z2SgQOTsMvWc//eQlHtxh7QQ895Dyj4rjwrrSDzB4avpPAy8vcJYUR
         NnWAbeJg+tgKVEwd+UuNO1nYtnqxXrJTAis4G+Ei1fFPmj52MCw1g3nm3PjxmlZYvW3e
         9l+vTSCFBvGlDKsuTcxo7Ux/oNuOWDfDp1h8gM3ybn2Uin0weXZgm9n//Np9tEYB18JX
         /OtPusi+ULOTnp/yl+VIAeyDbA6Xf5M2hyVFqEGXMOJNR0qjQWXJhHWxFkkrsAgoeYe8
         uF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Y+4Tl47IG+lz0BxKQcbzY1Eso3ZPi0a0zQy/pwXSWM=;
        b=QtdEccH+1UuA4wGCoDxqM7+r02TrPXencNCtwzUd6JJhS++vOkGPQ4kwMDeBRWGud4
         EPxU553OzcW4eBfgOtSZG2IbE7+yk7D5kKLmHGY/D+XwEklo6hVJREzb14XJ4lh4zmwy
         YSTXq5czQ1NWh/4Oy4p7ikOPLdPTgiq7WSjMayA9Hlpq7JkMC2Fat2K3xghDVCkverLp
         7QCOVdkJxDssEdUXGzBi03hbKpMIHPdoKzFbglCqiphNxIjgEcnO5UJKIAFmQ5uGGmax
         1m+SWS/xqiCIi7oCUIF3U3ItXJnVmGoTOcYne2THzrhpOZlxZbyJ/tqXf6ZDXN2+ADPJ
         6kDg==
X-Gm-Message-State: APjAAAUJkOkAPGDzQl4pq8V4Y8eweU5p0mihvTuJbKORGW7IMf3ARzU5
        NMMzZqApn4cgeP0NMe5Fyig=
X-Google-Smtp-Source: APXvYqyk/POYUvdk35I2whPVIAg8/WSc3NUy2eGeHn6j2RSTLnpZi2BPXJt0JWUcnlepCVr6LY1PQQ==
X-Received: by 2002:a2e:4a09:: with SMTP id x9mr5053589lja.19.1556296956179;
        Fri, 26 Apr 2019 09:42:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a315:5445:5300:2492:ad61:69f1:23cc])
        by smtp.googlemail.com with ESMTPSA id q11sm5637807lfc.51.2019.04.26.09.42.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 09:42:35 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kyungmin.park@samsung.com
Cc:     bbrezillon@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 3/5] mtd: onenand/samsung: Add device tree support
Date:   Fri, 26 Apr 2019 18:42:22 +0200
Message-Id: <20190426164224.11327-4-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426164224.11327-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190426164224.11327-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Figa <tomasz.figa@gmail.com>

This patch adds support for instantation using Device Tree.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/mtd/nand/onenand/samsung.c | 37 +++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/onenand/samsung.c b/drivers/mtd/nand/onenand/samsung.c
index 9628bf5bc397..0f450604412f 100644
--- a/drivers/mtd/nand/onenand/samsung.c
+++ b/drivers/mtd/nand/onenand/samsung.c
@@ -25,6 +25,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/of.h>
 
 #include "samsung.h"
 
@@ -835,8 +836,36 @@ static void s3c_onenand_setup(struct mtd_info *mtd)
 	this->write_bufferram = onenand_write_bufferram;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id s3c_onenand_of_match[] = {
+	{ .compatible = "samsung,s3c6400-onenand",
+		.data = (void *)TYPE_S3C6400 },
+	{ .compatible = "samsung,s3c6410-onenand",
+		.data = (void *)TYPE_S3C6410 },
+	{ .compatible = "samsung,s5pv210-onenand",
+		.data = (void *)TYPE_S5PC110 },
+	{},
+};
+MODULE_DEVICE_TABLE(of, onenand_s3c_dt_match);
+#endif
+
+static enum soc_type s3c_onenand_get_device_id(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+
+	if (IS_ENABLED(CONFIG_OF) && np) {
+		const struct of_device_id *match;
+
+		match = of_match_node(s3c_onenand_of_match, np);
+		return (enum soc_type)match->data;
+	}
+
+	return platform_get_device_id(pdev)->driver_data;
+}
+
 static int s3c_onenand_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct onenand_platform_data *pdata;
 	struct onenand_chip *this;
 	struct mtd_info *mtd;
@@ -858,9 +887,10 @@ static int s3c_onenand_probe(struct platform_device *pdev)
 
 	this = (struct onenand_chip *) &mtd[1];
 	mtd->priv = this;
+	mtd->dev.of_node = np;
 	mtd->dev.parent = &pdev->dev;
 	onenand->pdev = pdev;
-	onenand->type = platform_get_device_id(pdev)->driver_data;
+	onenand->type = s3c_onenand_get_device_id(pdev);
 
 	s3c_onenand_setup(mtd);
 
@@ -919,6 +949,10 @@ static int s3c_onenand_probe(struct platform_device *pdev)
 	}
 
 	onenand->clk_bus = devm_clk_get(&pdev->dev, "bus");
+	if (np && IS_ERR(onenand->clk_bus)) {
+		dev_err(&pdev->dev, "failed to get bus clock\n");
+		return PTR_ERR(onenand->clk_bus);
+	}
 	if (!IS_ERR(onenand->clk_bus))
 		clk_prepare_enable(onenand->clk_bus);
 
@@ -1000,6 +1034,7 @@ static struct platform_driver s3c_onenand_driver = {
 	.driver         = {
 		.name	= "samsung-onenand",
 		.pm	= &s3c_pm_ops,
+		.of_match_table = of_match_ptr(s3c_onenand_of_match),
 	},
 	.id_table	= s3c_onenand_driver_ids,
 	.probe          = s3c_onenand_probe,
-- 
2.20.1

