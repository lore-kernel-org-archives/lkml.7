Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234FEC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6799206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126887;
	bh=MoY2+55tNnWCo4noWQFa0hDjTOsYv28PsZI6SZWLkYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fc8Spslo0sV5PQ85f0PegnDyRqWCnN23fevq0CceGBgEn+E51OTRNn14e0AcO3aFe
	 Y0osYxEVsV46IOJ4WnqnrbL4EbTIJeR42rV/9llAOwhEVhQNel3nlf+03CMytn+h9j
	 GmP/nR1rMzNsj8LieNNy9XukFtIkc8bX1S1s5m2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390599AbfDXR2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:28:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390588AbfDXR2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:28:02 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59559205ED;
        Wed, 24 Apr 2019 17:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126881;
        bh=MoY2+55tNnWCo4noWQFa0hDjTOsYv28PsZI6SZWLkYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=og3aa8K2/hes9zp5M/38dtBgNuClPFT1BwIv2oMaszTqE6CVQ60rwt2EIusB4Wj51
         3rtVZbzG+cpSeSXyXMUaFlZN2N41Q6R+cO524IO4XhAGe0KLMJimJcPfAFGqoublNB
         fDWxpyxs7Czqb2yjASRjVDkX9Yy/5fxYDbrjDEyY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 50/70] mmc: sdhci: Rename SDHCI_ACMD12_ERR and SDHCI_INT_ACMD12ERR
Date:   Wed, 24 Apr 2019 19:10:10 +0200
Message-Id: <20190424170916.711291499@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170906.751869122@linuxfoundation.org>
References: <20190424170906.751869122@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 869f8a69bb3a4aec4eb914a330d4ba53a9eed495 ]

The SDHCI_ACMD12_ERR register is used for auto-CMD23 and auto-CMD12
errors, as is the SDHCI_INT_ACMD12ERR interrupt bit. Rename them to
SDHCI_AUTO_CMD_STATUS and SDHCI_INT_AUTO_CMD_ERR respectively.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 12 ++++++------
 drivers/mmc/host/sdhci.c           |  4 ++--
 drivers/mmc/host/sdhci.h           |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ff5c4ad37a3a..8c0b80a54e4d 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -425,7 +425,7 @@ static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
 				val = readl(host->ioaddr + ESDHC_MIX_CTRL);
 			else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING)
 				/* the std tuning bits is in ACMD12_ERR for imx6sl */
-				val = readl(host->ioaddr + SDHCI_ACMD12_ERR);
+				val = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
 		}
 
 		if (val & ESDHC_MIX_CTRL_EXE_TUNE)
@@ -490,7 +490,7 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 			}
 			writel(new_val , host->ioaddr + ESDHC_MIX_CTRL);
 		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
-			u32 v = readl(host->ioaddr + SDHCI_ACMD12_ERR);
+			u32 v = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
 			u32 m = readl(host->ioaddr + ESDHC_MIX_CTRL);
 			if (val & SDHCI_CTRL_TUNED_CLK) {
 				v |= ESDHC_MIX_CTRL_SMPCLK_SEL;
@@ -508,7 +508,7 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 				v &= ~ESDHC_MIX_CTRL_EXE_TUNE;
 			}
 
-			writel(v, host->ioaddr + SDHCI_ACMD12_ERR);
+			writel(v, host->ioaddr + SDHCI_AUTO_CMD_STATUS);
 			writel(m, host->ioaddr + ESDHC_MIX_CTRL);
 		}
 		return;
@@ -937,9 +937,9 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
 			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
 			writel(0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
 		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
-			ctrl = readl(host->ioaddr + SDHCI_ACMD12_ERR);
+			ctrl = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
 			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
-			writel(ctrl, host->ioaddr + SDHCI_ACMD12_ERR);
+			writel(ctrl, host->ioaddr + SDHCI_AUTO_CMD_STATUS);
 		}
 	}
 }
@@ -1303,7 +1303,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
 		/* clear tuning bits in case ROM has set it already */
 		writel(0x0, host->ioaddr + ESDHC_MIX_CTRL);
-		writel(0x0, host->ioaddr + SDHCI_ACMD12_ERR);
+		writel(0x0, host->ioaddr + SDHCI_AUTO_CMD_STATUS);
 		writel(0x0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
 	}
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2d59b0389567..8abbe40a9a05 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -82,8 +82,8 @@ void sdhci_dumpregs(struct sdhci_host *host)
 	SDHCI_DUMP("Int enab:  0x%08x | Sig enab: 0x%08x\n",
 		   sdhci_readl(host, SDHCI_INT_ENABLE),
 		   sdhci_readl(host, SDHCI_SIGNAL_ENABLE));
-	SDHCI_DUMP("AC12 err:  0x%08x | Slot int: 0x%08x\n",
-		   sdhci_readw(host, SDHCI_ACMD12_ERR),
+	SDHCI_DUMP("ACmd stat: 0x%08x | Slot int: 0x%08x\n",
+		   sdhci_readw(host, SDHCI_AUTO_CMD_STATUS),
 		   sdhci_readw(host, SDHCI_SLOT_INT_STATUS));
 	SDHCI_DUMP("Caps:      0x%08x | Caps_1:   0x%08x\n",
 		   sdhci_readl(host, SDHCI_CAPABILITIES),
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 1d7d61e25dbf..860b2c729e68 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -144,7 +144,7 @@
 #define  SDHCI_INT_DATA_CRC	0x00200000
 #define  SDHCI_INT_DATA_END_BIT	0x00400000
 #define  SDHCI_INT_BUS_POWER	0x00800000
-#define  SDHCI_INT_ACMD12ERR	0x01000000
+#define  SDHCI_INT_AUTO_CMD_ERR	0x01000000
 #define  SDHCI_INT_ADMA_ERROR	0x02000000
 
 #define  SDHCI_INT_NORMAL_MASK	0x00007FFF
@@ -166,7 +166,7 @@
 
 #define SDHCI_CQE_INT_MASK (SDHCI_CQE_INT_ERR_MASK | SDHCI_INT_CQE)
 
-#define SDHCI_ACMD12_ERR	0x3C
+#define SDHCI_AUTO_CMD_STATUS	0x3C
 
 #define SDHCI_HOST_CONTROL2		0x3E
 #define  SDHCI_CTRL_UHS_MASK		0x0007
-- 
2.19.1



