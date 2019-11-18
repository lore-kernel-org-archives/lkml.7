Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA5CC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9542075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="up7FKGds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfKRKn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 05:43:58 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39521 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfKRKnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 05:43:55 -0500
Received: by mail-pj1-f66.google.com with SMTP id t103so1374706pjb.6;
        Mon, 18 Nov 2019 02:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=nn1ZIH5FykXJcqKbMnJbBFiTcSLprwBTAdbttbSmu1c=;
        b=up7FKGdsAUKzK/7smdx4XvpBr5BlN8uUQObNojVhC65e8PHjGCY7ER/w+Xo5HAfkC4
         7R4M497BiCKs8dnFRPEJW9I7ZFSeiBMRdMRhCUPsDLQ4Gj8gVscm4z97cBY9hpGH9eOO
         ex01QvevtzHm+t3JR+z3Y3RjAuKWxiSeBSWTBWP1R5JKJSggGr/rbs5fWwVeHLdH1Qsu
         SH/Nc2cmOrll7klQR0KJgek5v9hPXMrd/CWQAjteEoAxNhvkuPAaVguA2hAeDN98GGky
         TpJbFdbp12WwqorAph/ts8KZp4kdHZOqW3oclxx8ry8ed4+meHXwpubhui+E8X+Yvz+7
         HVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=nn1ZIH5FykXJcqKbMnJbBFiTcSLprwBTAdbttbSmu1c=;
        b=E+S/xmH4/81pv/2SdTVK4uncGwf9sTL418A/9FuJDIL/8G5xE8ODZrxKedpkD5U8F7
         XaGfDe3ByIGaxd7v9VzVLlvq44Hs6sNuTJHxOK7iJeoE/ope2AZIcdHdBIX9duc0Z2r0
         H5iwJ3tno/TBocaOB/13+n7KB1gQpAIoBsZq9rcK0Fb8fSFNFTWQsW0ffjx6YF9jz+fY
         TkrCrxeclRfX6qbNOzyCPRYS7BjNiyt3im1dJJuCg6fGpmRvTsNOeJdf9eSGWNYMgNmf
         xU873K9T64FpoI6U6LmaF60VMHyxdWtBJbzN/9YugzuNaJFwkaccVkCmRWTAXJhzzh4L
         cudQ==
X-Gm-Message-State: APjAAAVkhwnhWdlVddduEvhiFN2x3JOYOv3+JHPxKpD17thxbFh0M73R
        Lfy69bkXsdzEDGChhRa0ni0=
X-Google-Smtp-Source: APXvYqz9SHImOx5T8xyhYkcrzWqBuwr+UANHqCAAyP/PnFd83tvydxnCy8h3H9OR0XbltuXGkx00BA==
X-Received: by 2002:a17:902:b582:: with SMTP id a2mr29037410pls.103.1574073834664;
        Mon, 18 Nov 2019 02:43:54 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c13sm19343905pfo.5.2019.11.18.02.43.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Nov 2019 02:43:54 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/4] mmc: host: sdhci-sprd: Add software queue support
Date:   Mon, 18 Nov 2019 18:43:22 +0800
Message-Id: <2f194a08e69e922bb706528cde409b739cda0151.1574073572.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1574073572.git.baolin.wang7@gmail.com>
References: <cover.1574073572.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1574073572.git.baolin.wang7@gmail.com>
References: <cover.1574073572.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baolin Wang <baolin.wang@linaro.org>

Add software queue support to improve the performance.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mmc/host/Kconfig      |    1 +
 drivers/mmc/host/sdhci-sprd.c |   28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index efa4019..54b86f6 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -632,6 +632,7 @@ config MMC_SDHCI_SPRD
 	depends on ARCH_SPRD
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
+	select MMC_HSQ
 	help
 	  This selects the SDIO Host Controller in Spreadtrum
 	  SoCs, this driver supports R11(IP version: R11P0).
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index d07b979..d346223 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 
 #include "sdhci-pltfm.h"
+#include "mmc_hsq.h"
 
 /* SDHCI_ARGUMENT2 register high 16bit */
 #define SDHCI_SPRD_ARG2_STUFF		GENMASK(31, 16)
@@ -379,6 +380,16 @@ static unsigned int sdhci_sprd_get_ro(struct sdhci_host *host)
 	return 0;
 }
 
+static void sdhci_sprd_request_done(struct sdhci_host *host,
+				    struct mmc_request *mrq)
+{
+	/* Validate if the request was from software queue firstly. */
+	if (mmc_hsq_finalize_request(host->mmc, mrq))
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
+	struct mmc_hsq *hsq;
 	struct clk *clk;
 	int ret = 0;
 
@@ -631,6 +644,18 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 
 	sprd_host->flags = host->flags;
 
+	hsq = devm_kzalloc(&pdev->dev, sizeof(*hsq), GFP_KERNEL);
+	if (!hsq) {
+		ret = -ENOMEM;
+		goto err_cleanup_host;
+	}
+
+	ret = mmc_hsq_init(hsq, host->mmc);
+	if (ret)
+		goto err_cleanup_host;
+
+	host->always_defer_done = true;
+
 	ret = __sdhci_add_host(host);
 	if (ret)
 		goto err_cleanup_host;
@@ -689,6 +714,7 @@ static int sdhci_sprd_runtime_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
 
+	mmc_hsq_suspend(host->mmc);
 	sdhci_runtime_suspend_host(host);
 
 	clk_disable_unprepare(sprd_host->clk_sdio);
@@ -717,6 +743,8 @@ static int sdhci_sprd_runtime_resume(struct device *dev)
 		goto clk_disable;
 
 	sdhci_runtime_resume_host(host, 1);
+	mmc_hsq_resume(host->mmc);
+
 	return 0;
 
 clk_disable:
-- 
1.7.9.5

