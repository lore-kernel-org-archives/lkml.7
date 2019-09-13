Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF881C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98718206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381427;
	bh=ao2KN6nkrJRRgCQMaG6wwvL0TDA2aYFqBntUtLWoWy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tyuwy6lNWPYlXava6w23Z3WcK1lGu3rioxuAb5HrOFhr4bw1Bhm/N2t/BFOSh+R6e
	 qU95noUoVVHUOAnJsCtYFwWdaMQmbKT8ZV+tcwzPCu+QdOrB7BkClvbtaP9heX7Ly9
	 JHqdfErdN+0lPYocNVe4GlB/49eC8xuEnKOW78Bw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389031AbfIMNQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:16:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389214AbfIMNQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:16:46 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E18F120717;
        Fri, 13 Sep 2019 13:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380605;
        bh=ao2KN6nkrJRRgCQMaG6wwvL0TDA2aYFqBntUtLWoWy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1AlLx+oaX9lAOvyxw4DWXHPoYFceMKcqIdVm4lmFiCz1gvUy4qUW49hfy0IBS8zj+
         oQTurp6E9CEqq5Ongee7AK9XZaAnWXn/pzohxANiomxh+ha4HA4hh8yvJ1rt+fnLY8
         zyCqdCOOo9293yN0Ajg2n6wUmfUTQtlntADc+NsA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Takeshi Saito <takeshi.saito.xv@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 098/190] mmc: renesas_sdhi: Fix card initialization failure in high speed mode
Date:   Fri, 13 Sep 2019 14:05:53 +0100
Message-Id: <20190913130607.445320954@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d30ae056adb81e1d2b8b953efa74735a020b8e3b ]

This fixes card initialization failure in high speed mode.

If U-Boot uses SDR or HS200/400 mode before starting Linux and Linux
DT does not enable SDR/HS200/HS400 mode, card initialization fails in
high speed mode.

It is necessary to initialize SCC registers during card initialization
phase. HW reset function is registered only for a port with either of
SDR/HS200/HS400 properties in device tree. If SDR/HS200/HS400 properties
are not present in device tree, SCC registers will not be reset. In SoC
that support SCC registers, HW reset function should be registered
regardless of the configuration of device tree.

Reproduction procedure:
- Use U-Boot that support MMC HS200/400 mode.
- Delete HS200/HS400 properties in device tree.
  (Delete mmc-hs200-1_8v and mmc-hs400-1_8v)
- MMC port works high speed mode and all commands fail.

Signed-off-by: Takeshi Saito <takeshi.saito.xv@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Cc: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/renesas_sdhi_core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 45baf5d9120e3..61f0faddfd889 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -636,6 +636,13 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		host->ops.card_busy = renesas_sdhi_card_busy;
 		host->ops.start_signal_voltage_switch =
 			renesas_sdhi_start_signal_voltage_switch;
+
+		/* SDR and HS200/400 registers requires HW reset */
+		if (of_data && of_data->scc_offset) {
+			priv->scc_ctl = host->ctl + of_data->scc_offset;
+			host->mmc->caps |= MMC_CAP_HW_RESET;
+			host->hw_reset = renesas_sdhi_hw_reset;
+		}
 	}
 
 	/* Orginally registers were 16 bit apart, could be 32 or 64 nowadays */
@@ -693,8 +700,6 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		const struct renesas_sdhi_scc *taps = of_data->taps;
 		bool hit = false;
 
-		host->mmc->caps |= MMC_CAP_HW_RESET;
-
 		for (i = 0; i < of_data->taps_num; i++) {
 			if (taps[i].clk_rate == 0 ||
 			    taps[i].clk_rate == host->mmc->f_max) {
@@ -707,12 +712,10 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		if (!hit)
 			dev_warn(&host->pdev->dev, "Unknown clock rate for SDR104\n");
 
-		priv->scc_ctl = host->ctl + of_data->scc_offset;
 		host->init_tuning = renesas_sdhi_init_tuning;
 		host->prepare_tuning = renesas_sdhi_prepare_tuning;
 		host->select_tuning = renesas_sdhi_select_tuning;
 		host->check_scc_error = renesas_sdhi_check_scc_error;
-		host->hw_reset = renesas_sdhi_hw_reset;
 		host->prepare_hs400_tuning =
 			renesas_sdhi_prepare_hs400_tuning;
 		host->hs400_downgrade = renesas_sdhi_disable_scc;
-- 
2.20.1



