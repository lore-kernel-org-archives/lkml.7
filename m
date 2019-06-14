Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A71C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BFBB2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfFNI2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 04:28:09 -0400
Received: from inva020.nxp.com ([92.121.34.13]:39342 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfFNI2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 04:28:09 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8DC081A05D5;
        Fri, 14 Jun 2019 10:28:07 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CD31D1A05E6;
        Fri, 14 Jun 2019 10:28:03 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D0D94402A0;
        Fri, 14 Jun 2019 16:27:58 +0800 (SGT)
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     yinbo.zhu@nxp.com, xiaobo.xie@nxp.com, jiafei.pan@nxp.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        yangbo.lu@nxp.com
Subject: [PATCH v1] mmc: sdhci-of-esdhc: set the sd clock divisor value above 3
Date:   Fri, 14 Jun 2019 16:29:53 +0800
Message-Id: <20190614082954.39648-1-yinbo.zhu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangbo Lu <yangbo.lu@nxp.com>

This patch is to set the sd clock divisor value above 3 in tuning mode

Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index d4ec0a959a75..c4af026c3fba 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -824,9 +824,17 @@ static int esdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
 	bool hs400_tuning;
+	unsigned int clk;
 	u32 val;
 	int ret;
 
+	/* For tuning mode, the sd clock divisor value
+	 * must be larger than 3 according to reference manual.
+	 */
+	clk = esdhc->peripheral_clock / 3;
+	if (host->clock > clk)
+		esdhc_of_set_clock(host, clk);
+
 	if (esdhc->quirk_limited_clk_division &&
 	    host->flags & SDHCI_HS400_TUNING)
 		esdhc_of_set_clock(host, host->clock);
-- 
2.17.1

