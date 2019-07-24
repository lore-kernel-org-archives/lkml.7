Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49368C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCDF218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563996654;
	bh=UYhVJVotaj7fsqpZY+NOnNwcCkeqGoDS+hWkdm5bLjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J/IpVE1ZW+XoK94uxQwDGGC+sDZJ4Kme7LiQJSN+7Qj99hGHVvW4oDWGN3xK54L+v
	 2OdTs8pec3ZWz+n0rYIuxTlBlTChDdjOFNcvVcSwxSXOHknIrNvD1UK0TgCubuZbJy
	 fxNUpNOY/ET+MwQWAgvnf6jUTZ8zaenxpkXu2u3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388428AbfGXTax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:30:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388007AbfGXTas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:30:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7844E229F3;
        Wed, 24 Jul 2019 19:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996648;
        bh=UYhVJVotaj7fsqpZY+NOnNwcCkeqGoDS+hWkdm5bLjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oDxROgpGrxEAzJcL2CgHkghbcuHeuuPqk2ddq9ElA8PYjCH/45q6k9grg3AlqpcVJ
         pmZHouCqjHYMGqHUDKegtwyrQxKQnz10WhCt/KuNWlXxcSiKxLuQ8T3iOQK6pQQM4z
         5o9JRflDxbnmLiSWJQJ+P9uBuYnCWVKtc8mzCagk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 128/413] spi: fix ctrl->num_chipselect constraint
Date:   Wed, 24 Jul 2019 21:16:59 +0200
Message-Id: <20190724191744.262506567@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f9481b08220d7dc1ff21e296a330ee8b721b44e4 ]

at91sam9g25ek showed the following error at probe:
atmel_spi f0000000.spi: Using dma0chan2 (tx) and dma0chan3 (rx)
for DMA transfers
atmel_spi: probe of f0000000.spi failed with error -22

Commit 0a919ae49223 ("spi: Don't call spi_get_gpio_descs() before device name is set")
moved the calling of spi_get_gpio_descs() after ctrl->dev is set,
but didn't move the !ctrl->num_chipselect check. When there are
chip selects in the device tree, the spi-atmel driver lets the
SPI core discover them when registering the SPI master.
The ctrl->num_chipselect is thus expected to be set by
spi_get_gpio_descs().

Move the !ctlr->num_chipselect after spi_get_gpio_descs() as it was
before the aforementioned commit. While touching this block, get rid
of the explicit comparison with 0 and update the commenting style.

Fixes: 0a919ae49223 ("spi: Don't call spi_get_gpio_descs() before device name is set")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5e4654032bfa..29916e446143 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2286,11 +2286,6 @@ int spi_register_controller(struct spi_controller *ctlr)
 	if (status)
 		return status;
 
-	/* even if it's just one always-selected device, there must
-	 * be at least one chipselect
-	 */
-	if (ctlr->num_chipselect == 0)
-		return -EINVAL;
 	if (ctlr->bus_num >= 0) {
 		/* devices with a fixed bus num must check-in with the num */
 		mutex_lock(&board_lock);
@@ -2361,6 +2356,13 @@ int spi_register_controller(struct spi_controller *ctlr)
 		}
 	}
 
+	/*
+	 * Even if it's just one always-selected device, there must
+	 * be at least one chipselect.
+	 */
+	if (!ctlr->num_chipselect)
+		return -EINVAL;
+
 	status = device_add(&ctlr->dev);
 	if (status < 0) {
 		/* free bus id */
-- 
2.20.1



