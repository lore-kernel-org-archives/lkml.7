Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C333DC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BEE521928
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567946623;
	bh=0G54NzqspS3ThXIbyo+flEPSStI+M8ELnHPxBup1xRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Rr8myuxl3DbZpZFvQC2NHm8pvK2GF06ehbqHBMjBwQK4P4dR7/Fw23LQ0arcrFap
	 7hN6ieYzz2zSM7tuK3nMb19/465vJhRAhErc+LfD3M1gvlhgkzYdBcwu/fRhtbedf/
	 OiNxxxX/3m2oo6s86jhgHkmyL/6I8srDH90UeYo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbfIHMnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:43:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729431AbfIHMni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:43:38 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BD3E218AE;
        Sun,  8 Sep 2019 12:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567946618;
        bh=0G54NzqspS3ThXIbyo+flEPSStI+M8ELnHPxBup1xRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w6tfei1czHgAxc28rDjd1Uc+e76ntsNQ+IEDjlir9ffSQqSywi/01XJPi6Go687nb
         c35eFKhYJ5w+18uwIABsdcg43XKl/EeOyFK7F4+2RRd3M2et2DzyYXGaYlXPfnw4m0
         yjsjW+0TKTEAUlPVScGPN6ulh2PLOXf5J1vxTFrg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hubert Denkmair <h.denkmair@intence.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 19/23] spi: bcm2835aux: remove dangerous uncontrolled read of fifo
Date:   Sun,  8 Sep 2019 13:41:54 +0100
Message-Id: <20190908121102.838776856@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121052.898169328@linuxfoundation.org>
References: <20190908121052.898169328@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c7de8500fd8ecbb544846dd5f11dca578c3777e1 ]

This read of the fifo is a potential candidate for a race condition
as the spi transfer is not necessarily finished and so can lead to
an early read of the fifo that still misses data.

So it has been removed.

Fixes: 1ea29b39f4c812ec ("spi: bcm2835aux: add bcm2835 auxiliary spi device...")
Suggested-by: Hubert Denkmair <h.denkmair@intence.de>
Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-bcm2835aux.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 5b2c2b2e13396..4d233356772aa 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -197,13 +197,6 @@ static void bcm2835aux_spi_transfer_helper(struct bcm2835aux_spi *bs)
 		  BCM2835_AUX_SPI_STAT_TX_FULL))) {
 		bcm2835aux_wr_fifo(bs);
 	}
-
-	/* and check if we have reached "done" */
-	while (bs->rx_len &&
-	       (!(bcm2835aux_rd(bs, BCM2835_AUX_SPI_STAT) &
-		  BCM2835_AUX_SPI_STAT_BUSY))) {
-		bcm2835aux_rd_fifo(bs);
-	}
 }
 
 static irqreturn_t bcm2835aux_spi_interrupt(int irq, void *dev_id)
-- 
2.20.1



