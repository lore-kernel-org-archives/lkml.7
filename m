Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA9CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CAA420857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ODdVQL4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732070AbfDAHxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:53:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44386 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732032AbfDAHxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:53:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id y7so10574707wrn.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 00:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n0cjVrPkAczN0OVZtKpXlRyeOATGIyf7FvuDhqdvYrw=;
        b=ODdVQL4rV04dS66tCynCWu6fjjowyc67Xc8yJFhxXOdy+bgfk2p46ncV5qXpGC06x1
         Dv07enfzyZ92UNQtYlPJrprpNSbr1q1iQsAqfeU9NIn/0zgtpTzQKe33z3wWAi2XcPp6
         qWrfMGBF5Cx5WdrRDBZUWz9/4LWkxqOtWSTOU9YwlBXFgNGv60b6qYw68huxxZ/C7NGz
         OgUrY5aqukBZDgbP2n33uYE61P9Ej0AAsAfPoU9dHPrFaNEUXrifZwmm46nKuAPf1zOs
         o/HFtDWl4qddpIaRaBO5rtJa0RczsucxuRVWjZhPlwJOkeTqqkMoeweLt6cHrih4Ijw1
         Zmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n0cjVrPkAczN0OVZtKpXlRyeOATGIyf7FvuDhqdvYrw=;
        b=AxKOZaNA17Hx5QdkL2m4xgCG1ZXYJDgmVDuvCmKmM8/2iB6rfQqPmILsmOXMafUubZ
         5n/4/rwpBgm+yXB5vPbN2KKzB/3Tb3I1u4vY4dbzojQdqbu8aDhuiqT17moG9I6jYGv6
         PovRVtPYnl3799vuNsGrzsW1ic4CCT4eLptNePtQC/Th2Di1pzDMI2HUVkGdO9Ajm9nq
         aDtbTu3zNcwzRlNwEBPRetDf20fYhds3cFZLhYGjCm1dgoXtgqhoER6RUy66ZJluF64y
         oL8H53dzjRGIQZHBa5ksWE2AaGUd9mJGeIuM9cXqgq6q7tJfwnjMhE9N+achIdiJoo+L
         AVpg==
X-Gm-Message-State: APjAAAUDlFLX2u1KB+kuoRGjcXVJkHrED6N0yH7SqFJUtYOOQy3AKVQt
        frM8KGDpJ9fHO5Te4VWdaZHwXA==
X-Google-Smtp-Source: APXvYqyMqAdPDh1rOCx/fzzfybqwj9i3vghVh1NLf83qWvikBAzHaGemtnoGMhG/430TQRpvThY8hQ==
X-Received: by 2002:adf:edca:: with SMTP id v10mr37926519wro.157.1554105181994;
        Mon, 01 Apr 2019 00:53:01 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id f11sm10264511wrm.30.2019.04.01.00.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Apr 2019 00:53:01 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] soc: amlogic: meson-gx-pwrc-vpu: Add support for G12A
Date:   Mon,  1 Apr 2019 09:52:58 +0200
Message-Id: <20190401075258.11595-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A SoC has a very similar VPU Power Controller setup
than the older GXBB, GXL & GXm SoCs.

This patch adds the variant support for G12A.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
Changes since v1:
- Move the GX mask fix to a separate patch

Dependencies:
- Depends on [1], but is reviewed, linux-amlogic maintainer can pick it in the same time as this patch

[1] https://patchwork.kernel.org/patch/10851177/

 drivers/soc/amlogic/meson-gx-pwrc-vpu.c | 152 ++++++++++++++++++++++--
 1 file changed, 140 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c b/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
index 05421d029dff..511b6856225d 100644
--- a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
+++ b/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
@@ -11,6 +11,7 @@
 #include <linux/bitfield.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
+#include <linux/of_device.h>
 #include <linux/reset.h>
 #include <linux/clk.h>
 
@@ -26,6 +27,7 @@
 #define HHI_MEM_PD_REG0			(0x40 << 2)
 #define HHI_VPU_MEM_PD_REG0		(0x41 << 2)
 #define HHI_VPU_MEM_PD_REG1		(0x42 << 2)
+#define HHI_VPU_MEM_PD_REG2		(0x4d << 2)
 
 struct meson_gx_pwrc_vpu {
 	struct generic_pm_domain genpd;
@@ -80,6 +82,49 @@ static int meson_gx_pwrc_vpu_power_off(struct generic_pm_domain *genpd)
 	return 0;
 }
 
