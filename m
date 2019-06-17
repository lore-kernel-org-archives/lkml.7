Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574C2C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293492085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tt1rc+ZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbfFQUK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 16:10:26 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42309 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbfFQUKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 16:10:23 -0400
Received: by mail-io1-f66.google.com with SMTP id u19so24090465ior.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 13:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TrP+dwORO9Xg4aec0HaWAympb2e/AJiy4gVQT0weYII=;
        b=Tt1rc+ZS5s3ESXw6Ayk3cPGD+JH2l1u+D6wOwC5cLjeRxfOgt3UjNysh5Us5d6LYYe
         XlJsJRNBimN64BpEFyyZLbCFstqRfDhXhIXa9gQHIR54lo/sfhzrEfhDfaxZjmjcNQDO
         OCC2H/nYzkpPawyo5nqdZza510JsZElQZDl9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TrP+dwORO9Xg4aec0HaWAympb2e/AJiy4gVQT0weYII=;
        b=N95Gr4konqNmGNd4RhlGNDfKBDrMtcAoxDn8OEK5913pywV5fQvv/bAc9O8YsOs7r2
         gVvTaxK1NFPMAxYbN8/OEYTgfEZtFygBrVKfWqC2FgUnVsVJqehVsW6wexfOBOzxrmkg
         EMSGvQQ3fJC9cD9TEvgUWqCsIVp+p3SSnMBVrygKswp4l+fsW7GujcYmfGD2mOpb1ShM
         1kjezmmo1OPUQ7vqztjnWy1WxsHfztovkbWexKTf9OyqRUBRnKLAbuWd9fA/u/sVMrzH
         F8G3/bZ/p4azl0zvv6P+Zek60CX3O/byVRQvNKaFAZenZJbHcqCEWKMK8EAMRidWJR8W
         sthw==
X-Gm-Message-State: APjAAAXYX36XOySXgtJ5CNuNa0h3dhkZmswSvqtO5+OZeEdM9nAPnqaK
        As5wOeUSFWH4QNxi4sKG96vTcQ==
X-Google-Smtp-Source: APXvYqygMJgeWzK1ojHPxZex1M+4XMd9/xaXnVY9vsSh+ib4eptOyhNbzhCuBUjV952+Zzqj8lC6DA==
X-Received: by 2002:a05:6602:2183:: with SMTP id b3mr694917iob.249.1560802222714;
        Mon, 17 Jun 2019 13:10:22 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id e26sm11047672iod.10.2019.06.17.13.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 13:10:22 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org
Cc:     ernest.zhang@bayhubtech.com, djkurtz@chromium.org,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 2/3] mmc: sdhci: sdhci-pci-o2micro: Check if controller supports 8-bit width
Date:   Mon, 17 Jun 2019 14:10:13 -0600
Message-Id: <20190617201014.84503-2-rrangel@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190617201014.84503-1-rrangel@chromium.org>
References: <20190617201014.84503-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The O2 controller supports 8-bit EMMC access.

JESD84-B51 section A.6.3.a defines the bus testing procedure that
`mmc_select_bus_width()` implements. This is used to determine the actual
bus width of the eMMC.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
I tested this on an AMD chromebook.

$ cat /sys/kernel/debug/mmc1/ios
clock:          200000000 Hz
actual clock:   200000000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    9 (mmc HS200)
signal voltage: 1 (1.80 V)
driver type:    0 (driver type B)

Before this patch only 4 bit was negotiated.

 drivers/mmc/host/sdhci-pci-o2micro.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index dd21315922c87..9dc4548271b4b 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -395,11 +395,21 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 {
 	struct sdhci_pci_chip *chip;
 	struct sdhci_host *host;
-	u32 reg;
+	u32 reg, caps;
 	int ret;
 
 	chip = slot->chip;
 	host = slot->host;
+
+	caps = sdhci_readl(host, SDHCI_CAPABILITIES);
+
+	/*
+	 * mmc_select_bus_width() will test the bus to determine the actual bus
+	 * width.
+	 */
+	if (caps & SDHCI_CAN_DO_8BIT)
+		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
+
 	switch (chip->pdev->device) {
 	case PCI_DEVICE_ID_O2_SDS0:
 	case PCI_DEVICE_ID_O2_SEABIRD0:
-- 
2.22.0.410.gd8fdbe21b5-goog

