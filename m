Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1642C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E06820880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355489;
	bh=NBgbJQoXvQp6YbzNokytJMcdj5bH7DACkuVhg6Tp9w8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uVbHgpHmvRfRDGWHXZBedZakWLs1oAowPvx3N1oUhk13NFXamc+r4rt58weHNpzfY
	 AQJXMCGWrDAo+rUgW8xJgj+2Fogto09wetwD0SxJbnfD6nDqxQGQSynculST/yRoGm
	 kQ6HZt+Y/RmbXBlXf6mXmmEdsstsKaU26+eltKR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbfDOTL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:11:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731205AbfDOTLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:11:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98476218FF;
        Mon, 15 Apr 2019 19:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355483;
        bh=NBgbJQoXvQp6YbzNokytJMcdj5bH7DACkuVhg6Tp9w8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=icCE3FErCBoTUQ6SXMHP6f4sFXRGcmCqp0ZqjFqueWpiASW6C7vN5HSH2FL9QljZg
         cfKmb+D/V4fdlngmQhLf5M4JZxInbuHRaF9DRgIBF8yb9w/mBrgUVJ5VqXHD4bXj6t
         rYrL8lY5EBYLpmdqK/WfKuEl8d3MV/c3WUF77lVk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 044/117] Revert "clk: meson: clean-up clock registration"
Date:   Mon, 15 Apr 2019 21:00:14 +0200
Message-Id: <20190415183747.254194615@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9b0f430450cf230e736bc40f95bf34fbdb99cead.

This patch was not initially a fix and is dependent on other
changes which are not fixes eithers.

With this change, multiple Amlogic based boards fails to boot,
as reported by kernelci.

Cc: stable@vger.kernel.org # 5.0.7
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/meson/meson-aoclk.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/meson/meson-aoclk.c b/drivers/clk/meson/meson-aoclk.c
index 258c8d259ea1..f965845917e3 100644
--- a/drivers/clk/meson/meson-aoclk.c
+++ b/drivers/clk/meson/meson-aoclk.c
@@ -65,20 +65,15 @@ int meson_aoclkc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* Populate regmap */
-	for (clkid = 0; clkid < data->num_clks; clkid++)
+	/*
+	 * Populate regmap and register all clks
+	 */
+	for (clkid = 0; clkid < data->num_clks; clkid++) {
 		data->clks[clkid]->map = regmap;
 
-	/* Register all clks */
-	for (clkid = 0; clkid < data->hw_data->num; clkid++) {
-		if (!data->hw_data->hws[clkid])
-			continue;
-
 		ret = devm_clk_hw_register(dev, data->hw_data->hws[clkid]);
-		if (ret) {
-			dev_err(dev, "Clock registration failed\n");
+		if (ret)
 			return ret;
-		}
 	}
 
 	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
-- 
2.19.1



