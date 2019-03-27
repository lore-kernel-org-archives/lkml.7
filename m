Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17F6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E5320693
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="axejtihW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732800AbfC0F5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:57:09 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6978 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfC0F5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:57:08 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9b10ac0004>; Tue, 26 Mar 2019 22:57:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 26 Mar 2019 22:57:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 26 Mar 2019 22:57:05 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:05 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:05 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 Mar 2019 05:57:05 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.161.83]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c9b10af0000>; Tue, 26 Mar 2019 22:57:04 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V1 03/26] spi: tegra114: fix for unpacked mode transfers
Date:   Tue, 26 Mar 2019 22:56:24 -0700
Message-ID: <1553666207-11414-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553666221; bh=BbVb8qftn7ikNLmb5ZIGDeTbmYh2XNlqSyxXW/Zu/c0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=axejtihWJbqmbiQ0LGd5Rtd7ZeSjDXpSfmJnajsJBjF4ZWNL/hqBRQcd6uS6MUiwF
         TCeQIVZfc/ve4VLXSSZiwBAfRN5Gu7zwgSEJsuyvC938rjhpI1f2jDTpmUUgdjXkxS
         HkULBVveETpJMV3easuid77NEPhN6Qfadw19/Pb2RVterxOP2KHDH0o1sb0Zo0R8lX
         15FYc0ZGg+wl1wY2WoboSgeSpCKRrYUkr9xDCUoTU9uV66lCriGeuVu1lId4jyzckR
         pzeQENAkzfrOkxa3S/AHi934W5YugGrtlO9nItX63rq4XuKXNiOWJE3I1/PPrvMA8f
         cpeCw37Pzln/w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: computation of actual bytes to fill/receive in/from FIFO in unpacked
mode when transfer length is not a multiple of requested bits per word.

unpacked mode transfers fails when the transfer includes partial bytes in
the last word.

Total words to be written/read to/from FIFO is computed based on transfer
length and bits per word. Unpacked mode includes 0 padding bytes for partial
words to align with bits per word and these extra bytes are also accounted
for calculating bytes left to transfer in the current driver.

This causes extra bytes access of tx/rx buffers along with buffer index
position crossing actual length where remain_len becomes negative and due to
unsigned type, negative value is a 32 bit representation of signed value
and transferred bytes never meets the actual transfer length resulting in
transfer timeout and a hang.

This patch fixes this with proper computation of the actual bytes to fill in
FIFO during transmit and the actual bytes to read from FIFO during receive
ignoring 0 padded bytes.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 82431115b7c0..fdba302eb3b6 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -307,10 +307,16 @@ static unsigned tegra_spi_fill_tx_fifo_from_client_txbuf(
 				x |= (u32)(*tx_buf++) << (i * 8);
 			tegra_spi_writel(tspi, x, SPI_TX_FIFO);
 		}
+
+		tspi->cur_tx_pos += written_words * tspi->bytes_per_word;
 	} else {
+		unsigned int write_bytes;
 		max_n_32bit = min(tspi->curr_dma_words,  tx_empty_count);
 		written_words = max_n_32bit;
 		nbytes = written_words * tspi->bytes_per_word;
+		if (nbytes > t->len - tspi->cur_pos)
+			nbytes = t->len - tspi->cur_pos;
+		write_bytes = nbytes;
 		for (count = 0; count < max_n_32bit; count++) {
 			u32 x = 0;
 
@@ -319,8 +325,10 @@ static unsigned tegra_spi_fill_tx_fifo_from_client_txbuf(
 				x |= (u32)(*tx_buf++) << (i * 8);
 			tegra_spi_writel(tspi, x, SPI_TX_FIFO);
 		}
+
+		tspi->cur_tx_pos += write_bytes;
 	}
-	tspi->cur_tx_pos += written_words * tspi->bytes_per_word;
+
 	return written_words;
 }
 
@@ -344,20 +352,27 @@ static unsigned int tegra_spi_read_rx_fifo_to_client_rxbuf(
 			for (i = 0; len && (i < 4); i++, len--)
 				*rx_buf++ = (x >> i*8) & 0xFF;
 		}
-		tspi->cur_rx_pos += tspi->curr_dma_words * tspi->bytes_per_word;
 		read_words += tspi->curr_dma_words;
