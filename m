Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F88C76196
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973362086C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563199632;
	bh=LmXZnOHv3NAGVLafslyPQnv9A/6RbdCMEAOVl74Cvow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HUWCmw/3eL1DKFw1L8cxZyHVxtJ4baJj/I8zKzfbFeOFz2VdP+h8anxNwd6LIOquh
	 o3NV+Ej+Edo0MhewfbQITmVI20UZKtekYTmip46qweZbtuYgaF36DYrkCRnNgaeEyZ
	 w/88rnT6OMHqdHr9C2yHf2ebTNmTmCRsbeKluNNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388003AbfGOOHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:07:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387629AbfGOOGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:06:53 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 787732081C;
        Mon, 15 Jul 2019 14:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199612;
        bh=LmXZnOHv3NAGVLafslyPQnv9A/6RbdCMEAOVl74Cvow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p/KjXv6auWrrWtD5ydLbWo6C1AAkScRvSXIag0DL+RFJDfmFij0GXXuOBofq3fmkt
         RHHPG7sB87XVIpGSWLW9Ew92je/tsk5imVOArYFzwAYtKsEvi0HsR8noP+KLyA43FK
         M3d7gkOk+TnS7gNAQG1t6ykYWNv8nc0PfzerXdAI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Weihang Li <liweihang@hisilicon.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 055/219] net: hns3: add a check to pointer in error_detected and slot_reset
Date:   Mon, 15 Jul 2019 10:00:56 -0400
Message-Id: <20190715140341.6443-55-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weihang Li <liweihang@hisilicon.com>

[ Upstream commit 661262bc3e0ecc9a1aed39c6b2a99766da2c22e2 ]

If we add a VF without loading hclgevf.ko and then there is a RAS error
occurs, PCIe AER will call error_detected and slot_reset of all functions,
and will get a NULL pointer when we check ad_dev->ops->handle_hw_ras_error.
This will cause a call trace and failures on handling of follow-up RAS
errors.

This patch check ae_dev and ad_dev->ops at first to solve above issues.

Signed-off-by: Weihang Li <liweihang@hisilicon.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 5e41ed4954f9..cac17152157d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1847,9 +1847,9 @@ static pci_ers_result_t hns3_error_detected(struct pci_dev *pdev,
 	if (state == pci_channel_io_perm_failure)
 		return PCI_ERS_RESULT_DISCONNECT;
 
-	if (!ae_dev) {
+	if (!ae_dev || !ae_dev->ops) {
 		dev_err(&pdev->dev,
-			"Can't recover - error happened during device init\n");
+			"Can't recover - error happened before device initialized\n");
 		return PCI_ERS_RESULT_NONE;
 	}
 
@@ -1868,6 +1868,9 @@ static pci_ers_result_t hns3_slot_reset(struct pci_dev *pdev)
 
 	dev_info(dev, "requesting reset due to PCI error\n");
 
+	if (!ae_dev || !ae_dev->ops)
+		return PCI_ERS_RESULT_NONE;
+
 	/* request the reset */
 	if (ae_dev->ops->reset_event) {
 		if (!ae_dev->override_pci_need_reset)
-- 
2.20.1

