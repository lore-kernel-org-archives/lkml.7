Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D355C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3C921655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429908;
	bh=1T9ReUJnk6XnIwjSgiM7I75GocWQu1OTYIVqyvK0xPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b2SQ6+LTSc3511QfcsvX4iptqXMG4kT6AidsiCAV3h0CYnh+CMu/BOVqZHoG7dWNw
	 DB95kU+rJ816nKVnFsYpP0goETKoemWFKa2RRPHzo1gGCnnvfUrDvkjbT4aV3ShrNl
	 2qk6acqWbRRZu9HR2IRLK38eTYffMh7kIz+pGu18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403885AbfG2Tvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390808AbfG2Tvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:51:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04448217D4;
        Mon, 29 Jul 2019 19:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429901;
        bh=1T9ReUJnk6XnIwjSgiM7I75GocWQu1OTYIVqyvK0xPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JMFS8mKFiI3AXXyIcr2sY2i8yyuy+9N36/o180YDRu9KZIR6bqMIshinq/fVcKeF8
         Dojjc2kDNLxG+d4f2uuh8XCzzlGv4orYqHlBw3SS7cTdfaiAKvP7qB3BCl53W9F6L7
         mtLui0xSxeFMO6RMSEtK7CHRAIa3ymu1gJHNnSoI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Atish Patra <Atish.Patra@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 133/215] nvme-pci: limit max_hw_sectors based on the DMA max mapping size
Date:   Mon, 29 Jul 2019 21:22:09 +0200
Message-Id: <20190729190802.565753706@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 245b6e2151c1..7fbcd72c438f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2521,7 +2521,8 @@ static void nvme_reset_work(struct work_struct *work)
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



