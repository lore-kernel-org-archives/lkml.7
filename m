Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F354C10F0D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7059720872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zWPBxCW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfCSGfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 02:35:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41690 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfCSGfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 02:35:44 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2J6ZgI2117920;
        Tue, 19 Mar 2019 01:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552977342;
        bh=Bz1zmbzBXhT/PGbp5HKH0FWEtOeXxNXVs19+WqsRB1U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=zWPBxCW5OKB7i7ungSWMA91KFJQBvopV9/WJa8hq4WHc7LR+vBaBzsSFXjIrhOkJG
         XRwvhmj3vJ/3zgPlvUmgRDvK6B2+4BZrif1pZQ2BEyJi8A1VaTXYJDe7LDa5i6F4+M
         ldz3aqJapAcVWmOliIU+D/7mKXWOQRPy9EbJzRTU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2J6Zg92115643
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Mar 2019 01:35:42 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 19
 Mar 2019 01:35:42 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Tue, 19 Mar 2019 01:35:42 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2J6ZZdC016257;
        Tue, 19 Mar 2019 01:35:40 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <kishon@ti.com>,
        <adrian.hunter@intel.com>, <faiz_abbas@ti.com>
Subject: [PATCH v3 2/2] mmc: sdhci-omap: Don't finish_mrq() on a command error during tuning
Date:   Tue, 19 Mar 2019 12:05:33 +0530
Message-ID: <20190319063533.12171-3-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190319063533.12171-1-faiz_abbas@ti.com>
References: <20190319063533.12171-1-faiz_abbas@ti.com>
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
 drivers/mmc/host/sdhci-omap.c | 36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index b1a66ca3821a..765873dff7ca 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -797,6 +797,41 @@ void sdhci_omap_reset(struct sdhci_host *host, u8 mask)
 	sdhci_reset(host, mask);
 }
 
+#define CMD_ERR_MASK (SDHCI_INT_CRC | SDHCI_INT_END_BIT | SDHCI_INT_INDEX)
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
@@ -807,6 +842,7 @@ static struct sdhci_ops sdhci_omap_ops = {
 	.platform_send_init_74_clocks = sdhci_omap_init_74_clocks,
 	.reset = sdhci_omap_reset,
 	.set_uhs_signaling = sdhci_omap_set_uhs_signaling,
+	.irq = sdhci_omap_irq,
 };
 
 static int sdhci_omap_set_capabilities(struct sdhci_omap_host *omap_host)
-- 
2.19.2

