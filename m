Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6F6C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B4821734
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564000543;
	bh=7x5uqPwcLPoDTZF6cLw3c7iz9svtdhqhoJcH03CK8ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cgY0e4ScWNeVjsZt7f/cQKBXargGEyXfwfwOStOWzT1+9ZCDB4etNcF3NM5zy1BWx
	 FGSTC08EI+bnZ7jV5T0bZ+TsnbMbRR9bo395P4a/F6HmMd+ayCuUcGA6u4uzUlUDKC
	 IlvLI8FFUC5Kvt9Zm6rLx6VAgnqDTSxLLiRyY1jE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388918AbfGXUfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:35:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388058AbfGXTZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:25:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E91CB229ED;
        Wed, 24 Jul 2019 19:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996339;
        bh=7x5uqPwcLPoDTZF6cLw3c7iz9svtdhqhoJcH03CK8ZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qubO+LVUIUht3XqNhA4aBwYzWpxqocfoSNTblT+nnRr/yfw9ZBpXzcF7/j8Wb60bS
         ohjK7Tc61KosQoUClHCMBoRztI9fJZzhNlEVVPPG7aGUMTboJUSR+301KICzS2jmFQ
         oA14lZZrbv0HK86e9ABF+ONALJ1pGGTkDfufpG44=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Weihang Li <liweihang@hisilicon.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 061/413] net: hns3: add a check to pointer in error_detected and slot_reset
Date:   Wed, 24 Jul 2019 21:15:52 +0200
Message-Id: <20190724191739.647808700@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index cd59c0cc636a..5611b990ac34 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1916,9 +1916,9 @@ static pci_ers_result_t hns3_error_detected(struct pci_dev *pdev,
 	if (state == pci_channel_io_perm_failure)
 		return PCI_ERS_RESULT_DISCONNECT;
 
-	if (!ae_dev) {
+	if (!ae_dev || !ae_dev->ops) {
 		dev_err(&pdev->dev,
-			"Can't recover - error happened during device init\n");
+			"Can't recover - error happened before device initialized\n");
 		return PCI_ERS_RESULT_NONE;
 	}
 
@@ -1937,6 +1937,9 @@ static pci_ers_result_t hns3_slot_reset(struct pci_dev *pdev)
 
 	dev_info(dev, "requesting reset due to PCI error\n");
 
+	if (!ae_dev || !ae_dev->ops)
+		return PCI_ERS_RESULT_NONE;
+
 	/* request the reset */
 	if (ae_dev->ops->reset_event) {
 		if (!ae_dev->override_pci_need_reset)
-- 
2.20.1



