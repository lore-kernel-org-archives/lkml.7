Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63232C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9B0214D9
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383425;
	bh=RZZgYD1fyG5xCQcGnFdd9/9L3RDH6oeyniowEFWObRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sLlDIunGBl4kGmeRYBEpJMTcTEnvMMFLW6l0JIwSZMbueffIxbpcAAAI7AVN8SmcH
	 d5YIOJc3QnbimJy610z/MvskmPssj2Wh/vKFpIBDbv4BbvhAJy8UT3mXPuok+nvMiq
	 Hxf96ylqYbgMgc7VKlFARym1A3JI9ElEtKgPJmUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbfJFRhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:37:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730375AbfJFRhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:37:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 680CE20862;
        Sun,  6 Oct 2019 17:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383421;
        bh=RZZgYD1fyG5xCQcGnFdd9/9L3RDH6oeyniowEFWObRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b2pWoeB66I2Ih/JNislZf+A3FUSvO0Roz+xJL81hucJsADdTjA9+06VhdHdcvRgSf
         BMQbFrhOpYR9zcKCabbZa85OCxFmh3GrrEDeMdL41WdY3d7LEYpWD3N2ksQo9kV08B
         l84FJneQbV0qWEV3axhwr9Zonf81wLhC6WG2bFXA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiaowei Bao <xiaowei.bao@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 099/137] PCI: layerscape: Add the bar_fixed_64bit property to the endpoint driver
Date:   Sun,  6 Oct 2019 19:21:23 +0200
Message-Id: <20191006171217.159263456@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171209.403038733@linuxfoundation.org>
References: <20191006171209.403038733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaowei Bao <xiaowei.bao@nxp.com>

[ Upstream commit fd5d16531a39322c3d7433d9f8a36203c9aaeddc ]

The layerscape PCIe controller have 4 BARs.

 BAR0 and BAR1 are 32bit, BAR2 and BAR4 are 64bit and that's a
fixed hardware configuration.

Set the bar_fixed_64bit variable accordingly.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
[lorenzo.pieralisi@arm.com: commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pci-layerscape-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index be61d96cc95ed..ca9aa4501e7e9 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -44,6 +44,7 @@ static const struct pci_epc_features ls_pcie_epc_features = {
 	.linkup_notifier = false,
 	.msi_capable = true,
 	.msix_capable = false,
+	.bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4),
 };
 
 static const struct pci_epc_features*
-- 
2.20.1



