Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568CAC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205AA20679
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560441571;
	bh=QXO6KMAi//p5OKgiiB8eqhvn4lP9izoheJSoNKegOUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tSRjPz+AGxVfxThQL79UkJZ5rDQVoPM14dqAPJs2LNrKt0M+1JC56ZaspidpFF1JZ
	 GBqA+1HVxvh8jHuNaxkoYHglj3N4F3wBENmeR6PDJOhLaIDBzy/PZSdkUPPfg+bbVg
	 +ogiTfk/gdsTrfEYiF7l+L3Dwm0taCVx6cnTiYdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390228AbfFMP7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:59:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731485AbfFMItq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:49:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4E43206BA;
        Thu, 13 Jun 2019 08:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415786;
        bh=QXO6KMAi//p5OKgiiB8eqhvn4lP9izoheJSoNKegOUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yH35c+8oPZBKgDpjwAxpCj7zKjxT2i98CFeTDUPGXWaKCfJktRjK5SdUnvfog0mvJ
         2pvupFZiF5N0UbExLaUAvhngiZ1JuzaQhG2eKTj9DeFb0k7nXLlo9RN27bp/01dHme
         od2GVhU8r1EPZTk5aZMbOWjH2Gx7hmR1coNani3s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 097/155] PCI: keystone: Invoke phy_reset() API before enabling PHY
Date:   Thu, 13 Jun 2019 10:33:29 +0200
Message-Id: <20190613075658.492671914@linuxfoundation.org>
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

[ Upstream commit b22af42b3e57c3a49a4c4a54c7d8a1363af75e90 ]

SERDES connected to the PCIe controller in AM654 requires
power on reset enable (POR_EN) to be set in the SERDES. The
SERDES driver sets POR_EN in the reset ops and it has to be
invoked before init or enable ops. In order for SERDES driver
to set POR_EN, invoke the phy_reset() API in pci-keystone driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pci-keystone.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 14f2b0b4ed5e..94bd31b255a4 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -873,6 +873,10 @@ static int ks_pcie_enable_phy(struct keystone_pcie *ks_pcie)
 	int num_lanes = ks_pcie->num_lanes;
 
 	for (i = 0; i < num_lanes; i++) {
+		ret = phy_reset(ks_pcie->phy[i]);
+		if (ret < 0)
+			goto err_phy;
+
 		ret = phy_init(ks_pcie->phy[i]);
 		if (ret < 0)
 			goto err_phy;
-- 
2.20.1



