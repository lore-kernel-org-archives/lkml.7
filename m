Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF0EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4AE217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EnDfCBr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbfDEAP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:15:57 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7960 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730508AbfDEAO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 20:14:27 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca69dd80000>; Thu, 04 Apr 2019 17:14:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 04 Apr 2019 17:14:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 04 Apr 2019 17:14:27 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Apr
 2019 00:14:27 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 5 Apr 2019 00:14:27 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.48]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca69de20002>; Thu, 04 Apr 2019 17:14:26 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 07/20] spi: tegra114: set bus number based on id
Date:   Thu, 4 Apr 2019 17:14:06 -0700
Message-ID: <1554423259-26056-7-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554423256; bh=7kFmddCnnwdnrAeG+ZW/CtFTmup+QR8mSzFCa6z6xtE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=EnDfCBr78vOcRHdxMPmY/mlhx+ZDWOKOpbuf29ZwO9YX3NFmGwqdyoS19B5nf3fec
         pJ7AORgjXKix7Kbaqgv/97d8rcEgenykq1yxRiomJJa3b7BuidHX7njTie1R4j3Q2o
         1GpH9OQ/JIN92ko8lPG8NGmT8X5lhhyJHKhpd6Bc30HWEgFzfwMqBezvNt7fna+3jt
         34aGuUtB3qr964/fqgQ1RU5JBgEY8jrJtdJ/p3prP4/i3/7VojIalUd/QcQNXQp7lL
         8TIzY27hXYyQq81QM69sdkApdGfroOz1tkOf37lFTGKuUkYORzlVu8viDucmA3odm5
         XHfoPA1x1IZpA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch sets SPI device id from the device tree as the bus number.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 191233eae149..58f5059b339f 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1138,6 +1138,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	struct tegra_spi_data	*tspi;
 	struct resource		*r;
 	int ret, spi_irq;
+	int bus_num;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*tspi));
 	if (!master) {
@@ -1158,6 +1159,9 @@ static int tegra_spi_probe(struct platform_device *pdev)
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

