Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDE2C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F70212F5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563199826;
	bh=hWwjP+rKG/WpmEczv6N7q5Qr9DUTij0C+wlSV0YM0aE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u+kB06lKnempfxI8jWC+HMZuOnrHV4ikE2/eVH7ewHzRunoKSnlvkAmsxr6PJI2Mq
	 cwyWH7c5mk/HJz+VCC3aYSnwGRlrbOtXUlEJNGvEMcQZ1Kq88x2cAs8je0ZxTvSNNk
	 3CNqnB7EEb29rxOXra0lbU8kcy1czXhpI/xki34g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388614AbfGOOKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388603AbfGOOKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:10:20 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEE602083D;
        Mon, 15 Jul 2019 14:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199819;
        bh=hWwjP+rKG/WpmEczv6N7q5Qr9DUTij0C+wlSV0YM0aE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vllRiBLvUd0PTlr3QKj8iRr+JnM1dtTE2NbN1MDOT8giUCYUcaRbR2H9tkWP7MJ6n
         xmdaYWTId9Blw0i6IqtEMBFhjksVBYCYHhZLog8WZoFNBRli8yE8GL7y5efVxzlTaW
         l2zq2yYaybHyfavuSadkXIRYvgbuWi4UkRd9BwS4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 115/219] spi: fix ctrl->num_chipselect constraint
Date:   Mon, 15 Jul 2019 10:01:56 -0400
Message-Id: <20190715140341.6443-115-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

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
index a83fcddf1dad..7f6fb383d7a7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2281,11 +2281,6 @@ int spi_register_controller(struct spi_controller *ctlr)
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
@@ -2356,6 +2351,13 @@ int spi_register_controller(struct spi_controller *ctlr)
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

