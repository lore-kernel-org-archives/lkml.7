Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FAFC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28C020645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355679;
	bh=5QImTVuc0lxp89bL2HI9b6Gh4NBrFme6P7Laz59P0CI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0h4oPiIQRenzNbiv9btjnzqpG7idwghyCLvryhbtIVWNe+0SplFhpkr2U5+7kGFFs
	 3mQH6gireg73XsebrveXImQc68GzvLMDD9HTS96husbUIXmC5BTj8PXcfRxQCJhspR
	 EWXwzPNInfAAgVsNtZlDm96clWjzYJvZMGzRVwI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390964AbfETMej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:34:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387431AbfETMeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:34:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0627320645;
        Mon, 20 May 2019 12:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355670;
        bh=5QImTVuc0lxp89bL2HI9b6Gh4NBrFme6P7Laz59P0CI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cWgwM5L9X8rxw8dS0J7EB5sDpn/zGMalbwiC/FSZwMQnsVZQgHokUfb0xvBHMDN53
         6GIIgvqhCU/vIQO3PhIWv5oBJN089aQ1rtEMBmd/7aPqsq4kVYlyN0VyELHXGvmRx4
         xrSiM9y9kqWeCbgfhefzJ0UglKcBSekYnYZ+roDw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Romain Porte <romain.porte@nokia.com>,
        Pascal Fabreges <pascal.fabreges@nokia.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.1 079/128] mtd: spi-nor: intel-spi: Avoid crossing 4K address boundary on read/write
Date:   Mon, 20 May 2019 14:14:26 +0200
Message-Id: <20190520115255.006434205@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115249.449077487@linuxfoundation.org>
References: <20190520115249.449077487@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

commit 2b75ebeea6f4937d4d05ec4982c471cef9a29b7f upstream.

It was observed that reads crossing 4K address boundary are failing.

This limitation is mentioned in Intel documents:

Intel(R) 9 Series Chipset Family Platform Controller Hub (PCH) Datasheet:

"5.26.3 Flash Access
Program Register Access:
* Program Register Accesses are not allowed to cross a 4 KB boundary..."

Enhanced Serial Peripheral Interface (eSPI)
Interface Base Specification (for Client and Server Platforms):

"5.1.4 Address
For other memory transactions, the address may start or end at any byte
boundary. However, the address and payload length combination must not
cross the naturally aligned address boundary of the corresponding Maximum
Payload Size. It must not cross a 4 KB address boundary."

Avoid this by splitting an operation crossing the boundary into two
operations.

Fixes: 8afda8b26d01 ("spi-nor: Add support for Intel SPI serial flash controller")
Cc: stable@vger.kernel.org
Reported-by: Romain Porte <romain.porte@nokia.com>
Tested-by: Pascal Fabreges <pascal.fabreges@nokia.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/spi-nor/intel-spi.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/mtd/spi-nor/intel-spi.c
+++ b/drivers/mtd/spi-nor/intel-spi.c
@@ -632,6 +632,10 @@ static ssize_t intel_spi_read(struct spi
 	while (len > 0) {
 		block_size = min_t(size_t, len, INTEL_SPI_FIFO_SZ);
 
+		/* Read cannot cross 4K boundary */
+		block_size = min_t(loff_t, from + block_size,
+				   round_up(from + 1, SZ_4K)) - from;
+
 		writel(from, ispi->base + FADDR);
 
 		val = readl(ispi->base + HSFSTS_CTL);
@@ -685,6 +689,10 @@ static ssize_t intel_spi_write(struct sp
 	while (len > 0) {
 		block_size = min_t(size_t, len, INTEL_SPI_FIFO_SZ);
 
+		/* Write cannot cross 4K boundary */
+		block_size = min_t(loff_t, to + block_size,
+				   round_up(to + 1, SZ_4K)) - to;
+
 		writel(to, ispi->base + FADDR);
 
 		val = readl(ispi->base + HSFSTS_CTL);


