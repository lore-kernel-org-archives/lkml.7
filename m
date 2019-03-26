Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4330CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021BE2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cCH6PlwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbfCZLBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:01:18 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35904 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731202AbfCZLBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:01:16 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2QB1DM7097704;
        Tue, 26 Mar 2019 06:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553598073;
        bh=vqcfCy6Av2WN2+WxiD/Fpy2SJGk/Sj8IuUnnc6DwXic=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cCH6PlwAqfAJ34bSxkRx/MgJfHK0NoPHHw0IOWjLBnfJ79AY90gwslIdjJPb5+HXr
         0Q5Cmsg5jjJYSMVBhMUV9DDVGdo5S+l0XSFBg1gZsxULaXNm96T5nuSIP0eGpQxl28
         oGDUZDjKpJtsl52NQz5f/T5qibE+8gx/yQOi8xkw=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2QB1DpM060144
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Mar 2019 06:01:13 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 26
 Mar 2019 06:01:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 26 Mar 2019 06:01:13 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2QB16Si101424;
        Tue, 26 Mar 2019 06:01:11 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <kishon@ti.com>,
        <adrian.hunter@intel.com>, <faiz_abbas@ti.com>
Subject: [PATCH v4 2/2] mmc: sdhci-omap: Don't finish_mrq() on a command error during tuning
Date:   Tue, 26 Mar 2019 16:30:57 +0530
Message-ID: <20190326110057.7055-3-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190326110057.7055-1-faiz_abbas@ti.com>
References: <20190326110057.7055-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 5b0d62108b46 ("mmc: sdhci-omap: Add platform specific reset
callback") skips data resets during tuning operation. Because of this,
a data error or data finish interrupt might still arrive after a command
error has been handled and the mrq ended. This ends up with a "mmc0: Got
data interrupt 0x00000002 even though no data operation was in progress"
error message.

Fix this by adding a platform specific callback for sdhci_irq. Mark the
mrq as a failure but wait for a data interrupt instead of calling
finish_mrq().

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 37 +++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 5bbed477c9b1..9da2ff9ede8b 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -797,6 +797,42 @@ void sdhci_omap_reset(struct sdhci_host *host, u8 mask)
 	sdhci_reset(host, mask);
 }
 
+#define CMD_ERR_MASK (SDHCI_INT_CRC | SDHCI_INT_END_BIT | SDHCI_INT_INDEX |\
+		      SDHCI_INT_TIMEOUT)
+#define CMD_MASK (CMD_ERR_MASK | SDHCI_INT_RESPONSE)
+
+static irqreturn_t sdhci_omap_irq(struct sdhci_host *host, u32 intmask)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
+
+	if (omap_host->is_tuning && (intmask & CMD_ERR_MASK)) {
+
+		/*
+		 * Since we are not resetting data lines during tuning
+		 * operation, data error or data complete interrupts
+		 * might still arrive. Mark this request as a failure
+		 * but still wait for the data interrupt
+		 */
+		if (intmask & SDHCI_INT_TIMEOUT)
+			host->cmd->error = -ETIMEDOUT;
+		else
+			host->cmd->error = -EILSEQ;
+
+		sdhci_finish_command(host);
+
+		/*
+		 * Sometimes command error interrupts and command complete
+		 * interrupt will arrive together. Clear all command related
+		 * interrupts here.
+		 */
+		sdhci_writel(host, intmask & CMD_MASK, SDHCI_INT_STATUS);
+		intmask &= ~CMD_MASK;
+	}
+
+	return intmask;
+}
+
 static struct sdhci_ops sdhci_omap_ops = {
 	.set_clock = sdhci_omap_set_clock,
 	.set_power = sdhci_omap_set_power,
@@ -807,6 +843,7 @@ static struct sdhci_ops sdhci_omap_ops = {
 	.platform_send_init_74_clocks = sdhci_omap_init_74_clocks,
 	.reset = sdhci_omap_reset,
 	.set_uhs_signaling = sdhci_omap_set_uhs_signaling,
+	.irq = sdhci_omap_irq,
 };
 
 static int sdhci_omap_set_capabilities(struct sdhci_omap_host *omap_host)
-- 
2.19.2

