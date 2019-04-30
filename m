Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74973C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505BA2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfD3RCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 13:02:39 -0400
Received: from charlie.dont.surf ([128.199.63.193]:57016 "EHLO
        charlie.dont.surf" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfD3RCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 13:02:38 -0400
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Apr 2019 13:02:38 EDT
Received: from apples.localdomain (ip-5-186-120-196.cgn.fibianet.dk [5.186.120.196])
        by charlie.dont.surf (Postfix) with ESMTPSA id EE88EBF5B7;
        Tue, 30 Apr 2019 16:53:29 +0000 (UTC)
From:   Klaus Birkelund Jensen <klaus@birkelund.eu>
To:     Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Klaus Birkelund Jensen <klaus@birkelund.eu>
Subject: [PATCH] nvme-pci: fix psdt field for single segment sgls
Date:   Tue, 30 Apr 2019 18:53:29 +0200
Message-Id: <20190430165329.6984-1-klaus@birkelund.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shortcut for single segment SGL requests did not set the PSDT field
to mark the request as using SGLs.

Fixes: 297910571f08 ("nvme-pci: optimize mapping single segment requests using SGLs")
Signed-off-by: Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c1eecde6b853..efc1da56521c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -830,6 +830,7 @@ static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,
 		return BLK_STS_RESOURCE;
 	iod->dma_len = bv->bv_len;
 
+	cmnd->flags = NVME_CMD_SGL_METABUF;
 	cmnd->dptr.sgl.addr = cpu_to_le64(iod->first_dma);
 	cmnd->dptr.sgl.length = cpu_to_le32(iod->dma_len);
 	cmnd->dptr.sgl.type = NVME_SGL_FMT_DATA_DESC << 4;
-- 
2.21.0

