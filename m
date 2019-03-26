Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A549C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E982075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582735;
	bh=dTe/+VBP+uK9EEcRhTpGkpbX1XfnOqLR8cqikRR8xXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ItD+wfD16+TfuyCZgWbg0R/jJs+Qnq/f+WfxLmDsXR3Ju1PT6miQ+bTYHDKV5BRyb
	 2ZI6dapUDHl3XK6AiEL/jz18dVILkOCMe/NapXhchC5eFYa8CJMLex52MaJOnGp/wt
	 azYMt3S3ptI+GaTgnI1SAo2B/yR1hRrFkICprxJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbfCZGe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:34:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731441AbfCZGeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:34:23 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C8F2206C0;
        Tue, 26 Mar 2019 06:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582062;
        bh=dTe/+VBP+uK9EEcRhTpGkpbX1XfnOqLR8cqikRR8xXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hrOiTSOQloz4IaYoiKPSiNbCXoi2WVSDiVBELDEovXbtqff19sDYMci3o5acdvWD4
         Ha+M1UJNjsSrv8vryLBZxaA5LKTiDr/aE8hVGxhRBigGblrWdPQM6FaY0DvdEb5NHB
         qwZ51w3q22frTsk51IvGTHkiGrQLvWSYgu/O59EE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <jpinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.14 34/41] PCI: designware-ep: dw_pcie_ep_set_msi() should only set MMC bits
Date:   Tue, 26 Mar 2019 15:30:11 +0900
Message-Id: <20190326042651.750249866@linuxfoundation.org>
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

commit 099a95f3591ade29da52131895a3ba9f92a0e82c upstream.

Previously, dw_pcie_ep_set_msi() wrote all bits in the Message Control
register, thus overwriting the PCI_MSI_FLAGS_64BIT bit.
By clearing the PCI_MSI_FLAGS_64BIT bit, we break MSI
on systems where the RC has set a 64 bit MSI address.
Fix dw_pcie_ep_set_msi() so that it only sets MMC bits.

Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Joao Pinto <jpinto@synopsys.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/dwc/pcie-designware-ep.c |    4 +++-
 drivers/pci/dwc/pcie-designware.h    |    1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/pci/dwc/pcie-designware-ep.c
+++ b/drivers/pci/dwc/pcie-designware-ep.c
@@ -214,7 +214,9 @@ static int dw_pcie_ep_set_msi(struct pci
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	val = (encode_int << MSI_CAP_MMC_SHIFT);
+	val = dw_pcie_readw_dbi(pci, MSI_MESSAGE_CONTROL);
+	val &= ~MSI_CAP_MMC_MASK;
+	val |= (encode_int << MSI_CAP_MMC_SHIFT) & MSI_CAP_MMC_MASK;
 	dw_pcie_writew_dbi(pci, MSI_MESSAGE_CONTROL, val);
 
 	return 0;
--- a/drivers/pci/dwc/pcie-designware.h
+++ b/drivers/pci/dwc/pcie-designware.h
@@ -99,6 +99,7 @@
 
 #define MSI_MESSAGE_CONTROL		0x52
 #define MSI_CAP_MMC_SHIFT		1
+#define MSI_CAP_MMC_MASK		(7 << MSI_CAP_MMC_SHIFT)
 #define MSI_CAP_MME_SHIFT		4
 #define MSI_CAP_MSI_EN_MASK		0x1
 #define MSI_CAP_MME_MASK		(7 << MSI_CAP_MME_SHIFT)


