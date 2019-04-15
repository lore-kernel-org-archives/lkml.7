Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F74C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEEE2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cGa63/wQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfDOVas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:30:48 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16522 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbfDOVar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 17:30:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb4f80c0000>; Mon, 15 Apr 2019 14:30:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 15 Apr 2019 14:30:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 15 Apr 2019 14:30:46 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 15 Apr
 2019 21:30:46 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 15 Apr 2019 21:30:46 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.167.253]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cb4f8040003>; Mon, 15 Apr 2019 14:30:46 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V3 2/9] spi: expand mode support
Date:   Mon, 15 Apr 2019 14:30:27 -0700
Message-ID: <1555363834-32155-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
References: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555363852; bh=Q/Ac6tgh+Fi0QXzPMWJrKBU/7jvvVApsGufw1si05cg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=cGa63/wQ+dBu4q98NWVg9+dlnjMpSGXppt6R30TsvXhjUetyCr8CLMYjD8xYCVSiE
         R3RDw++QjiJwil6XLQp1nJ97NZ5/35VLXqLNe9AlpgU+dNR21HXX0jo1pO4tnRfMNp
         1pR44McJrCVUpREpMfx09J3Z84Iekfh8I3AquQOGD52guMuWOT/K2TXomrS7MmWIUB
         nYX5kSBUE78J1hNuehgwtqtGx/yaM3GRHc1nfTfjic3snCOnWZZxezP/8k4w7htvC3
         G5oCUBjxpOWCxFukKsOyh4kRgq9m9Y+QZ01YJXmM4f1n7gexGqSK7wiDqDxs58aVaT
         x2jV+WjyP8/NQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes mode and mode_bits from u16 to u32 to allow more
mode configurations.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 include/linux/spi/spi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 589f9dc9ac2b..053abd22ad31 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -143,7 +143,7 @@ struct spi_device {
 	u32			max_speed_hz;
 	u8			chip_select;
 	u8			bits_per_word;
-	u16			mode;
+	u32			mode;
 #define	SPI_CPHA	0x01			/* clock phase */
 #define	SPI_CPOL	0x02			/* clock polarity */
 #define	SPI_MODE_0	(0|0)			/* (original MicroWire) */
@@ -443,7 +443,7 @@ struct spi_controller {
 	u16			dma_alignment;
 
 	/* spi_device.mode flags understood by this controller driver */
-	u16			mode_bits;
+	u32			mode_bits;
 
 	/* bitmask of supported bits_per_word for transfers */
 	u32			bits_per_word_mask;
@@ -1291,7 +1291,7 @@ struct spi_board_info {
 	/* mode becomes spi_device.mode, and is essential for chips
 	 * where the default of SPI_CS_HIGH = 0 is wrong.
 	 */
-	u16		mode;
+	u32		mode;
 
 	/* ... may need additional spi_device chip config data here.
 	 * avoid stuff protocol drivers can set; but include stuff
-- 
2.7.4

