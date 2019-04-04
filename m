Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5CFC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315002186A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368840;
	bh=QW5DUS6pz2+BjaMs3rleFvD4NQXGRGfc+iLvi+sce0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vbBKttZuWdkMYSybpjk0FF9G6H6krHGHbWqD5QmyS57h4cBlhQD8x1m+pIO7dUfy6
	 WYfDkT6j4FpjeVIudDn1xrE41SRzkFRhTU5RHG2bc0bJLeKiUTGFfffkOpUCrOmkqT
	 t2u2+DlhHsmE1oovBL+VohRpzq0B0S2dOgxrxe9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731999AbfDDJHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:07:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732216AbfDDJHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:07:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9765A2183E;
        Thu,  4 Apr 2019 09:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368834;
        bh=QW5DUS6pz2+BjaMs3rleFvD4NQXGRGfc+iLvi+sce0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f7GgwCBBDIdE7WEFT0m7x44zB5z73eUEC4zxkfTS/qak3ShMQNtho97ygrm14umrc
         o8uIEYYr7unTLWtLcRTt55bKWUSX38AfktspZrTPkgA9arUHxJQ+9Xw/mmIy/SVCue
         uhYWR5liYsYgYA54J3avWU6RstWGGt5PFCyWaPxA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 179/187] clk: meson: clean-up clock registration
Date:   Thu,  4 Apr 2019 10:48:36 +0200
Message-Id: <20190404084611.558652834@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



