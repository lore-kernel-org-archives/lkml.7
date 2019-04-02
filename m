Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3A1C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51D32084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554246093;
	bh=dzd7PCwRRfPfuAc/7nvl9MamfV8T+7jn8AD1EHfUI04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UvbMpaqsz41gUW+HqOqBMD45Ez2ISTwdeDJYAQKZh2EaWcryfJlO1ibbs8wLxA9l1
	 W5znMC1CaPiP0BvAiNNOeQFnp7ZdQBaCqw8Y3Y6QT4uzWqMfSk0zNbSUg96eRqRd8n
	 Go8TIl+yBw69Zpzt08iciW5h0hgbIigeRJ/Yi4NQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfDBXBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:01:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbfDBXBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:01:07 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE16520882;
        Tue,  2 Apr 2019 23:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554246066;
        bh=dzd7PCwRRfPfuAc/7nvl9MamfV8T+7jn8AD1EHfUI04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1l7rqJhaxVp3TDDQ9XgOLXoz7K6Vif2Z31tuFnPRWusg7++JThajA3NcbTy00Y5yK
         FnnOrzsKmC92RxQkcbXDRTLqicP6D0hCVtsZUI1n7iXQ5FwmToNRdKSHHDEMkf5xjx
         5lShOWBPUOLzNEkaP5hp3T6arNLojkz04aR8Vwew=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 5/8] clk: nxp: Drop 'flags' on fixed_rate clk macro
Date:   Tue,  2 Apr 2019 16:01:01 -0700
Message-Id: <20190402230104.105845-6-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190402230104.105845-1-sboyd@kernel.org>
References: <20190402230104.105845-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flags argument here is always 0, and we want to get rid of the flags
member of the clk_fixed_rate struct. So remove this here and just pass 0
when it's used.

Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/nxp/clk-lpc32xx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/nxp/clk-lpc32xx.c b/drivers/clk/nxp/clk-lpc32xx.c
index 5eeecee17b69..7524d19fe60b 100644
--- a/drivers/clk/nxp/clk-lpc32xx.c
+++ b/drivers/clk/nxp/clk-lpc32xx.c
@@ -1085,13 +1085,12 @@ struct clk_hw_proto {
 	};
 };
 
-#define LPC32XX_DEFINE_FIXED(_idx, _rate, _flags)			\
+#define LPC32XX_DEFINE_FIXED(_idx, _rate)			\
 [CLK_PREFIX(_idx)] = {							\
 	.type = CLK_FIXED,						\
 	{								\
 		.f = {							\
 			.fixed_rate = (_rate),				\
-			.flags = (_flags),				\
 		},							\
 	},								\
 }
@@ -1225,7 +1224,7 @@ struct clk_hw_proto {
 }
 
 static struct clk_hw_proto clk_hw_proto[LPC32XX_CLK_HW_MAX] = {
-	LPC32XX_DEFINE_FIXED(RTC, 32768, 0),
+	LPC32XX_DEFINE_FIXED(RTC, 32768),
 	LPC32XX_DEFINE_PLL(PLL397X, pll_397x, HCLKPLL_CTRL, BIT(1)),
 	LPC32XX_DEFINE_PLL(HCLK_PLL, hclk_pll, HCLKPLL_CTRL, PLL_CTRL_ENABLE),
 	LPC32XX_DEFINE_PLL(USB_PLL, usb_pll, USB_CTRL, PLL_CTRL_ENABLE),
@@ -1468,7 +1467,7 @@ static struct clk * __init lpc32xx_clk_register(u32 id)
 		struct clk_fixed_rate *fixed = &clk_hw->f;
 
 		clk = clk_register_fixed_rate(NULL, lpc32xx_clk->name,
-			parents[0], fixed->flags, fixed->fixed_rate);
+			parents[0], 0, fixed->fixed_rate);
 		break;
 	}
 	default:
-- 
Sent by a computer through tubes

