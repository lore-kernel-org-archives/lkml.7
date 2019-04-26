Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4248EC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130A3208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkHXdRvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfDZQm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:42:57 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40130 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfDZQmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:42:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id o16so2944727lfl.7;
        Fri, 26 Apr 2019 09:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eWVEhVXV6Szyd9/44KMWrRQaDEl4L0ZWJnDi1/l1OvU=;
        b=WkHXdRvo7xgf4zAkZ1FgFwoafjH+HccU9KLH1nV9eSay+kL9EbIhE6HkomyibxW1e4
         lNHutCqEG+L35Mk8D6utdJQ97nVWRuksU1keF0ALEwIfHvmOpLMVogA/Wi5dsdXkj6ZH
         heoVg3WDdIQwDg0auIn9YOkFfd1EjsS6W3Xm8S1MFOVqip9GQ5Q8M9dxn0u6389PMpTr
         C5SXY+nN5SKa4QMyjEZQ6vNGwTxE0MxU2JzTkAD7zuNxehhx3MBHRh6z7wxd/gSBScS2
         n+JZfX5Ahg5EbO2YYTuPLFt/ibIXN/yzINXn0rCyOrI7VZ5g7YpEmZD6TmN+KgxMm4bV
         3/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eWVEhVXV6Szyd9/44KMWrRQaDEl4L0ZWJnDi1/l1OvU=;
        b=GbUGUDgc1r+KzlsdwPrkEyprJb5wq0KwuNL4u0QJcIoGrM+FAHadrTVi0JFq2lXmN/
         Pr+zd3Dzq6WbrMzvKfq44DPEDFRjV+QHU1GkKni1B4FpbzKLWEyvQbWLdusj9E+gy9rs
         l8sP/NAo0QbqFrtgcPdobjQo/8AvoLhNYC1DXeJ0kNjXpXNfZdOwlJI/7Jj66ceAVP7L
         FBhiXlLpVN/+9Kcs5zBKgApt9mzgcdsImxUtgqM7ryfNmCQj/Pf6OVopmdDmSr44l5q0
         BpeanPc5NFK0jeCoMsVkaX8LUdx0ZzjX0FzKuKS+hTg4j+XT0GXsFuO93gCYRauU4TWb
         oKcQ==
X-Gm-Message-State: APjAAAWiGh76j4Fqg04qPdW8iY2CgWzmyeocD4CmrhnBYPgOpmlZzfk/
        pte4PdJapQNEFkcBuppxu6c=
X-Google-Smtp-Source: APXvYqxhhrqH1igbuxLqu6Jv09PPhxp/Yw5Ugs/uQ7FpqteK7/kO4wqb+fOJ0yS80vA0LZ6oBCvrzQ==
X-Received: by 2002:a19:7702:: with SMTP id s2mr26244975lfc.102.1556296954524;
        Fri, 26 Apr 2019 09:42:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a315:5445:5300:2492:ad61:69f1:23cc])
        by smtp.googlemail.com with ESMTPSA id q11sm5637807lfc.51.2019.04.26.09.42.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 09:42:33 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kyungmin.park@samsung.com
Cc:     bbrezillon@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 2/5] mtd: onenand/samsung: Make sure that bus clock is enabled
Date:   Fri, 26 Apr 2019 18:42:21 +0200
Message-Id: <20190426164224.11327-3-pawel.mikolaj.chmiel@gmail.com>
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

This patch adds basic handling of controller bus clock to make sure that
in device probe it is enabled and device can operate correctly. The
clock is optional and driver behavior is identical as before this patch
if not provided.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/mtd/nand/onenand/samsung.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/nand/onenand/samsung.c b/drivers/mtd/nand/onenand/samsung.c
index a425f19a3876..9628bf5bc397 100644
--- a/drivers/mtd/nand/onenand/samsung.c
+++ b/drivers/mtd/nand/onenand/samsung.c
@@ -14,6 +14,7 @@
  *	S5PC110: use DMA
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
@@ -125,6 +126,7 @@ enum soc_type {
 struct s3c_onenand {
 	struct mtd_info	*mtd;
 	struct platform_device	*pdev;
+	struct clk	*clk_bus;
 	enum soc_type	type;
 	void __iomem	*ctrl_base;
 	void __iomem	*chip_base;
@@ -916,6 +918,10 @@ static int s3c_onenand_probe(struct platform_device *pdev)
 		}
 	}
 
+	onenand->clk_bus = devm_clk_get(&pdev->dev, "bus");
+	if (!IS_ERR(onenand->clk_bus))
+		clk_prepare_enable(onenand->clk_bus);
+
 	err = onenand_scan(mtd, 1);
 	if (err)
 		return err;
@@ -947,6 +953,8 @@ static int s3c_onenand_remove(struct platform_device *pdev)
 	struct mtd_info *mtd = platform_get_drvdata(pdev);
 
 	onenand_release(mtd);
+	if (!IS_ERR(onenand->clk_bus))
+		clk_disable_unprepare(onenand->clk_bus);
 
 	return 0;
 }
-- 
2.20.1

