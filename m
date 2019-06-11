Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC596C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13C320657
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BwbdazJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388113AbfFKKyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:54:49 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3990 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387978AbfFKKys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:54:48 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cff88750002>; Tue, 11 Jun 2019 03:54:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 11 Jun 2019 03:54:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 11 Jun 2019 03:54:47 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 11 Jun
 2019 10:53:34 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 11 Jun 2019 10:51:37 +0000
Received: from dhcp-10-19-65-14.client.nvidia.com (Not Verified[10.19.65.14]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cff87b60002>; Tue, 11 Jun 2019 03:51:37 -0700
From:   Bitan Biswas <bbiswas@nvidia.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-i2c@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@the-dreams.de>,
        Dmitry Osipenko <digetx@gmail.com>
CC:     Shardar Mohammed <smohammed@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>
Subject: [PATCH V5 6/7] i2c: tegra: fix PIO rx/tx residual transfer check
Date:   Tue, 11 Jun 2019 03:51:13 -0700
Message-ID: <1560250274-18499-6-git-send-email-bbiswas@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560250274-18499-1-git-send-email-bbiswas@nvidia.com>
References: <1560250274-18499-1-git-send-email-bbiswas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560250485; bh=DnwBZrSx2+8LhMKPSbReeXUfovA6frfU5DW0aOdqwo4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=BwbdazJUfAo2KZXZmR+tmcjFjGYFLLBGv5gRRsZLS7ikcbcCN2cbKPD/ClwjauLNV
         w+EjmN3rf3G58L8jUEKgLDuwhg2f/+0LBoGQCTHsLVT13+jB/+Dhk8G+ae2bzuGmdt
         FCRPBz/JxZEfIZXqOUcoTC8Mi00nmbUYzZ2hcmY2VQm6dmaKNpx73YEcETsJLZcO/z
         ZNBSmHkx3CQ6IyOPwv23ptnWix+jKaKD2QWmofyBqa7xMtSjP7vBNWKVSVNRBIHzeT
         mr9mkNvGQeR+Ml57IV/Rq7YGwAve/HZnhN/45xelEBgpHHvjyaHDT2J3/neiNsVNZ1
         dMhnfsv8ECOXA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix expression for residual bytes(less than word) transfer
in I2C PIO mode RX/TX.

Signed-off-by: Bitan Biswas <bbiswas@nvidia.com>
---
 drivers/i2c/busses/i2c-tegra.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 4dfb4c1..0596c12 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -514,7 +514,8 @@ static int tegra_i2c_empty_rx_fifo(struct tegra_i2c_dev *i2c_dev)
 	 * If there is a partial word at the end of buf, handle it manually to
 	 * prevent overwriting past the end of buf
 	 */
-	if (rx_fifo_avail > 0 && buf_remaining > 0) {
+	if (rx_fifo_avail > 0 &&
+	    (buf_remaining > 0 && buf_remaining < BYTES_PER_FIFO_WORD)) {
 		BUG_ON(buf_remaining > 3);
 		val = i2c_readl(i2c_dev, I2C_RX_FIFO);
 		val = cpu_to_le32(val);
@@ -557,11 +558,10 @@ static int tegra_i2c_fill_tx_fifo(struct tegra_i2c_dev *i2c_dev)
 			words_to_transfer = tx_fifo_avail;
 
 		/*
-		 * Update state before writing to FIFO.  If this casues us
+		 * Update state before writing to FIFO.  If this causes us
 		 * to finish writing all bytes (AKA buf_remaining goes to 0) we
 		 * have a potential for an interrupt (PACKET_XFER_COMPLETE is
-		 * not maskable).  We need to make sure that the isr sees
-		 * buf_remaining as 0 and doesn't call us back re-entrantly.
+		 * not maskable).
 		 */
 		buf_remaining -= words_to_transfer * BYTES_PER_FIFO_WORD;
 		tx_fifo_avail -= words_to_transfer;
@@ -580,7 +580,8 @@ static int tegra_i2c_fill_tx_fifo(struct tegra_i2c_dev *i2c_dev)
 	 * prevent reading past the end of buf, which could cross a page
 	 * boundary and fault.
 	 */
-	if (tx_fifo_avail > 0 && buf_remaining > 0) {
+	if (tx_fifo_avail > 0 &&
+	    (buf_remaining > 0 && buf_remaining < BYTES_PER_FIFO_WORD)) {
 		BUG_ON(buf_remaining > 3);
 		memcpy(&val, buf, buf_remaining);
 		val = le32_to_cpu(val);
-- 
2.7.4

