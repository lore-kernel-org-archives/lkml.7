Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF8EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4E32054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258003;
	bh=LVmzGzdXQDF+iI2tiem7wO2p8OtOfqosvOv3ISN6Df8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PLbg+7LL+uhbs3v9jHcLha8PyZxWhdrhr3cIswFV0YxvfzUaksYXnw2I01e6z7LuP
	 zH19Kp9M8zMtL2chmm/aRfO9fTnvkaHIqriqoadq+7560IQUQ46ovH4na2ZrFJ+ezr
	 fOxcJWAMZmLGNCwBZu+JDDrNBbUpmbQstIgss3GE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389895AbfCVMdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:33:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389976AbfCVMOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:14:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE0E62082C;
        Fri, 22 Mar 2019 12:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256889;
        bh=LVmzGzdXQDF+iI2tiem7wO2p8OtOfqosvOv3ISN6Df8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g69ENPZLGEq71MqbyWLmeD+0UXiYDiuuwBZzI3e4TEfRaolMElreFTSJacpRmtk6k
         aSIUYKeJ7UlK5Ydh2959pfMcrDI+bvOAkvIFhrDwZ/B7wIBr7IfBjt+HGkyhB2Kl9h
         2nojGuN2JU9+N3UeBDdUNAHjisjecUz9Dp26veR4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.0 068/238] spi: spi-gpio: fix SPI_CS_HIGH capability
Date:   Fri, 22 Mar 2019 12:14:47 +0100
Message-Id: <20190322111302.635574528@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>

commit b89fefda7d4e3a649129584d855be233c7465264 upstream.

spi-gpio is capable of dealing with active-high chip-selects.
Unfortunately, commit 4b859db2c606 ("spi: spi-gpio: add SPI_3WIRE
support") broke this by setting master->mode_bits, which overrides
the setting in the spi-bitbang code.  Fix this.

[Fixed a trivial conflict with SPI_3WIRE_HIZ support -- broonie]

Fixes: 4b859db2c606 ("spi: spi-gpio: add SPI_3WIRE support")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-gpio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -428,7 +428,8 @@ static int spi_gpio_probe(struct platfor
 		return status;
 
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
-	master->mode_bits = SPI_3WIRE | SPI_3WIRE_HIZ | SPI_CPHA | SPI_CPOL;
+	master->mode_bits = SPI_3WIRE | SPI_3WIRE_HIZ | SPI_CPHA | SPI_CPOL |
+			    SPI_CS_HIGH;
 	master->flags = master_flags;
 	master->bus_num = pdev->id;
 	/* The master needs to think there is a chipselect even if not connected */
@@ -455,7 +456,6 @@ static int spi_gpio_probe(struct platfor
 		spi_gpio->bitbang.txrx_word[SPI_MODE_3] = spi_gpio_spec_txrx_word_mode3;
 	}
 	spi_gpio->bitbang.setup_transfer = spi_bitbang_setup_transfer;
-	spi_gpio->bitbang.flags = SPI_CS_HIGH;
 
 	status = spi_bitbang_start(&spi_gpio->bitbang);
 	if (status)


