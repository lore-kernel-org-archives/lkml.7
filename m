Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25294C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F7920821
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbfEVV0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 17:26:15 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:34895 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbfEVV0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 17:26:14 -0400
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id A7F9A240009;
        Wed, 22 May 2019 21:26:08 +0000 (UTC)
From:   Remi Pommarel <repk@triplefau.lt>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ellie Reeves <ellierevves@gmail.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH] PCI: aardvark: Fix PCI_EXP_RTCTL conf register writing
Date:   Wed, 22 May 2019 23:33:49 +0200
Message-Id: <20190522213351.21366-1-repk@triplefau.lt>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCI_EXP_RTCTL is used to activate PME interrupt only, so writing into it
should not modify other interrupts' mask (such as ISR0).

Fixes: 6302bf3ef78d ("PCI: Init PCIe feature bits for managed host bridge alloc")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
Please note that I will unlikely be able to answer any comments from May
24th to June 10th.
---
 drivers/pci/controller/pci-aardvark.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 134e0306ff00..27102d3b4f9c 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -451,10 +451,14 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
 		advk_writel(pcie, new, PCIE_CORE_PCIEXP_CAP + reg);
 		break;
 
-	case PCI_EXP_RTCTL:
-		new = (new & PCI_EXP_RTCTL_PMEIE) << 3;
-		advk_writel(pcie, new, PCIE_ISR0_MASK_REG);
+	case PCI_EXP_RTCTL: {
+		/* Only mask/unmask PME interrupt */
+		u32 val = advk_readl(pcie, PCIE_ISR0_MASK_REG) &
+			~PCIE_MSG_PM_PME_MASK;
+		val |= (new & PCI_EXP_RTCTL_PMEIE) << 3;
+		advk_writel(pcie, val, PCIE_ISR0_MASK_REG);
 		break;
+	}
 
 	case PCI_EXP_RTSTA:
 		new = (new & PCI_EXP_RTSTA_PME) >> 9;
-- 
2.20.1

