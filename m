Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9091AC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A660206C1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566242765;
	bh=a4OAPQC7QBlpR77vZpXRRlHgkluk9x/qSx4mXQiMJE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E7zZOvpiSNP3jzy5rFY35tPGUBlWh3hrqPFqxrhHeBFcv3p1yysy3nVKvDjL46g07
	 abg0LF4AXgXUXyzZbWIuRaXPk7P5QouvkStZ+EzJaMHH/43EGxms93zqvs/G0rhOti
	 v819Wh8UvpTeBkreq987TwzkCgoF6P18HT287fUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfHST0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:26:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728608AbfHSTZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:25:57 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C260922CF8;
        Mon, 19 Aug 2019 19:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566242757;
        bh=a4OAPQC7QBlpR77vZpXRRlHgkluk9x/qSx4mXQiMJE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EL6DlqP+LE2dqslfP6Yd6cUgnNQJ+1zvCC5wFIjj2XWiSBy+It2CGvRnNgB3zIcCS
         Gy1WcRGCLPYyhl6J2dhvpXPjN6sW4DrW7uNl3PD99yUr7Gj73W3uh0lBIZQCkJC8yf
         Tj6Fv7Tqy6fxdnxYGrt0PfMtV+ujo2wgH63CC5/E=
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        codekipper@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 08/21] ASoC: sun4i-i2s: Use module clock as BCLK parent on newer SoCs
Date:   Mon, 19 Aug 2019 21:25:15 +0200
Message-Id: <0b6665be216b3bd0e7bc43724818f05f3f8ee881.1566242458.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
References: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

On the first generation of Allwinner SoCs (A10-A31), the i2s controller was
using the MCLK as BCLK parent. However, this changed since the introduction
of the A83t and BCLK now uses the module clock as its parent.

Let's introduce a hook to get the parent rate and use that in our divider
calculations.

Fixes: 7d2993811a1e ("ASoC: sun4i-i2s: Add support for H3")
Fixes: 21faaea1343f ("ASoC: sun4i-i2s: Add support for A83T")
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index ee8ee3eb2087..51be395102b2 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -152,6 +152,7 @@ struct sun4i_i2s_quirks {
 	struct reg_field		field_fmt_bclk;
 	struct reg_field		field_fmt_lrclk;
 
+	unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *);
 	s8	(*get_sr)(const struct sun4i_i2s *, int);
 	s8	(*get_wss)(const struct sun4i_i2s *, int);
 	int	(*set_chan_cfg)(const struct sun4i_i2s *,
@@ -207,6 +208,16 @@ static const struct sun4i_i2s_clk_div sun4i_i2s_mclk_div[] = {
 	/* TODO - extend divide ratio supported by newer SoCs */
 };
 
+static unsigned long sun4i_i2s_get_bclk_parent_rate(const struct sun4i_i2s *i2s)
+{
+	return i2s->mclk_freq;
+}
+
+static unsigned long sun8i_i2s_get_bclk_parent_rate(const struct sun4i_i2s *i2s)
+{
+	return clk_get_rate(i2s->mod_clk);
+}
+
 static int sun4i_i2s_get_bclk_div(struct sun4i_i2s *i2s,
 				  unsigned long parent_rate,
 				  unsigned int sampling_rate,
@@ -259,7 +270,7 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 				  unsigned int word_size)
 {
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
-	unsigned int oversample_rate, clk_rate;
+	unsigned int oversample_rate, clk_rate, bclk_parent_rate;
 	int bclk_div, mclk_div;
 	int ret;
 
@@ -301,7 +312,8 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	bclk_div = sun4i_i2s_get_bclk_div(i2s, i2s->mclk_freq,
+	bclk_parent_rate = i2s->variant->get_bclk_parent_rate(i2s);
+	bclk_div = sun4i_i2s_get_bclk_div(i2s, bclk_parent_rate,
 					  rate, word_size);
 	if (bclk_div < 0) {
 		dev_err(dai->dev, "Unsupported BCLK divider: %d\n", bclk_div);
@@ -957,6 +969,7 @@ static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
 	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
 	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
+	.get_bclk_parent_rate	= sun4i_i2s_get_bclk_parent_rate,
 	.get_sr			= sun4i_i2s_get_sr,
 	.get_wss		= sun4i_i2s_get_wss,
 	.set_chan_cfg		= sun4i_i2s_set_chan_cfg,
@@ -972,6 +985,7 @@ static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
 	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
 	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
+	.get_bclk_parent_rate	= sun4i_i2s_get_bclk_parent_rate,
 	.get_sr			= sun4i_i2s_get_sr,
 	.get_wss		= sun4i_i2s_get_wss,
 	.set_chan_cfg		= sun4i_i2s_set_chan_cfg,
@@ -987,6 +1001,7 @@ static const struct sun4i_i2s_quirks sun8i_a83t_i2s_quirks = {
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
 	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
 	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
+	.get_bclk_parent_rate	= sun8i_i2s_get_bclk_parent_rate,
 	.get_sr			= sun8i_i2s_get_sr_wss,
 	.get_wss		= sun8i_i2s_get_sr_wss,
 	.set_chan_cfg		= sun8i_i2s_set_chan_cfg,
@@ -1005,6 +1020,7 @@ static const struct sun4i_i2s_quirks sun8i_h3_i2s_quirks = {
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 6),
 	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
 	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 19, 19),
+	.get_bclk_parent_rate	= sun8i_i2s_get_bclk_parent_rate,
 	.get_sr			= sun8i_i2s_get_sr_wss,
 	.get_wss		= sun8i_i2s_get_sr_wss,
 	.set_chan_cfg		= sun8i_i2s_set_chan_cfg,
@@ -1020,6 +1036,7 @@ static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
 	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 5),
 	.field_fmt_bclk		= REG_FIELD(SUN4I_I2S_FMT0_REG, 6, 6),
 	.field_fmt_lrclk	= REG_FIELD(SUN4I_I2S_FMT0_REG, 7, 7),
+	.get_bclk_parent_rate	= sun4i_i2s_get_bclk_parent_rate,
 	.get_sr			= sun4i_i2s_get_sr,
 	.get_wss		= sun4i_i2s_get_wss,
 	.set_chan_cfg		= sun4i_i2s_set_chan_cfg,
-- 
git-series 0.9.1
