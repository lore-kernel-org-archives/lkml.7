Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380A2C3276E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE7221582
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003518;
	bh=okv38Ret50vgljluGPpeQLZqSgaaVFFyHEQwC3S3k44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NikiS2hSi+1qdq2YCDSPpVeE2xLjkWcJq5JE0GUTjBdBjlKWOcYQcf1faQE5DxUtN
	 4qEg73A+I1F9TWBHaPRm5qdzBoHRrcMLoqdoI0LJOZnh58YgdwyaZu+wZMK8EbhsiB
	 C94uMQUGPfKKOzoZv5u1tD9GhCtkY+UDqmG04VeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgABWSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:18:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:33856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728470AbgABWSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:18:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2F7322B48;
        Thu,  2 Jan 2020 22:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003512;
        bh=okv38Ret50vgljluGPpeQLZqSgaaVFFyHEQwC3S3k44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qs65n6AeHHjfKA9dvWgB0EZ/ch71JHe05mryPCl2cBZlwUCaNl7SLTw0Ve3wqFByS
         cdS8Y00avTjlWLZcOa2+SortO/YybuL/ZwcUf8BbwbUZ03+X40oSHNAi/FHyvyAVqX
         jXh9snhQ380V5nFTjbgUahInYgVBJNEFO5XQqANo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangbo Lu <yangbo.lu@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 191/191] mmc: sdhci-of-esdhc: re-implement erratum A-009204 workaround
Date:   Thu,  2 Jan 2020 23:07:53 +0100
Message-Id: <20200102215850.119555468@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangbo Lu <yangbo.lu@nxp.com>

[ Upstream commit f667216c5c7c967c3e568cdddefb51fe606bfe26 ]

The erratum A-009204 workaround patch was reverted because of
incorrect implementation.

8b6dc6b mmc: sdhci-of-esdhc: Revert "mmc: sdhci-of-esdhc: add
        erratum A-009204 support"

This patch is to re-implement the workaround (add a 5 ms delay
before setting SYSCTL[RSTD] to make sure all the DMA transfers
are finished).

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
Link: https://lore.kernel.org/r/20191219032335.26528-1-yangbo.lu@nxp.com
Fixes: 5dd195522562 ("mmc: sdhci-of-esdhc: add erratum A-009204 support")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 14f0cb7fa374..fcfb50f84c8b 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -80,6 +80,7 @@ struct sdhci_esdhc {
 	bool quirk_tuning_erratum_type1;
 	bool quirk_tuning_erratum_type2;
 	bool quirk_ignore_data_inhibit;
+	bool quirk_delay_before_data_reset;
 	bool in_sw_tuning;
 	unsigned int peripheral_clock;
 	const struct esdhc_clk_fixup *clk_fixup;
@@ -735,6 +736,11 @@ static void esdhc_reset(struct sdhci_host *host, u8 mask)
 	struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
 	u32 val;
 
+	if (esdhc->quirk_delay_before_data_reset &&
+	    (mask & SDHCI_RESET_DATA) &&
+	    (host->flags & SDHCI_REQ_USE_DMA))
+		mdelay(5);
+
 	sdhci_reset(host, mask);
 
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
@@ -1197,6 +1203,10 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
 	if (match)
 		esdhc->clk_fixup = match->data;
 	np = pdev->dev.of_node;
+
+	if (of_device_is_compatible(np, "fsl,p2020-esdhc"))
+		esdhc->quirk_delay_before_data_reset = true;
+
 	clk = of_clk_get(np, 0);
 	if (!IS_ERR(clk)) {
 		/*
-- 
2.20.1