+static int meson_g12a_pwrc_vpu_power_off(struct generic_pm_domain *genpd)
+{
+	struct meson_gx_pwrc_vpu *pd = genpd_to_pd(genpd);
+	int i;
+
+	regmap_update_bits(pd->regmap_ao, AO_RTI_GEN_PWR_SLEEP0,
+			   GEN_PWR_VPU_HDMI_ISO, GEN_PWR_VPU_HDMI_ISO);
+	udelay(20);
+
+	/* Power Down Memories */
+	for (i = 0; i < 32; i += 2) {
+		regmap_update_bits(pd->regmap_hhi, HHI_VPU_MEM_PD_REG0,
+				   0x3 << i, 0x3 << i);
+		udelay(5);
+	}
+	for (i = 0; i < 32; i += 2) {
+		regmap_update_bits(pd->regmap_hhi, HHI_VPU_MEM_PD_REG1,
+				   0x3 << i, 0x3 << i);
+		udelay(5);
+	}
+	for (i = 0; i < 32; i += 2) {
+		regmap_update_bits(pd->regmap_hhi, HHI_VPU_MEM_PD_REG2,
+				   0x3 << i, 0x3 << i);
+		udelay(5);
+	}
+	for (i = 8; i < 16; i++) {
+		regmap_update_bits(pd->regmap_hhi, HHI_MEM_PD_REG0,
+				   BIT(i), BIT(i));
+		udelay(5);
+	}
+	udelay(20);
+
+	regmap_update_bits(pd->regmap_ao, AO_RTI_GEN_PWR_SLEEP0,
+			   GEN_PWR_VPU_HDMI, GEN_PWR_VPU_HDMI);
+
+	msleep(20);
+
+	clk_disable_unprepare(pd->vpu_clk);
+	clk_disable_unprepare(pd->vapb_clk);
+
+	return 0;
+}
+
 static int meson_gx_pwrc_vpu_setup_clk(struct meson_gx_pwrc_vpu *pd)
 {
 	int ret;
@@ -143,6 +188,60 @@ static int meson_gx_pwrc_vpu_power_on(struct generic_pm_domain *genpd)
 	return 0;
 }
 
