Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AABBC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F7C20825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfEGNva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 09:51:30 -0400
Received: from jax4mhob18.registeredsite.com ([64.69.218.106]:49486 "EHLO
        jax4mhob18.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726295AbfEGNva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 09:51:30 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.203])
        by jax4mhob18.registeredsite.com (8.14.4/8.14.4) with ESMTP id x47DpQp7050048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Tue, 7 May 2019 09:51:27 -0400
Received: (qmail 16166 invoked by uid 0); 7 May 2019 13:51:26 -0000
X-TCPREMOTEIP: 81.173.50.109
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO mikebuntu.TOPIC.LOCAL) (mike@milosoftware.com@81.173.50.109)
  by 0 with ESMTPA; 7 May 2019 13:51:26 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] clk: clk-si544: Implement small frequency change support
Date:   Tue,  7 May 2019 15:51:10 +0200
Message-Id: <20190507135110.27979-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Si544 supports changing frequencies "on the fly" when the change is
less than 950 ppm from the current center frequency. The driver now
uses the small adjustment routine for implementing this.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/clk/clk-si544.c | 102 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 92 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/clk-si544.c b/drivers/clk/clk-si544.c
index 64e607f3232a..d9ec9086184d 100644
--- a/drivers/clk/clk-si544.c
+++ b/drivers/clk/clk-si544.c
@@ -7,6 +7,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
@@ -50,6 +51,11 @@
 /* Lowest frequency synthesizeable using only the HS divider */
 #define MIN_HSDIV_FREQ	(FVCO_MIN / HS_DIV_MAX)
 
