Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2FDC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7A920867
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vgLPKG9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438610AbfIWKIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 06:08:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34540 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405390AbfIWKIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 06:08:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id a11so13285898wrx.1;
        Mon, 23 Sep 2019 03:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ehc2rp+oM8XMUcsYsV9AJzPdXDz5yqtJsvQjDJWeBcU=;
        b=vgLPKG9Xg80fQ6+TPzXyJnTWHlCad0eNKWkYJmYRNKMMOYdpDvlDBEZNRvF65VmXrv
         ylNnnvi6quR80DxqZh9UF107dodCl1Igi5wMW3fERCzp2Pl8BOl7F31MyHFzCNQQ3oZq
         B9ZLbm4+84kghGRePLhfviNqBw0DmjNk22kLJz37BGIIAn4ZXEgIJYcp+cqSLlWDV/YO
         +HcZNHsB+o9axGTYu2KHNpgEhFtlgySQyYzIrMOeQLDSMxAo0lyGuoG+zTkDyl5tn4Nu
         tQy/5XJYThNEqHjuI5O2IrurraU72unVpgbjS8vzzkzmz6PRmDoV3SEkg4My2B0MLm5N
         ugLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ehc2rp+oM8XMUcsYsV9AJzPdXDz5yqtJsvQjDJWeBcU=;
        b=jQ76lTXVkyWRhnjua2B77ME+dj1nfDInAacy1KU1UUSbkf4cEhQt9Q568Iminf/Mg2
         RwqBQS4w8u4Aeb6qht4IMjvFRNCkF3uPN+lpHPvo8mdIGeNfRM945JoCa4gogHMhEXea
         57XS2I83Zn0r4qMzie+tpxrTF6XP9NhUfZhz578Qpp/Duk1vbSAgyD4OZiVSdGkGK+AV
         HHeraeHnLgkAhORKQ/qiyEpCur7EowH0YfwlPr1MCSKA8WV12uY0671rICTjHDcIJ8z7
         2URaOXxRatlJuZMhwz45cIPTfrcjw03RXOk7Ma/ws6rwwuT/DPv3sB23W+3DQR7CUlQf
         ixKQ==
X-Gm-Message-State: APjAAAUtpGuXbXODb7iQ+ykf55BINeTfVQ/ZleMoUSbIwrM6SIHreCzN
        ZNbgx8wpW7uuZ84j9fmJ+vc=
X-Google-Smtp-Source: APXvYqwuRjrmxn2gyIIOm+Gm32e8EHf7nC3/TFZI1P3uKB/AlOdcJGLKAXzo0sjnP53r+Z1xCB6gcQ==
X-Received: by 2002:adf:f4cd:: with SMTP id h13mr21396740wrp.42.1569233292454;
        Mon, 23 Sep 2019 03:08:12 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id a14sm4889993wmm.44.2019.09.23.03.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 03:08:11 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mmc: sdhci: Let drivers define their DMA mask
Date:   Mon, 23 Sep 2019 12:08:09 +0200
Message-Id: <20190923100810.12698-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
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
Tested-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- add Tested-by tag from Nicolin

 drivers/mmc/host/sdhci.c | 12 ++++--------
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d814dc004bad..cf38ff09bef0 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3782,18 +3782,14 @@ int sdhci_setup_host(struct sdhci_host *host)
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
index cf3d1ed91909..61018e7fb0b6 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -623,6 +623,7 @@ struct sdhci_ops {
 
 	u32		(*irq)(struct sdhci_host *host, u32 intmask);
 
+	int		(*set_dma_mask)(struct sdhci_host *host);
 	int		(*enable_dma)(struct sdhci_host *host);
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
-- 
2.23.0

