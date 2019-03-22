Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7A4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4FC2083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256980;
	bh=fcZl3fKBQoVlxAFlmvZRIW+fWoEIR2Fgbh9kbs/JBRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NmsQ+DNzVbYsi5YqQr+4kNwmdJqtdY1GNN+WA29vSq/I8cMGqQE6tENqSy7UJCfLn
	 xHY1qcImmoLPa0vjDxsZu+wnrC+FEsDntW7H4qc/8CVUMRiU4E1nMBnyyEU+trauWr
	 IEOh9yzJzzjHTCLG2Tt4nBSbZYvrTxG7GsdCe6F8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390196AbfCVMQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:16:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389935AbfCVMQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:16:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06BF92083D;
        Fri, 22 Mar 2019 12:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256976;
        bh=fcZl3fKBQoVlxAFlmvZRIW+fWoEIR2Fgbh9kbs/JBRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gyDIXwEUhfdOIEclQJpL9TSr9Yj2/yyeljvPaupqzBo7WIiEfiPL1/2QNTHF2LfMm
         NRCsiMff412qP7HeNhBnG3PpGRil8NYO2h2JKKLeA5s9EvTygksFhwc4f5SMdzEOiC
         /lnaCRHCOTbc3pUT0GHw8BGrlutVIcxYSTHRXE1E=
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
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.0 063/238] mmc: renesas_sdhi: Fix card initialization failure in high speed mode
Date:   Fri, 22 Mar 2019 12:14:42 +0100
Message-Id: <20190322111302.294363058@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takeshi Saito <takeshi.saito.xv@renesas.com>

commit d30ae056adb81e1d2b8b953efa74735a020b8e3b upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/renesas_sdhi_core.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -723,6 +723,13 @@ int renesas_sdhi_probe(struct platform_d
 		host->ops.start_signal_voltage_switch =
 			renesas_sdhi_start_signal_voltage_switch;
 		host->sdcard_irq_setbit_mask = TMIO_STAT_ALWAYS_SET_27;
+
+		/* SDR and HS200/400 registers requires HW reset */
+		if (of_data && of_data->scc_offset) {
+			priv->scc_ctl = host->ctl + of_data->scc_offset;
+			host->mmc->caps |= MMC_CAP_HW_RESET;
+			host->hw_reset = renesas_sdhi_hw_reset;
+		}
 	}
 
 	/* Orginally registers were 16 bit apart, could be 32 or 64 nowadays */
@@ -775,8 +782,6 @@ int renesas_sdhi_probe(struct platform_d
 		const struct renesas_sdhi_scc *taps = of_data->taps;
 		bool hit = false;
 
-		host->mmc->caps |= MMC_CAP_HW_RESET;
-
 		for (i = 0; i < of_data->taps_num; i++) {
 			if (taps[i].clk_rate == 0 ||
 			    taps[i].clk_rate == host->mmc->f_max) {
@@ -789,12 +794,10 @@ int renesas_sdhi_probe(struct platform_d
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


