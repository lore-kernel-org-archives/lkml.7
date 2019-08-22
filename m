Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5370CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC49233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dB+Tq4VI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388120AbfHVOZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:25:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44952 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388049AbfHVOZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:25:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so5605758wrf.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 07:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W3ZKe7wvKgp9DF/q5SFHFIH+wtFWKtkn+RuPE2jKOyU=;
        b=dB+Tq4VIXfDguxnS2wK3qq7fYZrWRF6Dq9YjVxnkS+2pbFvz9gTgPhcaY1IXYWEdFS
         JNVvHcnjdLy4c4ZViOoM7qcJj+jyrG4/ExqAh8Swh56vWFk5j7AUkq6Bbv2v6XLXOBap
         rkaIVCZ9kkViJJB41/pJa+HJLDFfTtcmyi04f6H3GnzcXKOXNTjn/xg5oVph1mqbMTJ2
         byzK0KMjBYcaaW5TL/QJW3u23TN3+M9pLwaV7Lsa3P6YfKcp8qAxzMZ8GU7X5oMsViN0
         h3V22IvYEVdbJaV2+EL4VQuAkmidelRcpIWinDnBVgyBdIpQgMZS9ULJ45OMZ6I99FJH
         cnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W3ZKe7wvKgp9DF/q5SFHFIH+wtFWKtkn+RuPE2jKOyU=;
        b=HCl8GnpTXsa0PyHxT8uTPMwV7phRBCxrw3n7PPmsyP8oKgFwVOtlBxQfAQyKrgIEYy
         ZBpke2K3LeQq8UTzim10CW4ZYPhdt3R11f/ON1i7neO1YgoA+r/xxUHokjE26Zftt9PB
         +sXFWPOdTvlJJRyDHSlWs+mzk9lg/HgGe99gV2UAKR03A/+rNhKTLfYnWAmOB4xOH7iC
         edzF9/VI41IupmScAjFDv/3OXPKIZxFXXIAOwgYjoG8cnSFWOn4QCFi189UFyUobZ3vN
         4WKCaAWuGPLKPUyLP0/A+eeY+BH2xXzqyT5t/yzhoyKs/FfvWZSO+6nri6U2AJ3TFk/m
         YdCQ==
X-Gm-Message-State: APjAAAUUwtmObs6QT4LAwGH9p0j9ygA8+6izoevfCJSHOMd5q0SxSe0R
        Jw9o/j8LeQznSxmqeAsFxZVf+w==
X-Google-Smtp-Source: APXvYqy95iev0+owFdCqfO0PpxZORxPdAzw8OPciuPUksTpXu25Ul6RX+u5sudlsCf5Dt8bD+CAKug==
X-Received: by 2002:adf:ec4f:: with SMTP id w15mr31736699wrn.311.1566483903215;
        Thu, 22 Aug 2019 07:25:03 -0700 (PDT)
Received: from bender.baylibre.local (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id d17sm25806547wrm.52.2019.08.22.07.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 07:25:02 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] clk: meson: g12a: add support for SM1 CPU 1, 2 & 3 clocks
Date:   Thu, 22 Aug 2019 16:24:53 +0200
Message-Id: <20190822142455.12506-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190822142455.12506-1-narmstrong@baylibre.com>
References: <20190822142455.12506-1-narmstrong@baylibre.com>
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
 drivers/clk/meson/g12a.h |  5 +++-
 2 files changed, 64 insertions(+), 1 deletion(-)

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
index 66fd46940f91..4682a4442ae9 100644
--- a/drivers/clk/meson/g12a.h
+++ b/drivers/clk/meson/g12a.h
@@ -257,8 +257,11 @@
 #define CLKID_DSU_CLK_DYN			250
 #define CLKID_DSU_CLK_FINAL			251
 #define CLKID_DSU_CLK				252
+#define CLKID_CPU1_CLK				253
+#define CLKID_CPU2_CLK				254
+#define CLKID_CPU3_CLK				255
 
-#define NR_CLKS					253
+#define NR_CLKS					256
 
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/g12a-clkc.h>
-- 
2.22.0

