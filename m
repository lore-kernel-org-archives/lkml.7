Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96300C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3482177B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428406;
	bh=a9auGRC0fONO4VFLdSyctLRMfowRS4CXyI/bJApBCX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yKUTfKr5L4eHJBS8lIVqrihIfE6TtI8nNCLIxXpYfYlJuTsfqZHRF5+qlxYYN/6Su
	 wdoClKPOFF+YGKn2WKjqgvRhTKu3ygwPIuIRDh3ptTUMwmHe+7vgEHsMdiusGe9ivP
	 4nMrilxCGfy3n1mRbqu3sI9o+DMcWlfrhn3s9ASA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfEITAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 15:00:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728625AbfEISvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:51:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1100217D7;
        Thu,  9 May 2019 18:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427915;
        bh=a9auGRC0fONO4VFLdSyctLRMfowRS4CXyI/bJApBCX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dHBL6L+z7WUG0IIpzIXcskLxRq3gy1zB3AD6cc2ILkpbPazQYLwILsi1xXOAb2q+k
         ivb5wpcV4AXsb2y2Btc22Ok245dgHdH0Rp/qzLGJvhNhTdSKyfrGzPzz9BzTOiccyk
         ALw6qD1BeRTazS2uGWetwt5zCF0rfYymPgYfAm+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kamal Heib <kamalheib1@gmail.com>,
        Adit Ranadive <aditr@vmware.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 51/95] RDMA/vmw_pvrdma: Fix memory leak on pvrdma_pci_remove
Date:   Thu,  9 May 2019 20:42:08 +0200
Message-Id: <20190509181313.054985967@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181309.180685671@linuxfoundation.org>
References: <20190509181309.180685671@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit ea7a5c706fa49273cf6d1d9def053ecb50db2076 ]

Make sure to free the DSR on pvrdma_pci_remove() to avoid the memory leak.

Fixes: 29c8d9eba550 ("IB: Add vmw_pvrdma driver")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
Acked-by: Adit Ranadive <aditr@vmware.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
index 39c37b6fd7159..76b8dda40eddd 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -1125,6 +1125,8 @@ static void pvrdma_pci_remove(struct pci_dev *pdev)
 	pvrdma_page_dir_cleanup(dev, &dev->cq_pdir);
 	pvrdma_page_dir_cleanup(dev, &dev->async_pdir);
 	pvrdma_free_slots(dev);
+	dma_free_coherent(&pdev->dev, sizeof(*dev->dsr), dev->dsr,
+			  dev->dsrbase);
 
 	iounmap(dev->regs);
 	kfree(dev->sgid_tbl);
-- 
2.20.1



