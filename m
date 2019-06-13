Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A67FC31E4A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30439208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560441401;
	bh=lrKXsr2OjonUOOQWsPIwOl6T08bXjYyq3cI+FJ7ZUYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d1GImY+Hdwz6nWUbJL0gn1fVbOPBk+qW9D+A4qs6p5OgJoZGOnyhiHWYqwDJuNHAj
	 7RcRy0kHBXhNflFfsvJxmxoJ9ciYbxw7GPvt6LsVKkGRhhQVn5M389mBshpQaWAJ8f
	 u6mNXRcn4FKGbw/rC16Hxsuv7+CjBX3fTZZTa5Kw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388987AbfFMP4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:56:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731522AbfFMIvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:51:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BB6E20851;
        Thu, 13 Jun 2019 08:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415868;
        bh=lrKXsr2OjonUOOQWsPIwOl6T08bXjYyq3cI+FJ7ZUYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dC+r3q5Flj0LVRcLtPR5MNKWaAHscUmnbX2VODdz2xEQ9SgGnEuv8AE+GdW9lHbOY
         NN8V27Ksg0vf8BoQh1KuBfAh0E7u9eOYkaPSuQ3wbLSvSBxP2aS9b1fn/phhmf5Ckk
         NKMIcmYBzVPv9z+d0CRcL+sh9xmZZKphNaGpbBAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 126/155] PCI: rcar: Fix 64bit MSI message address handling
Date:   Thu, 13 Jun 2019 10:33:58 +0200
Message-Id: <20190613075659.876498184@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
References: <20190613075652.691765927@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 954b4b752a4c4e963b017ed8cef4c453c5ed308d ]

The MSI message address in the RC address space can be 64 bit. The
R-Car PCIe RC supports such a 64bit MSI message address as well.
The code currently uses virt_to_phys(__get_free_pages()) to obtain
a reserved page for the MSI message address, and the return value
of which can be a 64 bit physical address on 64 bit system.

However, the driver only programs PCIEMSIALR register with the bottom
32 bits of the virt_to_phys(__get_free_pages()) return value and does
not program the top 32 bits into PCIEMSIAUR, but rather programs the
PCIEMSIAUR register with 0x0. This worked fine on older 32 bit R-Car
SoCs, however may fail on new 64 bit R-Car SoCs.

Since from a PCIe controller perspective, an inbound MSI is a memory
write to a special address (in case of this controller, defined by
the value in PCIEMSIAUR:PCIEMSIALR), which triggers an interrupt, but
never hits the DRAM _and_ because allocation of an MSI by a PCIe card
driver obtains the MSI message address by reading PCIEMSIAUR:PCIEMSIALR
in rcar_msi_setup_irqs(), incorrectly programmed PCIEMSIAUR cannot
cause memory corruption or other issues.

There is however the possibility that if virt_to_phys(__get_free_pages())
returned address above the 32bit boundary _and_ PCIEMSIAUR was programmed
to 0x0 _and_ if the system had physical RAM at the address matching the
value of PCIEMSIALR, a PCIe card driver could allocate a buffer with a
physical address matching the value of PCIEMSIALR and a remote write to
such a buffer by a PCIe card would trigger a spurious MSI.

Fixes: e015f88c368d ("PCI: rcar: Add support for R-Car H3 to pcie-rcar")
Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-rcar.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 765c39911c0c..9b9c677ad3a0 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -892,7 +892,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct rcar_msi *msi = &pcie->msi;
-	unsigned long base;
+	phys_addr_t base;
 	int err, i;
 
 	mutex_init(&msi->lock);
@@ -937,8 +937,8 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 	}
 	base = virt_to_phys((void *)msi->pages);
 
-	rcar_pci_write_reg(pcie, base | MSIFE, PCIEMSIALR);
-	rcar_pci_write_reg(pcie, 0, PCIEMSIAUR);
+	rcar_pci_write_reg(pcie, lower_32_bits(base) | MSIFE, PCIEMSIALR);
+	rcar_pci_write_reg(pcie, upper_32_bits(base), PCIEMSIAUR);
 
 	/* enable all MSI interrupts */
 	rcar_pci_write_reg(pcie, 0xffffffff, PCIEMSIIER);
-- 
2.20.1



