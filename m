Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCD5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA6B2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MbpooTTu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733252AbfC0F5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:57:37 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7007 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733184AbfC0F5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:57:30 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9b10c40000>; Tue, 26 Mar 2019 22:57:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 Mar 2019 22:57:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 Mar 2019 22:57:29 -0700
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:29 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 Mar 2019 05:57:29 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.161.83]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c9b10c70001>; Tue, 26 Mar 2019 22:57:28 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V1 16/26] spi: tegra114: set bus number based on id
Date:   Tue, 26 Mar 2019 22:56:37 -0700
Message-ID: <1553666207-11414-16-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553666244; bh=wwyBPb+L2vkj/16eV8z6d34NZ+I/fcKs3EMH2g9KMdk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=MbpooTTu+lKG7kM8A8l9OqhM+LE8l+QJeMaAC1a23iZexMl6zI1g6U+4D4w3pzfa8
         lEmHgSqHVj9dMbOTqMD93wrDpFG5i2sE3hVkJY2ogY837vaZM0ukbx+hHS4+flIFc7
         j4Py5G8eAI8/1AYc49wuBmX4EtCQGaKkAhWRnFfkcZVzyyFU+p/ZoE6/PjCRMWPl6a
         mOK+uXRQw4RNZsSt3SD8jvNV5UJpws4Vineela3IFRNAZYs28nynQt8p7nK8tz9XmS
         q3XIpX+qU7rVHxJC1FRFCuNUIqcIUtPfA8Tj9MFC9JljrwNjZNbZhinc/8j2Zi7Zvj
         9aXQ024gHG+9Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch sets the SPI device id from the device tree as the
bus number.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 94acef0f5ea5..9b9d4b9e1f3e 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1138,6 +1138,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	struct tegra_spi_data	*tspi;
 	struct resource		*r;
 	int ret, spi_irq;
+	int bus_num;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*tspi));
 	if (!master) {
@@ -1159,6 +1160,9 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	master->transfer_one_message = tegra_spi_transfer_one_message;
 	master->num_chipselect = MAX_CHIP_SELECT;
 	master->auto_runtime_pm = true;
+	bus_num = of_alias_get_id(pdev->dev.of_node, "spi");
+	if (bus_num >= 0)
+		master->bus_num = bus_num;
 
 	tspi->master = master;
 	tspi->dev = &pdev->dev;
-- 
2.7.4

