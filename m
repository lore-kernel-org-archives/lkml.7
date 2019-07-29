Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5117EC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2102F2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429746;
	bh=vaANCP3glYXdOd8WXkfUWMyFhWN+1pq/iZnNAFKtP3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ksruxtan2UQWG9XJ+4f3e8WpOOO83Z7pj2LZT/dUwLWus3vJEJR0RdFG1iGFDSVdU
	 vIoBDbbG9CyEAvAf9G6LUKkjaM/E5JFajtO8jWkyzCXWa+YhFyyc3k8Pc0COZbbRJl
	 Bjt7+VGwfXo7It8uXAkLBuR9ZmaRuX98KVj+cTBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390460AbfG2TtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:49:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390281AbfG2TtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:49:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DEB32054F;
        Mon, 29 Jul 2019 19:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429741;
        bh=vaANCP3glYXdOd8WXkfUWMyFhWN+1pq/iZnNAFKtP3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kmcWQRMVTIijiKWzOmB0r+X/bTN5BHiPvooqjwoxlZnRzm/MAfB7wq/Ffy/vaNYzg
         BMjdiTV/v4/plX9H3iUYDmIPppeXAXozBb4V3IGzPdFawSa+t8U3lh9GInfcOdi2AX
         68sZmWOio+V5pPOlUJTjOcnuY7IiNXmVsXjtnGMk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Raul E Rangel <rrangel@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 073/215] mmc: sdhci: sdhci-pci-o2micro: Check if controller supports 8-bit width
Date:   Mon, 29 Jul 2019 21:21:09 +0200
Message-Id: <20190729190752.828870521@linuxfoundation.org>
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
index dd21315922c8..9dc4548271b4 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -395,11 +395,21 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
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



