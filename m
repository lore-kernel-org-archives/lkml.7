Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2704C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC2C218C5
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563509335;
	bh=GCknv2iR1X3DAJdVXiOIgIt2QQqLeu1ocCWVTs0WptI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OdkBX0m9nAiXBcZx2QyUm2sEpg/yUNC2m2dspTshfZDVsR1VZyx1P6eVNeG+SlJz2
	 bVqr7lbTOH/ITY70Zol4ichGySILHxfUUlWvob/Y/rZnP+Sv2QRrGbVxVBI3kUVaCI
	 0kPSZuG+HAeNanHe/F4TGKF6SNBA/XkTrnArqavI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731717AbfGSEIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:08:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731912AbfGSEIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:08:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6463218BB;
        Fri, 19 Jul 2019 04:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509330;
        bh=GCknv2iR1X3DAJdVXiOIgIt2QQqLeu1ocCWVTs0WptI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rk0Bdamqhh9kOkxY0ujwG9C4PkweiNnSersDdrLpRh1OjYIu40xXQMBnIrJN9tcia
         hCwUzpaHepyWJXqLIbuuQ7R4pDO+FPsFNwRm06u9iSpn5ubU69BIsFWgRXA/Sa6ZNP
         L1eCXk5k+SSec33WLk7R51A1lQzGojrsWujQ/is0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Raul E Rangel <rrangel@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 037/101] mmc: sdhci: sdhci-pci-o2micro: Check if controller supports 8-bit width
Date:   Fri, 19 Jul 2019 00:06:28 -0400
Message-Id: <20190719040732.17285-37-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719040732.17285-1-sashal@kernel.org>
References: <20190719040732.17285-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raul E Rangel <rrangel@chromium.org>

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

