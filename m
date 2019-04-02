Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70B8C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67922084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QgW1w8E2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfDBF1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 01:27:39 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17030 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfDBF1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 01:27:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca2f2c80001>; Mon, 01 Apr 2019 22:27:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 01 Apr 2019 22:27:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 01 Apr 2019 22:27:38 -0700
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Apr
 2019 05:27:38 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 2 Apr 2019 05:27:37 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.164.1]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca2f2c80001>; Mon, 01 Apr 2019 22:27:37 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>
CC:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <anrao@nvidia.com>, <talho@nvidia.com>,
        <bbiswas@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH V1] mmc: tegra: add sdhci tegra suspend and resume
Date:   Mon, 1 Apr 2019 22:27:33 -0700
Message-ID: <1554182853-31612-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554182856; bh=60mqR9zeYJkjdHLqH4RETBoPqs1ENZaD7JJYT9wSpxo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=QgW1w8E2YXNeDy3DB1dAdYGgZtCg7AlNPNNjUJh+nrO2q8Ng4ttGXRS/gyev2OT2F
         Kb4NQuUSBR8W0fmNKWfTwJhKAKuPPGbe46rCQnRbLnoj/v1BMXxDsrALwQGfW1qy1E
         4q5oS3hOmMffFe/OZU6s6GuQLuO9oxQ+UOyquQcQsXxtOpgsQQnu/LduRRdzIt9eW0
         baD+kvbgZoRdhedhNWbruDjZG8Vu6RRYGmpv2Lxb/5xENczoHChiEW1bGh9lm6BFLX
         bDQW/ZfUn6WxvuE9wYcKG0V1gmqGokP5kb4MNHj9uaK3+ZHKvXIis9GzzB5zDMbtMM
         ssOLWMBShYqDg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds suspend and resume PM ops for tegra SDHCI.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 45 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index eafaaefab4a6..68263ea4a93e 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1611,11 +1611,54 @@ static int sdhci_tegra_remove(struct platform_device *pdev)
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
+	clk_prepare_enable(pltfm_host->clk);
+
+	ret = sdhci_resume_host(host);
+	if (ret)
+		return ret;
+
+	if (host->mmc->caps2 & MMC_CAP2_CQE)
+		return cqhci_resume(host->mmc);
+
+	return 0;
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

