Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C530C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407D62084B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482321;
	bh=4UUe5xhh7O/MyXb31+TgBKcz6e1KFA7Sq4PVGQ2k+NY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z/1qwRgfoP97LrPOBLy4c6blwGe77M7muza4jrHb2+8R/iZpU4XXEOd6KppsTJL5D
	 MWfdw/VGVFyjamgoAHwsIuDO8NRKli2HbAbLh4/43uIfp1eSip+/t9c72sairXiTWy
	 PGBgQTowxAmYgKXigzzOVrn+BsFectObabC4zT7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfLDR6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:58:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:33468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728777AbfLDR6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:58:37 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8960D2073B;
        Wed,  4 Dec 2019 17:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482317;
        bh=4UUe5xhh7O/MyXb31+TgBKcz6e1KFA7Sq4PVGQ2k+NY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s5EmwKZ9QiP26lIn3u82JuNW/sg79C6AUHBg5aCNJKD8dxbkXbccNkTaQrl54UP8g
         yKyECdzVJKO+TGqsa32knygG0iXgCKRk8CVSzqLN+hbMh6ZtEFaSA3Y/CzFzlVF0Dc
         uzp/Cq36BKdD7ihdYfg9ZnB/rHi36Qifa2AQQRhw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 37/92] IB/qib: Fix an error code in qib_sdma_verbs_send()
Date:   Wed,  4 Dec 2019 18:49:37 +0100
Message-Id: <20191204174332.788569888@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204174327.215426506@linuxfoundation.org>
References: <20191204174327.215426506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 5050ae5fa3d54c8e83e1e447cc7e3591110a7f57 ]

We accidentally return success on this error path.

Fixes: f931551bafe1 ("IB/qib: Add new qib driver for QLogic PCIe InfiniBand adapters")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/qib/qib_sdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qib/qib_sdma.c b/drivers/infiniband/hw/qib/qib_sdma.c
index c6d6a54d2e19d..1c9a3e8752012 100644
--- a/drivers/infiniband/hw/qib/qib_sdma.c
+++ b/drivers/infiniband/hw/qib/qib_sdma.c
@@ -597,8 +597,10 @@ retry:
 		dw = (len + 3) >> 2;
 		addr = dma_map_single(&ppd->dd->pcidev->dev, sge->vaddr,
 				      dw << 2, DMA_TO_DEVICE);
-		if (dma_mapping_error(&ppd->dd->pcidev->dev, addr))
+		if (dma_mapping_error(&ppd->dd->pcidev->dev, addr)) {
+			ret = -ENOMEM;
 			goto unmap;
+		}
 		sdmadesc[0] = 0;
 		make_sdma_desc(ppd, sdmadesc, (u64) addr, dw, dwoffset);
 		/* SDmaUseLargeBuf has to be set in every descriptor */
-- 
2.20.1



