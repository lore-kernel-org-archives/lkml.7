Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41919C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184E62067B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947635;
	bh=eux4fIGlT+5peVgOwVIJoXwTvuLrYXt5ySKlTBOOM2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EhS+77wUZa9PA8000K5n5ZrinL9HMBe2O6U7IPawkWA+zZwGoCZ4TvhtcX4gQ9smw
	 cAvVoEUN1Ewzsjd+wyzt1ZJUIBdcNtE5UQGsOOvtiXr6a6oWy4ObXRp0ZBFh6ehJTG
	 rHDAKGv7DxwPfC3LNSIv9wrFNHP/dK8Cw8eXCYWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfIHNAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 09:00:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729797AbfIHMo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:44:27 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD5B121920;
        Sun,  8 Sep 2019 12:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946667;
        bh=eux4fIGlT+5peVgOwVIJoXwTvuLrYXt5ySKlTBOOM2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yt11jyTCjYF1AqEsqaa5uQ4TtzFpFE0wDtOq0HqLIanxXoCwYuQofvS24smqwG2yl
         MsnxrEzx2np6Xq6/9FG79YU2vMB/xvvimLpfqkS3BsS+VpHTSHYkV6wX6qdLLnrba3
         ABzMjak4xiPx9YUP4o+jLkWFqvMpi2oJdb7nD4dQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hubert Denkmair <h.denkmair@intence.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 21/26] spi: bcm2835aux: fix corruptions for longer spi transfers
Date:   Sun,  8 Sep 2019 13:42:00 +0100
Message-Id: <20190908121110.075802835@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121057.216802689@linuxfoundation.org>
References: <20190908121057.216802689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 73b114ee7db1750c0b535199fae383b109bd61d0 ]

On long running tests with a mcp2517fd can controller it showed that
on rare occations the data read shows corruptions for longer spi transfers.

Example of a 22 byte transfer:

expected (as captured on logic analyzer):
FF FF 78 00 00 00 08 06 00 00 91 20 77 56 84 85 86 87 88 89 8a 8b

read by the driver:
FF FF 78 00 00 00 08 06 00 00 91 20 77 56 84 88 89 8a 00 00 8b 9b

To fix this use BCM2835_AUX_SPI_STAT_RX_LVL to determine when we may
read data from the fifo reliably without any corruption.

Surprisingly the only values ever empirically read in
BCM2835_AUX_SPI_STAT_RX_LVL are 0x00, 0x10, 0x20 and 0x30.
So whenever the mask is not 0 we can read from the fifo in a safe manner.

The patch has now been tested intensively and we are no longer
able to reproduce the "RX" issue any longer.

Fixes: 1ea29b39f4c812ec ("spi: bcm2835aux: add bcm2835 auxiliary spi device...")
Reported-by: Hubert Denkmair <h.denkmair@intence.de>
Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-bcm2835aux.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 4454d9c6a3dd4..5c89bbb05441b 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -180,12 +180,12 @@ static void bcm2835aux_spi_reset_hw(struct bcm2835aux_spi *bs)
 
 static void bcm2835aux_spi_transfer_helper(struct bcm2835aux_spi *bs)
 {
+	u32 stat = bcm2835aux_rd(bs, BCM2835_AUX_SPI_STAT);
+
 	/* check if we have data to read */
-	while (bs->rx_len &&
-	       (!(bcm2835aux_rd(bs, BCM2835_AUX_SPI_STAT) &
-		  BCM2835_AUX_SPI_STAT_RX_EMPTY))) {
+	for (; bs->rx_len && (stat & BCM2835_AUX_SPI_STAT_RX_LVL);
+	     stat = bcm2835aux_rd(bs, BCM2835_AUX_SPI_STAT))
 		bcm2835aux_rd_fifo(bs);
-	}
 
 	/* check if we have data to write */
 	while (bs->tx_len &&
-- 
2.20.1



