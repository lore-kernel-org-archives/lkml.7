Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91E8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A837F21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127983;
	bh=ITA7lDMk09nGvYYJDaDIN0iY/k8LcpHv3+iwktCr2tE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vnj3FYyHzNMKzX67OTZjtKcUqECHNyfJpJ0nVIptQuia+UjDV5jH/gsMtvN2qnpdH
	 FLDNYO6E2cAh6lXNdUF9B1Merau/MdPWfs7rRb53DECtkJn4Hh112RfpEE93tvd5+b
	 VqqalMl7F16l9c8JVnvDvfEpvuQcjhoVAT62hIvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391388AbfDXRcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:32:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390781AbfDXRch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:32:37 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DA0A2054F;
        Wed, 24 Apr 2019 17:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127155;
        bh=ITA7lDMk09nGvYYJDaDIN0iY/k8LcpHv3+iwktCr2tE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2U2uT14jq3REcEVl5J/gEcsNYUn6CijVuSDZIGav/W6InOwnCGbVLT/50HzbNqnJW
         bS8jwRs4sC8hc3lR2/5I3ixMP1BamY/c1rKSo5Lq1j4+4FukOBUiSVCWNJVGVkz0WJ
         MTI2YtEZ0+NNaNXoXv5uhBBp8fvPnkDtL5SFLiZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 82/96] mmc: sdhci: Rename SDHCI_ACMD12_ERR and SDHCI_INT_ACMD12ERR
Date:   Wed, 24 Apr 2019 19:10:27 +0200
Message-Id: <20190424170925.355947627@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
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
index 8dae12b841b3..629860f7327c 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -429,7 +429,7 @@ static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
 				val = readl(host->ioaddr + ESDHC_MIX_CTRL);
 			else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING)
 				/* the std tuning bits is in ACMD12_ERR for imx6sl */
-				val = readl(host->ioaddr + SDHCI_ACMD12_ERR);
+				val = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
 		}
 
 		if (val & ESDHC_MIX_CTRL_EXE_TUNE)
@@ -494,7 +494,7 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 			}
 			writel(new_val , host->ioaddr + ESDHC_MIX_CTRL);
 		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
-			u32 v = readl(host->ioaddr + SDHCI_ACMD12_ERR);
+			u32 v = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
 			u32 m = readl(host->ioaddr + ESDHC_MIX_CTRL);
 			if (val & SDHCI_CTRL_TUNED_CLK) {
 				v |= ESDHC_MIX_CTRL_SMPCLK_SEL;
@@ -512,7 +512,7 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 				v &= ~ESDHC_MIX_CTRL_EXE_TUNE;
 			}
 
-			writel(v, host->ioaddr + SDHCI_ACMD12_ERR);
+			writel(v, host->ioaddr + SDHCI_AUTO_CMD_STATUS);
 			writel(m, host->ioaddr + ESDHC_MIX_CTRL);
 		}
 		return;
@@ -957,9 +957,9 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
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
@@ -1319,7 +1319,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
 		/* clear tuning bits in case ROM has set it already */
 		writel(0x0, host->ioaddr + ESDHC_MIX_CTRL);
-		writel(0x0, host->ioaddr + SDHCI_ACMD12_ERR);
+		writel(0x0, host->ioaddr + SDHCI_AUTO_CMD_STATUS);
 		writel(0x0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
 	}
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4bfaca33a477..0eb05a42a857 100644
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
index f0bd36ce3817..33a7728c71fa 100644
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



