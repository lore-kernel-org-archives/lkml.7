Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CACC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E15B2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y6+XH3rT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfFQUKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 16:10:23 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39392 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfFQUKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 16:10:20 -0400
Received: by mail-io1-f65.google.com with SMTP id r185so18187229iod.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 13:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zhz2d9XJe8nX7yclD2KabSz2ABSlxKrOqshNsQUbLNs=;
        b=Y6+XH3rTuBpT3/+zGSEve8N2Cd4liXJXGlvGeJlSlgjF4gvKqhNYNQxq4gH2UmWvyX
         JRm4nzTjgugm66g7l1Ku3kx7AtyeUDOjqK0/t+VGLauGNDrRYHMgRW4cdQWrRGcBinuJ
         IJ2ILz0XYXRMpBMaqMofa8CyfHQqrj4BGtpAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zhz2d9XJe8nX7yclD2KabSz2ABSlxKrOqshNsQUbLNs=;
        b=MzD2Lszj0sD7nu9v5eD7JQSB6SDVl2f3DF+uSPweTuttcUQ1R6rZAH+OPTmr6LnUh3
         Z09JkyJMon8blyHrgKOX04vv+GxYUgEny211XwxE7kz4VKNrNwN/32qzTMzPpeHPquWx
         3JBcaMlGsnMyiX2xSSJJEMl9yO2s6YRna/+obDGy9fQadY3N3xwI1Wi139BQ6o1Gn/5b
         m/KlthZJ11IePnu+GVONz/3UEZqGvpCTR8XmIsfSsYAjaySn090gPNlHFUcioqelpJhI
         bUugQ2al96VfmZfncI6B4fYpwCpJrYFZY8vkDdG59BExEk9yoyi0hXljLJhPgMiTOiiN
         mErg==
X-Gm-Message-State: APjAAAUR8cdXk1PdIiVraRL3jIcvz4wSG7DqcMoiCkIix52vwWw+sJ1I
        fUNFCXJ1Wjdz2Fycm/+byVSmtg==
X-Google-Smtp-Source: APXvYqyvSFVPICXlZ5qOrdYqNCjoeODwgIZegCYh7Y1Z/RNaw1BomNUYMBee5d7BAhV7K2HU9ro+EQ==
X-Received: by 2002:a5d:9643:: with SMTP id d3mr18399719ios.227.1560802220123;
        Mon, 17 Jun 2019 13:10:20 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id b6sm9755978iok.71.2019.06.17.13.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 13:10:19 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org
Cc:     ernest.zhang@bayhubtech.com, djkurtz@chromium.org,
        Raul E Rangel <rrangel@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 1/3] mmc: sdhci: sdhci-pci-o2micro: Correctly set bus width when tuning
Date:   Mon, 17 Jun 2019 14:10:12 -0600
Message-Id: <20190617201014.84503-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The O2Micro controller only supports tuning at 4-bits. So the host driver
needs to change the bus width while tuning and then set it back when done.

There was a bug in the original implementation in that mmc->ios.bus_width
also wasn't updated. Thus setting the incorrect blocksize in
sdhci_send_tuning which results in a tuning failure.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Fixes: 0086fc217d5d7 ("mmc: sdhci: Add support for O2 hardware tuning")
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

 drivers/mmc/host/sdhci-pci-o2micro.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index b29bf4e7dcb48..dd21315922c87 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -115,6 +115,7 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 */
 	if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
 		current_bus_width = mmc->ios.bus_width;
+		mmc->ios.bus_width = MMC_BUS_WIDTH_4;
 		sdhci_set_bus_width(host, MMC_BUS_WIDTH_4);
 	}
 
@@ -126,8 +127,10 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 	sdhci_end_tuning(host);
 
-	if (current_bus_width == MMC_BUS_WIDTH_8)
+	if (current_bus_width == MMC_BUS_WIDTH_8) {
+		mmc->ios.bus_width = MMC_BUS_WIDTH_8;
 		sdhci_set_bus_width(host, current_bus_width);
+	}
 
 	host->flags &= ~SDHCI_HS400_TUNING;
 	return 0;
-- 
2.22.0.410.gd8fdbe21b5-goog

