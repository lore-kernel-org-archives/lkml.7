Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13233C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D928B20665
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="a3SrpT7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390328AbfIXPeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 11:34:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41673 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390145AbfIXPeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 11:34:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id h7so2459025wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 08:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ks76Xrr9nKNePqaLMRUF1ZkG2fudOj170M7fieae2vM=;
        b=a3SrpT7YOFcb6RqQISZy0OBn0LLXJPlaadQLpRvpPfAUu9OF99EtqZ+iZDWCKSQKfm
         /PY+tEdZw0J+mqtUsu8JTg9ppjXjwcjBySMg3nAb7aTIT34K3m+8Jl1VBj3eHuBXUQSO
         uLUSHgPIZsBoU52AdQr9pOAs/DihLV4NGltOP/2jIei9uDmFRnWZm6kYKX8kc0h0cLR6
         kBw+tYPK4W+ch/jJ+JJCcdK5aJ253psq4G4gU9PT4eeraMoiODcud/IylmvIW8/nS+IO
         g3Ks9unobl885EMsBOy9VUtuEuBNXttCtqdE5aV5vexAXh+JtYnUaE5KtFiuYlG+MZ+4
         q7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ks76Xrr9nKNePqaLMRUF1ZkG2fudOj170M7fieae2vM=;
        b=BkfDl8qlhypBBi6lGVF8YIvTaxX4kwPjlRZEXQyZ1OfwowmmJlHwBe520fpB0eiSE/
         Yr6u/4LNf8PpVdc0+yRZD1IwU5OOYhT4rnk2g0Zi+uHj+7ZZ+FPup9Jd3UH2lcW4bUu7
         +CT5uLZHqGUmCCmtgj4NAwXkzPHwoFYM51IJgbS/VAubBYbTJV/0/ujVVKnNIAK7JQuG
         laoa73cPzIem0HI8HNLvAigozz8vNGGJKlz3e4/mVTuPtDvsRUITZ4Q7Xj0KJTRGY0xx
         HX77feX6OMfRyp5364cTfFu/4iQOleQBpGblIc4Yrkoj6NXplWE73RVkZj6nozS2CPp3
         CUpQ==
X-Gm-Message-State: APjAAAXsL0r/8Uxnw0ocEBiOCVBod60XI7jnsfqW61FACfeaGK8SJ/Tf
        dhyTQbHVacBzxul4WzrVWuoiqA==
X-Google-Smtp-Source: APXvYqwENWiw/6oEckacIFl28j6UnFFsq1VIO9Hk+y2r2bmjzF5Kz7jabrwCicvxYGqr/mVqilsnVw==
X-Received: by 2002:adf:ed88:: with SMTP id c8mr3117861wro.329.1569339253138;
        Tue, 24 Sep 2019 08:34:13 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id d10sm144240wma.42.2019.09.24.08.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 08:34:11 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] clk: meson: axg-audio: provide clk top signal name
Date:   Tue, 24 Sep 2019 17:33:55 +0200
Message-Id: <20190924153356.24103-7-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190924153356.24103-1-jbrunet@baylibre.com>
References: <20190924153356.24103-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The peripheral clock on the sm1 goes through some muxes
and dividers before reaching the audio gates. To model that,
without repeating our self too much, the "top" clock signal
is introduced and will serve as a the parent of the gates.

On the axg and g12a, the top clock is just a pass-through to
the audio peripheral clock provided by the main controller.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg-audio.c | 19 ++++++++++++++++---
 drivers/clk/meson/axg-audio.h |  3 ++-
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index ce8836776d1c..a8ccdbaecae2 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -74,9 +74,7 @@
 	.hw.init = &(struct clk_init_data) {				\
 		.name = "aud_"#_name,					\
 		.ops = &clk_regmap_gate_ops,				\
-		.parent_data = &(const struct clk_parent_data) {	\
-			.fw_name = "pclk",				\
-		},							\
+		.parent_names = (const char *[]){ "aud_top" },		\
 		.num_parents = 1,					\
 	},								\
 }
@@ -504,6 +502,19 @@ static struct clk_regmap tdmout_c_lrclk =
 	AUD_TDM_LRLCK(out_c, AUDIO_CLK_TDMOUT_C_CTRL);
 
 /* AXG/G12A Clocks */
+
+static struct clk_hw axg_aud_top = {
+	.init = &(struct clk_init_data) {
+		/* Provide aud_top signal name on axg and g12a */
+		.name = "aud_top",
+		.ops = &(const struct clk_ops) {},
+		.parent_data = &(const struct clk_parent_data) {
+			.fw_name = "pclk",
+		},
+		.num_parents = 1,
+	},
+};
+
 static struct clk_regmap mst_a_mclk_sel =
 	AUD_MST_MCLK_MUX(mst_a_mclk, AUDIO_MCLK_A_CTRL);
 static struct clk_regmap mst_b_mclk_sel =
@@ -691,6 +702,7 @@ static struct clk_hw_onecell_data axg_audio_hw_onecell_data = {
 		[AUD_CLKID_TDMOUT_A_LRCLK]	= &tdmout_a_lrclk.hw,
 		[AUD_CLKID_TDMOUT_B_LRCLK]	= &tdmout_b_lrclk.hw,
 		[AUD_CLKID_TDMOUT_C_LRCLK]	= &tdmout_c_lrclk.hw,
+		[AUD_CLKID_TOP]			= &axg_aud_top,
 		[NR_CLKS] = NULL,
 	},
 	.num = NR_CLKS,
@@ -835,6 +847,7 @@ static struct clk_hw_onecell_data g12a_audio_hw_onecell_data = {
 		[AUD_CLKID_TDM_SCLK_PAD0]	= &g12a_tdm_sclk_pad_0.hw,
 		[AUD_CLKID_TDM_SCLK_PAD1]	= &g12a_tdm_sclk_pad_1.hw,
 		[AUD_CLKID_TDM_SCLK_PAD2]	= &g12a_tdm_sclk_pad_2.hw,
+		[AUD_CLKID_TOP]			= &axg_aud_top,
 		[NR_CLKS] = NULL,
 	},
 	.num = NR_CLKS,
diff --git a/drivers/clk/meson/axg-audio.h b/drivers/clk/meson/axg-audio.h
index c00e28b2e1a9..a4956837f597 100644
--- a/drivers/clk/meson/axg-audio.h
+++ b/drivers/clk/meson/axg-audio.h
@@ -116,9 +116,10 @@
 #define AUD_CLKID_SPDIFOUT_B_CLK_SEL	153
 #define AUD_CLKID_SPDIFOUT_B_CLK_DIV	154
 
+
 /* include the CLKIDs which are part of the DT bindings */
 #include <dt-bindings/clock/axg-audio-clkc.h>
 
-#define NR_CLKS	163
+#define NR_CLKS	164
 
 #endif /*__AXG_AUDIO_CLKC_H */
-- 
2.21.0

