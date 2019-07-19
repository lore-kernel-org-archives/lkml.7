Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB034C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6182173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563510934;
	bh=GN/OsSNmdwC+UYwQNWTMkfKny8MRTFWFNFlzyHs3pjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dDAd8EpK/Jdp00cnZ6e6wCyehRZJcvY7LcDfV9ZSCVhjta+Nhqgx35460Fhnxkk/y
	 ePPN/K1goQCQxLXVVKzgsLxZ+/Z1EFWlTroWqBaGf8O6hnM6JxOgpHC3ADWElbVLR4
	 7m7xylIDAbSxiNh5VqsqL7OjUKMnx1804QDPwVUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388584AbfGSEfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:35:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729420AbfGSEBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:01:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76D4621897;
        Fri, 19 Jul 2019 04:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508885;
        bh=GN/OsSNmdwC+UYwQNWTMkfKny8MRTFWFNFlzyHs3pjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WMEAuy8V//91E5PQd2XeRLl4PVexfPXla+SWGqb5z7oK6TIVz3H1vpZkilABDcSNm
         J61XkELg2knGNKgO9ST3JymR0md63u64QZ3x8+GsAqs1NWF3YPr4u7aGxGD+UmjAmr
         RE/EQSxX8QtX9LLBWL2IgsRLqKp3F+xORmQA+djA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Atish Patra <Atish.Patra@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.2 136/171] nvme-pci: limit max_hw_sectors based on the DMA max mapping size
Date:   Thu, 18 Jul 2019 23:56:07 -0400
Message-Id: <20190719035643.14300-136-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 7637de311bd2124b298a072852448b940d8a34b9 ]

When running a NVMe device that is attached to a addressing
challenged PCIe root port that requires bounce buffering, our
request sizes can easily overflow the swiotlb bounce buffer
size.  Limit the maximum I/O size to the limit exposed by
the DMA mapping subsystem.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Atish Patra <Atish.Patra@wdc.com>
Tested-by: Atish Patra <Atish.Patra@wdc.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5dfa067f6506..5c45f4cab060 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2515,7 +2515,8 @@ static void nvme_reset_work(struct work_struct *work)
 	 * Limit the max command size to prevent iod->sg allocations going
 	 * over a single page.
 	 */
-	dev->ctrl.max_hw_sectors = NVME_MAX_KB_SZ << 1;
+	dev->ctrl.max_hw_sectors = min_t(u32,
+		NVME_MAX_KB_SZ << 1, dma_max_mapping_size(dev->dev) >> 9);
 	dev->ctrl.max_segments = NVME_MAX_SEGS;
 
 	/*
-- 
2.20.1

