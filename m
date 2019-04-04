Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0540C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E718205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370216;
	bh=WTSEa6yiCfqAIwNANgSK8bRTQ1rfWjdG29g/uArCGWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2fbuDupNVD7pN1syB1bAVXD4Gn/Z7E3i0YAwubXjCVm0dOkRi5IL8pp3jIEdFWdbv
	 KRVrLoHP6ron1Z6NcbpxMfUBx8jj5lhb6VmTv1uPaaq6kLyWWgrgV/19ym/1qVv2s+
	 TB8sbX7LvvcUHq3mNK++uA0wVnhbjIEdVYoZDPjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733267AbfDDJaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:30:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732540AbfDDJKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:10:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17E1220855;
        Thu,  4 Apr 2019 09:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369017;
        bh=WTSEa6yiCfqAIwNANgSK8bRTQ1rfWjdG29g/uArCGWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RoeE9NgOM67vqsnYy4phwpzUvqtCAMmNJbBU7nJ4+vtR3WlVs8S5RKsvPfUfwmhSp
         5gTEv0ngggM68AF1ME5Wz+2FWbTOJTfGlYmIVJ6e7+BAilZQKmxVreVVw1iBrFi8pb
         5JCJifDZsIIkVW9mk3PY5HOlI6dA0ysKGYCGmKrM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Honghui Zhang <honghui.zhang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 050/246] PCI: mediatek: Fix memory mapped IO range size computation
Date:   Thu,  4 Apr 2019 10:45:50 +0200
Message-Id: <20190404084620.771098024@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

[ Upstream commit c61df57343bf05743f8abbb31eec9a6f05820dd1 ]

Mediatek's HW assigns a MMIO address range (typically starts from
0x20000000 to 0x2fffffff for both mt2712 and mt7622) for PCI usage.

This MMIO address space represents the address space that can
be allocated to PCI devices through Base Address Registers.

Even though the full MMIO address range is available to be allocated, it
should be enabled by the PCIE_AHB_TRANS_BASE register in the host
controller and the size that is enabled is determined by AHB2PCIE_SIZE
bits in this register.

Owing to a bug in the MMIO window size computation, current code does
not enable the full size of the available MMIO address range in the
PCI host controller; if the PCI devices BARs requested size exceeds the
size enabled through the PCIE_AHB_TRANS_BASE register the requests
targeting the disabled address address space will be blocked by the root
complex causing a system error.

Existing code has never run into a system error in production because
even half of the enabled MMIO range (128MB) is big enough for typical
devices BAR requests (4MB) but the full MMIO address range should
be enabled regardless.

Fix the MMIO window size computation by using resource_size(mem) instead
of mem->end - mem->start.

Since the MMIO window size for both MT2712 and MT7622 is 0x10000000,
this change will update the parameter passed to fls() from 0xfffffff to
0x10000000 and calculate the whole memory mapped IO range size
correctly.

Detected through coccinelle semantic patch (and related warning):

scripts/coccinelle/api/resource_size.cocci:

pcie-mediatek.c:720:13-16: WARNING: Suspicious code. resource_size is maybe missing with mem

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
[lorenzo.pieralisi@arm.com: rewrote the commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-mediatek.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 55e471c18e8d..c42fe5c4319f 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -654,7 +654,6 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	struct resource *mem = &pcie->mem;
 	const struct mtk_pcie_soc *soc = port->pcie->soc;
 	u32 val;
-	size_t size;
 	int err;
 
 	/* MT7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
@@ -706,8 +705,8 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 		mtk_pcie_enable_msi(port);
 
 	/* Set AHB to PCIe translation windows */
-	size = mem->end - mem->start;
-	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(size));
+	val = lower_32_bits(mem->start) |
+	      AHB2PCIE_SIZE(fls(resource_size(mem)));
 	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
 
 	val = upper_32_bits(mem->start);
-- 
2.19.1



