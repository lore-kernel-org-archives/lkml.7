Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451D4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12EB62070D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FcqSXsxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387522AbfC0F6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:58:40 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17613 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732949AbfC0F50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:57:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9b10c90000>; Tue, 26 Mar 2019 22:57:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 Mar 2019 22:57:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 Mar 2019 22:57:25 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:25 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:25 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 Mar 2019 05:57:25 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.161.83]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c9b10c30000>; Tue, 26 Mar 2019 22:57:24 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V1 14/26] spi: tegra114: add 3 wire transfer mode support
Date:   Tue, 26 Mar 2019 22:56:35 -0700
Message-ID: <1553666207-11414-14-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553666249; bh=dqiaYl9e3e2zWmKkKdtYcyIMQJtt/a5spEADASNXdDQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=FcqSXsxh41eoJ+7DDjQp17apzKFbNHw2Z9svxwaygDOCnpdnTEf3Bc+NRqE6VRTrq
         uzEPyhfZGFOdELP8D319CpFeqdCuP9q7eS8MV2m2ZSbuz3RpA68n0jADYqTLmZAAOW
         Twggz3mimHDmVzawpRkzHbqNxfMY9iO62hl7JYNqMstqwwaT/63m0smorBJK62evGs
         QLnNq97CWVhB4QcHlVt0jLYS/9ObDo2+6sBKnCJcfu/peGeOc+Bu8MAf9UAf0Dcs36
         3Dus0U21CQVp6zPw0lY594CHRH6ugWlcNr6EnGHoyJD0Rcr4QzhXEVWAkpq1x4CbbG
         XvG76s92kInXQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds 3 wire transfer support to SPI mode list and also
implements it.

3 wire or Bi-directional mode uses only one serial data pin for
the transfer. SPI in master mode uses MOSI data line only and MISO
data line is not used by the SPI.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 335c594d5b74..01efb615a196 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -755,6 +755,11 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		else
 			command1 &= ~SPI_LSBIT_FE;
 
+		if (spi->mode & SPI_3WIRE)
+			command1 |= SPI_BIDIROE;
+		else
+			command1 &= ~SPI_BIDIROE;
+
 		if (tspi->cs_control) {
 			if (tspi->cs_control != spi)
 				tegra_spi_writel(tspi, command1, SPI_COMMAND1);
@@ -1148,7 +1153,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
-			    SPI_TX_DUAL | SPI_RX_DUAL;
+			    SPI_TX_DUAL | SPI_RX_DUAL | SPI_3WIRE;
 	master->setup = tegra_spi_setup;
 	master->transfer_one_message = tegra_spi_transfer_one_message;
 	master->num_chipselect = MAX_CHIP_SELECT;
-- 
2.7.4

