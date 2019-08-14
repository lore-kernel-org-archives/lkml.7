Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E36FC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 15:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35372208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 15:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565796627;
	bh=CX48mP1/qs/V0WIfEuGbZqpNO4Jo433GaILdRZ/JeEM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Qz1o8t5p5cv96LpuPV1IETg1tbkwB7QaPCa1c18lW5KvpgrybpsarMMtPPlPKTd/I
	 ln6KMm9n471ni1Bz3lk+pZ6rBE1qqRnx7rIETyhdeFNMa3aI7DbL+t+OZ2BgingWb0
	 26E62rNA8H+ZGEB68o1o1jj+QSX+d/U9CuvO22Vo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfHNPa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 11:30:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:50204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfHNPaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 11:30:25 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01F702084F;
        Wed, 14 Aug 2019 15:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565796624;
        bh=CX48mP1/qs/V0WIfEuGbZqpNO4Jo433GaILdRZ/JeEM=;
        h=From:To:Cc:Subject:Date:From;
        b=PGQUpwQFn9e0omqFaTUYm7VbpW+lXW0bU9M+B2FR7aU67oDqxmiEmiBjnW9MulJx/
         T/qx3MWZHfn9hU+trpxwu/BTwz32PdAXz9bgi9ZQTHzoU/zlJ6Sohx0ZZfOhnK/Leq
         wdI/Ln1KlneQc+SVrWr0dvUwdu0+FV6Oi5R8bxfA=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-clk@vger.kernel.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, stable@vger.kernel.org
Subject: [PATCH] clk: socfpga: stratix10: fix rate caclulationg for cnt_clks
Date:   Wed, 14 Aug 2019 10:30:14 -0500
Message-Id: <20190814153014.12962-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking bypass_reg is incorrect for calculating the cnt_clk rates.
Instead we should be checking that there is a proper hardware register
that holds the clock divider.

Cc: stable@vger.kernel.org
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/clk/socfpga/clk-periph-s10.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/socfpga/clk-periph-s10.c b/drivers/clk/socfpga/clk-periph-s10.c
index 5c50e723ecae..1a191eeeebba 100644
--- a/drivers/clk/socfpga/clk-periph-s10.c
+++ b/drivers/clk/socfpga/clk-periph-s10.c
@@ -38,7 +38,7 @@ static unsigned long clk_peri_cnt_clk_recalc_rate(struct clk_hw *hwclk,
 	if (socfpgaclk->fixed_div) {
 		div = socfpgaclk->fixed_div;
 	} else {
-		if (!socfpgaclk->bypass_reg)
+		if (socfpgaclk->hw.reg)
 			div = ((readl(socfpgaclk->hw.reg) & 0x7ff) + 1);
 	}
 
-- 
2.20.0

