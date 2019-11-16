Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D54C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105D921479
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573921490;
	bh=ijZUssjHtXM9YfOAy7rCU8OcNgoZ6UItBKk+B3wUlS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MhcoDv6ObHUqoUgVk4GRnLkxE+OKRz0M/rZ6i0W6igbtLH5J9wwbDOMddupaG4ypc
	 w1WMo7l4R9ho+0iOOaKEfCPKOs1pJ3Z+0j1RlnLhJE01C6RW/reAlTw+uVY5VHD8au
	 iOoMljZ2b48FeqtNVI3m65wgti5qXo7Jz42fIZfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731135AbfKPQYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:24:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:45928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbfKPPmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:42:22 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59EC22084B;
        Sat, 16 Nov 2019 15:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573918942;
        bh=ijZUssjHtXM9YfOAy7rCU8OcNgoZ6UItBKk+B3wUlS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WH67GIgCzA333QEVnaJXmu0QNTIR9v139PM9cZbNAi5w0gw+p5Fpei69X/F30D6Bf
         meFFNGL3OY0JLQZP3Nx7bJ+Rgz4RleSzpppOecQqbTHJh0iZDOTgz/dGI5dkGUfOuU
         P6PhogyHukgO4FUYeZaLb2x+Ta+jpSU7t07quDGw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, dc395x@twibble.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 064/237] scsi: dc395x: fix DMA API usage in sg_update_list
Date:   Sat, 16 Nov 2019 10:38:19 -0500
Message-Id: <20191116154113.7417-64-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 6c404a68bf83b4135a8a9aa1c388ebdf98e8ba7f ]

We need to transfer device ownership to the CPU before we can manipulate
the mapped data.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/dc395x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index 08161df64ead5..3943347ec3c7c 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -1969,6 +1969,11 @@ static void sg_update_list(struct ScsiReqBlk *srb, u32 left)
 			xferred -= psge->length;
 		} else {
 			/* Partial SG entry done */
+			pci_dma_sync_single_for_cpu(srb->dcb->
+					    acb->dev,
+					    srb->sg_bus_addr,
+					    SEGMENTX_LEN,
+					    PCI_DMA_TODEVICE);
 			psge->length -= xferred;
 			psge->address += xferred;
 			srb->sg_index = idx;
-- 
2.20.1

