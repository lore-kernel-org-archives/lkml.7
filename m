Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A334C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE19206B6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369616;
	bh=nbWDwaLmicGyNxbM4FPtBdgnNOzfVLmtHTOmzG0SRZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Au3c/IOT1gRl7DQO9jGdpMhs//xwMTBom8g2IhBpYYYDD4oDsa1DtXqQi4bGqy4Mu
	 T3KbShWX36mntIGxfH8rlzXxPh7vPDcL2RFQntJ3pP52HsccemS+rDb5ezVkDxIWAD
	 LC6mtDE9fwzhBA85SvoJP+Sbj0Ba87FbbviBO3t4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388278AbfDDJRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:17:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388263AbfDDJRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:17:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D30CB2075E;
        Thu,  4 Apr 2019 09:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369462;
        bh=nbWDwaLmicGyNxbM4FPtBdgnNOzfVLmtHTOmzG0SRZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mk97qqvfkEOHpz4WsH5iC3sHyAWOBxvkVBPx6zWXJq6/LEoAAQQb8rQy0Fzk2EQxq
         G1rw3J/N9wNg+0JJQQkX216o5NE90fY7iYDXJZ8Tl3nXZrR4u6IeOVnN9IOukbM4/i
         vwnLhDxSIp0RYFIPWIK7xsczWG+wufg18k1KW8U8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 233/246] clk: meson: clean-up clock registration
Date:   Thu,  4 Apr 2019 10:48:53 +0200
Message-Id: <20190404084627.438749658@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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