+/* Range and interpretation of the adjustment value */
+#define DELTA_M_MAX	8161512
+#define DELTA_M_FRAC_NUM	19
+#define DELTA_M_FRAC_DEN	20000
+
 enum si544_speed_grade {
 	si544a,
 	si544b,
@@ -71,12 +77,14 @@ struct clk_si544 {
  * @hs_div:		1st divider, 5..2046, must be even when >33
  * @ls_div_bits:	2nd divider, as 2^x, range 0..5
  *                      If ls_div_bits is non-zero, hs_div must be even
+ * @delta_m:		Frequency shift for small -950..+950 ppm changes, 24 bit
  */
 struct clk_si544_muldiv {
 	u32 fb_div_frac;
 	u16 fb_div_int;
 	u16 hs_div;
 	u8 ls_div_bits;
+	s32 delta_m;
 };
 
 /* Enables or disables the output driver */
@@ -134,9 +142,30 @@ static int si544_get_muldiv(struct clk_si544 *data,
 	settings->fb_div_int = reg[4] | (reg[5] & 0x07) << 8;
 	settings->fb_div_frac = reg[0] | reg[1] << 8 | reg[2] << 16 |
 				reg[3] << 24;
+
+	err = regmap_bulk_read(data->regmap, SI544_REG_ADPLL_DELTA_M0, reg, 3);
+	if (err)
+		return err;
+
+	/* Interpret as 24-bit signed number */
+	settings->delta_m = reg[0] << 8 | reg[1] << 16 | reg[2] << 24;
+	settings->delta_m >>= 8;
+
 	return 0;
 }
 
+static int si544_set_delta_m(struct clk_si544 *data, s32 delta_m)
+{
+	u8 reg[3];
+
+	reg[0] = delta_m;
+	reg[1] = delta_m >> 8;
+	reg[2] = delta_m >> 16;
+
+	return regmap_bulk_write(data->regmap, SI544_REG_ADPLL_DELTA_M0,
+				 reg, 3);
+}
+
 static int si544_set_muldiv(struct clk_si544 *data,
 	struct clk_si544_muldiv *settings)
 {
@@ -238,11 +267,15 @@ static int si544_calc_muldiv(struct clk_si544_muldiv *settings,
 	do_div(vco, FXO);
 	settings->fb_div_frac = vco;
 
+	/* Reset the frequency adjustment */
+	settings->delta_m = 0;
+
 	return 0;
 }
 
 /* Calculate resulting frequency given the register settings */
-static unsigned long si544_calc_rate(struct clk_si544_muldiv *settings)
+static unsigned long si544_calc_center_rate(
+		const struct clk_si544_muldiv *settings)
 {
 	u32 d = settings->hs_div * BIT(settings->ls_div_bits);
 	u64 vco;
@@ -261,6 +294,25 @@ static unsigned long si544_calc_rate(struct clk_si544_muldiv *settings)
 	return vco;
 }
 
+static unsigned long si544_calc_rate(const struct clk_si544_muldiv *settings)
+{
+	unsigned long rate = si544_calc_center_rate(settings);
+	s64 delta = (s64)rate * (DELTA_M_FRAC_NUM * settings->delta_m);
+
+	/*
+	 * The clock adjustment is much smaller than 1 Hz, round to the
+	 * nearest multiple. Apparently div64_s64 rounds towards zero, hence
+	 * check the sign and adjust into the proper direction.
+	 */
+	if (settings->delta_m < 0)
+		delta -= ((s64)DELTA_M_MAX * DELTA_M_FRAC_DEN) / 2;
+	else
+		delta += ((s64)DELTA_M_MAX * DELTA_M_FRAC_DEN) / 2;
+	delta = div64_s64(delta, ((s64)DELTA_M_MAX * DELTA_M_FRAC_DEN));
+
+	return rate + delta;
+}
+
 static unsigned long si544_recalc_rate(struct clk_hw *hw,
 		unsigned long parent_rate)
 {
@@ -279,33 +331,60 @@ static long si544_round_rate(struct clk_hw *hw, unsigned long rate,
 		unsigned long *parent_rate)
 {
 	struct clk_si544 *data = to_clk_si544(hw);
-	struct clk_si544_muldiv settings;
-	int err;
 
 	if (!is_valid_frequency(data, rate))
 		return -EINVAL;
 
-	err = si544_calc_muldiv(&settings, rate);
-	if (err)
-		return err;
+	/* The accuracy is less than 1 Hz, so any rate is possible */
+	return rate;
+}
 
-	return si544_calc_rate(&settings);
+/* Calculates the maximum "small" change, 950 * rate / 1000000 */
+static unsigned long si544_max_delta(unsigned long rate)
+{
+	u64 num = rate;
+
+	num *= DELTA_M_FRAC_NUM;
+	do_div(num, DELTA_M_FRAC_DEN);
+
+	return num;
+}
+
+static s32 si544_calc_delta(s32 delta, s32 max_delta)
+{
+	s64 n = (s64)delta * DELTA_M_MAX;
+
+	return div_s64(n, max_delta);
 }
 
-/*
- * Update output frequency for "big" frequency changes
- */
 static int si544_set_rate(struct clk_hw *hw, unsigned long rate,
 		unsigned long parent_rate)
 {
 	struct clk_si544 *data = to_clk_si544(hw);
 	struct clk_si544_muldiv settings;
+	unsigned long center;
+	long max_delta;
+	long delta;
 	unsigned int old_oe_state;
 	int err;
 
 	if (!is_valid_frequency(data, rate))
 		return -EINVAL;
 
+	/* Try using the frequency adjustment feature for a <= 950ppm change */
+	err = si544_get_muldiv(data, &settings);
+	if (err)
+		return err;
+
+	center = si544_calc_center_rate(&settings);
+	max_delta = si544_max_delta(center);
+	delta = rate - center;
+
+	if (abs(delta) <= max_delta)
+		return si544_set_delta_m(data,
+					 si544_calc_delta(delta, max_delta));
+
+	/* Too big for the delta adjustment, need to reprogram */
 	err = si544_calc_muldiv(&settings, rate);
 	if (err)
 		return err;
@@ -321,6 +400,9 @@ static int si544_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (err < 0)
 		return err;
 
+	err = si544_set_delta_m(data, settings.delta_m);
+	if (err < 0)
+		return err;
 
 	err = si544_set_muldiv(data, &settings);
 	if (err < 0)
-- 
2.17.1

