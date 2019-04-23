Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74778C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C7720674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1Hot/GKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfDWJC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:02:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42016 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfDWJC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:02:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so19134502wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 02:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gQX+K9p9SQAOy7UwhmluaKADnDQs943ULXYGiNIkGa4=;
        b=1Hot/GKKAF181enkj5J517RScAaqI3GuFMOfFMA3hgp6FLJe97zWqYT9GJYhBD1Cyt
         WFagKCP3BrH6knGrHYsDoDtJl9vVOn0meKChi8ut6kfzVqe4rRXzJJvtqgnmAzv1gvBH
         Vy2Z+pshyeyz42eHzLBsiXFYwxuXHhhzRwZu+dyKMX7tk9ACbnwnXtcJqTkwMIElBjKM
         Iq07EQUE1+YmR4bfhcU7ulDso/Cs3iy8iMXhc5mXMTT+Wr1NJulXuej0LnEXT2ziI3yw
         nx7RwRDqd61xhPJQdtx+nimnScisczCeaVJR5mtoWNtb7SPmNG3wK4tLIR3i6+XPzuY3
         hHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gQX+K9p9SQAOy7UwhmluaKADnDQs943ULXYGiNIkGa4=;
        b=SFASn4+Ka31APBnCA7/Qm6nTYtzQ5mgt+xkK9wOAUM+sCbUeWlqzz4oUiJDYrqXWfx
         DKxCx6qDYKOIYZflYLqde0iR87HVtmrG4Lcw6lwDiqIPFmWuAsqDajUtqeXG8jsnzN5S
         GXDbBqbVABTORJ8d+MQJpuMjBkoSEhiq1tIcfjvqT6fGN2cWzO1w34Xyj/sfcqGKrQ17
         JG12HSlfXYAG/mZyZA/c5DDDl+YirdLBaHoUQqS88fZNa4qtHGss6nmo9C/GDcvKgP3Z
         aMf6o8A8n6jHGCwyECTQr0a8YUxv8txaJQWpnSaUdM1D/snzW+D9rQXQOBb4HbT4gh30
         8VAA==
X-Gm-Message-State: APjAAAUbbA/z5s/Pxouj86FsI71MCOXFXsUIkTSFBOauqo+GhnDEj6+K
        KC8WyoZOygCf1Dif/I5VzTWpOA==
X-Google-Smtp-Source: APXvYqzWM2t2wRdlMkv4lrtj91eiEt5j640qrtv5CdyZYi0L6WHMERa+NZNbVK1CL7dA3Y9Lu7fPQw==
X-Received: by 2002:a5d:4d49:: with SMTP id a9mr17804701wru.227.1556010173339;
        Tue, 23 Apr 2019 02:02:53 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z23sm12361894wma.0.2019.04.23.02.02.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 02:02:52 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] mmc: meson-gx: remove Rx phase tuning
Date:   Tue, 23 Apr 2019 11:02:34 +0200
Message-Id: <20190423090235.17244-7-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423090235.17244-1-jbrunet@baylibre.com>
References: <20190423090235.17244-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This remove all the code related to phase settings. Using the Rx phase
for tuning has not been reliable. We had several issues over the past
months, on both v2 and v3 mmc chips After discussing the issue matter
with Amlogic, They suggested to set a phase shift of 180 between Core and
Tx and use signal resampling for the tuning.

Since we won't be playing with the phase anymore, let's remove all the
clock code related to it and set the appropriate value on init.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 290 ++------------------------------
 1 file changed, 13 insertions(+), 277 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 0454021c9ff5..acdc5520d02c 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -49,6 +49,8 @@
 #define   CLK_CORE_PHASE_MASK GENMASK(9, 8)
 #define   CLK_TX_PHASE_MASK GENMASK(11, 10)
 #define   CLK_RX_PHASE_MASK GENMASK(13, 12)
