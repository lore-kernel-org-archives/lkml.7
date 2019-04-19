Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C608C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D35120645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="byTpf8Qo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfDSS6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:58:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40210 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbfDSS6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:58:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id z24so7306529wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 11:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ynOU9D+n/C593aR3+aH7h2j53IirX4AgmFGNr7usCrU=;
        b=byTpf8QoDgheP4OH2aYrCTOxGGLrxTH10MiS0MadOR04anYnsYV3eXcz0Z5yIL4hMc
         cUB8UgQcoNVUgO+CYC4mDqDAioM40IiIwGUvTWVLmzmZOr+vi0a6LMpnh3AHazSm8/BC
         shZvT217NUTHxY/C41qd7v80EyDpr8ENIJLNeOga9H2B+XK1lPVehRNZMF1IB//lma7l
         Ye8SjgV9UqExN8kwh4cifc9xHyEAeftkvfDLQ5IMH4LiKafv+fcC6Ur6nRmLa7Jxcut0
         gQ0XYpGIok5VuoWE0nNo60Oc9kVhI+ilYcYNoTeYTfhVDS6KPMLx0Z87s9LzvLM4uL+0
         VB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ynOU9D+n/C593aR3+aH7h2j53IirX4AgmFGNr7usCrU=;
        b=ZnwSl8qdc0SCIhVoQTwymqy5B6IDVtwHz+0X0oEw8Jq3f8vZX9YPSZTtkn9PWwmvjr
         XeD7/8x+WYxAOvnsCx2cG13thNn4gUHSycoJg2julzCgKM5LtoMlonSN/9L94G7px7Hr
         0k1GNr8KdCFLLQpPS4MN09uhTs+8YxrtG9mUEX4TVWv+gQrt2TqY4DbfxgvcPDcAph38
         fYMqninNn88hoSTVErOzm4Q91uYzAJu5V+KrG+072/Kmkmm3WGcD3MtvXfkK+MK9pi1X
         VJfcWCxe8AaYEFejCWVz/2LAMYAdyouva13sJlNGsNgrNeyD1Ho8N+L5KOBVoHXcDVMY
         jcSw==
X-Gm-Message-State: APjAAAUyIH+ahKZS1LVNi5zo5DacWJ9UYKl8xg0cK8Gbx7mZltNBHloK
        4P83nEkOuPBTuBZjTbkEkLWCZ83v6Q8=
X-Google-Smtp-Source: APXvYqwekbzTNrsULQwgq7khMJrLh4Cfn1gRnNMNgYqnDRCzpvEUs6iMH0O5C23PtZ6RMMJEoHncBA==
X-Received: by 2002:a1c:f606:: with SMTP id w6mr1732536wmc.130.1555662908388;
        Fri, 19 Apr 2019 01:35:08 -0700 (PDT)
Received: from localhost.localdomain (cpc89244-aztw30-2-0-cust4998.18-1.cable.virginm.net. [86.31.179.135])
        by smtp.gmail.com with ESMTPSA id t76sm5700147wmt.8.2019.04.19.01.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Apr 2019 01:35:07 -0700 (PDT)
From:   Peter Griffin <peter.griffin@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, p.zabel@pengutronix.de,
        xuwei5@hisilicon.com, mturquette@baylibre.com, sboyd@kernel.org,
        yuq825@gmail.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, lima@lists.freedesktop.org
Subject: [PATCH v2 4/6] reset: hi6220: Add support for AO reset controller
Date:   Fri, 19 Apr 2019 09:32:59 +0100
Message-Id: <1555662781-22570-5-git-send-email-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555662781-22570-1-git-send-email-peter.griffin@linaro.org>
References: <1555662781-22570-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required to bring Mali450 gpu out of reset. Also
we now use CLK_OF_DECLARE_DRIVER to probe in both the
clock and reset drivers. The clock and reset parts have
been done as one atomic commit to avoid a bisection hole.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi |  1 +
 drivers/clk/hisilicon/clk-hi6220.c        |  3 +-
 drivers/reset/hisilicon/hi6220_reset.c    | 65 ++++++++++++++++++++++++++++++-
 3 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 2defc19..66a3746 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -260,6 +260,7 @@
 			compatible = "hisilicon,hi6220-aoctrl", "syscon";
 			reg = <0x0 0xf7800000 0x0 0x2000>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 		};
 
 		sys_ctrl: sys_ctrl@f7030000 {
diff --git a/drivers/clk/hisilicon/clk-hi6220.c b/drivers/clk/hisilicon/clk-hi6220.c
index a87809d..3dde9d3 100644
--- a/drivers/clk/hisilicon/clk-hi6220.c
+++ b/drivers/clk/hisilicon/clk-hi6220.c
@@ -89,8 +89,9 @@ static void __init hi6220_clk_ao_init(struct device_node *np)
 	hisi_clk_register_gate_sep(hi6220_separated_gate_clks_ao,
 				ARRAY_SIZE(hi6220_separated_gate_clks_ao), clk_data_ao);
 }
