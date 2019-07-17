Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F069C76188
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 02:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C430C20818
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 02:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ry0p9a7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfGQC3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 22:29:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38728 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfGQC3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 22:29:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id f5so1533491pgu.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 19:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6tx+Qq2PicIrG+dzO2uxG2U4IUaoivU08tFcHg3bC90=;
        b=ry0p9a7B2piOJHxaJ0socATSfRMNBTtIqUgTg5L4WuZvJ3jd4fJPIPE3p5X3X7RZpA
         C+iQ1I/xyZUE5fdUDDBJIqL0jGSEnIOBYR5HsNLijGTvF0DlyD54RZS4bmG2LDEV/gM5
         7/3iA54FuRXD1C7egezt9LJR+k70q1DPHU3AT6Poh32nFg1Rz/lEi2gy5imzUkjrCOZG
         DeBl5gdMy2PeWJPP1bCYqnrsd+Nw3RaTEFkdkatxut4xTE9FR2rQPQm1nXl2uQ43ZfAO
         /CSwXHJt1AzSkk0j11Vx/q2mAapucXAJ8aOVspukpDstG95Ta/4wHpn7fNLDKTdjuFER
         65lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6tx+Qq2PicIrG+dzO2uxG2U4IUaoivU08tFcHg3bC90=;
        b=BumR6+Z7AC+7Rh2BEjHiPAr7pFW7pCQshe1oTt4tzRo+S0241EOseLsDEIfIUcTGgc
         I/DPSYB38JBZfY4oKxgTBIm7eZ1dBxhmntPG9poZBBlJ/sM+PRseZbBz45LgyC2FTpyV
         94pYEJ4U5an2thVaj4JNQ8Dlspy0bfAvAqTa5+CRqkak88plcI4zb+tj98kn8WqTyXnP
         I1up5Z8emtkvLmV/64szbxVhrUZuJKhaaA+S39Pp/DBxxPKOAH+YJBRMpzYSfss48lHm
         5TahNdaHZTMV2CzyvdSGezWxE3MqiGwg6PHMBuwgDOjB/TaG4nLRPaw2RlxBL/+5kPWa
         08Ww==
X-Gm-Message-State: APjAAAVntICw45GJO9wAOOoogj6ZYoqyeF8lwaPQ8wZENny8lE/eQXuf
        zVAckyqaQ8MNbjaNUiT3V9K7kA==
X-Google-Smtp-Source: APXvYqzJUSsTFD+M6lu8qyQuwXWk/dbBc0xWO16evdYBd8ztZlEEBzYZbVK/a0ncpzVDnkTlo0phfA==
X-Received: by 2002:a63:5402:: with SMTP id i2mr10860876pgb.414.1563330545351;
        Tue, 16 Jul 2019 19:29:05 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p19sm26906104pfn.99.2019.07.16.19.29.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Jul 2019 19:29:04 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] mmc: host: sdhci-sprd: Fix the incorrect soft reset operation when runtime resuming
Date:   Wed, 17 Jul 2019 10:28:52 +0800
Message-Id: <89c3ef495c367d58ca3abe99a1f82c48f8c08705.1563274904.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sdhci_runtime_resume_host() function, we will always do software reset
for all, which will cause Spreadtrum host controller work abnormally after
resuming.

Thus for Spreadtrum platform that will not power down the SD/eMMC card during
runtime suspend, we should not do software reset for all. To fix this
issue, adding a specific reset operation that adds one condition to validate
the power mode to decide if we can do software reset for all or just reset
command and data lines.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changess from v3:
 - Use ios.power_mode to validate if the card is power down or not.

Changes from v2:
 - Simplify the sdhci_sprd_reset() by issuing sdhci_reset().

Changes from v1:
 - Add a specific reset operation instead of changing the core to avoid
 affecting other hardware.
---
 drivers/mmc/host/sdhci-sprd.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 603a5d9..94f9726 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -373,6 +373,23 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
 	return 1 << 31;
 }
 
+static void sdhci_sprd_reset(struct sdhci_host *host, u8 mask)
+{
+	struct mmc_host *mmc = host->mmc;
+
+	/*
+	 * When try to reset controller after runtime suspend, we should not
+	 * reset for all if the SD/eMMC card is not power down, just reset
+	 * command and data lines instead. Otherwise will meet some strange
+	 * behaviors for Spreadtrum host controller.
+	 */
+	if (host->runtime_suspended && (mask & SDHCI_RESET_ALL) &&
+	    mmc->ios.power_mode == MMC_POWER_ON)
+		mask = SDHCI_RESET_CMD | SDHCI_RESET_DATA;
+
+	sdhci_reset(host, mask);
+}
+
 static struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
@@ -381,7 +398,7 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
 	.get_max_clock = sdhci_sprd_get_max_clock,
 	.get_min_clock = sdhci_sprd_get_min_clock,
 	.set_bus_width = sdhci_set_bus_width,
-	.reset = sdhci_reset,
+	.reset = sdhci_sprd_reset,
 	.set_uhs_signaling = sdhci_sprd_set_uhs_signaling,
 	.hw_reset = sdhci_sprd_hw_reset,
 	.get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
-- 
1.7.9.5

