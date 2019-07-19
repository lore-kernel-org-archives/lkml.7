Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EFDC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87C5218BB
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563509144;
	bh=8Qkmo7ezGTUAxtzDgCwqLOTlTxCum23/8/8T9fga8WM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RaOKJfo+bQ9Zydd6Hl+c9Bw30iinNshLGNDGmljscNxWfaok5ZdZFZkfRvbDHgaFm
	 hnHSM9fV+D7SusZ+3FiPOTwYz9GGJyJEUwCDnVr3BqH05d4Q+CMR32Xt3CeqTFptKp
	 Aq1zVdTN4EoDJTuav4nJQ4cXAO2iRd2ZPATLr4M0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbfGSEFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:05:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730445AbfGSEFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:05:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5382C218BA;
        Fri, 19 Jul 2019 04:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509139;
        bh=8Qkmo7ezGTUAxtzDgCwqLOTlTxCum23/8/8T9fga8WM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w4McZ0PCzAChTtHkN5xKqC+eiTVWB501TUs3qxj9dlClu7NHovhv1WeBlYafdXStO
         OzApVQjYD3h2Zs2g0sJIcciquM10N2urqpqeFv+E5upC6CRGrpiCa8AINpQFVAQBkj
         0BgrWs8gOkpiI0OUKX/PbLab2d54DFZ2kh6jbSQU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Minghuan Lian <Minghuan.Lian@nxp.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 092/141] PCI: mobiveil: Fix the Class Code field
Date:   Fri, 19 Jul 2019 00:01:57 -0400
Message-Id: <20190719040246.15945-92-sashal@kernel.org>
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

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

[ Upstream commit 0122af0a08243f344a438f924e5c2486486555b3 ]

Fix up the Class Code field in PCI configuration space and set it to
PCI_CLASS_BRIDGE_PCI.

Move the Class Code fixup to function mobiveil_host_init() where
it belongs.

Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP driver")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-mobiveil.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index 03d697b63e2a..88e9b70081fc 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -558,6 +558,12 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 		}
 	}
 
+	/* fixup for PCIe class register */
+	value = csr_readl(pcie, PAB_INTP_AXI_PIO_CLASS);
+	value &= 0xff;
+	value |= (PCI_CLASS_BRIDGE_PCI << 16);
+	csr_writel(pcie, value, PAB_INTP_AXI_PIO_CLASS);
+
 	/* setup MSI hardware registers */
 	mobiveil_pcie_enable_msi(pcie);
 
@@ -798,9 +804,6 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
 		goto error;
 	}
 
-	/* fixup for PCIe class register */
-	csr_writel(pcie, 0x060402ab, PAB_INTP_AXI_PIO_CLASS);
-
 	/* initialize the IRQ domains */
 	ret = mobiveil_pcie_init_irq_domain(pcie);
 	if (ret) {
-- 
2.20.1

