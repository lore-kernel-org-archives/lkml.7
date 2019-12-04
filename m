Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD712C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4122073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482597;
	bh=i3OiJAVeEM0iaNfq2u0wBwNrMPqsr8N9vfgbPm+77kE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iAEwd0YvXEd6/eO5mYeATxKEOYS5q478vIb0cc5YwOFy0/M9AqzVFkI2Wr3Km8LzV
	 qhVLBUr70Uerou7Z0q7PI2Khu3EVkOZR4zN8FafUm+K9WdVJaSwbuf6ofwe8Stptrw
	 u9m/jLiMa+yVXOKpez3j1ttHU/Ql8mYF339HMHUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbfLDSDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:03:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:46630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729522AbfLDSDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:03:14 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1730C2081B;
        Wed,  4 Dec 2019 18:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482594;
        bh=i3OiJAVeEM0iaNfq2u0wBwNrMPqsr8N9vfgbPm+77kE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xQNPUh7jaEmobscimKhzg5pRhexLxsI0U+Fm7EPx+ZxgEbAGpx1NEU0GUKV9c9St9
         Ze05psshkUT3tQ82pR6VYinQ4K9OrYvifkPDMqM6wofokNFOoLQUdre45wrJH3cCdb
         oD0w3+YtdC5C85ntoSqOCUcVbOaC6uKW5XTDXyjY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 059/209] mtd: rawnand: sunxi: Write pageprog related opcodes to WCMD_SET
Date:   Wed,  4 Dec 2019 18:54:31 +0100
Message-Id: <20191204175325.409066513@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@bootlin.com>

[ Upstream commit 732774437ae01d9882e60314e303898e63c7f038 ]

The opcodes used by the controller when doing batched page prog should
be written in NFC_REG_WCMD_SET not FC_REG_RCMD_SET. Luckily, the
default NFC_REG_WCMD_SET value matches the one we set in the driver
which explains why we didn't notice the problem.

Fixes: 614049a8d904 ("mtd: nand: sunxi: add support for DMA assisted operations")
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/sunxi_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
index 9589748215821..8e52314823976 100644
--- a/drivers/mtd/nand/sunxi_nand.c
+++ b/drivers/mtd/nand/sunxi_nand.c
@@ -1435,7 +1435,7 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct mtd_info *mtd,
 	sunxi_nfc_randomizer_enable(mtd);
 
 	writel((NAND_CMD_RNDIN << 8) | NAND_CMD_PAGEPROG,
-	       nfc->regs + NFC_REG_RCMD_SET);
+	       nfc->regs + NFC_REG_WCMD_SET);
 
 	dma_async_issue_pending(nfc->dmac);
 
-- 
2.20.1



