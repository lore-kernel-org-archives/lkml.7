Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EC3C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA3C208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576079852;
	bh=XbKuNasBmPbrtd60IDb/eU5UqdPMSal8akdyx3GHlvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cfIuVlrJx7TSVvbiZo6wNuvhW8jxLIscXZKugSHXw9ydIDcCXc6As0vsBEBWqTC1k
	 WnQf4XkFsGWXRpoMWGuTAr1AJm/s2mVUZtVih/aG4iQWU03zaCK3iWA/+2AmASreei
	 8LhNT8X5oa/yeJSY+uZyzw5geNmMjJJ0/M0lR2xo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731887AbfLKP5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:57:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:40932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731719AbfLKPPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:15:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE14620663;
        Wed, 11 Dec 2019 15:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077305;
        bh=XbKuNasBmPbrtd60IDb/eU5UqdPMSal8akdyx3GHlvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nM3wAg5CH/94xw61jxSXViSD550Opx848pr9YSzIyzlriezp5Ts9ZGatEZoLrE28s
         Nre6xv3BDw7Y2i0KGvOCatI+9wUsCnvZixzRMVtfFeuaCpcvUTfScneg8dSlre6SUM
         4KGCWX4V8QVnMVLiqDfEg6vvbwnmlq1kNz2TIp2g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.3 095/105] spi: atmel: Fix CS high support
Date:   Wed, 11 Dec 2019 16:06:24 +0100
Message-Id: <20191211150302.100629315@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150221.153659747@linuxfoundation.org>
References: <20191211150221.153659747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gregory CLEMENT <gregory.clement@bootlin.com>

commit 7cbb16b2122c09f2ae393a1542fed628505b9da6 upstream.

Until a few years ago, this driver was only used with CS GPIO. The
only exception is CS0 on AT91RM9200 which has to use internal CS. A
limitation of the internal CS is that they don't support CS High.

So by using the CS GPIO the CS high configuration was available except
for the particular case CS0 on RM9200.

When the support for the internal chip-select was added, the check of
the CS high support was not updated. Due to this the driver accepts
this configuration for all the SPI controller v2 (used by all SoCs
excepting the AT91RM9200) whereas the hardware doesn't support it for
infernal CS.

This patch fixes the test to match the hardware capabilities.

Fixes: 4820303480a1 ("spi: atmel: add support for the internal chip-select of the spi controller")
Cc: <stable@vger.kernel.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Link: https://lore.kernel.org/r/20191017141846.7523-3-gregory.clement@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-atmel.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1182,10 +1182,8 @@ static int atmel_spi_setup(struct spi_de
 	as = spi_master_get_devdata(spi->master);
 
 	/* see notes above re chipselect */
-	if (!atmel_spi_is_v2(as)
-			&& spi->chip_select == 0
-			&& (spi->mode & SPI_CS_HIGH)) {
-		dev_dbg(&spi->dev, "setup: can't be active-high\n");
+	if (!as->use_cs_gpios && (spi->mode & SPI_CS_HIGH)) {
+		dev_warn(&spi->dev, "setup: non GPIO CS can't be active-high\n");
 		return -EINVAL;
 	}
 


