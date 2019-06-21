Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1440AC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 06:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0C52083B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 06:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="osCAdvXZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfFUGMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 02:12:55 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39860 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfFUGMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 02:12:54 -0400
Received: by mail-pl1-f196.google.com with SMTP id b7so2470549pls.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 23:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=7nHW+SBzX1vnb4mk1MDf9lGhalkNUllPIWRi8UNhM/c=;
        b=osCAdvXZJmd8s32WoaH84e0LvoQF3n8quJaSrFXXcZI2cepOsKaYqkZhdXl6Hipp1t
         MNT21Hkn6pag47WU/b70key5vgzuhiyEbIyDFj7NUoKIwA4nVoTsgAr1LbAvE1e9580o
         ojwN0FXPZn+ZwbFGBZaWJBlmoykMq8Y3IfDCrdn4Lje8NGTdaAn4Zu0K3ZaBj3ngMSzd
         5heMfR7ve4WTUcKdL3TLMPPguf7EzfTIJCi6nJQkpc5I3ja4gL7elfXltWm2OukUep48
         KQ6bedBrVvRAxuX0n+NXZV/uHEmz1LzGOWHDLYMm/iBXQpWgyeU+VJJSgISWBjEFC1++
         gMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=7nHW+SBzX1vnb4mk1MDf9lGhalkNUllPIWRi8UNhM/c=;
        b=UJ48ZFaqunqy5P7yJIoP7OYTHflduB/Bk9UqZDV+DwiVxb483exHzEpLfiaBECPypE
         7goPSH4bDW159gxa+8Hv3EutCSrX87TRhIp3g0wKLTL9PCrSz6PXX0adQCogige6rSwL
         wpC0uPWl7khVp/ODdc9V8Nv8U+dbqDvJjsE40jcExcoI/yfhx4rH80aLCZLXYHOYMuQt
         g+qz3ctbhuKpUFow+1rebeM1WfXSYDAcafOKhM7ye6fiK1I6SJ6M72i3Io75nzonPR0f
         DM8sVjqhlyx7Z0D1wN1s99NJeNbsDciD5Pb0GnNV7h5wsMYjSOf48OgQ+e0/QhRwmyA5
         bRaA==
X-Gm-Message-State: APjAAAXCd4A4ogY4u+S1NN0268BpR8BfLozTV1tQtEZ19y1CG5DYwpXw
        qKNvHK9VeR7kLkzB/MItld0Fqg==
X-Google-Smtp-Source: APXvYqzV1QMcGWKHcO3GJFszFvYHtJaXinkBiAsjKQeNI5kSsCCcFHT5+Hm1oVT9CT+LJc1z8sKSjg==
X-Received: by 2002:a17:902:7583:: with SMTP id j3mr11377956pll.196.1561097573451;
        Thu, 20 Jun 2019 23:12:53 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id x7sm1266134pfm.82.2019.06.20.23.12.50
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 23:12:53 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/3] mmc: sdhci-sprd: Add start_signal_voltage_switch ops
Date:   Fri, 21 Jun 2019 14:12:31 +0800
Message-Id: <89fb15e88f33a3c1ce7b5eefa9414a20c984c579.1561094029.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1561094029.git.baolin.wang@linaro.org>
References: <cover.1561094029.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1561094029.git.baolin.wang@linaro.org>
References: <cover.1561094029.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Spreadtrum SD host controller, we can not use standard SD registers
to change and detect the I/O voltage signals, since our voltage regulator
for I/O is fixed in hardware, and no signals were connected to the SD
controller. Thus add Spreadtrum specific voltage switch ops to change
voltage instead of using standard SD host registers.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci-sprd.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 024c3c5..8b23c88 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -403,6 +403,22 @@ static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	sdhci_request(mmc, mrq);
 }
 
+static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	int ret;
+
+	if (!IS_ERR(mmc->supply.vqmmc)) {
+		ret = mmc_regulator_set_vqmmc(mmc, ios);
+		if (ret) {
+			pr_err("%s: Switching signalling voltage failed\n",
+			       mmc_hostname(mmc));
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static void sdhci_sprd_hs400_enhanced_strobe(struct mmc_host *mmc,
 					     struct mmc_ios *ios)
 {
@@ -470,6 +486,14 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	host->mmc_host_ops.request = sdhci_sprd_request;
 	host->mmc_host_ops.hs400_enhanced_strobe =
 		sdhci_sprd_hs400_enhanced_strobe;
+	/*
+	 * We can not use the standard ops to change and detect the voltage
+	 * signal for Spreadtrum SD host controller, since our voltage regulator
+	 * for I/O is fixed in hardware, that means we do not need control
+	 * the standard SD host controller to change the I/O voltage.
+	 */
+	host->mmc_host_ops.start_signal_voltage_switch =
+		sdhci_sprd_voltage_switch;
 
 	host->mmc->caps = MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
 		MMC_CAP_ERASE | MMC_CAP_CMD23;
-- 
1.7.9.5