-CLK_OF_DECLARE(hi6220_clk_ao, "hisilicon,hi6220-aoctrl", hi6220_clk_ao_init);
 
+/* reset driver also probes and uses these registers */
+CLK_OF_DECLARE_DRIVER(hi6220_clk_ao, "hisilicon,hi6220-aoctrl", hi6220_clk_ao_init);
 
 /* clocks in sysctrl */
 static const char *mmc0_mux0_p[] __initdata = { "pll_ddr_gate", "syspll", };
diff --git a/drivers/reset/hisilicon/hi6220_reset.c b/drivers/reset/hisilicon/hi6220_reset.c
index d5e5229..ccd5e0a 100644
--- a/drivers/reset/hisilicon/hi6220_reset.c
+++ b/drivers/reset/hisilicon/hi6220_reset.c
@@ -36,6 +36,7 @@
 enum hi6220_reset_ctrl_type {
 	PERIPHERAL,
 	MEDIA,
+	AO,
 };
 
 struct hi6220_reset_data {
@@ -95,6 +96,61 @@ static const struct reset_control_ops hi6220_media_reset_ops = {
 	.deassert = hi6220_media_deassert,
 };
 
+#define AO_SCTRL_SC_PW_CLKEN0     0x800
+#define AO_SCTRL_SC_PW_CLKDIS0    0x804
+
+#define AO_SCTRL_SC_PW_RSTEN0     0x810
+#define AO_SCTRL_SC_PW_RSTDIS0    0x814
+
+#define AO_SCTRL_SC_PW_ISOEN0     0x820
+#define AO_SCTRL_SC_PW_ISODIS0    0x824
+#define AO_MAX_INDEX              12
+
+static int hi6220_ao_assert(struct reset_controller_dev *rc_dev,
+			       unsigned long idx)
+{
+	struct hi6220_reset_data *data = to_reset_data(rc_dev);
+	struct regmap *regmap = data->regmap;
+	int ret;
+
+	ret = regmap_write(regmap, AO_SCTRL_SC_PW_RSTEN0, BIT(idx));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(regmap, AO_SCTRL_SC_PW_ISOEN0, BIT(idx));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(regmap, AO_SCTRL_SC_PW_CLKDIS0, BIT(idx));
+	if (ret)
+		return ret;
+}
+
+static int hi6220_ao_deassert(struct reset_controller_dev *rc_dev,
+				 unsigned long idx)
+{
+	struct hi6220_reset_data *data = to_reset_data(rc_dev);
+	struct regmap *regmap = data->regmap;
+	int ret;
+
+	ret = regmap_write(regmap, AO_SCTRL_SC_PW_RSTDIS0, BIT(idx));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(regmap, AO_SCTRL_SC_PW_ISODIS0, BIT(idx));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(regmap, AO_SCTRL_SC_PW_CLKEN0, BIT(idx));
+	if (ret)
+		return ret;
+}
+
+static const struct reset_control_ops hi6220_ao_reset_ops = {
+	.assert = hi6220_ao_assert,
+	.deassert = hi6220_ao_deassert,
+};
+
 static int hi6220_reset_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -120,9 +176,12 @@ static int hi6220_reset_probe(struct platform_device *pdev)
 	if (type == MEDIA) {
 		data->rc_dev.ops = &hi6220_media_reset_ops;
 		data->rc_dev.nr_resets = MEDIA_MAX_INDEX;
-	} else {
+	} else if (type == PERIPHERAL) {
 		data->rc_dev.ops = &hi6220_peripheral_reset_ops;
 		data->rc_dev.nr_resets = PERIPH_MAX_INDEX;
+	} else {
+		data->rc_dev.ops = &hi6220_ao_reset_ops;
+		data->rc_dev.nr_resets = AO_MAX_INDEX;
 	}
 
 	return reset_controller_register(&data->rc_dev);
@@ -137,6 +196,10 @@ static const struct of_device_id hi6220_reset_match[] = {
 		.compatible = "hisilicon,hi6220-mediactrl",
 		.data = (void *)MEDIA,
 	},
+	{
+		.compatible = "hisilicon,hi6220-aoctrl",
+		.data = (void *)AO,
+	},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, hi6220_reset_match);
-- 
2.7.4