+#define   CLK_PHASE_0 0
+#define   CLK_PHASE_180 2
 #define   CLK_V2_TX_DELAY_MASK GENMASK(19, 16)
 #define   CLK_V2_RX_DELAY_MASK GENMASK(23, 20)
 #define   CLK_V2_ALWAYS_ON BIT(24)
@@ -57,10 +59,6 @@
 #define   CLK_V3_RX_DELAY_MASK GENMASK(27, 22)
 #define   CLK_V3_ALWAYS_ON BIT(28)
 
-#define   CLK_DELAY_STEP_PS 200
-#define   CLK_PHASE_STEP 30
-#define   CLK_PHASE_POINT_NUM (360 / CLK_PHASE_STEP)
-
 #define   CLK_TX_DELAY_MASK(h)		(h->data->tx_delay_mask)
 #define   CLK_RX_DELAY_MASK(h)		(h->data->rx_delay_mask)
 #define   CLK_ALWAYS_ON(h)		(h->data->always_on)
@@ -165,9 +163,8 @@ struct meson_host {
 
 	void __iomem *regs;
 	struct clk *core_clk;
+	struct clk *mux_clk;
 	struct clk *mmc_clk;
-	struct clk *rx_clk;
-	struct clk *tx_clk;
 	unsigned long req_rate;
 	bool ddr;
 
@@ -209,90 +206,6 @@ struct meson_host {
 #define CMD_RESP_MASK GENMASK(31, 1)
 #define CMD_RESP_SRAM BIT(0)
 
-struct meson_mmc_phase {
-	struct clk_hw hw;
-	void __iomem *reg;
-	unsigned long phase_mask;
-	unsigned long delay_mask;
-	unsigned int delay_step_ps;
-};
-
-#define to_meson_mmc_phase(_hw) container_of(_hw, struct meson_mmc_phase, hw)
-
-static int meson_mmc_clk_get_phase(struct clk_hw *hw)
-{
-	struct meson_mmc_phase *mmc = to_meson_mmc_phase(hw);
-	unsigned int phase_num = 1 <<  hweight_long(mmc->phase_mask);
-	unsigned long period_ps, p, d;
-		int degrees;
-	u32 val;
-
-	val = readl(mmc->reg);
-	p = (val & mmc->phase_mask) >> __ffs(mmc->phase_mask);
-	degrees = p * 360 / phase_num;
-
-	if (mmc->delay_mask) {
-		period_ps = DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,
-					 clk_get_rate(hw->clk));
-		d = (val & mmc->delay_mask) >> __ffs(mmc->delay_mask);
-		degrees += d * mmc->delay_step_ps * 360 / period_ps;
-		degrees %= 360;
-	}
-
-	return degrees;
-}
-
-static void meson_mmc_apply_phase_delay(struct meson_mmc_phase *mmc,
-					unsigned int phase,
-					unsigned int delay)
-{
-	u32 val;
-
-	val = readl(mmc->reg);
-	val &= ~mmc->phase_mask;
-	val |= phase << __ffs(mmc->phase_mask);
-
-	if (mmc->delay_mask) {
-		val &= ~mmc->delay_mask;
-		val |= delay << __ffs(mmc->delay_mask);
-	}
-
-	writel(val, mmc->reg);
-}
-
-static int meson_mmc_clk_set_phase(struct clk_hw *hw, int degrees)
-{
-	struct meson_mmc_phase *mmc = to_meson_mmc_phase(hw);
-	unsigned int phase_num = 1 <<  hweight_long(mmc->phase_mask);
-	unsigned long period_ps, d = 0, r;
-	uint64_t p;
-
-	p = degrees % 360;
-
-	if (!mmc->delay_mask) {
-		p = DIV_ROUND_CLOSEST_ULL(p, 360 / phase_num);
-	} else {
-		period_ps = DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,
-					 clk_get_rate(hw->clk));
-
-		/* First compute the phase index (p), the remainder (r) is the
-		 * part we'll try to acheive using the delays (d).
-		 */
-		r = do_div(p, 360 / phase_num);
-		d = DIV_ROUND_CLOSEST(r * period_ps,
-				      360 * mmc->delay_step_ps);
-		d = min(d, mmc->delay_mask >> __ffs(mmc->delay_mask));
-	}
-
-	meson_mmc_apply_phase_delay(mmc, p, d);
-	return 0;
-}
-
-static const struct clk_ops meson_mmc_clk_phase_ops = {
-	.get_phase = meson_mmc_clk_get_phase,
-	.set_phase = meson_mmc_clk_set_phase,
-};
-
 static unsigned int meson_mmc_get_timeout_msecs(struct mmc_data *data)
 {
 	unsigned int timeout = data->timeout_ns / NSEC_PER_MSEC;
@@ -492,8 +405,6 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	struct clk_init_data init;
 	struct clk_mux *mux;
 	struct clk_divider *div;
-	struct meson_mmc_phase *core, *tx, *rx;
-	struct clk *clk;
 	char clk_name[32];
 	int i, ret = 0;
 	const char *mux_parent_names[MUX_CLK_NUM_PARENTS];
@@ -501,9 +412,11 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	u32 clk_reg;
 
 	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
-	clk_reg = 0;
-	clk_reg |= CLK_ALWAYS_ON(host);
+	clk_reg = CLK_ALWAYS_ON(host);
 	clk_reg |= CLK_DIV_MASK;
+	clk_reg |= FIELD_PREP(CLK_CORE_PHASE_MASK, CLK_PHASE_180);
+	clk_reg |= FIELD_PREP(CLK_TX_PHASE_MASK, CLK_PHASE_0);
+	clk_reg |= FIELD_PREP(CLK_RX_PHASE_MASK, CLK_PHASE_0);
 	writel(clk_reg, host->regs + SD_EMMC_CLOCK);
 
 	/* get the mux parents */
@@ -539,9 +452,9 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	mux->mask = CLK_SRC_MASK >> mux->shift;
 	mux->hw.init = &init;
 
-	clk = devm_clk_register(host->dev, &mux->hw);
-	if (WARN_ON(IS_ERR(clk)))
-		return PTR_ERR(clk);
+	host->mux_clk = devm_clk_register(host->dev, &mux->hw);
+	if (WARN_ON(IS_ERR(host->mux_clk)))
+		return PTR_ERR(host->mux_clk);
 
 	/* create the divider */
 	div = devm_kzalloc(host->dev, sizeof(*div), GFP_KERNEL);
@@ -552,7 +465,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	init.name = clk_name;
 	init.ops = &clk_divider_ops;
 	init.flags = CLK_SET_RATE_PARENT;
-	clk_parent[0] = __clk_get_name(clk);
+	clk_parent[0] = __clk_get_name(host->mux_clk);
 	init.parent_names = clk_parent;
 	init.num_parents = 1;
 
@@ -562,192 +475,19 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	div->hw.init = &init;
 	div->flags = CLK_DIVIDER_ONE_BASED;
 
-	clk = devm_clk_register(host->dev, &div->hw);
-	if (WARN_ON(IS_ERR(clk)))
-		return PTR_ERR(clk);
-
-	/* create the mmc core clock */
-	core = devm_kzalloc(host->dev, sizeof(*core), GFP_KERNEL);
-	if (!core)
-		return -ENOMEM;
-
-	snprintf(clk_name, sizeof(clk_name), "%s#core", dev_name(host->dev));
-	init.name = clk_name;
-	init.ops = &meson_mmc_clk_phase_ops;
-	init.flags = CLK_SET_RATE_PARENT;
-	clk_parent[0] = __clk_get_name(clk);
-	init.parent_names = clk_parent;
-	init.num_parents = 1;
-
-	core->reg = host->regs + SD_EMMC_CLOCK;
-	core->phase_mask = CLK_CORE_PHASE_MASK;
-	core->hw.init = &init;
-
-	host->mmc_clk = devm_clk_register(host->dev, &core->hw);
-	if (WARN_ON(PTR_ERR_OR_ZERO(host->mmc_clk)))
+	host->mmc_clk = devm_clk_register(host->dev, &div->hw);
+	if (WARN_ON(IS_ERR(host->mmc_clk)))
 		return PTR_ERR(host->mmc_clk);
 
-	/* create the mmc tx clock */
-	tx = devm_kzalloc(host->dev, sizeof(*tx), GFP_KERNEL);
-	if (!tx)
-		return -ENOMEM;
-
-	snprintf(clk_name, sizeof(clk_name), "%s#tx", dev_name(host->dev));
-	init.name = clk_name;
-	init.ops = &meson_mmc_clk_phase_ops;
-	init.flags = 0;
-	clk_parent[0] = __clk_get_name(host->mmc_clk);
-	init.parent_names = clk_parent;
-	init.num_parents = 1;
-
-	tx->reg = host->regs + SD_EMMC_CLOCK;
-	tx->phase_mask = CLK_TX_PHASE_MASK;
-	tx->delay_mask = CLK_TX_DELAY_MASK(host);
-	tx->delay_step_ps = CLK_DELAY_STEP_PS;
-	tx->hw.init = &init;
-
-	host->tx_clk = devm_clk_register(host->dev, &tx->hw);
-	if (WARN_ON(PTR_ERR_OR_ZERO(host->tx_clk)))
-		return PTR_ERR(host->tx_clk);
-
-	/* create the mmc rx clock */
-	rx = devm_kzalloc(host->dev, sizeof(*rx), GFP_KERNEL);
-	if (!rx)
-		return -ENOMEM;
-
-	snprintf(clk_name, sizeof(clk_name), "%s#rx", dev_name(host->dev));
-	init.name = clk_name;
-	init.ops = &meson_mmc_clk_phase_ops;
-	init.flags = 0;
-	clk_parent[0] = __clk_get_name(host->mmc_clk);
-	init.parent_names = clk_parent;
-	init.num_parents = 1;
-
-	rx->reg = host->regs + SD_EMMC_CLOCK;
-	rx->phase_mask = CLK_RX_PHASE_MASK;
-	rx->delay_mask = CLK_RX_DELAY_MASK(host);
-	rx->delay_step_ps = CLK_DELAY_STEP_PS;
-	rx->hw.init = &init;
-
-	host->rx_clk = devm_clk_register(host->dev, &rx->hw);
-	if (WARN_ON(PTR_ERR_OR_ZERO(host->rx_clk)))
-		return PTR_ERR(host->rx_clk);
-
 	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
 	host->mmc->f_min = clk_round_rate(host->mmc_clk, 400000);
 	ret = clk_set_rate(host->mmc_clk, host->mmc->f_min);
 	if (ret)
 		return ret;
 
-	clk_set_phase(host->mmc_clk, 180);
-	clk_set_phase(host->tx_clk, 0);
-	clk_set_phase(host->rx_clk, 0);
-
 	return clk_prepare_enable(host->mmc_clk);
 }
 
