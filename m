Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25420C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAFC2189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="iDDG+wOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfH2LWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:22:42 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:62421 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfH2LWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:22:41 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x7TBMDjE007183;
        Thu, 29 Aug 2019 20:22:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x7TBMDjE007183
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1567077734;
        bh=358U2uqPbl6qXFC9SXmqT9U+KgkSDo6eJ4UtGlqT3Kw=;
        h=From:To:Cc:Subject:Date:From;
        b=iDDG+wOVXM/+21lGdyYLTmVoNK3HTjUTLOSnC6ELrsr289u4SiLK5ziYZWGKrbpNO
         xnETFHkR+5UdmQwOcRXT3LDqWkL6WZRDuymXkgxhYJQqA/rlq9GUuwdxCAvkVlLMit
         JpSvTfHKUXTWK3s+55EOvYH2SW0PZd5yB882M7G1n5iLjYEA7tVcvbTgnEkR3ym3nt
         bQmjX2g6M82XGvnpNxEEWeTPHdffHKu/sanvCOw5IAH+3JQeNEgmeNf4Pf9U57layo
         DaUSaTEbNJ2HRNnYR+Pwqa/JOezFT/+i2zaDGH0GGYz/2jtCnQTusuQQlPLlgF2yiP
         D/1Zu32494mrQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Piotr Sroka <piotrs@cadence.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc: sdhci: use lower/upper_32_bits() macros for DMA addresses
Date:   Thu, 29 Aug 2019 20:22:06 +0900
Message-Id: <20190829112206.22213-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the DMA addresses are casted to (u64) for the upper 32bits
to avoid "right shift count >= width of type" warning.

<linux/kernel.h> provides macros to address this, and I like the macro
names are self-documenting.

I introduced a new helper, sdhci_set_adma_addr() to avoid the code
duplication.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Another way to reduce linu wrapping

 drivers/mmc/host/sdhci.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 08cc0792c174..66c2cf89ee22 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -668,10 +668,10 @@ void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
 	/* 32-bit and 64-bit descriptors have these members in same position */
 	dma_desc->cmd = cpu_to_le16(cmd);
 	dma_desc->len = cpu_to_le16(len);
-	dma_desc->addr_lo = cpu_to_le32((u32)addr);
+	dma_desc->addr_lo = cpu_to_le32(lower_32_bits(addr));
 
 	if (host->flags & SDHCI_USE_64_BIT_DMA)
-		dma_desc->addr_hi = cpu_to_le32((u64)addr >> 32);
+		dma_desc->addr_hi = cpu_to_le32(upper_32_bits(addr));
 
 	*desc += host->desc_sz;
 }
@@ -816,6 +816,13 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 	}
 }
 
+static void sdhci_set_adma_addr(struct sdhci_host *host, dma_addr_t addr)
+{
+	sdhci_writel(host, lower_32_bits(addr), SDHCI_ADMA_ADDRESS);
+	if (host->flags & SDHCI_USE_64_BIT_DMA)
+		sdhci_writel(host, upper_32_bits(addr), SDHCI_ADMA_ADDRESS_HI);
+}
+
 static dma_addr_t sdhci_sdma_address(struct sdhci_host *host)
 {
 	if (host->bounce_buffer)
@@ -826,13 +833,10 @@ static dma_addr_t sdhci_sdma_address(struct sdhci_host *host)
 
 static void sdhci_set_sdma_addr(struct sdhci_host *host, dma_addr_t addr)
 {
-	if (host->v4_mode) {
-		sdhci_writel(host, addr, SDHCI_ADMA_ADDRESS);
-		if (host->flags & SDHCI_USE_64_BIT_DMA)
-			sdhci_writel(host, (u64)addr >> 32, SDHCI_ADMA_ADDRESS_HI);
-	} else {
+	if (host->v4_mode)
+		sdhci_set_adma_addr(host, addr);
+	else
 		sdhci_writel(host, addr, SDHCI_DMA_ADDRESS);
-	}
 }
 
 static unsigned int sdhci_target_timeout(struct sdhci_host *host,
@@ -1095,12 +1099,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 			host->flags &= ~SDHCI_REQ_USE_DMA;
 		} else if (host->flags & SDHCI_USE_ADMA) {
 			sdhci_adma_table_pre(host, data, sg_cnt);
-
-			sdhci_writel(host, host->adma_addr, SDHCI_ADMA_ADDRESS);
-			if (host->flags & SDHCI_USE_64_BIT_DMA)
-				sdhci_writel(host,
-					     (u64)host->adma_addr >> 32,
-					     SDHCI_ADMA_ADDRESS_HI);
+			sdhci_set_adma_addr(host, host->adma_addr);
 		} else {
 			WARN_ON(sg_cnt != 1);
 			sdhci_set_sdma_addr(host, sdhci_sdma_address(host));
-- 
2.17.1

