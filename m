Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F15BC5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAACB206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uyKc+aH4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfIKNPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 09:15:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37619 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbfIKNPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:15:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id c17so3753875pgg.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 06:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=HJGZrNijsmlC5WTcQ4d8JI7jp4tO9JVLJxVcQXONoXo=;
        b=uyKc+aH4wratJZkJatOcySBRFbiAHLNyssKiIe5+5Gg+7LIiuamaypPhAC6tpNkoAi
         DtKNRqmoKD/BbzkoSATkV9Gm4UC5lDJRgz1Zr9hmpyv6faXhjpSSwYDcbJBjwcB1uznb
         nK8FFqbVs6fwO6tcPELepSySimc//fSBv5YkUYLwx0rR55tpmZo5MLAPKDr6BOEEZm4V
         miGE/jElyvvcUGhB1/QqJx9eTkyK8LqNtQ4KBgob1qHPfF5TJIgcA+HNmlMcDkVD4iMI
         h6Jsaz8DcEn8IoXxxJ0RPaxB5EJNH4DFlfs1O1+tywoaqTg685b4Qxgal76ncan4lDR1
         hPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=HJGZrNijsmlC5WTcQ4d8JI7jp4tO9JVLJxVcQXONoXo=;
        b=p97kZAS9GD7ZBLyhSnV1i+Vgic3MIERdyjIIEYcQVBuWcI0qFRpqahCOFq7p7e7XDo
         NBWGQgMTzzcYlLMK7oJPpnxZ2eQbnl9aBixuypQr685NNNzhgRM/fLg6qyn/gLK5bfRf
         ekQecA4PRblkuJce6Ghf91cQjKLLZg/xT+Zcqp314KkVmL36oYlJTk7agxY51dM/4l+i
         elkxtVLe1j25AsK+4sN8F4KUJO7NdF+Fr/Ukm1CIeUOfi0pJdWkrxV/qJIrs5lq+vrVj
         GJJ9spGnXNLacI3YO7YR1JeqhmnUT4u6u/0jwR/JdnhJz6zEaIojetKzKBAHPDXdsSlK
         bl5A==
X-Gm-Message-State: APjAAAUZ07bXIgP6MUx8asjPz4reGPGUl+IeSwCa7RgfLaq4UGRM9TVD
        s9wIf+eLd+8PNrEyPar4U6L3Jg==
X-Google-Smtp-Source: APXvYqwaBtIn5Ydg+bFThEB8HKE8FUyy085EWCxRpciLQul2CPSU5IOFKxXZ+54lEHwo+5eJRhNwRg==
X-Received: by 2002:a17:90a:17c5:: with SMTP id q63mr5449836pja.106.1568207720620;
        Wed, 11 Sep 2019 06:15:20 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id e21sm6420120pgr.43.2019.09.11.06.15.16
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Sep 2019 06:15:19 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] mmc: host: sdhci-sprd: Add software queue support
Date:   Wed, 11 Sep 2019 21:14:43 +0800
Message-Id: <351897e271069582a7ce7775fd803d556b5bebde.1568206300.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1568206300.git.baolin.wang@linaro.org>
References: <cover.1568206300.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1568206300.git.baolin.wang@linaro.org>
References: <cover.1568206300.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add software queue support to improve the performance.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/Kconfig      |    1 +
 drivers/mmc/host/sdhci-sprd.c |   26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index d117f18..862e8e9 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -619,6 +619,7 @@ config MMC_SDHCI_SPRD
 	depends on ARCH_SPRD
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
+	select MMC_SQHCI
 	help
 	  This selects the SDIO Host Controller in Spreadtrum
 	  SoCs, this driver supports R11(IP version: R11P0).
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index d07b979..f6f157f 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 
 #include "sdhci-pltfm.h"
+#include "sqhci.h"
 
 /* SDHCI_ARGUMENT2 register high 16bit */
 #define SDHCI_SPRD_ARG2_STUFF		GENMASK(31, 16)
@@ -379,6 +380,16 @@ static unsigned int sdhci_sprd_get_ro(struct sdhci_host *host)
 	return 0;
 }
 
+static void sdhci_sprd_request_done(struct sdhci_host *host,
+				    struct mmc_request *mrq)
+{
+	/* Validate if the request was from software queue firstly. */
+	if (sqhci_finalize_request(host->mmc, mrq))
+		return;
+
+	 mmc_request_done(host->mmc, mrq);
+}
+
 static struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
@@ -392,6 +403,7 @@ static unsigned int sdhci_sprd_get_ro(struct sdhci_host *host)
 	.hw_reset = sdhci_sprd_hw_reset,
 	.get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
 	.get_ro = sdhci_sprd_get_ro,
+	.request_done = sdhci_sprd_request_done,
 };
 
 static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
@@ -521,6 +533,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
 	struct sdhci_sprd_host *sprd_host;
+	struct cqhci_host *sq_host;
 	struct clk *clk;
 	int ret = 0;
 
@@ -631,6 +644,16 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 
 	sprd_host->flags = host->flags;
 
+	sq_host = devm_kzalloc(&pdev->dev, sizeof(*sq_host), GFP_KERNEL);
+	if (!sq_host) {
+		ret = -ENOMEM;
+		goto err_cleanup_host;
+	}
+
+	ret = sqhci_init(sq_host, host->mmc);
+	if (ret)
+		goto err_cleanup_host;
+
 	ret = __sdhci_add_host(host);
 	if (ret)
 		goto err_cleanup_host;
@@ -689,6 +712,7 @@ static int sdhci_sprd_runtime_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
 
+	sqhci_suspend(host->mmc);
 	sdhci_runtime_suspend_host(host);
 
 	clk_disable_unprepare(sprd_host->clk_sdio);
@@ -717,6 +741,8 @@ static int sdhci_sprd_runtime_resume(struct device *dev)
 		goto clk_disable;
 
 	sdhci_runtime_resume_host(host, 1);
+	sqhci_resume(host->mmc);
+
 	return 0;
 
 clk_disable:
-- 
1.7.9.5

