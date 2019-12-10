Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9DFC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79FE2073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576017341;
	bh=+d/EPeAnK08Y492IrzqNRX5zak9fQNfVoHVoWmvBVg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1svwA1RKfEdEHWnKMjv1wULdoJi22L1DvJGFL+ecPZFGPt0ntkf1pUYjJt6+3IWQb
	 dJEvW0ZanDcxNFTfnUtqqN2wyLI4YxqCnL+3vFZIn8Er6T69LrxONYNAOR/LYjU1uQ
	 CYc7p/IoCp47bSdVXR2X4evsh4eEPGUhvf32l0uA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbfLJWfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:35:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730355AbfLJWeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:34:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4EA020836;
        Tue, 10 Dec 2019 22:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576017270;
        bh=+d/EPeAnK08Y492IrzqNRX5zak9fQNfVoHVoWmvBVg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S0oLChbAuun1I9TXPFZph03frXeUfffTR9K5tgir+VyjR7VddfL9n47Gig6kgynPW
         e/dJZilTuMJfuXfo8A7bIIX0pekvSDeEmwFY7rJYNuPuFkuyl65qUxmb5+OyjM1wQV
         tBx+dN1ap6908J78O5bNRgeaXrQGPeangrFXtcPo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 62/71] spi: tegra20-slink: add missed clk_unprepare
Date:   Tue, 10 Dec 2019 17:33:07 -0500
Message-Id: <20191210223316.14988-62-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210223316.14988-1-sashal@kernel.org>
References: <20191210223316.14988-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit 04358e40ba96d687c0811c21d9dede73f5244a98 ]

The driver misses calling clk_unprepare in probe failure and remove.
Add the calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Link: https://lore.kernel.org/r/20191115083122.12278-1-hslester96@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-tegra20-slink.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index af2880d0c1126..cf2a329fd8958 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1078,7 +1078,7 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	ret = clk_enable(tspi->clk);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Clock enable failed %d\n", ret);
-		goto exit_free_master;
+		goto exit_clk_unprepare;
 	}
 
 	spi_irq = platform_get_irq(pdev, 0);
@@ -1151,6 +1151,8 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	free_irq(spi_irq, tspi);
 exit_clk_disable:
 	clk_disable(tspi->clk);
+exit_clk_unprepare:
+	clk_unprepare(tspi->clk);
 exit_free_master:
 	spi_master_put(master);
 	return ret;
@@ -1164,6 +1166,7 @@ static int tegra_slink_remove(struct platform_device *pdev)
 	free_irq(tspi->irq, tspi);
 
 	clk_disable(tspi->clk);
+	clk_unprepare(tspi->clk);
 
 	if (tspi->tx_dma_chan)
 		tegra_slink_deinit_dma_param(tspi, false);
-- 
2.20.1

