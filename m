Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76C8C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 23:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85AE8215E5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 23:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0nOoIYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfK2XlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 18:41:22 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35511 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbfK2XlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 18:41:21 -0500
Received: by mail-yb1-f194.google.com with SMTP id h23so12141521ybg.2;
        Fri, 29 Nov 2019 15:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w6aGDbK+jDFr0DNlFhH0AkU2TMmVEMp+XdVndgg8nhk=;
        b=G0nOoIYuH7iygIW+7m+vw7OcTTjb5hGom+lsRcfPKrKhwAJs7W/AE+X8QxKmSh8CuQ
         7hzaKYmDfS7/arV+t+Elnz/1gcRBK890ztf6ONeWYC26ltGQXq4ElN2oNkq+yA/vwNAe
         aCUcTHWWDHB3NYqgs4Z3/LkY5k7OMhTnqcPwS77RbsWz9Dxbqz+tXs6XC+U0LptnRGiG
         ULmTdkWAiFVzFMI+0RmDSoLqJWKeHvE9dK2rYQhZua1xvVZyxCwpIFuNgiHN8QpXJNNL
         TvpDOQwltEWohEIyZOwduTHcL9Zr2FNpRm7YCn6C5ewkj8ybQHZ4xoEkb9DSJRX+8vWH
         q0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w6aGDbK+jDFr0DNlFhH0AkU2TMmVEMp+XdVndgg8nhk=;
        b=LMJk3Mj1/2kbXP/XJy9IbljqYuSZy+YUZ+QrrsgpBbbjj7kZu8ZnYM1HTjMVLnxhFu
         iSgIBIBhLoatnHLqLBmCaNNLUe/+za5FT4YSYgp7ETdY78BbhPlcj/8ihppXWDmyOSSh
         /Yyiu8rZR87aRDlI4362ETTdeW3O1HRnMEjEB12syRDHiBMRrn00rz+VOZWR1hCkEykS
         H02m76PerGSibMZIcuY/SqtownX3226dLCLf80S/pCvtYrf3LbYYGQ3JypyXAo9pkgC9
         795nLoWdV8G1mDiPpoA38bXbMCR1587rNXljYwHNWRhwTGnXOcAVdUYdaZPTR1pTWl+q
         /09w==
X-Gm-Message-State: APjAAAUKuhYmfbhHQqGU4e9l3P1ACmaew4/P986YGmEmuA/eek0Nylqp
        N9eOIWBdiJuEEJm3zZXP4TQ=
X-Google-Smtp-Source: APXvYqwSwVvflrmSiTOxPwXtUrgWDNSNsJzEGcrVvMwdUZsPvrXCqY4vNZ9+/VEarJY8JTpntrv8MA==
X-Received: by 2002:a25:5903:: with SMTP id n3mr42708691ybb.466.1575070879029;
        Fri, 29 Nov 2019 15:41:19 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id q131sm10636436ywh.22.2019.11.29.15.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 15:41:18 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Adam Ford <aford173@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] soc: imx: gpcv2: Add support for imx8mm
Date:   Fri, 29 Nov 2019 17:41:07 -0600
Message-Id: <20191129234108.12732-1-aford173@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The technical reference manual for both the i.MX8MQ and i.MX8M Mini
appear to show the same register definitions and locations for the
General Power Controller (GPC).

This patch expands the table of compatible SoC's to include
the i.MX8m Mini

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index b0dffb06c05d..67c54cbb6c81 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -641,6 +641,7 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 static const struct of_device_id imx_gpcv2_dt_ids[] = {
 	{ .compatible = "fsl,imx7d-gpc", .data = &imx7_pgc_domain_data, },
 	{ .compatible = "fsl,imx8mq-gpc", .data = &imx8m_pgc_domain_data, },
+	{ .compatible = "fsl,imx8mm-gpc", .data = &imx8m_pgc_domain_data, },
 	{ }
 };
 
-- 
2.20.1