+		tspi->cur_rx_pos += tspi->curr_dma_words * tspi->bytes_per_word;
 	} else {
 		u32 rx_mask = ((u32)1 << t->bits_per_word) - 1;
+		u8 bytes_per_word = tspi->bytes_per_word;
+		unsigned int read_bytes;
 
+		len = rx_full_count * bytes_per_word;
+		if (len > t->len - tspi->cur_pos)
+			len = t->len - tspi->cur_pos;
+		read_bytes = len;
 		for (count = 0; count < rx_full_count; count++) {
 			u32 x = tegra_spi_readl(tspi, SPI_RX_FIFO) & rx_mask;
 
-			for (i = 0; (i < tspi->bytes_per_word); i++)
+			for (i = 0; len && (i < bytes_per_word); i++, len--)
 				*rx_buf++ = (x >> (i*8)) & 0xFF;
 		}
-		tspi->cur_rx_pos += rx_full_count * tspi->bytes_per_word;
 		read_words += rx_full_count;
+		tspi->cur_rx_pos += read_bytes;
 	}
+
 	return read_words;
 }
 
@@ -372,12 +387,17 @@ static void tegra_spi_copy_client_txbuf_to_spi_txbuf(
 		unsigned len = tspi->curr_dma_words * tspi->bytes_per_word;
 
 		memcpy(tspi->tx_dma_buf, t->tx_buf + tspi->cur_pos, len);
+		tspi->cur_tx_pos += tspi->curr_dma_words * tspi->bytes_per_word;
 	} else {
 		unsigned int i;
 		unsigned int count;
 		u8 *tx_buf = (u8 *)t->tx_buf + tspi->cur_tx_pos;
 		unsigned consume = tspi->curr_dma_words * tspi->bytes_per_word;
+		unsigned int write_bytes;
 
+		if (consume > t->len - tspi->cur_pos)
+			consume = t->len - tspi->cur_pos;
+		write_bytes = consume;
 		for (count = 0; count < tspi->curr_dma_words; count++) {
 			u32 x = 0;
 
@@ -386,8 +406,9 @@ static void tegra_spi_copy_client_txbuf_to_spi_txbuf(
 				x |= (u32)(*tx_buf++) << (i * 8);
 			tspi->tx_dma_buf[count] = x;
 		}
+
+		tspi->cur_tx_pos += write_bytes;
 	}
-	tspi->cur_tx_pos += tspi->curr_dma_words * tspi->bytes_per_word;
 
 	/* Make the dma buffer to read by dma */
 	dma_sync_single_for_device(tspi->dev, tspi->tx_dma_phys,
@@ -405,20 +426,28 @@ static void tegra_spi_copy_spi_rxbuf_to_client_rxbuf(
 		unsigned len = tspi->curr_dma_words * tspi->bytes_per_word;
 
 		memcpy(t->rx_buf + tspi->cur_rx_pos, tspi->rx_dma_buf, len);
+		tspi->cur_rx_pos += tspi->curr_dma_words * tspi->bytes_per_word;
 	} else {
 		unsigned int i;
 		unsigned int count;
 		unsigned char *rx_buf = t->rx_buf + tspi->cur_rx_pos;
 		u32 rx_mask = ((u32)1 << t->bits_per_word) - 1;
+		unsigned consume = tspi->curr_dma_words * tspi->bytes_per_word;
+		unsigned int read_bytes;
 
+		if (consume > t->len - tspi->cur_pos)
+			consume = t->len - tspi->cur_pos;
+		read_bytes = consume;
 		for (count = 0; count < tspi->curr_dma_words; count++) {
 			u32 x = tspi->rx_dma_buf[count] & rx_mask;
 
-			for (i = 0; (i < tspi->bytes_per_word); i++)
+			for (i = 0; consume && (i < tspi->bytes_per_word);
+							i++, consume--)
 				*rx_buf++ = (x >> (i*8)) & 0xFF;
 		}
+
+		tspi->cur_rx_pos += read_bytes;
 	}
-	tspi->cur_rx_pos += tspi->curr_dma_words * tspi->bytes_per_word;
 
 	/* Make the dma buffer to read by dma */
 	dma_sync_single_for_device(tspi->dev, tspi->rx_dma_phys,
-- 
2.7.4

