Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FAAC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49818244EF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559185981;
	bh=rcP9e4BvTds2Ys2zrNhxdB54UkdmOwPiFX3hoKQP6NM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dENoOJmMf68pVe8L8YM2/r611lJn5ltPeF3W+lYDK4AH5AHOF3OJ7wWVWbB0JD3Re
	 Cj9SGaPkhq8PiqwAi61NytuFeBL2/rw84npGsmLTqwq7lO1X0LsxxJhwT/49m0VHu+
	 lh6hj16ErHk0SL9y+ST2h8LJEIWMah+FovcTomCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfE3DNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:13:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728077AbfE3DLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:11:22 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97E4424476;
        Thu, 30 May 2019 03:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185881;
        bh=rcP9e4BvTds2Ys2zrNhxdB54UkdmOwPiFX3hoKQP6NM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HfpUxWDNDvb/pW2hGcT2r4Aj0Gnn8IkSeCQ0hraosyDX6ONq8kWGYnt75FzrqrBXE
         coP0n7/yGtInOQxPUYSfeN7gFfevpGbhoFlRCGYItgdOIkc51yutcPCakr4CDoj1CK
         rveigtFYRuR2ZwkJpLSCWioh3F4kPjAs6PyU/xUg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 232/405] habanalabs: prevent device PTE read/write during hard-reset
Date:   Wed, 29 May 2019 20:03:50 -0700
Message-Id: <20190530030552.770697134@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 9f201aba56b92c3daa4b76efae056ddbb80d91e6 ]

During hard-reset, contexts are closed as part of the tear-down process.
After a context is closed, the driver cleans up the page tables of that
context in the device's DRAM. This action is both dangerous and
unnecessary.

It is unnecessary, because the device is going through a hard-reset, which
means the device's DRAM contents are no longer valid and the device's MMU
is being reset.

It is dangerous, because if the hard-reset came as a result of a PCI
freeze, this action may cause the entire host machine to hang.

Therefore, prevent all device PTE updates when a hard-reset operation is
pending.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/habanalabs/goya/goya.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 3c509e19d69dc..1533cb3205400 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4407,6 +4407,9 @@ static u64 goya_read_pte(struct hl_device *hdev, u64 addr)
 {
 	struct goya_device *goya = hdev->asic_specific;
 
+	if (hdev->hard_reset_pending)
+		return U64_MAX;
+
 	return readq(hdev->pcie_bar[DDR_BAR_ID] +
 			(addr - goya->ddr_bar_cur_addr));
 }
@@ -4415,6 +4418,9 @@ static void goya_write_pte(struct hl_device *hdev, u64 addr, u64 val)
 {
 	struct goya_device *goya = hdev->asic_specific;
 
+	if (hdev->hard_reset_pending)
+		return;
+
 	writeq(val, hdev->pcie_bar[DDR_BAR_ID] +
 			(addr - goya->ddr_bar_cur_addr));
 }
-- 
2.20.1



