Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106A5C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AF420656
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfF1EJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 00:09:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725792AbfF1EJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 00:09:01 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 537774E622FCE9D19A42;
        Fri, 28 Jun 2019 12:08:59 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Fri, 28 Jun 2019
 12:08:49 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <faiz_abbas@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] mmc: sdhci_am654: Make some symbols static
Date:   Fri, 28 Jun 2019 12:07:51 +0800
Message-ID: <20190628040751.46196-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings:

drivers/mmc/host/sdhci_am654.c:192:6: warning: symbol 'sdhci_j721e_4bit_set_clock' was not declared. Should it be static?
drivers/mmc/host/sdhci_am654.c:261:18: warning: symbol 'sdhci_j721e_8bit_ops' was not declared. Should it be static?
drivers/mmc/host/sdhci_am654.c:284:18: warning: symbol 'sdhci_j721e_4bit_ops' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/mmc/host/sdhci_am654.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 3b39481..bb90757 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -189,7 +189,8 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 	}
 }
 
-void sdhci_j721e_4bit_set_clock(struct sdhci_host *host, unsigned int clock)
+static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
+				       unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
@@ -258,7 +259,7 @@ static const struct sdhci_am654_driver_data sdhci_am654_drvdata = {
 	.flags = IOMUX_PRESENT | FREQSEL_2_BIT | STRBSEL_4_BIT | DLL_PRESENT,
 };
 
-struct sdhci_ops sdhci_j721e_8bit_ops = {
+static struct sdhci_ops sdhci_j721e_8bit_ops = {
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
@@ -281,7 +282,7 @@ static const struct sdhci_am654_driver_data sdhci_j721e_8bit_drvdata = {
 	.flags = DLL_PRESENT,
 };
 
-struct sdhci_ops sdhci_j721e_4bit_ops = {
+static struct sdhci_ops sdhci_j721e_4bit_ops = {
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
-- 
2.7.4


