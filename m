Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5656AC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C8A218FF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="p3Co2cbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfDOVa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:30:56 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9361 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbfDOVaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 17:30:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb4f80b0003>; Mon, 15 Apr 2019 14:30:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Apr 2019 14:30:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Apr 2019 14:30:54 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 21:30:54 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 15 Apr 2019 21:30:54 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.167.253]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cb4f80c0000>; Mon, 15 Apr 2019 14:30:53 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V3 5/9] spi: export spi core function spi_set_cs
Date:   Mon, 15 Apr 2019 14:30:30 -0700
Message-ID: <1555363834-32155-6-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
References: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555363851; bh=WRtJfiWmOEYhx64jh6qAJX+kcmk+2aZRa6tkyoRkzLY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=p3Co2cboMlrBo1i7WnyEaIwkL/oQZNy4yVfXzfvtq7pt+4yQ02GLbe39W41Ewg/tu
         x0UDmJNyV1A5WpIXvlabeHfHOr1xkY8AW376AxWJ6FkRBcd7rbkIZdn3kCA/3Nbsf4
         z5R/Bq80Y6VSisR/O60huYi3oEmsBTzFWVJg/XqqfD5gT6yJ4AAZzCmzlfY0dSIOEd
         M9bToEfc+LEpb89ZqbsZrECHhWHfLXuldR4aVArOtkPjV4KyBaj+UyWbOUj6whmHlF
         prDqpIRPlF1n86aVazfWfNWXuItiuIxl28jkFopzF2hVrGtBd2+7U33oZPJjiJopTp
         SHxP58AkEikpA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch exports spi_set_cs of the spi core to allow SPI masters
to use when gpio based chip select is needed.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi.c       | 3 ++-
 include/linux/spi/spi.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 59b1e57cae74..fa70e595f17a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -773,7 +773,7 @@ int spi_register_board_info(struct spi_board_info const *info, unsigned n)
 
 /*-------------------------------------------------------------------------*/
 
-static void spi_set_cs(struct spi_device *spi, bool enable)
+void spi_set_cs(struct spi_device *spi, bool enable)
 {
 	if (spi->mode & SPI_CS_HIGH)
 		enable = !enable;
@@ -801,6 +801,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
 		spi->controller->set_cs(spi, !enable);
 	}
 }
+EXPORT_SYMBOL_GPL(spi_set_cs);
 
 #ifdef CONFIG_HAS_DMA
 int spi_map_buf(struct spi_controller *ctlr, struct device *dev,
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index fc4d21b4c2e4..c7ca95f26725 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -973,6 +973,7 @@ extern int spi_async(struct spi_device *spi, struct spi_message *message);
 extern int spi_async_locked(struct spi_device *spi,
 			    struct spi_message *message);
 extern int spi_slave_abort(struct spi_device *spi);
+extern void spi_set_cs(struct spi_device *spi, bool enable);
 
 static inline size_t
 spi_max_message_size(struct spi_device *spi)
-- 
2.7.4

