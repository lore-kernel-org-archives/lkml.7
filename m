Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FC3C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91FC217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564430443;
	bh=gTOeOC5VmGuItE7SqR1J06FTqVJudN8LyY0SgeGDW4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dMhr0XXVHtWe5c8lBIMa/hnYM+fIm2oQXlQdHSJod8zJhb7WKHeXDcApQPfBBZCOS
	 h0RiRS5tneW+HmzHddQ+5TOlTcHp/LOz2rzgJIL/4vrnV3NBAHzdmSSZKSMNCeFLvm
	 pMfXcluX20NDeoR2U7WI15mxBRQFmG5d+OfX9+Z4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390286AbfG2TwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:52:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390791AbfG2TvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:51:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97975205F4;
        Mon, 29 Jul 2019 19:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429872;
        bh=gTOeOC5VmGuItE7SqR1J06FTqVJudN8LyY0SgeGDW4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=teIp+lS14h/FbBs/iRm/Qt+Sttr6VZT6Y8ztTJpeCnR83phSUNUNSRbnN0hXMcLgM
         2wzL4DkXD9iWXAY7CSFqmpr+d+KB6CAdQ2g+FlrFnm+yWVZ1EnDe3ElKGc+jcNrbWb
         3WE+pZob7cYoFtt4D+lJ0SsmY1wtlUX9tQB6bH6I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Minghuan Lian <Minghuan.Lian@nxp.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 115/215] PCI: mobiveil: Fix the Class Code field
Date:   Mon, 29 Jul 2019 21:21:51 +0200
Message-Id: <20190729190758.970953197@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



