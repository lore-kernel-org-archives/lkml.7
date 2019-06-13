Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3201CC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B2420644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560442730;
	bh=j5w28E3klWyw4CPlY2bADWeTaIatMocL/9pnRrsXdJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uTzIL4ZwHrqtsgdPf31n/hunW743ZarHhutsDyI6ILUR7cLtxaTwn5HXauY73yHxF
	 K/ck9lyVptq73oYpTzWGAWrBQ13fKn+5H93gVyXZFzUOosvgjRvTbBAoZu5rzXYjWF
	 OzJ4eMk2+T8iTLsZQ0TKzBcJUhFbCPm/uRtTzZzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391925AbfFMQSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:18:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731113AbfFMIkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:40:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E947620851;
        Thu, 13 Jun 2019 08:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415214;
        bh=j5w28E3klWyw4CPlY2bADWeTaIatMocL/9pnRrsXdJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kVS+itW3LQf+lBcPQ/7WIxbnLYkMCkPcOu9jGw39hSNoocK5VFllaO1QzzdAgsGr/
         7pDDJg1YBaEojsdK9bu8Tir5Rht4sdrrOMX73FVy0UQukgJww7MrOtWlQ7S7zkiEV5
         rH0fpokJnGD9ARzmfOJhxL3jogj1o+ljaJd1g5JY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 045/118] PCI: dwc: Free MSI in dw_pcie_host_init() error path
Date:   Thu, 13 Jun 2019 10:33:03 +0200
Message-Id: <20190613075646.368348067@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075643.642092651@linuxfoundation.org>
References: <20190613075643.642092651@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 9e2b5de5604a6ff2626c51e77014d92c9299722c ]

If we ever did MSI-related initializations, we need to call
dw_pcie_free_msi() in the error code path.

Remove the IS_ENABLED(CONFIG_PCI_MSI) check for MSI init because
pci_msi_enabled() already has a stub for !CONFIG_PCI_MSI.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index b56e22262a77..4eedb2c54ab3 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -439,7 +439,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (ret)
 		pci->num_viewport = 2;
 
-	if (IS_ENABLED(CONFIG_PCI_MSI) && pci_msi_enabled()) {
+	if (pci_msi_enabled()) {
 		/*
 		 * If a specific SoC driver needs to change the
 		 * default number of vectors, it needs to implement
@@ -477,7 +477,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (pp->ops->host_init) {
 		ret = pp->ops->host_init(pp);
 		if (ret)
-			goto error;
+			goto err_free_msi;
 	}
 
 	pp->root_bus_nr = pp->busn->start;
@@ -491,7 +491,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	ret = pci_scan_root_bus_bridge(bridge);
 	if (ret)
-		goto error;
+		goto err_free_msi;
 
 	bus = bridge->bus;
 
@@ -507,6 +507,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	pci_bus_add_devices(bus);
 	return 0;
 
+err_free_msi:
+	if (pci_msi_enabled() && !pp->ops->msi_host_init)
+		dw_pcie_free_msi(pp);
 error:
 	pci_free_host_bridge(bridge);
 	return ret;
-- 
2.20.1



