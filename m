Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B520C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD1F22522
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577468474;
	bh=UqWDGdnGYn8PIGKucH4/pdEz+x9a832aJ9USi9sauLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qBXp8HbBPa/oEwOJOSb9ft8Q0DlhSUzJlvIKN9voOIeUToRMe3MywwHe+SizXc11E
	 3U/GTfifRoAFWlLdL0+v+T+1NNh7ffr6/9dGx45e3B+5spupmAB4VXQJ27K7BKUSaf
	 1XgZNbfrTHwe0Yzd8XxsghKyOAceeH29Z0xm27Zo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfL0RlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:41:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:37106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbfL0RlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:41:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B67832173E;
        Fri, 27 Dec 2019 17:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468467;
        bh=UqWDGdnGYn8PIGKucH4/pdEz+x9a832aJ9USi9sauLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CUO4jwnIvGXOoYpSWo0N+na9MfEUJr8sPvM9Bw4pMOxviMKKffVkn1cRsfzEV67ml
         GQI6enYZQzD3uftOfdtC2P+nXL5LoKevm0K0ROPuKzMGg5Bf2fDkVEVYQyIdDF6QBy
         c3+CnhjC58BahNv5n2exxLMQwS7uOUF0YyJgOxk4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 009/187] spi: dw: Correct handling of native chipselect
Date:   Fri, 27 Dec 2019 12:37:57 -0500
Message-Id: <20191227174055.4923-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174055.4923-1-sashal@kernel.org>
References: <20191227174055.4923-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit ada9e3fcc175db4538f5b5e05abf5dedf626e550 ]

This patch reverts commit 6e0a32d6f376 ("spi: dw: Fix default polarity
of native chipselect").

The SPI framework always called the set_cs callback with the logic
level it desired on the chip select line, which is what the drivers
original handling supported. commit f3186dd87669 ("spi: Optionally
use GPIO descriptors for CS GPIOs") changed these symantics, but only
in the case of drivers that also support GPIO chip selects, to true
meaning apply slave select rather than logic high. This left things in
an odd state where a driver that only supports hardware chip selects,
the core would handle polarity but if the driver supported GPIOs as
well the driver should handle polarity.  At this point the reverted
change was applied to change the logic in the driver to match new
system.

This was then broken by commit 3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH
setting when using native and GPIO CS") which reverted the core back
to consistently calling set_cs with a logic level.

This fix reverts the driver code back to its original state to match
the current core code. This is probably a better fix as a) the set_cs
callback is always called with consistent symantics and b) the
inversion for SPI_CS_HIGH can be handled in the core and doesn't need
to be coded in each driver supporting it.

Fixes: 3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH setting when using native and GPIO CS")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20191127153936.29719-1-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-dw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 9a49e073e8b7..b47a9eb23ef8 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -129,10 +129,11 @@ void dw_spi_set_cs(struct spi_device *spi, bool enable)
 	struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
 	struct chip_data *chip = spi_get_ctldata(spi);
 
+	/* Chip select logic is inverted from spi_set_cs() */
 	if (chip && chip->cs_control)
-		chip->cs_control(enable);
+		chip->cs_control(!enable);
 
-	if (enable)
+	if (!enable)
 		dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
 	else if (dws->cs_override)
 		dw_writel(dws, DW_SPI_SER, 0);
-- 
2.20.1

