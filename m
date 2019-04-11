Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D23C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5CC2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="o5vr6izI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfDKJAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:00:13 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40310 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKJAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:00:12 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3B90AD3071405;
        Thu, 11 Apr 2019 04:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554973210;
        bh=Hgd31Wn7smTAA6aEyQYRHWXG1uZQvuQ3bQcL2bMRP+w=;
        h=From:To:CC:Subject:Date;
        b=o5vr6izI+2iUNei5qi9J0DJYztFjRxLSmWLL1+XfKGed5798MMzyHqmp0Ws827ROr
         fV5f8ObwKGWTBnQNZ9tpYIKZjC5BHEiGFPDPB2j5NHtp2a5XfBoUN236cq5ZCJRvYP
         vBM/yREGxyyvr3x1QpLmnEODt/T1WB5kqob4DWRM=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3B90AU5095527
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Apr 2019 04:00:10 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 11
 Apr 2019 04:00:09 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 11 Apr 2019 04:00:09 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3B907Z6122466;
        Thu, 11 Apr 2019 04:00:07 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <kishon@ti.com>,
        <adrian.hunter@intel.com>, <faiz_abbas@ti.com>
Subject: [PATCH v6] mmc: sdhci-omap: Don't finish_mrq() on a command error during tuning
Date:   Thu, 11 Apr 2019 14:29:37 +0530
Message-ID: <20190411085937.633-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
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

Fixes: 5b0d62108b46 ("mmc: sdhci-omap: Add platform specific reset
callback")
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

Tested with 100 times boot tests on dra71x-evm, dra72x-evm and
dra7xx-evm.

v6:
Changed return value to u32 to fix the build warning.

v5:
Drop patch 1 and replace call to sdhci_finish_command() with
host->cmd = NULL

v4:
Fixed commit description for patch 1.
Added SDHCI_INT_TIMEOUT to CMD_ERR_MASK in patch 2.

v3:
Removed the command error specific callback and using the already
existing sdhci_irq callback instead. No measurable drop in performance.

v2:
Added EXPORT_SYMBOL_GPL for sdhci_cmd_err and sdhci_send_command to fix
errors when built as module.

 drivers/mmc/host/sdhci-omap.c | 38 +++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 5bbed477c9b1..9f20fff9781b 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -797,6 +797,43 @@ void sdhci_omap_reset(struct sdhci_host *host, u8 mask)
 	sdhci_reset(host, mask);
 }
 
+#define CMD_ERR_MASK (SDHCI_INT_CRC | SDHCI_INT_END_BIT | SDHCI_INT_INDEX |\
+		      SDHCI_INT_TIMEOUT)
+#define CMD_MASK (CMD_ERR_MASK | SDHCI_INT_RESPONSE)
+
+static u32 sdhci_omap_irq(struct sdhci_host *host, u32 intmask)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
+
+	if (omap_host->is_tuning && host->cmd && !host->data_early &&
+	    (intmask & CMD_ERR_MASK)) {
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
+		host->cmd = NULL;
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
@@ -807,6 +844,7 @@ static struct sdhci_ops sdhci_omap_ops = {
 	.platform_send_init_74_clocks = sdhci_omap_init_74_clocks,
 	.reset = sdhci_omap_reset,
 	.set_uhs_signaling = sdhci_omap_set_uhs_signaling,
+	.irq = sdhci_omap_irq,
 };
 
 static int sdhci_omap_set_capabilities(struct sdhci_omap_host *omap_host)
-- 
2.19.2

