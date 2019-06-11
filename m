Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6680AC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368482089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560248253;
	bh=uJeKLBS6fKTQ/nvA0FnBFJQrRlvrfsBQnK9IvrqNg7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uSvgaGyNt3m9/G1Ih7j6Jlu9/eQ+13+GRnD3XlTz+dEb87P4k8KiFNcoqzUd1tkYI
	 0Y8OUkrQKlrjTSPVqPLrwRvZHCrIDO3ilBm00jSdbyGDE+xphsYL22DcTYUd0QtjKr
	 f+SJIj2qjnvppHczsc5a9RTGqlxsBJRfS1KjDHNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405391AbfFKKRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:17:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405341AbfFKKR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:17:26 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86E18217F9;
        Tue, 11 Jun 2019 10:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560248245;
        bh=uJeKLBS6fKTQ/nvA0FnBFJQrRlvrfsBQnK9IvrqNg7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fDcdUdswDYDQDHG+d5ZJRayMDbmyQwGi8EoB+nzcxHcYGBmHEmpq1M8RGUb9s4asg
         bref+Y+yRyQy22Z9PJR1cm7+kbtvIhR/x4mlimha8jfcWZnkWd4XFgl6K4b7GieDP1
         kTBMx1puq7jN4tb3fWpOSVI7lAAxPnJ9ZtrRBB20=
Received: by wens.tw (Postfix, from userid 1000)
        id 811C960C4E; Tue, 11 Jun 2019 18:17:18 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v2 18/25] clk: sunxi-ng: sun8i-r: Use local parent references for CLK_FIXED_FACTOR
Date:   Tue, 11 Jun 2019 18:16:51 +0800
Message-Id: <20190611101658.23855-19-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611101658.23855-1-wens@kernel.org>
References: <20190611101658.23855-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

With the new clk parenting code and CLK_FIXED_FACTOR_{HW,FW_NAME}
macros, we can reference parents locally via pointers to struct clk_hw
or DT clock-names.

Convert existing CLK_FIXED_FACTOR definitions to either the _HW or
_FW_NAME variant based on whether the parent clock is internal or
external to the CCU.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r.c b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
index a43e8de873d7..4a111c28b8c3 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
@@ -57,7 +57,7 @@ static struct ccu_div ar100_clk = {
 	},
 };
 
-static CLK_FIXED_FACTOR(ahb0_clk, "ahb0", "ar100", 1, 1, 0);
+static CLK_FIXED_FACTOR_HW(ahb0_clk, "ahb0", &ar100_clk.common.hw, 1, 1, 0);
 
 static struct ccu_div apb0_clk = {
 	.div		= _SUNXI_CCU_DIV_FLAGS(0, 2, CLK_DIVIDER_POWER_OF_TWO),
-- 
2.20.1

