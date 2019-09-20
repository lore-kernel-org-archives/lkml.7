Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A88C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68227207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfOKXau0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393184AbfITOx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:53:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45280 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393093AbfITOxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:53:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id r5so7029597wrm.12;
        Fri, 20 Sep 2019 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sqBk6Eh20MmrpL05y6UmSfOFAEnXMMhGLx6ipY+AkJE=;
        b=OfOKXau0IXNaeF8cNwCPvon5P7hs1xa6mXPkrtU2VA3qm92B6qgA6jPNMZYJZMMQ4q
         QxliAfWoUWcrObf2pJ4NnQRCi4T/EFtMsQCGOqteUUr00NG2o3dy9IyE2HA2uwYL8k1d
         7bwvpjNl1Fi34V/ssEpeNDO/d1O6gQVS1IasnrTnXhrv/XlFj4DSwLVFCTLkAL4OQZxp
         Pu4UovzidXJA9lIxKN4fPw6kw2L18JV+xJm8JBbIdsdQGHqRkurv9bjAddjpVAsyWa/Z
         1RXnu5WgyJ2bVwyu+QTsScHhSyKEGLLb0Q2+8xyQHSp2A7EpMhDfEk6PuDIl/1V9QTgj
         x+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sqBk6Eh20MmrpL05y6UmSfOFAEnXMMhGLx6ipY+AkJE=;
        b=sv5mDQQfP9+eF3HqEXh0iinbGbMTLFFDQMxYxj81peB+S4Y6OyMyloD0RxEs77LBbc
         8BVgwab5vpEhic6s3eWJyT2FAkOpW1Et4h0gSHnMTvWeFnR8rgDraR/ANXWlOTjQVnVy
         5ALQvrlJZPJ4onFJxgn3NyNN3NuuLH2AhxQ5wS9Pox9jhaQJPhlzA/OKl0hB5dTCI7DS
         8gMZw53SKfz90z2WmOztpmVsL+G7l9ZDWHaZ5Yu1ypV+q61nTrJni1Chd9sYK+RgkdzW
         RL04h3cG1lF7mHV76pHxsCfvHfkHINf38z3ujjy3wekJUXVJ+QBUeqNZWFkb+zGG1kHk
         gi2g==
X-Gm-Message-State: APjAAAXAv+gu0PciGYqRN5EH2tpIW6ve4OjLL3OSLCeAfOeIAPNnNG1d
        d+67lvITdTYEj1vqQwG256Y=
X-Google-Smtp-Source: APXvYqzJut0WE0+WqR67I7y132gqKvyUQsmajVMX3EFoJVKJKYKscC3WarA4WvNtYC6sZuy2KqOHZQ==
X-Received: by 2002:a5d:49c7:: with SMTP id t7mr12735323wrs.229.1568991202791;
        Fri, 20 Sep 2019 07:53:22 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id i5sm2228330wmd.21.2019.09.20.07.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 07:53:21 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        inux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mmc: sdhci: Let drivers define their DMA mask
Date:   Fri, 20 Sep 2019 16:53:16 +0200
Message-Id: <20190920145317.11972-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190920145317.11972-1-thierry.reding@gmail.com>
References: <20190920145317.11972-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add host operation ->set_dma_mask() so that drivers can define their own
DMA masks.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/host/sdhci.c | 12 ++++--------
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a5dc5aae973e..bc04c3180477 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3756,18 +3756,14 @@ int sdhci_setup_host(struct sdhci_host *host)
 		host->flags &= ~SDHCI_USE_ADMA;
 	}
 
-	/*
-	 * It is assumed that a 64-bit capable device has set a 64-bit DMA mask
-	 * and *must* do 64-bit DMA.  A driver has the opportunity to change
-	 * that during the first call to ->enable_dma().  Similarly
-	 * SDHCI_QUIRK2_BROKEN_64_BIT_DMA must be left to the drivers to
-	 * implement.
-	 */
 	if (sdhci_can_64bit_dma(host))
 		host->flags |= SDHCI_USE_64_BIT_DMA;
 
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
-		ret = sdhci_set_dma_mask(host);
+		if (host->ops->set_dma_mask)
+			ret = host->ops->set_dma_mask(host);
+		else
+			ret = sdhci_set_dma_mask(host);
 
 		if (!ret && host->ops->enable_dma)
 			ret = host->ops->enable_dma(host);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 902f855efe8f..8285498c0d8a 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -622,6 +622,7 @@ struct sdhci_ops {
 
 	u32		(*irq)(struct sdhci_host *host, u32 intmask);
 
+	int		(*set_dma_mask)(struct sdhci_host *host);
 	int		(*enable_dma)(struct sdhci_host *host);
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
-- 
2.23.0

