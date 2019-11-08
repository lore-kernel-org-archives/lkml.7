Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD06FC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89EF42085B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214983;
	bh=HYdL5GQ3OQvT0aFNudvAPyRyi+SuJmdXbbSLSZAqU6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F5Rx5RwV2qEYRtH2PYHGivfANaMmQbGAbt8xn5g7M0aG+SoGVpLouMMXpiTctMgHC
	 y5WJpGUK3oQeDzIjThuaf1ZOJT04VLnnmSpYnZW6QRptv4JSz0m3TztNppMBkx+T/Z
	 zZ7Ah7HIR7hnMXnhtlYuCTgOP/G4XYbFZT0CM4pA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388301AbfKHLkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:40:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:52878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732191AbfKHLkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:40:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9DDF21D7F;
        Fri,  8 Nov 2019 11:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213199;
        bh=HYdL5GQ3OQvT0aFNudvAPyRyi+SuJmdXbbSLSZAqU6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WvTe288PSPznFlLA3mWEsffPt+x81Lu38kGyycD5lRZnMGBp7Yx0CFjlejmtfu/zU
         K2HzCFdqL+gYDyUprHqAvC04hkoJ5oqVhcZepurjWnXBEea/lHH9aVnsD4Psf0deT+
         21l4UMKg5i2EHgu/w17Lts1yfupC0yMZStthGFV0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-mtd@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 083/205] mtd: rawnand: qcom: don't include dma-direct.h
Date:   Fri,  8 Nov 2019 06:35:50 -0500
Message-Id: <20191108113752.12502-83-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit ab0fb17c7d46406e1aac2dda265874751946626d ]

A recent commit removed the incorrect use of phys_to_dma from this
driver, but failed to remove the dma-direct.h include, so do that
now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 880e75f63a19b..07d8750313fd6 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -23,7 +23,6 @@
 #include <linux/of_device.h>
 #include <linux/delay.h>
 #include <linux/dma/qcom_bam_dma.h>
-#include <linux/dma-direct.h> /* XXX: drivers shall never use this directly! */
 
 /* NANDc reg offsets */
 #define	NAND_FLASH_CMD			0x00
-- 
2.20.1

