Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D14C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF48206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NKlJUoOf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732534AbfETKNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 06:13:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39107 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732519AbfETKM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 06:12:59 -0400
Received: by mail-pl1-f193.google.com with SMTP id g9so6499414plm.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 03:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=xveO13FKhXzoL1lkYTFX11xifuYVV7+mJh5hbeM4mGk=;
        b=NKlJUoOflJbwmEE4EZCwFYMT/ND4NmEVAhtO+YHos+oeGhc++olfTd8GSNmCw1X2u2
         Y56AU27jDf0om7R+rK1/dPYEMO3cKEFC39QaTfkSuhz/kfimV4LgjQatrj+p4JDeq3lO
         Z5CVPpDBkRd4tye4QFnooifpUpXVPwMotVR+q6LNKCfzhDU9lj8aALZIwwvG3xuEEBXr
         ZbVwR3Tlv+3ykzIAFM273uPcq3V1Ma4kjga/p0LmeREn4wX+Lxw8hZJ0M33IEstvThKZ
         J3lN+eq6HRcbGULZmhdJJklGpONAeiFp4eOiYNCz58FpSFT4pJkFqyjbi89UxIYPMx88
         iJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=xveO13FKhXzoL1lkYTFX11xifuYVV7+mJh5hbeM4mGk=;
        b=dkdo+d7Z9IqErz4bVyDfJhUu7Va6eC7nYP4Xl6Qs7BEPtAs5/w3zvSwkV7asmHjXJ4
         Zgt+cIorbeNav+Yz6gvx+/5ShVLtancalcd6F6XPn2atKIR5P1CrkWgTNQ10nWUcMQsb
         NU2xCz+mZt05QirF9KDOkG81krrcvfY5RuMRLD/vstUf7mGhONUmIW9+29NIqzmpOX8a
         Z9smafap+A0b3CQju5AZ3GHHYtuR1E0EEatqN8OOfS983mVdqg53xMtvoXf5z1LgWeFH
         rjAYbMoVsSLdV9jgs4oCixSizaD3foUNE+jDhQnL3qdrtPdQQd6wYwmtyYBtQY9IOj1o
         JVnQ==
X-Gm-Message-State: APjAAAVBtAvMdKsxnv/rqRlWowYC5QPn7QANP7JZYpa8SkIW9YntcTHK
        qxqF9Q2es+LIAzr3wKdBICCLpg==
X-Google-Smtp-Source: APXvYqymPJjB3rgrBffPOLp31IZLzKhzf+X3K6Ck/tLy6Yocxz5SJiq9u8LGcuExdnbuA0T7lxZR/g==
X-Received: by 2002:a17:902:3103:: with SMTP id w3mr470954plb.187.1558347178237;
        Mon, 20 May 2019 03:12:58 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id b3sm30098127pfr.146.2019.05.20.03.12.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 03:12:57 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 8/9] mmc: sdhci-sprd: Add PHY DLL delay configuration
Date:   Mon, 20 May 2019 18:12:01 +0800
Message-Id: <aafceaeb2fc7e9d103d1d7a19cdae97759dd1500.1558346019.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1558346019.git.baolin.wang@linaro.org>
References: <cover.1558346019.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1558346019.git.baolin.wang@linaro.org>
References: <cover.1558346019.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the PHY DLL delay for each timing mode, which is used to sample the clock
accurately and make the clock more stable.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci-sprd.c |   51 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index e6eda13..911a09b 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -29,6 +29,8 @@
 #define  SDHCI_SPRD_DLL_INIT_COUNT	0xc00
 #define  SDHCI_SPRD_DLL_PHASE_INTERNAL	0x3
 
+#define SDHCI_SPRD_REG_32_DLL_DLY	0x204
+
 #define SDHCI_SPRD_REG_32_DLL_DLY_OFFSET	0x208
 #define  SDHCIBSPRD_IT_WR_DLY_INV		BIT(5)
 #define  SDHCI_SPRD_BIT_CMD_DLY_INV		BIT(13)
