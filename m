Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C9DC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268B82086D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 13:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565358518;
	bh=9I+jFTe4CVg4SBn5kIG4JbU+BfzvJ6nCCHzgfhtmeII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wf96Q1IG1EP7fTs6V+WN+cjZLGzFIMBK1WLsqZxAgcNEcPmdtWMUVifzgMvgsJqeq
	 Cw80b0bp9a2jSDaOGsD8zMtUVYM9F7MVbncc+kYW+6/ZjjjFT06I5ZMBhTZb6Y6/wa
	 YJFLfrYWsEr2BssiO6TEKO8DQDI5K9ogNc5TPByA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407320AbfHINsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 09:48:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407254AbfHINr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 09:47:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C7A72086D;
        Fri,  9 Aug 2019 13:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565358448;
        bh=9I+jFTe4CVg4SBn5kIG4JbU+BfzvJ6nCCHzgfhtmeII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yek1Y90zATwVsSSv58GiD7fAcmOepLO67y8iotRaNAzI2gjs0GtgtJP7U4UoJAATv
         JduTGwM+jAjdFdglSsQrEzCXfKjN6l7C+C4b09r1rI9/vcz9C3eZO26d5VNK047DWK
         1lF6552bIBBFbIICfd2ixbVoU6MArSxqEDVBvzz0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Lukas Wunner <lukas@wunner.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.9 27/32] spi: bcm2835: Fix 3-wire mode if DMA is enabled
Date:   Fri,  9 Aug 2019 15:45:30 +0200
Message-Id: <20190809133923.804420993@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190809133922.945349906@linuxfoundation.org>
References: <20190809133922.945349906@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

commit 8d8bef50365847134b51c1ec46786bc2873e4e47 upstream.

Commit 6935224da248 ("spi: bcm2835: enable support of 3-wire mode")
added 3-wire support to the BCM2835 SPI driver by setting the REN bit
(Read Enable) in the CS register when receiving data.  The REN bit puts
the transmitter in high-impedance state.  The driver recognizes that
data is to be received by checking whether the rx_buf of a transfer is
non-NULL.

Commit 3ecd37edaa2a ("spi: bcm2835: enable dma modes for transfers
meeting certain conditions") subsequently broke 3-wire support because
it set the SPI_MASTER_MUST_RX flag which causes spi_map_msg() to replace
rx_buf with a dummy buffer if it is NULL.  As a result, rx_buf is
*always* non-NULL if DMA is enabled.

Reinstate 3-wire support by not only checking whether rx_buf is non-NULL,
but also checking that it is not the dummy buffer.

Fixes: 3ecd37edaa2a ("spi: bcm2835: enable dma modes for transfers meeting certain conditions")
Reported-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v4.2+
Cc: Martin Sperl <kernel@martin.sperl.org>
Acked-by: Stefan Wahren <wahrenst@gmx.net>
Link: https://lore.kernel.org/r/328318841455e505370ef8ecad97b646c033dc8a.1562148527.git.lukas@wunner.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-bcm2835.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -554,7 +554,8 @@ static int bcm2835_spi_transfer_one(stru
 	bcm2835_wr(bs, BCM2835_SPI_CLK, cdiv);
 
 	/* handle all the 3-wire mode */
-	if ((spi->mode & SPI_3WIRE) && (tfr->rx_buf))
+	if (spi->mode & SPI_3WIRE && tfr->rx_buf &&
+	    tfr->rx_buf != master->dummy_rx)
 		cs |= BCM2835_SPI_CS_REN;
 	else
 		cs &= ~BCM2835_SPI_CS_REN;


