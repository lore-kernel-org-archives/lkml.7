Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEC5C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A2524860
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qaONNRck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfFDIPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:15:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33495 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbfFDIP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:15:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id h17so9919112pgv.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 01:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=TOlsjtC4xw7paP6GLK66GH91I1tWkZ+EZIFEIW5p75U=;
        b=qaONNRck0VSqSeEFSOIDrDdwNVqam1arR0HmFCCadTly5tfEezmZl/GFaWhI/7TQfN
         RQ6gW6EZEuoPs9CdoaToEvKbIq2C3zwGq1zwuFQyQFoo8MrMNrCjuzQWvGcxZs9YaMli
         kCRfDvs8CAIf1t4jOmKx059r6Tkrdnwz0JVhnZZY4gISheGDg0UDge8aji8Ns1w8xoVO
         9hA0ZxHnKp2WqK6zP9qKk8YpGZBZZjftzm8orDryDi0oIPCxOqGCTCWfU10fkgFDbzHp
         JkyAILrpHAbcLRYQr/UlT+qhmUKqKiN98MjLD2vmH3oUA+c6CXAOptQ4GUpmvp2EIUo1
         8q8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=TOlsjtC4xw7paP6GLK66GH91I1tWkZ+EZIFEIW5p75U=;
        b=WRKGMs5RQsl33kvzq2pmFmueFX9YcwJR/iFGJp+Bx4xWHRwmjf+WPkfizF1y8XrVET
         db8+ZiEysaxt4NCeS5ltmYMJ8E3L/azKVFEhlxTdSlxO9AyH7eI3phgXuAyyM38kmX/u
         KeQFjT7ETRTFqtOsRgItFVINLd1rpls8bVgVDVx2pxAlDQ8+R7pUzPAS12RzBVZrqu/0
         WAdcPYV23An1dMGh/vFBhL61XcxiQjnIx8Dq23WnITxCU2Z3Vn47RzR5OfujfPeHQ8py
         Tz1qxSGAi2zjVJoYZ5mM6Ljy/7il46AVFCsEBRlXrT+nVfEMIoiEBpKDmMKpyC6Ir4++
         vrgw==
X-Gm-Message-State: APjAAAVpA/NltkQ/6K0/x6eDFodyQWRzVr8mk/zH+EGRj3FITU8B0Uu/
        nLgdhBjDlP3FqWrlcv/zFADrsvROVMz84A==
X-Google-Smtp-Source: APXvYqyiD1H2V0tnEmhgJvP9bNOu+eLMPl8+2+HiQlloePQjflI2qDezrKoJ0Ojd++7/j55cX4dXMQ==
X-Received: by 2002:a63:6f8d:: with SMTP id k135mr29774834pgc.118.1559636124909;
        Tue, 04 Jun 2019 01:15:24 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j4sm14818804pgc.56.2019.06.04.01.15.20
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Jun 2019 01:15:24 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 8/9] mmc: sdhci-sprd: Add PHY DLL delay configuration
Date:   Tue,  4 Jun 2019 16:14:28 +0800
Message-Id: <3565c86c5373384b50610113e2fe2992531f105a.1559635435.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1559635435.git.baolin.wang@linaro.org>
References: <cover.1559635435.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1559635435.git.baolin.wang@linaro.org>
References: <cover.1559635435.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the PHY DLL delay for each timing mode, which is used to sample the clock
accurately and make the clock more stable.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-sprd.c |   51 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index e6eda13..024c3c5 100644
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
+	{ "sprd,phy-delay-sd-highspeed", MMC_TIMING_SD_HS, },
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

