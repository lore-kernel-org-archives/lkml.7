Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BB7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4972054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257733;
	bh=/Tbw90IXv9EF2getQiOMp83wkLhdTYSq9xM1Yqv21CU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2PIuQ/B1meYjxC8IEUm+yEB267NjBiyjJgMG555yf2qR+UtV0VT6eLtXGk9A72x7O
	 pQWBj8jfHdCVCfRObTSErOuV/MLWx76Nue/qIsIAr3lSefne20oLmg+bnze3jlCWbX
	 5Dbo8L8GkfzhDbBMKf+gmhHpe65OiOD/BndI/u1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390878AbfCVM2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:28:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390102AbfCVMT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:19:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD356218A1;
        Fri, 22 Mar 2019 12:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257196;
        bh=/Tbw90IXv9EF2getQiOMp83wkLhdTYSq9xM1Yqv21CU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rUvexgC0LWxxZB42xuDvZdHD+OdgrIMGVmiM3k2oQlAOnneUIiFnYnIRhI506uZks
         RV0NmxdimFYulPYeXI9r1bGzjqlI3iHltsK8xUgiBlf+hdZATVyV4amvSO0r1Ly11V
         aEOdZVNXAqMfBkzN2w1k5nHPw3AlvhE7pjKvQ7IE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH 5.0 130/238] PCI: dwc: skip MSI init if MSIs have been explicitly disabled
Date:   Fri, 22 Mar 2019 12:15:49 +0100
Message-Id: <20190322111306.161841895@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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


