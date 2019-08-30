Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D670C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 02:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA85321726
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 02:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWDWXTP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfH3CXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 22:23:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43144 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfH3CXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 22:23:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id v12so3496405pfn.10;
        Thu, 29 Aug 2019 19:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kyP8YtTFMbDNG7qsSo2w5pZq5BUurmqPvqGOvI+33I4=;
        b=rWDWXTP702wCGI624fpXgt3wQTyudNC5ks+AxLmDINU0IG4hpia4jffy04LubJ+6FJ
         3J9fzomGghyOAFnNdIHOF92yQes/q9vsDG6AtSF/MYC/5/NC68QPpTardqn+t/tyrxpI
         64Ic+KzV2muXl7r97bMzxEH53rWDI9omFh9KAdJp+QBPzhDyDRMLZigFWK6Ux4nrOGln
         +jpirFjI3lO1Z1hy+s54+fHYuX++TiY7g6IthPlRxKstTiCD7XEsSRP9ilR3O/mE81oR
         zAcgaDkXM47vtcrkUMlMGeKuDfA5hxP97i/uXSpo/OuBUvySOy2UqQZFEwuTu3NFwizs
         Y1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kyP8YtTFMbDNG7qsSo2w5pZq5BUurmqPvqGOvI+33I4=;
        b=gytAb3y4fOVZzvhxhg99ieCDR2B1nKK6kNzC0ywF47hUfSlLM28nQJkRVl5u1GVz4A
         Ss5+i34Ez/z37k/QUAe3M2+SZH5Iwb/I2uya4VII7iCO6Qjb0i96nyBuRF2mOjqAkKgK
         CiGTsSSK+qt+1fRXUVQHdje/lqNdifnFznJ+Hk0iPfbmp7qiN0mfbsNl229WmpHEwwW8
         4hasCFMLZPYFPBjkprIGGBB99wUKridUm1NC2LEjLSHLH/1DkbKUAQF15s/TGFAv6XKO
         aZ2HW1mOe/sKwONbmMnGuRTUdb9SQXkTvow2e9/BizwFOeiKR5e1rBZXf5EBH5ThlpHf
         0+RA==
X-Gm-Message-State: APjAAAV8NRRkPujBzWC0MtE7BNhmahaX3I+CxO8zbPBJVlR47trsLq6+
        Vz7PXPHKSCLijA67vp7Z6UA6FQgg
X-Google-Smtp-Source: APXvYqwNoezNZPMbXavWEQcLm3PgRE/QzsUs6IR2c9RsVMOYbOJ/axfZDqM7Kc++s47GBrpL7Emfhw==
X-Received: by 2002:a62:8344:: with SMTP id h65mr15360588pfe.85.1567131791880;
        Thu, 29 Aug 2019 19:23:11 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id a11sm3231896pju.2.2019.08.29.19.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 19:23:11 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [PATCH V7 1/5] mmc: sdhci: Change timeout of loop for checking internal clock stable
Date:   Fri, 30 Aug 2019 10:23:10 +0800
Message-Id: <20190830022310.8299-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

According to section 3.2.1 internal clock setup in SD Host Controller
Simplified Specifications 4.20, the timeout of loop for checking
internal clock stable is defined as 150ms.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
Signed-off-by: Michael K Johnson <johnsonm@danlj.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 59acf8e3331e..bed0760a6c2a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1636,8 +1636,8 @@ void sdhci_enable_clk(struct sdhci_host *host, u16 clk)
 	clk |= SDHCI_CLOCK_INT_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
-	/* Wait max 20 ms */
-	timeout = ktime_add_ms(ktime_get(), 20);
+	/* Wait max 150 ms */
+	timeout = ktime_add_ms(ktime_get(), 150);
 	while (1) {
 		bool timedout = ktime_after(ktime_get(), timeout);
 
-- 
2.22.1

