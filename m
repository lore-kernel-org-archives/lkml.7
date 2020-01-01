Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E33C2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 16:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791822080A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 16:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HTgpjlTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgAAQbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 11:31:42 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55251 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbgAAQbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 11:31:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id b19so3769637wmj.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 08:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gYZKhe3uyN0VpRDDzaRxilm8f5Lw+XJVpBkexHfk67g=;
        b=HTgpjlTEb7MsRiJ+qHdkhSPVvdCn6qLEjnqyz4BdrafRQwVHY+GaYYyU+kOLy3NTOR
         BIwpcedApB+WNiOwqXDqHUHSzfOVDlqbpSK+lmUIZkhr7TW87OiUaISAhQGwHVY3s8rI
         jp0cCO/s5+0VXfeBr8W6ZnGPucqnqJsNXB7OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gYZKhe3uyN0VpRDDzaRxilm8f5Lw+XJVpBkexHfk67g=;
        b=Q3Ymvvt2eeO8eFQBiTXXgbmIFQ06LN6VWqcECyDCBHK3fXvAuOsVfLc0SpBQhZxwiX
         BmHcw/e/axByx+Y7m/ZDtRFsFrvOAcuwp1o2AZ08kfDoJEkP/dAHSaPdu3AagZc/Lyei
         ZBXYX/ta7kni5OGnr8Qv4ovpRoCC7A10fNyqc6Pc+/hPSOLnL0ehrx8gWMbSqS9zazi1
         ghQkOfp2vQORSK3WGVZ6uQ9KqMSTqytkTWstetOEJlyQujzlDYSL7YgVBzuuc0ol2jYz
         3q6eEAVckQqdBxapdE45c2pVLe/uLOQ7ih8EW074X5fysZz+CH4L723BAafpmcoYoWqW
         wnkw==
X-Gm-Message-State: APjAAAWYk0F3IrtLv/dFwqgK5PqNCLYXBaaIK4h3FV7t1zLTlxev1fK0
        A2pR8w0O9fsCH8TC2KhhISuZsQ==
X-Google-Smtp-Source: APXvYqxt5dEadYXCv/It36ubk7YpAZY/xQe4KFKf52CDIseKqJeFsEQbjh/Hb96WxX0BKATCEdzUDg==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr9904376wmk.124.1577896300553;
        Wed, 01 Jan 2020 08:31:40 -0800 (PST)
Received: from panicking.lan (93-46-124-24.ip107.fastwebnet.it. [93.46.124.24])
        by smtp.gmail.com with ESMTPSA id u13sm6108580wmd.36.2020.01.01.08.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 08:31:40 -0800 (PST)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-amarula@amarulasolutions.com
Subject: [PATCH 2/3] irqchip/irq-imx-gpcv2: Add IRQCHIP_DECLARE for i.MX8MM compatible
Date:   Wed,  1 Jan 2020 17:31:35 +0100
Message-Id: <20200101163136.1586-3-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200101163136.1586-1-michael@amarulasolutions.com>
References: <20200101163136.1586-1-michael@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPC node on i.MX8MM can not claim to be compatible with the i.MX8MQ
GPC, as the power gating part has some significant differences. Thus we
can not rely on the irqchip being probed with the old compatible.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/irqchip/irq-imx-gpcv2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index 4f74c15c4755..80855f15539c 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -196,6 +196,7 @@ static const struct irq_domain_ops gpcv2_irqchip_data_domain_ops = {
 static const struct of_device_id gpcv2_of_match[] = {
 	{ .compatible = "fsl,imx7d-gpc",  .data = (const void *) 2 },
 	{ .compatible = "fsl,imx8mq-gpc", .data = (const void *) 4 },
+	{ .compatible = "fsl,imx8mm-gpc", .data = (const void *) 4 },
 	{ /* END */ }
 };
 
@@ -290,3 +291,4 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 
 IRQCHIP_DECLARE(imx_gpcv2_imx7d, "fsl,imx7d-gpc", imx_gpcv2_irqchip_init);
 IRQCHIP_DECLARE(imx_gpcv2_imx8mq, "fsl,imx8mq-gpc", imx_gpcv2_irqchip_init);
+IRQCHIP_DECLARE(imx_gpcv2_imx8mm, "fsl,imx8mm-gpc", imx_gpcv2_irqchip_init);
-- 
2.17.1

