Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95CDC04AAA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757922081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="FZ06Vi01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfEBVZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 17:25:20 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:52898 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBVZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 17:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1556832314; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=wplknZmLov6wC+mWLkV3AuUEvMpefSHU8GtOCBjTcIg=;
        b=FZ06Vi01hFrMcldZW3/z1kxvQabQuBdwEOPBVEdXAgy608nqxUqRLdu5BpRtewYJYdj+2T
        dnBdaDMP8C44qAhVGtfGuzEdu2nP3ZAaRgPWlkVKTR3Y/0ZMlflWFePT/SnzVngb01ivMi
        W/HmvXMpCCFEmca5P3fEOpRK5ZuWgSY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/5] clk: ingenic: Add support for divider tables
Date:   Thu,  2 May 2019 23:24:58 +0200
Message-Id: <20190502212502.24330-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some clocks provided on Ingenic SoCs have dividers, whose hardware value
as written in the register cannot be expressed as an affine function
to the actual divider value.

For instance, for the CPU clock on the JZ4770, the dividers are coded as
follows:

    ------------------
    | Bits     | Div |
    ------------------
    | 0  0  0  |  1  |
    | 0  0  1  |  2  |
    | 0  1  0  |  3  |
    | 0  1  1  |  4  |
    | 1  0  0  |  6  |
    | 1  0  1  |  8  |
    | 1  1  0  | 12  |
    ------------------

To support this setup, we introduce a new field in the
ingenic_cgu_div_info structure that allows to specify the divider table.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/cgu.c | 41 +++++++++++++++++++++++++++++++++------
 drivers/clk/ingenic/cgu.h |  3 +++
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index 510b685212d3..6a8c4fb0f6d5 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -383,8 +383,11 @@ ingenic_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 		div_reg = readl(cgu->base + clk_info->div.reg);
 		div = (div_reg >> clk_info->div.shift) &
 		      GENMASK(clk_info->div.bits - 1, 0);
-		div += 1;
-		div *= clk_info->div.div;
+
+		if (clk_info->div.div_table)
+			div = clk_info->div.div_table[div];
+		else
+			div = (div + 1) * clk_info->div.div;
 
 		rate /= div;
 	} else if (clk_info->type & CGU_CLK_FIXDIV) {
@@ -394,16 +397,37 @@ ingenic_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	return rate;
 }
 
+static unsigned int
+ingenic_clk_calc_hw_div(const struct ingenic_cgu_clk_info *clk_info,
+			unsigned int div)
+{
+	unsigned int i;
+
+	for (i = 0; i < (1 << clk_info->div.bits)
+				&& clk_info->div.div_table[i]; i++) {
+		if (clk_info->div.div_table[i] >= div)
+			return i;
+	}
+
+	return i - 1;
+}
+
 static unsigned
 ingenic_clk_calc_div(const struct ingenic_cgu_clk_info *clk_info,
 		     unsigned long parent_rate, unsigned long req_rate)
 {
-	unsigned div;
+	unsigned int div, hw_div;
 
 	/* calculate the divide */
 	div = DIV_ROUND_UP(parent_rate, req_rate);
 
-	/* and impose hardware constraints */
+	if (clk_info->div.div_table) {
+		hw_div = ingenic_clk_calc_hw_div(clk_info, div);
+
+		return clk_info->div.div_table[hw_div];
+	}
+
+	/* Impose hardware constraints */
 	div = min_t(unsigned, div, 1 << clk_info->div.bits);
 	div = max_t(unsigned, div, 1);
 
@@ -446,7 +470,7 @@ ingenic_clk_set_rate(struct clk_hw *hw, unsigned long req_rate,
 	const struct ingenic_cgu_clk_info *clk_info;
 	const unsigned timeout = 100;
 	unsigned long rate, flags;
-	unsigned div, i;
+	unsigned int hw_div, div, i;
 	u32 reg, mask;
 	int ret = 0;
 
@@ -459,13 +483,18 @@ ingenic_clk_set_rate(struct clk_hw *hw, unsigned long req_rate,
 		if (rate != req_rate)
 			return -EINVAL;
 
+		if (clk_info->div.div_table)
+			hw_div = ingenic_clk_calc_hw_div(clk_info, div);
+		else
+			hw_div = ((div / clk_info->div.div) - 1);
+
 		spin_lock_irqsave(&cgu->lock, flags);
 		reg = readl(cgu->base + clk_info->div.reg);
 
 		/* update the divide */
 		mask = GENMASK(clk_info->div.bits - 1, 0);
 		reg &= ~(mask << clk_info->div.shift);
-		reg |= ((div / clk_info->div.div) - 1) << clk_info->div.shift;
+		reg |= hw_div << clk_info->div.shift;
 
 		/* clear the stop bit */
 		if (clk_info->div.stop_bit != -1)
diff --git a/drivers/clk/ingenic/cgu.h b/drivers/clk/ingenic/cgu.h
index e12716d8ce3c..8dcd83aeab84 100644
--- a/drivers/clk/ingenic/cgu.h
+++ b/drivers/clk/ingenic/cgu.h
@@ -88,6 +88,8 @@ struct ingenic_cgu_mux_info {
  *          isn't one
  * @busy_bit: the index of the busy bit within reg, or -1 if there isn't one
  * @stop_bit: the index of the stop bit within reg, or -1 if there isn't one
+ * @div_table: optional table to map the value read from the register to the
+ *             actual divider value
  */
 struct ingenic_cgu_div_info {
 	unsigned reg;
@@ -97,6 +99,7 @@ struct ingenic_cgu_div_info {
 	s8 ce_bit;
 	s8 busy_bit;
 	s8 stop_bit;
+	const u8 *div_table;
 };
 
 /**
-- 
2.21.0.593.g511ec345e18

