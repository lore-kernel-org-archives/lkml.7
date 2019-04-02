Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37476C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046C82075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jpczT4v1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731653AbfDBRh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:37:27 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9392 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDBRh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 13:37:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca39dd30001>; Tue, 02 Apr 2019 10:37:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 02 Apr 2019 10:37:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 02 Apr 2019 10:37:26 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Apr
 2019 17:37:26 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Apr
 2019 17:37:25 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 2 Apr 2019 17:37:25 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.164.1]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca39dd40000>; Tue, 02 Apr 2019 10:37:25 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>
CC:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <anrao@nvidia.com>, <talho@nvidia.com>,
        <bbiswas@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH V2] mmc: tegra: add sdhci tegra suspend and resume
Date:   Tue, 2 Apr 2019 10:37:21 -0700
Message-ID: <1554226641-22612-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554226644; bh=lrs3Vk1qpdmLzDtMnrx06ZkP+VBCh6yxyQVZEMJHEBc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=jpczT4v1MP7QCD7teVf073yye0DTeYeM7DAQ34jhqLVXvdGMBQKHo7roZBRE0m+s/
         zg0kn4PyYA1TzFS28vvo8DAwllXRAvyglYHD9YnfFHmWyv8RcmHfnQi1lE73VB78Y/
         /GD3McFwLxpWTUphwIdSokATpbo8gu5XAGI30VMC4Iw1NIEH4oCOn9qKQJgNgSWaUH
         bm+IZkqme21NdbWZ7vLz8hB7VY1k619FjYPmoWGODwPFUDA6ahf12WuvCQ4QTEM6hi
         /FpxVOdJN6WW675vrsGQD9bExzFN2xl3FLXmG5gvTL0HH/fIZ09IWM9uczTNmAVW7a
         w8ZmPrtgKlMrA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds suspend and resume PM ops for tegra SDHCI.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 56 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index eafaaefab4a6..6c91926a012c 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1611,11 +1611,65 @@ static int sdhci_tegra_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int sdhci_tegra_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	int ret;
+
+	if (host->mmc->caps2 & MMC_CAP2_CQE) {
+		ret = cqhci_suspend(host->mmc);
+		if (ret)
+			return ret;
+	}
+
+	ret = sdhci_suspend_host(host);
+	if (ret)
+		return ret;
+
+	clk_disable_unprepare(pltfm_host->clk);
+	return 0;
+}
+
+static int sdhci_tegra_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	int ret;
+
+	ret = clk_prepare_enable(pltfm_host->clk);
+	if (ret)
+		return ret;
+
+	ret = sdhci_resume_host(host);
+	if (ret)
+		goto disable_clk;
+
+	if (host->mmc->caps2 & MMC_CAP2_CQE) {
+		ret = cqhci_resume(host->mmc);
+		if (ret)
+			goto suspend_host;
+	}
+
+	return 0;
+
+suspend_host:
+	sdhci_suspend_host(host);
+disable_clk:
+	clk_disable_unprepare(pltfm_host->clk);
+	return ret;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(sdhci_tegra_dev_pm_ops, sdhci_tegra_suspend,
+			 sdhci_tegra_resume);
+
 static struct platform_driver sdhci_tegra_driver = {
 	.driver		= {
 		.name	= "sdhci-tegra",
 		.of_match_table = sdhci_tegra_dt_match,
-		.pm	= &sdhci_pltfm_pmops,
+		.pm	= &sdhci_tegra_dev_pm_ops,
 	},
 	.probe		= sdhci_tegra_probe,
 	.remove		= sdhci_tegra_remove,
-- 
2.7.4

