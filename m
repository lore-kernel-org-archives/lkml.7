Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF14FCA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962112070B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aebygqwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502929AbfJXOnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 10:43:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44685 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502818AbfJXOnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 10:43:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id e10so14370729pgd.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 07:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ej8B142hK6d03XKUGaQLuYVY6IpXZx2RmTPiqw40xi0=;
        b=aebygqwdzbyjiw1HI65W5nDqWVi//gOTnjJUMoWKjfynVochCmJY083Di3Z6fMd+2Q
         B4E5dQMYgWhkj9ZkFE1XJlPGurpFgXZoXwPoXN9Ix9sKAib91IXfaGWLfPxNvf3fkPvt
         Xa9/13iNYaLa/6P/LIUpcwIl98F2OusacFiQ5mWEss9viOnVX/ClAM4b5QmYv1JbmKef
         vgw4dOPpdDlsccirWZmcKsk8IZ/+SjhU/yAP5tvX6oZiodBlWz2livl5Kjma8204ZPEb
         EyxBRzhDqTzo65FthvKiqj3+vbKNzEYTYxRoop5a8r+QIENcwNZzUUNTCsxJxSwt8D8e
         NFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ej8B142hK6d03XKUGaQLuYVY6IpXZx2RmTPiqw40xi0=;
        b=iguuVwe+W5OS8PIN7NLUZnQ4cIY3I16B3pVGlsDt/wZ/q7yq0XP5FjN+a1dE4v7TgO
         55GeS/eo7KhrwkSEO9ntp7/cpJnRTjZuv2YmV9N1DFTfy2bOFRR/rRfrDe2imPz3S3XX
         5Lm9YQnHk+Egh/R/T7GEcKpKXoGMJVUhpK8Xkt1o/ze94JJEl61igCXfjTDzYjsSgStM
         Ez+H28Or7qXr5O04kL3qv4g4Yu/tzHGZ3uzizFMgVPsPbkPsUU3+v0Xve5sFoAWatFgS
         OrWk4gBKUsYpqi/3PiU45G+xS4cBwuR2OALIsTeVhBzYdVNmYzw724Di9oQiuMe5fLOD
         xNHw==
X-Gm-Message-State: APjAAAUHs3EuhESWMSGHtFZeoAJf3ijOf9z6UEcIvFKwga2tEwX8lg01
        18YDDWMqj1/XP14e2yECUFek
X-Google-Smtp-Source: APXvYqyDYXDc7Cp++dLoN78c2Zxn8cmXxMVZpwreIbgMQ5jl2bGcMqKD3B+kSHCDsAWtxtHmrJFrKQ==
X-Received: by 2002:a05:6a00:51:: with SMTP id i17mr11035059pfk.8.1571928199878;
        Thu, 24 Oct 2019 07:43:19 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:997:a0de:81a:ea25:468a:5918])
        by smtp.gmail.com with ESMTPSA id 193sm29059810pfc.59.2019.10.24.07.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 07:43:19 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        darshak.patel@einfochips.com, prajose.john@einfochips.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 3/3] mtd: spi-nor: Add support for w25q256jw
Date:   Thu, 24 Oct 2019 20:12:35 +0530
Message-Id: <20191024144235.3182-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024144235.3182-1-manivannan.sadhasivam@linaro.org>
References: <20191024144235.3182-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MTD support for w25q256jw SPI NOR chip from Winbond. This chip
supports dual/quad I/O mode with 512 blocks of memory organized in
4KB sectors. The device has been validated using Thor96 board.

Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Darshak Patel <darshak.patel@einfochips.com>
[Mani: cleaned up for upstream]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/mtd/spi-nor/spi-nor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 1d8621d43160..2c25b371d9f0 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2482,6 +2482,8 @@ static const struct flash_info spi_nor_ids[] = {
 	{ "w25q256", INFO(0xef4019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "w25q256jvm", INFO(0xef7019, 0, 64 * 1024, 512,
 			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "w25q256jw", INFO(0xef6019, 0, 64 * 1024, 512,
+			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024,
 			SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
 
-- 
2.17.1

