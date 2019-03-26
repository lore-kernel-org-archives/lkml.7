Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6F6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8F520856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582071;
	bh=yuuepFgbB5zJsl3IQkZKjQXyVQc8Z6lgF0wkEAQLPZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xkB1QXGPtdRHEi98hNGL+UNULu9Ot9CDB0ZWPkuD5FOSE7c/3TPkuc5fmRHOLnMne
	 ZTtUBQNWWPXxtfn+cNC97Lym6iiZB4uvEzVPD5OujNWYBjnIF8A41acnKotGUoY786
	 2gCdzquAD+MyptTUCnEcdOuz3GoO2Vuz/vuD2dNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731879AbfCZGe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:34:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731869AbfCZGe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:34:27 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F001D2075D;
        Tue, 26 Mar 2019 06:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582066;
        bh=yuuepFgbB5zJsl3IQkZKjQXyVQc8Z6lgF0wkEAQLPZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NOKobFyYzJKmbC/L3M4Se1qEJRk2VUz/L7SD6fK+E4prN2GbWWis8JSyPpk8fodXY
         ld+e1lzeXmaJBFQ84gVxMvvXY1O6KHlfDMBcjHO3Za4NnqSHcdQ19KMt7Qy5zaoZdt
         z5en4+EePODQQ2V8WuI7JGVUxYMJFo2MjyW6Ch6g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <jpinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.14 35/41] PCI: designware-ep: Read-only registers need DBI_RO_WR_EN to be writable
Date:   Tue, 26 Mar 2019 15:30:12 +0900
Message-Id: <20190326042651.810721809@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042649.889479098@linuxfoundation.org>
References: <20190326042649.889479098@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <niklas.cassel@axis.com>

commit 1cab826b30c6275d479a6ab1dea1067e15dbec62 upstream.

Certain registers that pcie-designware-ep tries to write to are read-only
registers. However, these registers can become read/write if we first
enable the DBI_RO_WR_EN bit. Set/unset the DBI_RO_WR_EN bit before/after
writing these registers.

Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Joao Pinto <jpinto@synopsys.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/dwc/pcie-designware-ep.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -35,8 +35,10 @@ static void dw_pcie_ep_reset_bar(struct
 	u32 reg;
 
 	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
+	dw_pcie_dbi_ro_wr_en(pci);
 	dw_pcie_writel_dbi2(pci, reg, 0x0);
 	dw_pcie_writel_dbi(pci, reg, 0x0);
+	dw_pcie_dbi_ro_wr_dis(pci);
 }
 
 static int dw_pcie_ep_write_header(struct pci_epc *epc,
@@ -45,6 +47,7 @@ static int dw_pcie_ep_write_header(struc
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
+	dw_pcie_dbi_ro_wr_en(pci);
 	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, hdr->vendorid);
 	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, hdr->deviceid);
 	dw_pcie_writeb_dbi(pci, PCI_REVISION_ID, hdr->revid);
@@ -58,6 +61,7 @@ static int dw_pcie_ep_write_header(struc
 	dw_pcie_writew_dbi(pci, PCI_SUBSYSTEM_ID, hdr->subsys_id);
 	dw_pcie_writeb_dbi(pci, PCI_INTERRUPT_PIN,
 			   hdr->interrupt_pin);
+	dw_pcie_dbi_ro_wr_dis(pci);
 
 	return 0;
 }
@@ -142,8 +146,10 @@ static int dw_pcie_ep_set_bar(struct pci
 	if (ret)
 		return ret;
 
+	dw_pcie_dbi_ro_wr_en(pci);
 	dw_pcie_writel_dbi2(pci, reg, size - 1);
 	dw_pcie_writel_dbi(pci, reg, flags);
+	dw_pcie_dbi_ro_wr_dis(pci);
 
 	return 0;
 }
@@ -217,7 +223,9 @@ static int dw_pcie_ep_set_msi(struct pci
 	val = dw_pcie_readw_dbi(pci, MSI_MESSAGE_CONTROL);
 	val &= ~MSI_CAP_MMC_MASK;
 	val |= (encode_int << MSI_CAP_MMC_SHIFT) & MSI_CAP_MMC_MASK;
+	dw_pcie_dbi_ro_wr_en(pci);
 	dw_pcie_writew_dbi(pci, MSI_MESSAGE_CONTROL, val);
+	dw_pcie_dbi_ro_wr_dis(pci);
 
 	return 0;
 }


