Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510ECC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2447720718
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420957;
	bh=KTkvUQEH+MTZwMLJGI6O1q79iMJJn6gCBtjwVFifjm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Crv/JHsuDQWgSi4mvjJEhNd7xd4HfHslNAQ8VCe9rqVjpHHKinCoZLUzULQJ4WSM8
	 sN5IAp3KBrJ9tMh/CmNRQwonMOL0pFEwZXiwv4SXOKcbTUcqYCpBRwMnYbPUGojm6l
	 dUBqOErJ7mWdWaz5XsuyZzhSCPbIzuvNPrJ5oCcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbfKVLJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:09:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:57600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730318AbfKVLDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:03:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FE10207FA;
        Fri, 22 Nov 2019 11:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420605;
        bh=KTkvUQEH+MTZwMLJGI6O1q79iMJJn6gCBtjwVFifjm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KdW4rOGgLN8hKI0GiFitf2fzrXo0EUxBAr0ChIiF66dj8g2UcDg/JOhfsMK5QM+sm
         g2howaUiJkvUE/Ru0M6BUPTwA/6xYFSfuHG3ZDQNfDZzUuwBUUK8srCGKBFbuGp0mn
         L1AvaocPCT0Psz0+VaZjJ709pnmZGqgM64F+nfUw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 162/220] mtd: spi-nor: cadence-quadspi: Use proper enum for dma_[un]map_single
Date:   Fri, 22 Nov 2019 11:28:47 +0100
Message-Id: <20191122100924.397793000@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 900f5e0d8c9edc5dacc57873d22aee2ae699a8e1 ]

Clang warns when one enumerated type is converted implicitly to another.

drivers/mtd/spi-nor/cadence-quadspi.c:962:47: warning: implicit
conversion from enumeration type 'enum dma_transfer_direction' to
different enumeration type 'enum dma_data_direction' [-Wenum-conversion]
        dma_dst = dma_map_single(nor->dev, buf, len, DMA_DEV_TO_MEM);
                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
./include/linux/dma-mapping.h:428:66: note: expanded from macro
'dma_map_single'
                                   ~~~~~~~~~~~~~~~~~~~~          ^
drivers/mtd/spi-nor/cadence-quadspi.c:997:43: warning: implicit
conversion from enumeration type 'enum dma_transfer_direction' to
different enumeration type 'enum dma_data_direction' [-Wenum-conversion]
        dma_unmap_single(nor->dev, dma_dst, len, DMA_DEV_TO_MEM);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
./include/linux/dma-mapping.h:429:70: note: expanded from macro
'dma_unmap_single'
                                     ~~~~~~~~~~~~~~~~~~~~~~          ^
2 warnings generated.

Use the proper enums from dma_data_direction to satisfy Clang.

DMA_FROM_DEVICE = DMA_DEV_TO_MEM = 2

Link: https://github.com/ClangBuiltLinux/linux/issues/108
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/spi-nor/cadence-quadspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index 0806c7a81c0f7..04cedd3a2bf66 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -972,7 +972,7 @@ static int cqspi_direct_read_execute(struct spi_nor *nor, u_char *buf,
 		return 0;
 	}
 
-	dma_dst = dma_map_single(nor->dev, buf, len, DMA_DEV_TO_MEM);
+	dma_dst = dma_map_single(nor->dev, buf, len, DMA_FROM_DEVICE);
 	if (dma_mapping_error(nor->dev, dma_dst)) {
 		dev_err(nor->dev, "dma mapping failed\n");
 		return -ENOMEM;
@@ -1007,7 +1007,7 @@ static int cqspi_direct_read_execute(struct spi_nor *nor, u_char *buf,
 	}
 
 err_unmap:
-	dma_unmap_single(nor->dev, dma_dst, len, DMA_DEV_TO_MEM);
+	dma_unmap_single(nor->dev, dma_dst, len, DMA_FROM_DEVICE);
 
 	return ret;
 }
-- 
2.20.1



