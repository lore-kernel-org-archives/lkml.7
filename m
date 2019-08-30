Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24963C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E055423407
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567177771;
	bh=VpzzJ2ZRApF5XJP92g0pEAE+DutW36XP7+YugwXF208=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AcAQtsbBx0Ag83GxvGzFCQryNSe+OYGsSjzrvxVt+jrxRpd5Q57RiXQCEAVs7SepM
	 bMMLfuVWe92maMFCld2nt7gGG9Kik0PEQQu0pGMoQKppaEEFAPaw/Bn8DLPSz6483u
	 49xFw1c1MhyYz+ULR5Pc2S+mNSIl7xXzAOHsL6hU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfH3PJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:09:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbfH3PJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:09:28 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B2FF2342B;
        Fri, 30 Aug 2019 15:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567177767;
        bh=VpzzJ2ZRApF5XJP92g0pEAE+DutW36XP7+YugwXF208=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Br6Mk2vqLJTALACyh7UHMrBYOwKmD/2KqK3SvebXhPgrXoDDHyJi2iiV+4LXQEqCN
         NW27VV7spvKkw64vP2q4pprk4Mu6GH+RPl4MIhGx7h+L4I2MtrbOWtIQ0vHwNlcO2v
         IvWoKmsq6TEoO3H7NXOlr5vcoZlM5Qq4wh4+s9xE=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 09/12] clk: asm9260: Use parent accuracy in fixed rate clk
Date:   Fri, 30 Aug 2019 08:09:20 -0700
Message-Id: <20190830150923.259497-10-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190830150923.259497-1-sboyd@kernel.org>
References: <20190830150923.259497-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixed rate clk is registered with the accuracy of the parent. Use
CLK_FIXED_RATE_PARENT_ACCURACY for that instead of getting the parent
clk and finding out the accuracy that way.

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-asm9260.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-asm9260.c b/drivers/clk/clk-asm9260.c
index dd0f90c9dd0e..536b59aabd2c 100644
--- a/drivers/clk/clk-asm9260.c
+++ b/drivers/clk/clk-asm9260.c
@@ -260,7 +260,6 @@ static void __init asm9260_acc_init(struct device_node *np)
 	const char *ref_clk, *pll_clk = "pll";
 	u32 rate;
 	int n;
-	u32 accuracy = 0;
 
 	clk_data = kzalloc(struct_size(clk_data, hws, MAX_CLKS), GFP_KERNEL);
 	if (!clk_data)
@@ -275,10 +274,11 @@ static void __init asm9260_acc_init(struct device_node *np)
 	/* register pll */
 	rate = (ioread32(base + HW_SYSPLLCTRL) & 0xffff) * 1000000;
 
+	/* TODO: Convert to DT parent scheme */
 	ref_clk = of_clk_get_parent_name(np, 0);
-	accuracy = clk_get_accuracy(__clk_lookup(ref_clk));
-	hw = clk_hw_register_fixed_rate_with_accuracy(NULL, pll_clk,
-			ref_clk, 0, rate, accuracy);
+	hw = __clk_hw_register_fixed_rate_with_accuracy(NULL, NULL, pll_clk,
+			ref_clk, NULL, NULL, 0, rate, 0,
+			CLK_FIXED_RATE_PARENT_ACCURACY);
 
 	if (IS_ERR(hw))
 		panic("%pOFn: can't register REFCLK. Check DT!", np);
-- 
Sent by a computer through tubes

