Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49BDC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 07:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4272071B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 07:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MweProfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfKRHfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 02:35:24 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39550 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfKRHfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 02:35:24 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAI7ZG6r099577;
        Mon, 18 Nov 2019 01:35:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574062516;
        bh=jAuRpekXF3jtoawWT7hGxk6T2pAz5AKTl9w23pKdMXY=;
        h=From:To:CC:Subject:Date;
        b=MweProfqMkKsL3KxQc0UkuH2LV3TiUL1OOFsctkFlJ8Yt2I2MYiFnj4UvNDQZv7b6
         C/cUsvcAXOGnf1xYtncRgO6Vf56jA3QOsui/74mKGujG25wVXQ4hTtMUTCJ8LweIdj
         7DPAeznZ2X//7+9c2yaJsJis4wbf5d66ECkxo9zA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAI7ZFhH124319
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Nov 2019 01:35:16 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 18
 Nov 2019 01:35:15 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 18 Nov 2019 01:35:15 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAI7ZDYI011349;
        Mon, 18 Nov 2019 01:35:14 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <faiz_abbas@ti.com>
Subject: [PATCH v2] mmc: sdhci_am654: Add Support for Command Queuing Engine to J721E
Date:   Mon, 18 Nov 2019 13:06:09 +0530
Message-ID: <20191118073609.22921-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Support for CQHCI (Command Queuing Host Controller Interface)
for each of the host controllers present in TI's J721E devices.
Add cqhci_ops and a .irq() callback to handle cqhci specific interrupts.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Reported-by: kbuild test robot <lkp@intel.com>
---

v2: Dropped CONFIG_ prefix from select MMC_CQHCI which led to build
failures. Successfully built with the .config provided by the kbuild test robot.

 drivers/mmc/host/Kconfig       |  1 +
 drivers/mmc/host/sdhci_am654.c | 71 +++++++++++++++++++++++++++++++++-
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 49ea02c467bf..7c1310ed26c6 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -1011,6 +1011,7 @@ config MMC_SDHCI_AM654
 	tristate "Support for the SDHCI Controller in TI's AM654 SOCs"
 	depends on MMC_SDHCI_PLTFM && OF && REGMAP_MMIO
 	select MMC_SDHCI_IO_ACCESSORS
+	select MMC_CQHCI
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  support present in TI's AM654 SOCs. The controller supports
diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index bb90757ecace..b8e897e31e2e 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -12,6 +12,7 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 
+#include "cqhci.h"
 #include "sdhci-pltfm.h"
 
 /* CTL_CFG Registers */
@@ -68,6 +69,9 @@
 
 #define CLOCK_TOO_SLOW_HZ	400000
 
+/* Command Queue Host Controller Interface Base address */
+#define SDHCI_AM654_CQE_BASE_ADDR 0x200
+
 static struct regmap_config sdhci_am654_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
@@ -259,6 +263,19 @@ static const struct sdhci_am654_driver_data sdhci_am654_drvdata = {
 	.flags = IOMUX_PRESENT | FREQSEL_2_BIT | STRBSEL_4_BIT | DLL_PRESENT,
 };
 
+static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)
+{
+	int cmd_error = 0;
+	int data_error = 0;
+
+	if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
+		return intmask;
+
+	cqhci_irq(host->mmc, intmask, cmd_error, data_error);
+
+	return 0;
+}
+
 static struct sdhci_ops sdhci_j721e_8bit_ops = {
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
@@ -267,6 +284,7 @@ static struct sdhci_ops sdhci_j721e_8bit_ops = {
 	.set_power = sdhci_am654_set_power,
 	.set_clock = sdhci_am654_set_clock,
 	.write_b = sdhci_am654_write_b,
+	.irq = sdhci_am654_cqhci_irq,
 	.reset = sdhci_reset,
 };
 
@@ -290,6 +308,7 @@ static struct sdhci_ops sdhci_j721e_4bit_ops = {
 	.set_power = sdhci_am654_set_power,
 	.set_clock = sdhci_j721e_4bit_set_clock,
 	.write_b = sdhci_am654_write_b,
+	.irq = sdhci_am654_cqhci_irq,
 	.reset = sdhci_reset,
 };
 
@@ -304,6 +323,40 @@ static const struct sdhci_am654_driver_data sdhci_j721e_4bit_drvdata = {
 	.pdata = &sdhci_j721e_4bit_pdata,
 	.flags = IOMUX_PRESENT,
 };
+
+static void sdhci_am654_dumpregs(struct mmc_host *mmc)
+{
+	sdhci_dumpregs(mmc_priv(mmc));
+}
+
+static const struct cqhci_host_ops sdhci_am654_cqhci_ops = {
+	.enable		= sdhci_cqe_enable,
+	.disable	= sdhci_cqe_disable,
+	.dumpregs	= sdhci_am654_dumpregs,
+};
+
+static int sdhci_am654_cqe_add_host(struct sdhci_host *host)
+{
+	struct cqhci_host *cq_host;
+	int ret;
+
+	cq_host = devm_kzalloc(host->mmc->parent, sizeof(struct cqhci_host),
+			       GFP_KERNEL);
+	if (!cq_host)
+		return -ENOMEM;
+
+	cq_host->mmio = host->ioaddr + SDHCI_AM654_CQE_BASE_ADDR;
+	cq_host->quirks |= CQHCI_QUIRK_SHORT_TXFR_DESC_SZ;
+	cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
+	cq_host->ops = &sdhci_am654_cqhci_ops;
+
+	host->mmc->caps2 |= MMC_CAP2_CQE;
+
+	ret = cqhci_init(cq_host, host->mmc, 1);
+
+	return ret;
+}
+
 static int sdhci_am654_init(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -344,7 +397,23 @@ static int sdhci_am654_init(struct sdhci_host *host)
 	regmap_update_bits(sdhci_am654->base, CTL_CFG_2, SLOTTYPE_MASK,
 			   ctl_cfg_2);
 
-	return sdhci_add_host(host);
+	ret = sdhci_setup_host(host);
+	if (ret)
+		return ret;
+
+	ret = sdhci_am654_cqe_add_host(host);
+	if (ret)
+		goto err_cleanup_host;
+
+	ret = __sdhci_add_host(host);
+	if (ret)
+		goto err_cleanup_host;
+
+	return 0;
+
+err_cleanup_host:
+	sdhci_cleanup_host(host);
+	return ret;
 }
 
 static int sdhci_am654_get_of_property(struct platform_device *pdev,
-- 
2.19.2

