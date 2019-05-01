Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB731C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D71420866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CMlH0fg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfEARzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 13:55:11 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41867 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfEARzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 13:55:09 -0400
Received: by mail-io1-f66.google.com with SMTP id r10so15442606ioc.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 10:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ugiQw2wmXsizkXcJVBBH7E80UNKwak/4AnnndV8B0U=;
        b=CMlH0fg6MSe0yGgM9xkAMZ/NyW0I63R3XsYDPFR9TW0ziXvksqmtD1tc1jsCb0vR2o
         8BQCaWD2MKxTmoPhVwOofqJnv5lkXWjl4tBhjTy6bXJyCb+I3rjpyimlSyUoTo7OZ1V1
         2T1Dx9MIkKmBZ/uEZA/mBMi/oa5EkcJ7iK20w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ugiQw2wmXsizkXcJVBBH7E80UNKwak/4AnnndV8B0U=;
        b=Hj2KUnYleLw8HNlM7TsfJAvfaCGKkJVLFqIu1d926xhbIjtr8/SRStJ/t4cT0uBUrB
         W2tO8He+5w5/dA+vUKPLUaJypY/nwjvOxy++E1Ln5H2/0ZTeKJ9zYjcjOKVS0V+CSYsO
         gai6tbfvkk+F5rQxUJ9nNKLgmKDQQlR5d4m5WNAgqORs62d8ubesdX9lFy6JpEHivAsF
         OH4Ek/MS2IwPNgm7Puz7GvygbOcHCvbYpou729ELExhxha1+CxfB0FHnc06+344mGqi5
         FmjInkfrr1jBc86OCuQTDd5bM0RyFsmPuvEwD9gN7XKVycq+U4+q75Mee/ozjZUCMO/8
         WdKw==
X-Gm-Message-State: APjAAAVHjHHQjmuLsHhl5r4zy9s3ex7Wghon6p/7/wk6fF/7kniHrOb0
        3qNkZ5Qo+XFAIKZbmm79m6202Q==
X-Google-Smtp-Source: APXvYqwhYaiNHFycxu5o4Vfs7eXTVNDib9H2MggZucpTu66eESNUATwh7pwGL5bEL+NhIKY6GJNzTA==
X-Received: by 2002:a6b:b585:: with SMTP id e127mr621510iof.197.1556733308703;
        Wed, 01 May 2019 10:55:08 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id f204sm3424627itc.26.2019.05.01.10.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 10:55:08 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org
Cc:     djkurtz@chromium.org, Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RFC PATCH 2/2] mmc: sdhci: Quirk for AMD SDHC Device 0x7906
Date:   Wed,  1 May 2019 11:54:57 -0600
Message-Id: <20190501175457.195855-2-rrangel@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
In-Reply-To: <20190501175457.195855-1-rrangel@chromium.org>
References: <20190501175457.195855-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD SDHC 0x7906 requires a hard reset to clear all internal state.
Otherwise it can get into a bad state where the DATA lines are always
read as zeros.

This change requires firmware that can transition the device into
D3Cold for it to work correctly. If the firmware does not support
transitioning to D3Cold then the power state transitions are a no-op.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/mmc/host/sdhci-pci-core.c | 51 ++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 99b0fec2836b..532fbcbd373b 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -25,6 +25,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/scatterlist.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/mmc/slot-gpio.h>
@@ -1498,11 +1499,59 @@ static int amd_probe(struct sdhci_pci_chip *chip)
 	return 0;
 }
 
+static u32 sdhci_read_present_state(struct sdhci_host *host)
+{
+	return sdhci_readl(host, SDHCI_PRESENT_STATE);
+}
+
+void amd_sdhci_reset(struct sdhci_host *host, u8 mask)
+{
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct pci_dev *pdev = slot->chip->pdev;
+	u32 present_state;
+
+	/*
+	 * SDHC 0x7906 requires a hard reset to clear all internal state.
+	 * Otherwise it can get into a bad state where the DATA lines are always
+	 * read as zeros.
+	 */
+	if (pdev->device == 0x7906 && (mask & SDHCI_RESET_ALL)) {
+		pci_clear_master(pdev);
+
+		pci_save_state(pdev);
+
+		pci_set_power_state(pdev, PCI_D3cold);
+		pr_debug("%s: power_state=%u\n", mmc_hostname(host->mmc),
+			pdev->current_state);
+		pci_set_power_state(pdev, PCI_D0);
+
+		pci_restore_state(pdev);
+
+		/*
+		 * SDHCI_RESET_ALL says the card detect logic should not be
+		 * reset, but since we need to reset the entire controller
+		 * we should wait until the card detect logic has stabilized.
+		 *
+		 * This normally takes about 40ms.
+		 */
+		readx_poll_timeout(
+			sdhci_read_present_state,
+			host,
+			present_state,
+			present_state & SDHCI_CD_STABLE,
+			10000,
+			100000
+		);
+	}
+
+	return sdhci_reset(host, mask);
+}
+
 static const struct sdhci_ops amd_sdhci_pci_ops = {
 	.set_clock			= sdhci_set_clock,
 	.enable_dma			= sdhci_pci_enable_dma,
 	.set_bus_width			= sdhci_set_bus_width,
-	.reset				= sdhci_reset,
+	.reset				= amd_sdhci_reset,
 	.set_uhs_signaling		= sdhci_set_uhs_signaling,
 };
 
-- 
2.21.0.593.g511ec345e18-goog

