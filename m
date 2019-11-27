Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E64C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0148E20665
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574890218;
	bh=mdj7XPfQr7aTT3QJ1EjZS6B280N60fbSQCKhLUyoZvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xynR+F+OPs3qRGuaVz7Eqcin551bX/q/PZUKxNvfn94ekY6CO7xHiFNJV8EMi/Suc
	 6ii8xGE/Np4kgrhEurHQGTj8+KkuPtBRFa4KipYH7mKOwlkAb/AThxcz5n24X9zyww
	 zuoCQ+zpr7Jv/Y3dpDqJgq8PqQNSmttwpu8psadg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731391AbfK0VaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:30:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:46708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731017AbfK0U4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:56:00 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AA082084D;
        Wed, 27 Nov 2019 20:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888160;
        bh=mdj7XPfQr7aTT3QJ1EjZS6B280N60fbSQCKhLUyoZvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YmTwYmY14XQ97vVEy1LPhK/fjSK9o69Le4yFmU2v8WEZnAHed15feS1z8VxYUUw6a
         lBwDKLoeDzsrKeH+ysU4KvVP4XFvc7+b/IG3/f9z19O3lHO59vdYmaA+EZiPVifp+D
         bJFj2bmD/ITshCaJKfQvd/5QYp+P7ZvXY131mrAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Douglas <adouglas@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 027/306] PCI: cadence: Write MSI data with 32bits
Date:   Wed, 27 Nov 2019 21:27:57 +0100
Message-Id: <20191127203116.673854739@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Douglas <adouglas@cadence.com>

[ Upstream commit e81e36a96bb56f243b5ac1d114c37c086761595b ]

According to the PCIe specification, although the MSI data is only
16bits, the upper 16bits should be written as 0. Use writel
instead of writew when writing the MSI data to the host.

Fixes: 37dddf14f1ae ("PCI: cadence: Add EndPoint Controller driver for Cadence PCIe controller")
Signed-off-by: Alan Douglas <adouglas@cadence.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-cadence-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index 6692654798d44..c3a088910f48d 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -355,7 +355,7 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
 		ep->irq_pci_addr = (pci_addr & ~pci_addr_mask);
 		ep->irq_pci_fn = fn;
 	}
-	writew(data, ep->irq_cpu_addr + (pci_addr & pci_addr_mask));
+	writel(data, ep->irq_cpu_addr + (pci_addr & pci_addr_mask));
 
 	return 0;
 }
-- 
2.20.1



