Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AD5C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08BF2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563510530;
	bh=chNTen6JXbK3wZOrgnl+fXOyxD3HJQ6t0xrmB/mIbpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rC82mLAfDaazz8VdRJPdrPD/GGb4QYBa4a7dakaPC1wOiH3IygAo91vHtixWMRg1o
	 /qq84bOGwfE4BdSPFmgKfDbTgQBUSc9RRu743Q7pY+C8wWMhURnVwxuabLZKqlQobo
	 M9HYcEllUNyHroBAS91RNhzPkQ1rYYWOdGqZYHEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388044AbfGSE2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:28:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730836AbfGSEGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:06:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4E9021852;
        Fri, 19 Jul 2019 04:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509178;
        bh=chNTen6JXbK3wZOrgnl+fXOyxD3HJQ6t0xrmB/mIbpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p+y7U4JAlWGLgp/G9Ias1hFBcYWqguZRDzBlSZ/mZ9bai0ekNoRhuGkcOqV/a3W3N
         GjINBPqEgFnI8+FnUOvPX01CVxbDPbVtDA+FBQukia1ZKYG9pn9Kd3Je77M4o/t1tm
         EgCaqxfvAEl4of8fxlPDbLP9Tz4ogWtR+31BmmJY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alan Mikhak <alan.mikhak@sifive.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>,
        linux-nvme@lists.infradead.org, linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 5.1 108/141] nvme-pci: check for NULL return from pci_alloc_p2pmem()
Date:   Fri, 19 Jul 2019 00:02:13 -0400
Message-Id: <20190719040246.15945-108-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719040246.15945-1-sashal@kernel.org>
References: <20190719040246.15945-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

[ Upstream commit bfac8e9f55cf62a000b643a0081488badbe92d96 ]

Modify nvme_alloc_sq_cmds() to call pci_free_p2pmem() to free the memory
it allocated using pci_alloc_p2pmem() in case pci_p2pmem_virt_to_bus()
returns null.

Makes sure not to call pci_free_p2pmem() if pci_alloc_p2pmem() returned
NULL, which can happen if CONFIG_PCI_P2PDMA is not configured.

The current implementation is not expected to leak since
pci_p2pmem_virt_to_bus() is expected to fail only if pci_alloc_p2pmem()
returns null. However, checking the return value of pci_alloc_p2pmem()
is more explicit.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 693f2a856200..b97ba5ea0e61 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1471,11 +1471,15 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 
 	if (qid && dev->cmb_use_sqes && (dev->cmbsz & NVME_CMBSZ_SQS)) {
 		nvmeq->sq_cmds = pci_alloc_p2pmem(pdev, SQ_SIZE(depth));
-		nvmeq->sq_dma_addr = pci_p2pmem_virt_to_bus(pdev,
-						nvmeq->sq_cmds);
-		if (nvmeq->sq_dma_addr) {
-			set_bit(NVMEQ_SQ_CMB, &nvmeq->flags);
-			return 0; 
+		if (nvmeq->sq_cmds) {
+			nvmeq->sq_dma_addr = pci_p2pmem_virt_to_bus(pdev,
+							nvmeq->sq_cmds);
+			if (nvmeq->sq_dma_addr) {
+				set_bit(NVMEQ_SQ_CMB, &nvmeq->flags);
+				return 0;
+			}
+
+			pci_free_p2pmem(pdev, nvmeq->sq_cmds, SQ_SIZE(depth));
 		}
 	}
 
-- 
2.20.1

