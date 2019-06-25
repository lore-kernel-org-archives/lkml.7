Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BAEC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0867B20644
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561470950;
	bh=PC7gSfqUEtkeTD3iRdN69HyrVN7sD1+21zTnnFyaSG4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=CiuTV3FjQ7u4cOMw0nH8s+E+djKVuDanxPedaHL4ftV6nh1uNNdKbhUoGCztMFEtV
	 dR0MyulbQfPOnK5V2L2HrMshTtN2dU1ecSu6PvJhAoXaEbALE/FABm+rYUC2qXXZ4H
	 DbEf3DQV2pf/DjLV5WgTEQbVcc7MBdZidMYU0lYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbfFYNzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:55:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbfFYNzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:55:48 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7670920644;
        Tue, 25 Jun 2019 13:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561470948;
        bh=PC7gSfqUEtkeTD3iRdN69HyrVN7sD1+21zTnnFyaSG4=;
        h=From:To:Cc:Subject:Date:From;
        b=D9UQYmGO3fHeSGPf9KHZ1bwYIpoHKFvWXJJN7KFb/VOtyGE9bmgHRw7sLKsaYkIoR
         pfxcAX8pIdR6v3xqjU1rBw0oxlMSUnjGxGHU/YLgsdHrFLA2w582VV9eP5h3fA8vpo
         hrJceze069zpi1ydHXofQNje1GQTl/6+7RV2/4yM=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     sboyd@kernel.org
Cc:     dinguyen@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] clk: socfpga: stratix10: fix divider entry for the emac clocks
Date:   Tue, 25 Jun 2019 08:55:35 -0500
Message-Id: <20190625135535.14179-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fixed dividers for the emac clocks should be 2 not 4.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/clk/socfpga/clk-s10.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/socfpga/clk-s10.c b/drivers/clk/socfpga/clk-s10.c
index 8281dfbf38c2..5bed36e12951 100644
--- a/drivers/clk/socfpga/clk-s10.c
+++ b/drivers/clk/socfpga/clk-s10.c
@@ -103,9 +103,9 @@ static const struct stratix10_perip_cnt_clock s10_main_perip_cnt_clks[] = {
 	{ STRATIX10_NOC_CLK, "noc_clk", NULL, noc_mux, ARRAY_SIZE(noc_mux),
 	  0, 0, 0, 0x3C, 1},
 	{ STRATIX10_EMAC_A_FREE_CLK, "emaca_free_clk", NULL, emaca_free_mux, ARRAY_SIZE(emaca_free_mux),
-	  0, 0, 4, 0xB0, 0},
+	  0, 0, 2, 0xB0, 0},
 	{ STRATIX10_EMAC_B_FREE_CLK, "emacb_free_clk", NULL, emacb_free_mux, ARRAY_SIZE(emacb_free_mux),
-	  0, 0, 4, 0xB0, 1},
+	  0, 0, 2, 0xB0, 1},
 	{ STRATIX10_EMAC_PTP_FREE_CLK, "emac_ptp_free_clk", NULL, emac_ptp_free_mux,
 	  ARRAY_SIZE(emac_ptp_free_mux), 0, 0, 4, 0xB0, 2},
 	{ STRATIX10_GPIO_DB_FREE_CLK, "gpio_db_free_clk", NULL, gpio_db_free_mux,
-- 
2.20.0