+static int meson_g12a_pwrc_vpu_power_on(struct generic_pm_domain *genpd)
+{
+	struct meson_gx_pwrc_vpu *pd = genpd_to_pd(genpd);
+	int ret;
+	int i;
+
+	regmap_update_bits(pd->regmap_ao, AO_RTI_GEN_PWR_SLEEP0,
+			   GEN_PWR_VPU_HDMI, 0);
+	udelay(20);
+
+	/* Power Up Memories */
+	for (i = 0; i < 32; i += 2) {
+		regmap_update_bits(pd->regmap_hhi, HHI_VPU_MEM_PD_REG0,
+				   0x3 << i, 0);
+		udelay(5);
+	}
+
+	for (i = 0; i < 32; i += 2) {
+		regmap_update_bits(pd->regmap_hhi, HHI_VPU_MEM_PD_REG1,
+				   0x3 << i, 0);
+		udelay(5);
+	}
+
+	for (i = 0; i < 32; i += 2) {
+		regmap_update_bits(pd->regmap_hhi, HHI_VPU_MEM_PD_REG2,
+				   0x3 << i, 0);
+		udelay(5);
+	}
+
+	for (i = 8; i < 16; i++) {
+		regmap_update_bits(pd->regmap_hhi, HHI_MEM_PD_REG0,
+				   BIT(i), 0);
+		udelay(5);
+	}
+	udelay(20);
+
+	ret = reset_control_assert(pd->rstc);
+	if (ret)
+		return ret;
+
+	regmap_update_bits(pd->regmap_ao, AO_RTI_GEN_PWR_SLEEP0,
+			   GEN_PWR_VPU_HDMI_ISO, 0);
+
+	ret = reset_control_deassert(pd->rstc);
+	if (ret)
+		return ret;
+
+	ret = meson_gx_pwrc_vpu_setup_clk(pd);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static bool meson_gx_pwrc_vpu_get_power(struct meson_gx_pwrc_vpu *pd)
 {
 	u32 reg;
@@ -160,15 +259,37 @@ static struct meson_gx_pwrc_vpu vpu_hdmi_pd = {
 	},
 };
 
+static struct meson_gx_pwrc_vpu vpu_hdmi_pd_g12a = {
+	.genpd = {
+		.name = "vpu_hdmi",
+		.power_off = meson_g12a_pwrc_vpu_power_off,
+		.power_on = meson_g12a_pwrc_vpu_power_on,
+	},
+};
+
 static int meson_gx_pwrc_vpu_probe(struct platform_device *pdev)
 {
+	const struct meson_gx_pwrc_vpu *vpu_pd_match;
 	struct regmap *regmap_ao, *regmap_hhi;
+	struct meson_gx_pwrc_vpu *vpu_pd;
 	struct reset_control *rstc;
 	struct clk *vpu_clk;
 	struct clk *vapb_clk;
 	bool powered_off;
 	int ret;
 
+	vpu_pd_match = of_device_get_match_data(&pdev->dev);
+	if (!vpu_pd_match) {
+		dev_err(&pdev->dev, "failed to get match data\n");
+		return -ENODEV;
+	}
+
+	vpu_pd = devm_kzalloc(&pdev->dev, sizeof(*vpu_pd), GFP_KERNEL);
+	if (!vpu_pd)
+		return -ENOMEM;
+
+	memcpy(vpu_pd, vpu_pd_match, sizeof(*vpu_pd));
+
 	regmap_ao = syscon_node_to_regmap(of_get_parent(pdev->dev.of_node));
 	if (IS_ERR(regmap_ao)) {
 		dev_err(&pdev->dev, "failed to get regmap\n");
@@ -201,39 +322,46 @@ static int meson_gx_pwrc_vpu_probe(struct platform_device *pdev)
 		return PTR_ERR(vapb_clk);
 	}
 
-	vpu_hdmi_pd.regmap_ao = regmap_ao;
-	vpu_hdmi_pd.regmap_hhi = regmap_hhi;
-	vpu_hdmi_pd.rstc = rstc;
-	vpu_hdmi_pd.vpu_clk = vpu_clk;
-	vpu_hdmi_pd.vapb_clk = vapb_clk;
+	vpu_pd->regmap_ao = regmap_ao;
+	vpu_pd->regmap_hhi = regmap_hhi;
+	vpu_pd->rstc = rstc;
+	vpu_pd->vpu_clk = vpu_clk;
+	vpu_pd->vapb_clk = vapb_clk;
+
+	platform_set_drvdata(pdev, vpu_pd);
 
-	powered_off = meson_gx_pwrc_vpu_get_power(&vpu_hdmi_pd);
+	powered_off = meson_gx_pwrc_vpu_get_power(vpu_pd);
 
 	/* If already powered, sync the clock states */
 	if (!powered_off) {
-		ret = meson_gx_pwrc_vpu_setup_clk(&vpu_hdmi_pd);
+		ret = meson_gx_pwrc_vpu_setup_clk(vpu_pd);
 		if (ret)
 			return ret;
 	}
 
-	pm_genpd_init(&vpu_hdmi_pd.genpd, &pm_domain_always_on_gov,
+	pm_genpd_init(&vpu_pd->genpd, &pm_domain_always_on_gov,
 		      powered_off);
 
 	return of_genpd_add_provider_simple(pdev->dev.of_node,
-					    &vpu_hdmi_pd.genpd);
+					    &vpu_pd->genpd);
 }
 
 static void meson_gx_pwrc_vpu_shutdown(struct platform_device *pdev)
 {
+	struct meson_gx_pwrc_vpu *vpu_pd = platform_get_drvdata(pdev);
 	bool powered_off;
 
-	powered_off = meson_gx_pwrc_vpu_get_power(&vpu_hdmi_pd);
+	powered_off = meson_gx_pwrc_vpu_get_power(vpu_pd);
 	if (!powered_off)
-		meson_gx_pwrc_vpu_power_off(&vpu_hdmi_pd.genpd);
+		vpu_pd->genpd.power_off(&vpu_pd->genpd);
 }
 
 static const struct of_device_id meson_gx_pwrc_vpu_match_table[] = {
-	{ .compatible = "amlogic,meson-gx-pwrc-vpu" },
+	{ .compatible = "amlogic,meson-gx-pwrc-vpu", .data = &vpu_hdmi_pd },
+	{
+	  .compatible = "amlogic,meson-g12a-pwrc-vpu",
+	  .data = &vpu_hdmi_pd_g12a
+	},
 	{ /* sentinel */ }
 };
 
-- 
2.21.0

