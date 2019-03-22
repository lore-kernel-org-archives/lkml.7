Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB42C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB2A2196F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256464;
	bh=XFMjzvokXhpCFXa7YbUtFxJ/o5q2xHn0KjhqbDJEekU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I8AypG4O5HMAQ7pzlLIf7YO3Dyi1ehnCS8rOsly1G9nvGbGjQLNELud6ZgGfuzwCP
	 5RGg4j1d8msVnKN1IMcFsfgmpsdNDBsZZ/hg7r4b54tgU/ebVqNV+XVcngMGtKK8Dc
	 gD8ZawegQkIlA4QA2M/TYoP5Lmxktw04wDNS1rYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389066AbfCVMHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:07:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388842AbfCVMHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:07:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF935206C0;
        Fri, 22 Mar 2019 12:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256459;
        bh=XFMjzvokXhpCFXa7YbUtFxJ/o5q2xHn0KjhqbDJEekU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BzjhCotyOLTE5P5fdPXwvSdv3+54NngaVbIJxMoLNR/VFe/4ahH0DhgFGW0A2wyNW
         GTqJRLR9ztPoi7pKXMzZ1sPdswfd7wfpwUWb50xahFSxTj5kmAqSyvgB+Hx29vh9vF
         RxsqGgR19uE0TngPkmJwL1J1i4VpzCo164oea1XE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH 4.19 187/280] PCI: dwc: skip MSI init if MSIs have been explicitly disabled
Date:   Fri, 22 Mar 2019 12:15:40 +0100
Message-Id: <20190322111327.920285480@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lucas Stach <l.stach@pengutronix.de>

commit 3afc8299f39a27b60e1519a28e18878ce878e7dd upstream.

Since 7c5925afbc58 (PCI: dwc: Move MSI IRQs allocation to IRQ domains
hierarchical API) the MSI init claims one of the controller IRQs as a
chained IRQ line for the MSI controller. On some designs, like the i.MX6,
this line is shared with a PCIe legacy IRQ. When the line is claimed for
the MSI domain, any device trying to use this legacy IRQs will fail to
request this IRQ line.

As MSI and legacy IRQs are already mutually exclusive on the DWC core,
as the core won't forward any legacy IRQs once any MSI has been enabled,
users wishing to use legacy IRQs already need to explictly disable MSI
support (usually via the pci=nomsi kernel commandline option). To avoid
any issues with MSI conflicting with legacy IRQs, just skip all of the
DWC MSI initalization, including the IRQ line claim, when MSI is disabled.

Fixes: 7c5925afbc58 ("PCI: dwc: Move MSI IRQs allocation to IRQ domains hierarchical API")
Tested-by: Tim Harvey <tharvey@gateworks.com>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/controller/dwc/pcie-designware-host.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -439,7 +439,7 @@ int dw_pcie_host_init(struct pcie_port *
 	if (ret)
 		pci->num_viewport = 2;
 
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+	if (IS_ENABLED(CONFIG_PCI_MSI) && pci_msi_enabled()) {
 		/*
 		 * If a specific SoC driver needs to change the
 		 * default number of vectors, it needs to implement


