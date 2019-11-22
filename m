Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0758AC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A082068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403395;
	bh=hADzEZR+GoHra9Qlw7/1Zj86PwIXDDqRV07xPIbmuOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OwweppQNwyvO6COIOys/W2Pxu1EF8SrwT5ENgiDcauc0poQ5iKCxaVw6G0i5cfnIF
	 pC4ZfkLQwNHIa26rmal6jOpkx1WzEZxqeXW4toDzVlx2slbtzG0gAfdtJOWNIsWLJm
	 8JskUEQmvRxteQW0MIrXZzVxEi0F8ZBdLxy/kb8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfKVGNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:13:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:50860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729144AbfKVGNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:13:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEC5220718;
        Fri, 22 Nov 2019 06:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574403214;
        bh=hADzEZR+GoHra9Qlw7/1Zj86PwIXDDqRV07xPIbmuOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eRrFjx1tHtmXYl70g2X1K1JPOB6ghaP4Nl1f7IdXa2MYeNe8caDk4FQMGOpjvj7Er
         UmHPJnVJRCvj6v9F+fh3gyWoSxJQTiGn/2UehBMEuRCi4ekacJBKsyOm2HCa/EcVed
         mCseiWH2KbpJkI9OkTvJFd6NR6ysls+84qGMFNsQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 29/68] IB/qib: Fix an error code in qib_sdma_verbs_send()
Date:   Fri, 22 Nov 2019 01:12:22 -0500
Message-Id: <20191122061301.4947-28-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122061301.4947-1-sashal@kernel.org>
References: <20191122061301.4947-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
@@ -597,8 +597,10 @@ int qib_sdma_verbs_send(struct qib_pportdata *ppd,
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

