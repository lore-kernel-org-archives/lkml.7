Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A43C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7250F20828
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="imFsa2XJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfDAM61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:58:27 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53630 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfDAM60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:58:26 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x31CwNa3054889;
        Mon, 1 Apr 2019 07:58:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554123503;
        bh=/WZ0nmtJalOQ39xsVFyhHuowPr0IYLoO9c7XQAIED3I=;
        h=From:To:CC:Subject:Date;
        b=imFsa2XJfdhA0VIspkgpd2pHaXUq75EGtybJJQ5Q7zx3LAsyGbhedgXUTG9VNllDr
         yZuqORjOteSTNXMtMIDDoleVZV4CDmwCTLCKtTjkoaSvAjETYNtvGmWvrBul3MFeL+
         xkj7oSvhKKQER0axrK3pt3r02x5rQCo95vluEib8=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x31CwNLR066614
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Apr 2019 07:58:23 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 1 Apr
 2019 07:58:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 1 Apr 2019 07:58:23 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x31CwLOD083714;
        Mon, 1 Apr 2019 07:58:21 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH v2] mmc: sdhci_am654: Clear HISPD_ENA in some lower speed modes
Date:   Mon, 1 Apr 2019 18:28:04 +0530
Message-ID: <20190401125804.5665-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the AM654x Data Manual[1], the setup timing in lower speed
modes can only be met if the controller uses a falling edge data launch.

To ensure this, the HIGH_SPEED_ENA (HOST_CONTROL[2]) bit should be
cleared in default speed, SD high speed, MMC high speed, SDR12 and SDR25
speed modes.

Use the sdhci writeb callback to implement this condition.

[1] http://www.ti.com/lit/gpn/am6546 Section 5.10.5.16.1

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---

v2: Dropped QUIRK in favour of writeb callback

 drivers/mmc/host/Kconfig       |  1 +
 drivers/mmc/host/sdhci_am654.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 28fcd8f580a1..6379fba8b122 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -993,6 +993,7 @@ config MMC_SDHCI_OMAP
 config MMC_SDHCI_AM654
 	tristate "Support for the SDHCI Controller in TI's AM654 SOCs"
 	depends on MMC_SDHCI_PLTFM && OF
+	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  support present in TI's AM654 SOCs. The controller supports
diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index eea183e90f1b..a91c0b45c48d 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -158,6 +158,27 @@ static void sdhci_am654_set_power(struct sdhci_host *host, unsigned char mode,
 	sdhci_set_power_noreg(host, mode, vdd);
 }
 
+static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
+{
+	unsigned char timing = host->mmc->ios.timing;
+
+	if (reg == SDHCI_HOST_CONTROL) {
+		switch (timing) {
+		/*
+		 * According to the data manual, HISPD bit
+		 * should not be set in these speed modes.
+		 */
+		case MMC_TIMING_SD_HS:
+		case MMC_TIMING_MMC_HS:
+		case MMC_TIMING_UHS_SDR12:
+		case MMC_TIMING_UHS_SDR25:
+			val &= ~SDHCI_CTRL_HISPD;
+		}
+	}
+
+	writeb(val, host->ioaddr + reg);
+}
+
 static struct sdhci_ops sdhci_am654_ops = {
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
@@ -165,6 +186,7 @@ static struct sdhci_ops sdhci_am654_ops = {
 	.set_bus_width = sdhci_set_bus_width,
 	.set_power = sdhci_am654_set_power,
 	.set_clock = sdhci_am654_set_clock,
+	.write_b = sdhci_am654_write_b,
 	.reset = sdhci_reset,
 };
 
-- 
2.19.2

