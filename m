Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C59C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0473420874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eNTsqQO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbfHZH0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 03:26:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38735 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbfHZHZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:25:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so14264333wrr.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 00:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zdrob6jLCWmAD4MIg2cSWU4L47HdPY2t/Oo0wCYY7Hk=;
        b=eNTsqQO+0IRILvTHpP4U1fThTnEQSQzUrubj1bYbnOVATm6sd6W5aOqxUUWAv7BYEL
         ysIjinLA/yDz9vcpiVmz67jr/wTtqIPTQ4IsAJ2mRUDPXZU0VXvBL26m3Z/l1bGc4cwT
         JBSXRBy4jup0VmK8HKTEfS3tgNsDebGX0YjQEg1eUM4fNtxiWmNVClaj8v859lLRFmue
         6aT2HFHzOZP+cbBPh9a25BNyjVHSjHhpPD6S5wwR8OmKxFEj9o+Xf0EE/FhF9R2i9kJ8
         szWomQyyFGc2IZuCz8ObyAoys8HZvToCMDi1FJkb5upkOd09yKVJ5HaTThausIJCaVvJ
         mfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zdrob6jLCWmAD4MIg2cSWU4L47HdPY2t/Oo0wCYY7Hk=;
        b=OuWWyrw7oY5TkPdHpUsTdEVoifU7qJ1Aa9+BUJ5d6yWA6DrLwQxlAS6CBb5FyRtile
         M/NHICysUMJwS9uyFRRunYe8rvISSiAkqr3s6ru9O5IL0KEjLJTV55+5/aAXwZexInal
         19Y0VOEgg0NA3FhVvsAtOSrE0c3JgpC+d/UdNWthwqAnl+JdDF/t6iZJFJe30lv3tYbi
         xpuE5TUlxYunLV7PUJVdwW3uvER7+E3ZgADCBVKcnyKut3i+oLu0MTOEIrSVPxgXT3tm
         4dltVX8/FcNvLOimkoLg0gHKi70w68LuTSNsbxsAY9fej5mfeo7sc3uVsP25dPdmoCER
         RS7g==
X-Gm-Message-State: APjAAAXyw4V5IHeW36ZMXF63Rwn67G1CTHzE4xMp6gKQzV0bw/AjJI4+
        /hIypsJgan4cylNLivQrWqiVvg==
X-Google-Smtp-Source: APXvYqxqinN+7WHsvAsFVT1CvNtxu5r6NgRiJ3mCW/RlIKEuf/08fVDXcyLiD4oRQqzLSplFV7uOcA==
X-Received: by 2002:a5d:4490:: with SMTP id j16mr20093838wrq.335.1566804346731;
        Mon, 26 Aug 2019 00:25:46 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a26sm10821324wmg.45.2019.08.26.00.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 00:25:46 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] clk: meson: g12a: add support for SM1 CPU 1, 2 & 3 clocks
Date:   Mon, 26 Aug 2019 09:25:38 +0200
Message-Id: <20190826072539.27725-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190826072539.27725-1-narmstrong@baylibre.com>
References: <20190826072539.27725-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic SM1 can set a dedicated clock frequency for each CPU core by
having a dedicate tree for each core similar to the CPU0 tree.
Like the DSU tree, a supplementaty mux has been added to use the CPU0
frequency instead.

But since the cluster only has a single power rail and shares a single PLL,
it's not worth adding 3 unsused clock tree, so we add only the mux to
select the CPU0 clock frequency for each CPU1, CPU2 and CPU3 cores.

They are set read-only because the early boot stages sets them to select
the CPU0 input clock.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/g12a.c | 60 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/g12a.h |  2 +-
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index e00df17f800a..ea4c791f106d 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -824,6 +824,60 @@ static struct clk_regmap sm1_dsu_final_clk = {
 	},
 };
 
+/* Datasheet names this field as "Cpu_clk_sync_mux_sel" bit 0 */
+static struct clk_regmap sm1_cpu1_clk = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL6,
+		.mask = 0x1,
+		.shift = 24,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu1_clk",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&g12a_cpu_clk.hw,
+			/* This CPU also have a dedicated clock tree */
+		},
+		.num_parents = 1,
+	},
+};
+
+/* Datasheet names this field as "Cpu_clk_sync_mux_sel" bit 1 */
+static struct clk_regmap sm1_cpu2_clk = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL6,
+		.mask = 0x1,
+		.shift = 25,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu2_clk",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&g12a_cpu_clk.hw,
+			/* This CPU also have a dedicated clock tree */
+		},
+		.num_parents = 1,
+	},
+};
+
+/* Datasheet names this field as "Cpu_clk_sync_mux_sel" bit 2 */
+static struct clk_regmap sm1_cpu3_clk = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_SYS_CPU_CLK_CNTL6,
+		.mask = 0x1,
+		.shift = 26,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "cpu3_clk",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_hws = (const struct clk_hw *[]) {
+			&g12a_cpu_clk.hw,
+			/* This CPU also have a dedicated clock tree */
+		},
+		.num_parents = 1,
+	},
+};
+
 /* Datasheet names this field as "Cpu_clk_sync_mux_sel" bit 4 */
 static struct clk_regmap sm1_dsu_clk = {
 	.data = &(struct clk_regmap_mux_data){
@@ -4576,6 +4630,9 @@ static struct clk_hw_onecell_data sm1_hw_onecell_data = {
 		[CLKID_DSU_CLK_DYN]		= &sm1_dsu_clk_dyn.hw,
 		[CLKID_DSU_CLK_FINAL]		= &sm1_dsu_final_clk.hw,
 		[CLKID_DSU_CLK]			= &sm1_dsu_clk.hw,
+		[CLKID_CPU1_CLK]		= &sm1_cpu1_clk.hw,
+		[CLKID_CPU2_CLK]		= &sm1_cpu2_clk.hw,
+		[CLKID_CPU3_CLK]		= &sm1_cpu3_clk.hw,
 		[NR_CLKS]			= NULL,
 	},
 	.num = NR_CLKS,
@@ -4807,6 +4864,9 @@ static struct clk_regmap *const g12a_clk_regmaps[] = {
 	&sm1_dsu_clk_dyn,
 	&sm1_dsu_final_clk,
 	&sm1_dsu_clk,
+	&sm1_cpu1_clk,
+	&sm1_cpu2_clk,
+	&sm1_cpu3_clk,
 };
 
 static const struct reg_sequence g12a_init_regs[] = {
diff --git a/drivers/clk/meson/g12a.h b/drivers/clk/meson/g12a.h
index 6804fcced6b5..9df4068aced1 100644
--- a/drivers/clk/meson/g12a.h
+++ b/drivers/clk/meson/g12a.h
@@ -256,7 +256,7 @@
 #define CLKID_DSU_CLK_DYN			250
 #define CLKID_DSU_CLK_FINAL			251
 
-#define NR_CLKS					253
+#define NR_CLKS					256
 
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/g12a-clkc.h>
-- 
2.22.0

