Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15D1C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AE82083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ij4qDino"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfDKTSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:18:24 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18688 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfDKTSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 15:18:23 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5caf93030000>; Thu, 11 Apr 2019 12:18:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 11 Apr 2019 12:18:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 11 Apr 2019 12:18:22 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 19:18:22 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Apr
 2019 19:18:22 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 11 Apr 2019 19:18:22 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.48]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5caf92fe0000>; Thu, 11 Apr 2019 12:18:22 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <skomatineni@nvidia.com>, <talho@nvidia.com>, <anrao@nvidia.com>,
        <bbiswas@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH V4] mmc: tegra: add sdhci tegra suspend and resume
Date:   Thu, 11 Apr 2019 12:18:19 -0700
Message-ID: <1555010299-19141-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555010307; bh=EzqXe8EIS6+c4hrJgaK3KbfTxED6BK/NCfoTo6wKTvk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=ij4qDino/ShdScl/+BV4NYsWUDixFhJfs7nJWXDGEuR2EjRIODeo1FEOMwukP4Nw8
         ei0ee0auglJLZj4lwFvtgUjQoSIO5bOWgz9LtBXR+s2F9TuBxXPtl4FuwQVUqEgB5/
         qcZOqa1Qe15zF92MlgtSxx8E60WTp3sRpc/rUJhj2rCQ3Ho+kxuRMNx9aPgs3zf8/2
         P+6qNPV5WPwDoBFj3u9r4RgRLN8P2FihjGlJT4N0rRIn/I660wR0zyUZR38YDC3ZgH
         apKDDwzVXKe7fhceH9dZwtxes7PglTh0Qn/ZXjZtrbiea3AqX7boZbkqoAxAJKnL+U
         NPQuu3qIO5eNA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds suspend and resume PM ops for tegra SDHCI.

Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 58 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index eafaaefab4a6..f608417ae967 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1611,11 +1611,67 @@ static int sdhci_tegra_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int __maybe_unused sdhci_tegra_suspend(struct device *dev)
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
+	if (ret) {
+		cqhci_resume(host->mmc);
+		return ret;
+	}
+
+	clk_disable_unprepare(pltfm_host->clk);
+	return 0;
+}
+
+static int __maybe_unused sdhci_tegra_resume(struct device *dev)
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

