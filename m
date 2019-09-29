Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AC3C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B9621928
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 17:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569778395;
	bh=RZZgYD1fyG5xCQcGnFdd9/9L3RDH6oeyniowEFWObRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CNlamkIKOG/xjiYya2tkSbCmF4sOJ0+O8gz6K+fhMuPDicYq58WWD9tVHk74yLBKc
	 rw3CLK2yRKIP/1rdWCZt4HIEaYn7umhLrUPwW+syba6pNA8dJsFG+B9PopNNGHrwvJ
	 /tjhLAbuMNMfOcN5rgwHG6NhB/ICrO3ZkADnlL/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbfI2RdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 13:33:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729962AbfI2RdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 13:33:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90D6F21925;
        Sun, 29 Sep 2019 17:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569778390;
        bh=RZZgYD1fyG5xCQcGnFdd9/9L3RDH6oeyniowEFWObRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZNBcfU9D4jdS41r8ppDMqKlasm7y7tXtJYchI1SMTr13nKM1eTBCUHsBj9xZG8eYn
         QgL4YXmNm4ob7Uzyin8641AhML5+eG1+dqXRLv5YEH6XgRnxPq99m+bN5sVYX2KrHG
         oVfeyhlUKFssoaL7rc4nHGhgIMugTq/8kkk439J4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.2 11/42] PCI: layerscape: Add the bar_fixed_64bit property to the endpoint driver
Date:   Sun, 29 Sep 2019 13:32:10 -0400
Message-Id: <20190929173244.8918-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190929173244.8918-1-sashal@kernel.org>
References: <20190929173244.8918-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaowei Bao <xiaowei.bao@nxp.com>

[ Upstream commit fd5d16531a39322c3d7433d9f8a36203c9aaeddc ]

The layerscape PCIe controller have 4 BARs.

 BAR0 and BAR1 are 32bit, BAR2 and BAR4 are 64bit and that's a
fixed hardware configuration.

Set the bar_fixed_64bit variable accordingly.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
[lorenzo.pieralisi@arm.com: commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pci-layerscape-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index be61d96cc95ed..ca9aa4501e7e9 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -44,6 +44,7 @@ static const struct pci_epc_features ls_pcie_epc_features = {
 	.linkup_notifier = false,
 	.msi_capable = true,
 	.msix_capable = false,
+	.bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4),
 };
 
 static const struct pci_epc_features*
-- 
2.20.1