-static void meson_mmc_shift_map(unsigned long *map, unsigned long shift)
-{
-	DECLARE_BITMAP(left, CLK_PHASE_POINT_NUM);
-	DECLARE_BITMAP(right, CLK_PHASE_POINT_NUM);
-
-	/*
-	 * shift the bitmap right and reintroduce the dropped bits on the left
-	 * of the bitmap
-	 */
-	bitmap_shift_right(right, map, shift, CLK_PHASE_POINT_NUM);
-	bitmap_shift_left(left, map, CLK_PHASE_POINT_NUM - shift,
-			  CLK_PHASE_POINT_NUM);
-	bitmap_or(map, left, right, CLK_PHASE_POINT_NUM);
-}
-
-static void meson_mmc_find_next_region(unsigned long *map,
-				       unsigned long *start,
-				       unsigned long *stop)
-{
-	*start = find_next_bit(map, CLK_PHASE_POINT_NUM, *start);
-	*stop = find_next_zero_bit(map, CLK_PHASE_POINT_NUM, *start);
-}
-
-static int meson_mmc_find_tuning_point(unsigned long *test)
-{
-	unsigned long shift, stop, offset = 0, start = 0, size = 0;
-
-	/* Get the all good/all bad situation out the way */
-	if (bitmap_full(test, CLK_PHASE_POINT_NUM))
-		return 0; /* All points are good so point 0 will do */
-	else if (bitmap_empty(test, CLK_PHASE_POINT_NUM))
-		return -EIO; /* No successful tuning point */
-
-	/*
-	 * Now we know there is a least one region find. Make sure it does
-	 * not wrap by the shifting the bitmap if necessary
-	 */
-	shift = find_first_zero_bit(test, CLK_PHASE_POINT_NUM);
-	if (shift != 0)
-		meson_mmc_shift_map(test, shift);
-
-	while (start < CLK_PHASE_POINT_NUM) {
-		meson_mmc_find_next_region(test, &start, &stop);
-
-		if ((stop - start) > size) {
-			offset = start;
-			size = stop - start;
-		}
-
-		start = stop;
-	}
-
-	/* Get the center point of the region */
-	offset += (size / 2);
-
-	/* Shift the result back */
-	offset = (offset + shift) % CLK_PHASE_POINT_NUM;
-
-	return offset;
-}
-
-static int meson_mmc_clk_phase_tuning(struct mmc_host *mmc, u32 opcode,
-				      struct clk *clk)
-{
-	int point, ret;
-	DECLARE_BITMAP(test, CLK_PHASE_POINT_NUM);
-
-	dev_dbg(mmc_dev(mmc), "%s phase/delay tunning...\n",
-		__clk_get_name(clk));
-	bitmap_zero(test, CLK_PHASE_POINT_NUM);
-
-	/* Explore tuning points */
-	for (point = 0; point < CLK_PHASE_POINT_NUM; point++) {
-		clk_set_phase(clk, point * CLK_PHASE_STEP);
-		ret = mmc_send_tuning(mmc, opcode, NULL);
-		if (!ret)
-			set_bit(point, test);
-	}
-
-	/* Find the optimal tuning point and apply it */
-	point = meson_mmc_find_tuning_point(test);
-	if (point < 0)
-		return point; /* tuning failed */
-
-	clk_set_phase(clk, point * CLK_PHASE_STEP);
-	dev_dbg(mmc_dev(mmc), "success with phase: %d\n",
-		clk_get_phase(clk));
-	return 0;
-}
-
-static int meson_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
-{
-	struct meson_host *host = mmc_priv(mmc);
-	int adj = 0;
-
-	/* enable signal resampling w/o delay */
-	adj = ADJUST_ADJ_EN;
-	writel(adj, host->regs + host->data->adjust);
-
-	return meson_mmc_clk_phase_tuning(mmc, opcode, host->rx_clk);
-}
-
 static int meson_mmc_prepare_ios_clock(struct meson_host *host,
 				       struct mmc_ios *ios)
 {
@@ -796,9 +536,6 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		/* disable signal resampling */
 		writel(0, host->regs + host->data->adjust);
 
-		/* Reset rx phase */
-		clk_set_phase(host->rx_clk, 0);
-
 		break;
 
 	case MMC_POWER_ON:
@@ -1226,7 +963,6 @@ static const struct mmc_host_ops meson_mmc_ops = {
 	.get_cd         = meson_mmc_get_cd,
 	.pre_req	= meson_mmc_pre_req,
 	.post_req	= meson_mmc_post_req,
-	.execute_tuning = meson_mmc_execute_tuning,
 	.card_busy	= meson_mmc_card_busy,
 	.start_signal_voltage_switch = meson_mmc_voltage_switch,
 };
-- 
2.20.1

