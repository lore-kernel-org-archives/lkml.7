Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCBAC4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA67A208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XOsFbF7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388887AbfFJSya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 14:54:30 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55942 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387674AbfFJSya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 14:54:30 -0400
Received: by mail-it1-f196.google.com with SMTP id i21so753710ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 11:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=daXs+Zg5JpwmvESTwSzf5RK4ZRVQCRqGZBkG95Vym1M=;
        b=XOsFbF7g+awpsBdgzHfH8P/28fJNJjNhXimq9Up5pVmSfDU0fwNM5F6pLhQXpGc8GG
         TMRbaNyazBpfStpSX+zSD4so0HCQ7ThrF3MTUSoYZ95pjUD+l4b+du8psedaFbjddUeD
         yX/zDbgHnGzN9ud6eAaHJDmEWr/3jP4vtx4Cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=daXs+Zg5JpwmvESTwSzf5RK4ZRVQCRqGZBkG95Vym1M=;
        b=JITPaxQN8E6Wcoek9JPRQIjii7Z7ABIGL2hLWl2Y4X6pVPE9bYuLbqVGl8q9qPrDT1
         /VCo8Y1WcRSPhbkzoYzBDkUiMmh0pORb+HA+w1daYmVdzx1H5sUzbty4sEvt6SOLpkiG
         0mvWVo7wuTt8WaOSqwrNMv1Wme2oSl72cS34hsbaCtTd0NU94vfK8MD3oKBAnJrhN/ut
         rpeYBBvcB3EnOywZ+JBYhvnaD1JqHkGPTSDX8fuZOx5j9BhS6O6X5uNatB90+4euq3hy
         wyUBJMDmFlsGerql0pXQlsHaJ4Y49qXKdxRkgcAQttX7EP3XwNXRbsxWoFv52VqDCfrM
         30NA==
X-Gm-Message-State: APjAAAVRv7H/457crcfA+LCXL97CkbswYHzYjirhYyLxQm4ffRGDuSq3
        k6xgv7E24pPU7BJBifIZzkYHLw==
X-Google-Smtp-Source: APXvYqxsczNm4XKbk5o9HtKx57BlZ6zZ8Ncz/ayRFUvobSV3RUF/A0TzU7Di7woJOM4m1Sgqdb6jRw==
X-Received: by 2002:a24:2b0f:: with SMTP id h15mr12121916ita.99.1560192869752;
        Mon, 10 Jun 2019 11:54:29 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id t133sm4107359iof.21.2019.06.10.11.54.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 11:54:29 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org
Cc:     ernest.zhang@bayhubtech.com, djkurtz@chromium.org,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/3] mmc: sdhci: sdhci-pci-o2micro: Correctly set bus width when tuning
Date:   Mon, 10 Jun 2019 12:53:51 -0600
Message-Id: <20190610185354.35310-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sdhci_send_tuning uses mmc->ios.bus_width to determine the block size.
Without this patch the block size would be set incorrectly when the
bus_width == 8 which results in tuning failing.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
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
2.22.0.rc2.383.gf4fbbf30c2-goog

