Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33296C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0970321D80
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570696865;
	bh=yCL7vknIl3cVtddlPXzUFN41K9u1QH75+TsucXHQe44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2ddSwkb1MMo2XOZ7+Lyg9WZAC12gI21n3Fc/vfAp30syYWkW7RmdHwEbDbqURur3H
	 PlRGh2xUvXA0j7tFBbgIlVgtVGd/vSVm3iAr6oGJe/y7cRGsULh0cfPTwEtV2xzy9h
	 Rgkj2zUIDiloQQWMq8CPTLaAvoyGvq07uSy5pML4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388243AbfJJIlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:41:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388235AbfJJIlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:41:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B52EF21D6C;
        Thu, 10 Oct 2019 08:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570696860;
        bh=yCL7vknIl3cVtddlPXzUFN41K9u1QH75+TsucXHQe44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rKXObDomHbv/hqSfksqmeUsSTCN7llShLlpKgb2mgWcZIYHm4tCeyoh90zx1JNDNX
         GEQhe+rx0lizlyb1fvhJvx1bCR5fJ0p7TDBlfN711A4rMPZKv0MAbbKtxd2ipOAs4S
         Cr80mUTzoJtVCGfbi+t85RTQXNzE98kHcrWtAGLQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.3 077/148] mmc: sdhci: Let drivers define their DMA mask
Date:   Thu, 10 Oct 2019 10:35:38 +0200
Message-Id: <20191010083616.016416989@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083609.660878383@linuxfoundation.org>
References: <20191010083609.660878383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

commit 4ee7dde4c777f14cb0f98dd201491bf6cc15899b upstream.

Add host operation ->set_dma_mask() so that drivers can define their own
DMA masks.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Cc: stable@vger.kernel.org # v4.15 +
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci.c |   12 ++++--------
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 5 insertions(+), 8 deletions(-)

--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3763,18 +3763,14 @@ int sdhci_setup_host(struct sdhci_host *
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
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -622,6 +622,7 @@ struct sdhci_ops {
 
 	u32		(*irq)(struct sdhci_host *host, u32 intmask);
 
+	int		(*set_dma_mask)(struct sdhci_host *host);
 	int		(*enable_dma)(struct sdhci_host *host);
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);