@@ -72,6 +74,24 @@ struct sdhci_sprd_host {
 	struct clk *clk_2x_enable;
 	u32 base_rate;
 	int flags; /* backup of host attribute */
+	u32 phy_delay[MMC_TIMING_MMC_HS400 + 2];
+};
+
+struct sdhci_sprd_phy_cfg {
+	const char *property;
+	u8 timing;
+};
+
+static const struct sdhci_sprd_phy_cfg sdhci_sprd_phy_cfgs[] = {
+	{ "sprd,phy-delay-legacy", MMC_TIMING_LEGACY, },
+	{ "sprd,phy-delay-sd-highspeed", MMC_TIMING_MMC_HS, },
+	{ "sprd,phy-delay-sd-uhs-sdr50", MMC_TIMING_UHS_SDR50, },
+	{ "sprd,phy-delay-sd-uhs-sdr104", MMC_TIMING_UHS_SDR104, },
+	{ "sprd,phy-delay-mmc-highspeed", MMC_TIMING_MMC_HS, },
+	{ "sprd,phy-delay-mmc-ddr52", MMC_TIMING_MMC_DDR52, },
+	{ "sprd,phy-delay-mmc-hs200", MMC_TIMING_MMC_HS200, },
+	{ "sprd,phy-delay-mmc-hs400", MMC_TIMING_MMC_HS400, },
+	{ "sprd,phy-delay-mmc-hs400es", MMC_TIMING_MMC_HS400 + 1, },
 };
 
 #define TO_SPRD_HOST(host) sdhci_pltfm_priv(sdhci_priv(host))
@@ -276,6 +296,9 @@ static unsigned int sdhci_sprd_get_min_clock(struct sdhci_host *host)
 static void sdhci_sprd_set_uhs_signaling(struct sdhci_host *host,
 					 unsigned int timing)
 {
+	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
+	struct mmc_host *mmc = host->mmc;
+	u32 *p = sprd_host->phy_delay;
 	u16 ctrl_2;
 
 	if (timing == host->timing)
@@ -314,6 +337,9 @@ static void sdhci_sprd_set_uhs_signaling(struct sdhci_host *host,
 	}
 
 	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+
+	if (!mmc->ios.enhanced_strobe)
+		sdhci_writel(host, p[timing], SDHCI_SPRD_REG_32_DLL_DLY);
 }
 
 static void sdhci_sprd_hw_reset(struct sdhci_host *host)
@@ -381,6 +407,8 @@ static void sdhci_sprd_hs400_enhanced_strobe(struct mmc_host *mmc,
 					     struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
+	u32 *p = sprd_host->phy_delay;
 	u16 ctrl_2;
 
 	if (!ios->enhanced_strobe)
@@ -395,6 +423,28 @@ static void sdhci_sprd_hs400_enhanced_strobe(struct mmc_host *mmc,
 	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
 
 	sdhci_sprd_sd_clk_on(host);
+
+	/* Set the PHY DLL delay value for HS400 enhanced strobe mode */
+	sdhci_writel(host, p[MMC_TIMING_MMC_HS400 + 1],
+		     SDHCI_SPRD_REG_32_DLL_DLY);
+}
+
+static void sdhci_sprd_phy_param_parse(struct sdhci_sprd_host *sprd_host,
+				       struct device_node *np)
+{
+	u32 *p = sprd_host->phy_delay;
+	int ret, i, index;
+	u32 val[4];
+
+	for (i = 0; i < ARRAY_SIZE(sdhci_sprd_phy_cfgs); i++) {
+		ret = of_property_read_u32_array(np,
+				sdhci_sprd_phy_cfgs[i].property, val, 4);
+		if (ret)
+			continue;
+
+		index = sdhci_sprd_phy_cfgs[i].timing;
+		p[index] = val[0] | (val[1] << 8) | (val[2] << 16) | (val[3] << 24);
+	}
 }
 
 static const struct sdhci_pltfm_data sdhci_sprd_pdata = {
@@ -428,6 +478,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 		goto pltfm_free;
 
 	sprd_host = TO_SPRD_HOST(host);
+	sdhci_sprd_phy_param_parse(sprd_host, pdev->dev.of_node);
 
 	clk = devm_clk_get(&pdev->dev, "sdio");
 	if (IS_ERR(clk)) {
-- 
1.7.9.5

