Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BBFC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB252461E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H3U36xsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfFDIPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:15:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36938 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfFDIPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:15:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id bh12so1960137plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 01:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Fv2whIvWWtuvlrntuYk8WF1rR93EthhOFv6VYDGUqK0=;
        b=H3U36xsCUdBFRm3KPZyTSWH//zyS50ZT4XZXXWDgwO3Va81kNw7pvlth33eG7dWzrH
         omDFCLKePr2nlgYtOe4W0MyTeJ4hTspfMvXK5YJB64ESExZnjLJlF4IykS6Q6+qbySr0
         zZdBNXibIrWEfD6IroCEc0ndnzGDzqBeIt0hnnv2CuM8D9y+lSHrDjc1ZMTR/GHVCo8W
         t8xBkc6ke362zGEgylzJz4/lIqJ8LwGOolPoY+xSvA8VNzKy2m+syMXqzJNrYUu8XKZA
         IICbKWPnqI21SxfiOPG5/wasSwdfVBzvFuastyGFb12nknN9hTFgpcQM+85KeTbthNc6
         gK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Fv2whIvWWtuvlrntuYk8WF1rR93EthhOFv6VYDGUqK0=;
        b=NNSLky/nIfm0LUIqB++IZu2rPK/cOIMHTDEJrLGckYtAmT8QLso6n2CpSRS07OhvG1
         iT8tjFMEFlmCB5Y1J3CHR7bXbsudcz7/fd0t6XOju/hEqb+ZTX3jMCOeSDqMOqw5G1ny
         ayVeSzxiwt8u5ehW/hTBIgOvBQ7GGtm1U8wuDrG0oHxVt5dt+LoNqyHUZI940ggkzzWc
         Yx6DCozG9ksbK7dBFWfU3UOGehB3ngcWZnqIhypbRYBJI/7N91Lo+QYNPXIv+KGFTwgz
         zSfm9zmoKFrSOF+oDEmAvxBPx465Iwkr1Ua1c39fkTmCXNzH+lc89n169m/ctAnRkBEr
         WR8g==
X-Gm-Message-State: APjAAAWY2dFjatA9UV7STHReETMOQBA2dg8jh5XB52Xf8VsNteNYWHdk
        tN4Vmxi8XQpqLbJ1M5MeKcoofw==
X-Google-Smtp-Source: APXvYqyY2NQVzf09JwfhQjHqJ106rVkuXkui5CHCsJNhadMPvAeANQiapZZITmLH2ZerWGrncqNblw==
X-Received: by 2002:a17:902:b584:: with SMTP id a4mr35666871pls.333.1559636116089;
        Tue, 04 Jun 2019 01:15:16 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j4sm14818804pgc.56.2019.06.04.01.15.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Jun 2019 01:15:15 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 6/9] mmc: sdhci-sprd: Enable PHY DLL to make clock stable
Date:   Tue,  4 Jun 2019 16:14:26 +0800
Message-Id: <c784bd147950d3534a92a9f55174c2406eedeb6e.1559635435.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1559635435.git.baolin.wang@linaro.org>
References: <cover.1559635435.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1559635435.git.baolin.wang@linaro.org>
References: <cover.1559635435.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the Spreadtrum SD host controller, when we changed the clock to be
more than 52M, we should enable the PHY DLL which is used to track the
clock frequency to make the clock work more stable. Otherwise deviation
may occur of the higher clock.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-sprd.c |   44 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index edec197..e6eda13 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -22,6 +22,13 @@
 /* SDHCI_ARGUMENT2 register high 16bit */
 #define SDHCI_SPRD_ARG2_STUFF		GENMASK(31, 16)
 
+#define SDHCI_SPRD_REG_32_DLL_CFG	0x200
+#define  SDHCI_SPRD_DLL_ALL_CPST_EN	(BIT(18) | BIT(24) | BIT(25) | BIT(26) | BIT(27))
+#define  SDHCI_SPRD_DLL_EN		BIT(21)
+#define  SDHCI_SPRD_DLL_SEARCH_MODE	BIT(16)
+#define  SDHCI_SPRD_DLL_INIT_COUNT	0xc00
+#define  SDHCI_SPRD_DLL_PHASE_INTERNAL	0x3
+
 #define SDHCI_SPRD_REG_32_DLL_DLY_OFFSET	0x208
 #define  SDHCIBSPRD_IT_WR_DLY_INV		BIT(5)
 #define  SDHCI_SPRD_BIT_CMD_DLY_INV		BIT(13)
@@ -56,6 +63,7 @@
 #define SDHCI_SPRD_CLK_MAX_DIV		1023
 
 #define SDHCI_SPRD_CLK_DEF_RATE		26000000
+#define SDHCI_SPRD_PHY_DLL_CLK		52000000
 
 struct sdhci_sprd_host {
 	u32 version;
@@ -200,9 +208,33 @@ static inline void _sdhci_sprd_set_clock(struct sdhci_host *host,
 	}
 }
 
+static void sdhci_sprd_enable_phy_dll(struct sdhci_host *host)
+{
+	u32 tmp;
+
+	tmp = sdhci_readl(host, SDHCI_SPRD_REG_32_DLL_CFG);
+	tmp &= ~(SDHCI_SPRD_DLL_EN | SDHCI_SPRD_DLL_ALL_CPST_EN);
+	sdhci_writel(host, tmp, SDHCI_SPRD_REG_32_DLL_CFG);
+	/* wait 1ms */
+	usleep_range(1000, 1250);
+
+	tmp = sdhci_readl(host, SDHCI_SPRD_REG_32_DLL_CFG);
+	tmp |= SDHCI_SPRD_DLL_ALL_CPST_EN | SDHCI_SPRD_DLL_SEARCH_MODE |
+		SDHCI_SPRD_DLL_INIT_COUNT | SDHCI_SPRD_DLL_PHASE_INTERNAL;
+	sdhci_writel(host, tmp, SDHCI_SPRD_REG_32_DLL_CFG);
+	/* wait 1ms */
+	usleep_range(1000, 1250);
+
+	tmp = sdhci_readl(host, SDHCI_SPRD_REG_32_DLL_CFG);
+	tmp |= SDHCI_SPRD_DLL_EN;
+	sdhci_writel(host, tmp, SDHCI_SPRD_REG_32_DLL_CFG);
+	/* wait 1ms */
+	usleep_range(1000, 1250);
+}
+
 static void sdhci_sprd_set_clock(struct sdhci_host *host, unsigned int clock)
 {
-	bool en = false;
+	bool en = false, clk_changed = false;
 
 	if (clock == 0) {
 		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
@@ -214,9 +246,19 @@ static void sdhci_sprd_set_clock(struct sdhci_host *host, unsigned int clock)
 			en = true;
 		sdhci_sprd_set_dll_invert(host, SDHCI_SPRD_BIT_CMD_DLY_INV |
 					  SDHCI_SPRD_BIT_POSRD_DLY_INV, en);
+		clk_changed = true;
 	} else {
 		_sdhci_sprd_set_clock(host, clock);
 	}
+
+	/*
+	 * According to the Spreadtrum SD host specification, when we changed
+	 * the clock to be more than 52M, we should enable the PHY DLL which
+	 * is used to track the clock frequency to make the clock work more
+	 * stable. Otherwise deviation may occur of the higher clock.
+	 */
+	if (clk_changed && clock > SDHCI_SPRD_PHY_DLL_CLK)
+		sdhci_sprd_enable_phy_dll(host);
 }
 
 static unsigned int sdhci_sprd_get_max_clock(struct sdhci_host *host)
-- 
1.7.9.5

