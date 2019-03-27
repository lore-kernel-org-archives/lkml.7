Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4053CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4A5217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710209;
	bh=0qLHF3LgfFbvHLtMyDGO59z6r4GEQMr2fBPiTFD6aKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YvvVTKXZpUjXJpVhcjwcUsNuBWjYOKPFebIZXtAYrVi+8FyrxXWP9D/eqjAZv6NNH
	 DLCTWu/vVFFvjfnQ9P6RSeVcXdlzS7172SjT1ISiqnXmbJavx8+X5ywq9qd9PZf6TC
	 NV92UeERVepLFtoK5eAwLWF6OvHO6CBxD4TLWQHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388738AbfC0SKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388719AbfC0SKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:10:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 975622183E;
        Wed, 27 Mar 2019 18:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710204;
        bh=0qLHF3LgfFbvHLtMyDGO59z6r4GEQMr2fBPiTFD6aKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z7szw4K1HlPrFyzhLKWr7YaLNk9wEtzwifobN06PJzjuefnnmybUSX6LFkJOCpCKH
         CAKA4qjqe+Pu/gWvzGzWwO06VIPluk5ApwgLuOLjYD9MJw3mYaXNONFZWOIg916DjU
         vuhuEOiFsEV+V2DvYK2epcsznsM9wT/Za3v+HLnI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 249/262] clk: meson: clean-up clock registration
Date:   Wed, 27 Mar 2019 14:01:44 -0400
Message-Id: <20190327180158.10245-249-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 8d9981efbcab066d17af4d3c85c169200f6f78df ]

Order, ids and size  between the table of regmap clocks and the onecell
data table could be different.

Set regmap pointer in all the regmap clocks before starting the
registration using the onecell data, to make sure we don't
get into an incoherent situation.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://lkml.kernel.org/r/20181221160239.26265-3-jbrunet@baylibre.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/meson/meson-aoclk.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/meson/meson-aoclk.c b/drivers/clk/meson/meson-aoclk.c
index f965845917e3..258c8d259ea1 100644
--- a/drivers/clk/meson/meson-aoclk.c
+++ b/drivers/clk/meson/meson-aoclk.c
@@ -65,15 +65,20 @@ int meson_aoclkc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/*
-	 * Populate regmap and register all clks
-	 */
-	for (clkid = 0; clkid < data->num_clks; clkid++) {
+	/* Populate regmap */
+	for (clkid = 0; clkid < data->num_clks; clkid++)
 		data->clks[clkid]->map = regmap;
 
+	/* Register all clks */
+	for (clkid = 0; clkid < data->hw_data->num; clkid++) {
+		if (!data->hw_data->hws[clkid])
+			continue;
+
 		ret = devm_clk_hw_register(dev, data->hw_data->hws[clkid]);
-		if (ret)
+		if (ret) {
+			dev_err(dev, "Clock registration failed\n");
 			return ret;
+		}
 	}
 
 	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
-- 
2.19.1

