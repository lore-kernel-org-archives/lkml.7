Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B32C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC6E2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UQO5XV1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732917AbfCAIfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 03:35:23 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33720 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCAIfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 03:35:22 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x218ZJCd008152;
        Fri, 1 Mar 2019 02:35:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551429319;
        bh=OuUzBmpkqynNVQR0t4kAMb7G5VmxLrK7ZOtOQyDCvVs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UQO5XV1zEUbjaIfzd8r5Il9wHqLKNXGkJ3oZBWkdj/pYbDQlP076li0pBn3erSHPb
         mTGqZnTL7hL1E0pDUxMLexxL5n+C/Zjtq2WzZn1sWe4IigO970xu5HBvi+D23Dc9dV
         klNw5lpKkOMI1rdwpFF+PQM2RZHBA1nA/EcMXvS8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x218ZJ1L124970
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Mar 2019 02:35:19 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 1
 Mar 2019 02:35:19 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 1 Mar 2019 02:35:18 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x218ZDJC009551;
        Fri, 1 Mar 2019 02:35:17 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <kishon@ti.com>,
        <adrian.hunter@intel.com>, <faiz_abbas@ti.com>
Subject: [PATCH v2 1/2] mmc: sdhci: Add platform_cmd_err() to sdhci_ops
Date:   Fri, 1 Mar 2019 14:08:23 +0530
Message-ID: <20190301083824.23918-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190301083824.23918-1-faiz_abbas@ti.com>
References: <20190301083824.23918-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms might need a custom method for handling command error
interrupts. Add a callback to sdhci_ops to facilitate the same. Move
default command error handling to its own non-static function so it can
be called from platform drivers. Also make sdhci_finish_command()
non-static.

Fixes: 5b0d62108b46 ("mmc: sdhci-omap: Add platform specific reset
callback")
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci.c | 40 ++++++++++++++++++++++++++--------------
 drivers/mmc/host/sdhci.h |  4 ++++
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a8141ff9be03..ff60b1830896 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1445,7 +1445,7 @@ static void sdhci_read_rsp_136(struct sdhci_host *host, struct mmc_command *cmd)
 	}
 }
 
-static void sdhci_finish_command(struct sdhci_host *host)
+void sdhci_finish_command(struct sdhci_host *host)
 {
 	struct mmc_command *cmd = host->cmd;
 
@@ -1495,6 +1495,8 @@ static void sdhci_finish_command(struct sdhci_host *host)
 			sdhci_finish_mrq(host, cmd->mrq);
 	}
 }
+EXPORT_SYMBOL_GPL(sdhci_finish_command);
+
 
 static u16 sdhci_get_preset_value(struct sdhci_host *host)
 {
@@ -2780,6 +2782,26 @@ static void sdhci_timeout_data_timer(struct timer_list *t)
  *                                                                           *
 \*****************************************************************************/
 
+void sdhci_cmd_err(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
+{
+		if (intmask & SDHCI_INT_TIMEOUT)
+			host->cmd->error = -ETIMEDOUT;
+		else
+			host->cmd->error = -EILSEQ;
+
+		/* Treat data command CRC error the same as data CRC error */
+		if (host->cmd->data &&
+		    (intmask & (SDHCI_INT_CRC | SDHCI_INT_TIMEOUT)) ==
+		     SDHCI_INT_CRC) {
+			host->cmd = NULL;
+			*intmask_p |= SDHCI_INT_DATA_CRC;
+			return;
+		}
+
+		sdhci_finish_mrq(host, host->cmd->mrq);
+}
+EXPORT_SYMBOL_GPL(sdhci_cmd_err);
+
 static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
 {
 	/* Handle auto-CMD12 error */
@@ -2813,21 +2835,11 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
 
 	if (intmask & (SDHCI_INT_TIMEOUT | SDHCI_INT_CRC |
 		       SDHCI_INT_END_BIT | SDHCI_INT_INDEX)) {
-		if (intmask & SDHCI_INT_TIMEOUT)
-			host->cmd->error = -ETIMEDOUT;
+		if (host->ops->platform_cmd_err)
+			host->ops->platform_cmd_err(host, intmask, intmask_p);
 		else
-			host->cmd->error = -EILSEQ;
-
-		/* Treat data command CRC error the same as data CRC error */
-		if (host->cmd->data &&
-		    (intmask & (SDHCI_INT_CRC | SDHCI_INT_TIMEOUT)) ==
-		     SDHCI_INT_CRC) {
-			host->cmd = NULL;
-			*intmask_p |= SDHCI_INT_DATA_CRC;
-			return;
-		}
+			sdhci_cmd_err(host, intmask, intmask_p);
 
-		sdhci_finish_mrq(host, host->cmd->mrq);
 		return;
 	}
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 01002cba1359..ca427d8efc29 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -645,6 +645,8 @@ struct sdhci_ops {
 	void	(*voltage_switch)(struct sdhci_host *host);
 	void	(*adma_write_desc)(struct sdhci_host *host, void **desc,
 				   dma_addr_t addr, int len, unsigned int cmd);
+	void	(*platform_cmd_err)(struct sdhci_host *host, u32 intmask,
+				    u32 *intmask_p);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
@@ -798,5 +800,7 @@ void sdhci_start_tuning(struct sdhci_host *host);
 void sdhci_end_tuning(struct sdhci_host *host);
 void sdhci_reset_tuning(struct sdhci_host *host);
 void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
+void sdhci_cmd_err(struct sdhci_host *host, u32 intmask, u32 *intmask_p);
+void sdhci_finish_command(struct sdhci_host *host);
 
 #endif /* __SDHCI_HW_H */
-- 
2.19.2

