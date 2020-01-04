Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650C1C00523
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301B522B48
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578097164;
	bh=MqqVqEIn41z92rrv1mY/TDM3b2e1uTCwKfL18Xyebts=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=uGFR2q6ZMrG4DnIS7WrEjIXOEPuP1/LR7A4+ujbh4UjG8OvoQW/N0JV7PmgRAMl6L
	 Ur1F3WDrw6+JldrJ3EepPnJEGLIWnvIzZTwtk35jGIabPMo2YMwCODK3sYM5txlcqE
	 P/o0D05bfHN2Fb+Umbksp8nnubNQkXJvpokhqcqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgADATX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 19:19:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:43842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbgADATW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 19:19:22 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9476321D7D;
        Sat,  4 Jan 2020 00:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578097161;
        bh=MqqVqEIn41z92rrv1mY/TDM3b2e1uTCwKfL18Xyebts=;
        h=From:To:Cc:Subject:Date:From;
        b=PUIAYGFXuHqL4mmr94yU/nMuQZvNIKlaZ5OFdQ8ENVc1c2tkxkT6MFobMqpnT8RNM
         SfnJh3AQFAoqiX1IYPCUiTlIXxBJNcFiodnEXj+cEh37bO8mVMkYLNmLWknVoj3Nzp
         HeZv+lqZ2L1n3hY7XfEzqtuM/tDyTBcGWAQBWMyY=
From:   Stephen Boyd <sboyd@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Yash Shah <yash.shah@sifive.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] macb: Don't unregister clks unconditionally
Date:   Fri,  3 Jan 2020 16:19:21 -0800
Message-Id: <20200104001921.225529-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only clk init function in this driver that register a clk is
fu540_c000_clk_init(), and thus we need to unregister the clk when this
driver is removed on that platform. Other init functions, for example
macb_clk_init(), don't register clks and therefore we shouldn't
unregister the clks when this driver is removed. Convert this
registration path to devm so it gets auto-unregistered when this driver
is removed and drop the clk_unregister() calls in driver remove (and
error paths) so that we don't erroneously remove a clk from the system
that isn't registered by this driver.

Otherwise we get strange crashes with a use-after-free when the
devm_clk_get() call in macb_clk_init() calls clk_put() on a clk pointer
that has become invalid because it is freed in clk_unregister().

Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Yash Shah <yash.shah@sifive.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: c218ad559020 ("macb: Add support for SiFive FU540-C000")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 9c767ee252ac..7dce403fd27c 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4069,7 +4069,7 @@ static int fu540_c000_clk_init(struct platform_device *pdev, struct clk **pclk,
 	mgmt->rate = 0;
 	mgmt->hw.init = &init;
 
-	*tx_clk = clk_register(NULL, &mgmt->hw);
+	*tx_clk = devm_clk_register(&pdev->dev, &mgmt->hw);
 	if (IS_ERR(*tx_clk))
 		return PTR_ERR(*tx_clk);
 
@@ -4397,7 +4397,6 @@ static int macb_probe(struct platform_device *pdev)
 
 err_disable_clocks:
 	clk_disable_unprepare(tx_clk);
-	clk_unregister(tx_clk);
 	clk_disable_unprepare(hclk);
 	clk_disable_unprepare(pclk);
 	clk_disable_unprepare(rx_clk);
@@ -4427,7 +4426,6 @@ static int macb_remove(struct platform_device *pdev)
 		pm_runtime_dont_use_autosuspend(&pdev->dev);
 		if (!pm_runtime_suspended(&pdev->dev)) {
 			clk_disable_unprepare(bp->tx_clk);
-			clk_unregister(bp->tx_clk);
 			clk_disable_unprepare(bp->hclk);
 			clk_disable_unprepare(bp->pclk);
 			clk_disable_unprepare(bp->rx_clk);
-- 
Sent by a computer, using git, on the internet

