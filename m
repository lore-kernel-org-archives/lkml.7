Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283D1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA897214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901246;
	bh=sybLscDQ+GsL1v0eQ5TTB8FvF9o2M9AphgrKOe0nNJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C1aNaAiDIgLtyaHkffbjjqNsW4jl23UnaUHozCT309ejsQsEpXugoqP2nKTzf6ti/
	 pIXg1MC3sGG7hGUdGEWpPBy28NrzArY+d9jpGQTkWAMZCdDxMuhHAcpNZ4x2exHD3O
	 4qWL+IDHFS8Oup41oPlLz0l3RlTiDdrTLDwyn5As=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfCRJ1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:27:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727772AbfCRJ1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:27:20 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DABE214D8;
        Mon, 18 Mar 2019 09:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901240;
        bh=sybLscDQ+GsL1v0eQ5TTB8FvF9o2M9AphgrKOe0nNJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WzD/kEFUM+04+jeUDjG1aJdIsrynu0+DQ79ccMTcfbSeESA2faEyMqI3Y2xpFdKld
         LLxql0jXCg7p1Ftf43+ybRzrIqGquVLURpfMHYfULMZjYLDCHRVXTYCC0f+ahJ8dHK
         rx/69tddq6jwZ9c8guYP/z+uRag2n21zQ6vS+tuw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiaofei Tan <tanxiaofei@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 28/43] net: hns3: fix to stop multiple HNS reset due to the AER changes
Date:   Mon, 18 Mar 2019 10:24:20 +0100
Message-Id: <20190318083716.700033043@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083715.877441740@linuxfoundation.org>
References: <20190318083715.877441740@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shiju Jose <shiju.jose@huawei.com>

[ Upstream commit 69b51bbb03f73e04c486f79d1556b2d9becf4dbc ]

The commit bfcb79fca19d
("PCI/ERR: Run error recovery callbacks for all affected devices")
affected the non-fatal error recovery logic for the HNS and RDMA devices.
This is because each HNS PF under PCIe bus receive callbacks
from the AER driver when an error is reported for one of the PF.
This causes unwanted PF resets because
the HNS decides which PF to reset based on the reset type set.
The HNS error handling code sets the reset type based on the hw error
type detected.

This patch provides fix for the above issue for the recovery of
the hw errors in the HNS and RDMA devices.

This patch needs backporting to the kernel v5.0+

Fixes: 332fbf576579 ("net: hns3: add handling of hw ras errors using new set of commands")
Reported-by: Xiaofei Tan <tanxiaofei@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h            |    1 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c        |    4 +++-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c |    9 +++++++--
 3 files changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -192,6 +192,7 @@ struct hnae3_ae_dev {
 	const struct hnae3_ae_ops *ops;
 	struct list_head node;
 	u32 flag;
+	u8 override_pci_need_reset; /* fix to stop multiple reset happening */
 	enum hnae3_dev_type dev_type;
 	enum hnae3_reset_type reset_type;
 	void *priv;
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -1852,7 +1852,9 @@ static pci_ers_result_t hns3_slot_reset(
 
 	/* request the reset */
 	if (ae_dev->ops->reset_event) {
-		ae_dev->ops->reset_event(pdev, NULL);
+		if (!ae_dev->override_pci_need_reset)
+			ae_dev->ops->reset_event(pdev, NULL);
+
 		return PCI_ERS_RESULT_RECOVERED;
 	}
 
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
@@ -1259,8 +1259,10 @@ pci_ers_result_t hclge_handle_hw_ras_err
 		hclge_handle_all_ras_errors(hdev);
 	} else {
 		if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state) ||
-		    hdev->pdev->revision < 0x21)
+		    hdev->pdev->revision < 0x21) {
+			ae_dev->override_pci_need_reset = 1;
 			return PCI_ERS_RESULT_RECOVERED;
+		}
 	}
 
 	if (status & HCLGE_RAS_REG_ROCEE_ERR_MASK) {
@@ -1269,8 +1271,11 @@ pci_ers_result_t hclge_handle_hw_ras_err
 	}
 
 	if (status & HCLGE_RAS_REG_NFE_MASK ||
-	    status & HCLGE_RAS_REG_ROCEE_ERR_MASK)
+	    status & HCLGE_RAS_REG_ROCEE_ERR_MASK) {
+		ae_dev->override_pci_need_reset = 0;
 		return PCI_ERS_RESULT_NEED_RESET;
+	}
+	ae_dev->override_pci_need_reset = 1;
 
 	return PCI_ERS_RESULT_RECOVERED;
 }


