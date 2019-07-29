Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95AFC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6512064C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564430741;
	bh=dEuEHs4GsP7bekn11dR5FNyO4oT3Y+XEYEwe9AxXBDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hKczEn3x0bjmSPwVajTHpXLR2PrQowH5ZKIpLlQiwfJBhRDpUwiQmBEhMXJLq6yJ4
	 d9HipjrbeYNyCHDOa558ytUqcH4Vpo3Ydq+RcKV/4AWbWSuNeYafmckUfDCSoSAq56
	 ZKRdaSDfm7UN1aQOnaT2HN2j2fa2DRa5SjDrHOLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389009AbfG2Tmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:42:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389526AbfG2Tmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:42:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B72C1217F5;
        Mon, 29 Jul 2019 19:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429358;
        bh=dEuEHs4GsP7bekn11dR5FNyO4oT3Y+XEYEwe9AxXBDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KOBt2WFTpVyryW444mWcZdFHstlzelwSUIXhnGRZVAq164Hbgc9Zi857GHSKqI9Rs
         eJS4hfzTE9doJyDWb7I1DipLLCW2J/FtYrC/O4aLmAIZOggy+2C5fGcFaCcjbEsvv3
         MOXqAVNuVRBIlgE7LmYv0Bz5EQDOVeiYlszZcjVo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Raul E Rangel <rrangel@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 035/113] mmc: sdhci: sdhci-pci-o2micro: Check if controller supports 8-bit width
Date:   Mon, 29 Jul 2019 21:22:02 +0200
Message-Id: <20190729190704.162266984@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190655.455345569@linuxfoundation.org>
References: <20190729190655.455345569@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit de23f0b757766d9fae59df97da6e8bdc5b231351 ]

The O2 controller supports 8-bit EMMC access.

JESD84-B51 section A.6.3.a defines the bus testing procedure that
`mmc_select_bus_width()` implements. This is used to determine the actual
bus width of the eMMC.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index fa8d9da2ab7f..e248d7945c06 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -290,11 +290,21 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 {
 	struct sdhci_pci_chip *chip;
 	struct sdhci_host *host;
-	u32 reg;
+	u32 reg, caps;
 	int ret;
 
 	chip = slot->chip;
 	host = slot->host;
+
+	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
+
+	/*
+	 * mmc_select_bus_width() will test the bus to determine the actual bus
+	 * width.
+	 */
+	if (caps & SDHCI_CAN_DO_8BIT)
+		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
+
 	switch (chip->pdev->device) {
 	case PCI_DEVICE_ID_O2_SDS0:
 	case PCI_DEVICE_ID_O2_SEABIRD0:
-- 
2.20.1



