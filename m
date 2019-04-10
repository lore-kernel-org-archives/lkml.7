Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4498CC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0773C2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="TIFlTAYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbfDJLcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:32:03 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:16698 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731316AbfDJLcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:32:01 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3ABLegm023346;
        Wed, 10 Apr 2019 13:31:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=0lDpJM31jNRsTsa3qFi2Gz7qprZdCQrj2PXabiYtqOc=;
 b=TIFlTAYSvC0yMJWCePIL8nZlTonQu0tqKbPpmqAQR2qwNYEissO1oQAD6T4ZY1DjCeq2
 weh4KsjGCn/P1jkGPoj1ZAaFkDrHmQfJHecC2QdbDmtKE/xEALvtN8Eh0Ttrt6bjl5vZ
 F4lxw3zRDiPylFx/IuewFRdu33uLkKHhuRIzEXh8/DWt5zWdKNRRhTJWx+rvzmSbMXx/
 YKv3nBCttQ7VcsIJiUki1s3xek7ZvZPQG4KFVLyp4bsiXWhtkYRXj6Rnj43dzYELn8Qr
 Smf6AgxbRl+A5tE7FrONR6zXJBDNypKMGrA5cMvfMMEvPEjqGbPjQ9k0xnmCu5AE+vQx vg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rprcp6j3u-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 10 Apr 2019 13:31:44 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F060234;
        Wed, 10 Apr 2019 11:31:43 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B47B615BF;
        Wed, 10 Apr 2019 11:31:43 +0000 (GMT)
Received: from localhost (10.75.127.49) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 10 Apr 2019 13:31:43
 +0200
From:   Alexandre Torgue <alexandre.torgue@st.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <arnd@arndb.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH 2/5] pinctrl: stm32: introduce package support
Date:   Wed, 10 Apr 2019 13:30:21 +0200
Message-ID: <1554895824-25709-3-git-send-email-alexandre.torgue@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554895824-25709-1-git-send-email-alexandre.torgue@st.com>
References: <1554895824-25709-1-git-send-email-alexandre.torgue@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A same SoC can be available in several packages. Differences between
packages are only the numbers of available balls. In order not to write
a driver for each new package, same driver (ex: pinctrl-stm32mp157.c) will
be used. This patch introduces the "package" property for each pin. So on a
same driver, it will be possible to indicate on which package the pin is
available. The package information will be got from the device tree.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 0b9ff5a..0aebc31 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -95,6 +95,9 @@ struct stm32_pinctrl {
 	struct regmap		*regmap;
 	struct regmap_field	*irqmux[STM32_GPIO_PINS_PER_BANK];
 	struct hwspinlock *hwlock;
+	struct stm32_desc_pin *pins;
+	u32 npins;
+	u32 pkg;
 };
 
 static inline int stm32_gpio_pin(int gpio)
@@ -358,8 +361,8 @@ static bool stm32_pctrl_is_function_valid(struct stm32_pinctrl *pctl,
 {
 	int i;
 
-	for (i = 0; i < pctl->match_data->npins; i++) {
-		const struct stm32_desc_pin *pin = pctl->match_data->pins + i;
+	for (i = 0; i < pctl->npins; i++) {
+		const struct stm32_desc_pin *pin = pctl->pins + i;
 		const struct stm32_desc_function *func = pin->functions;
 
 		if (pin->pin.number != pin_num)
@@ -1175,7 +1178,7 @@ static int stm32_pctrl_build_state(struct platform_device *pdev)
 	struct stm32_pinctrl *pctl = platform_get_drvdata(pdev);
 	int i;
 
-	pctl->ngroups = pctl->match_data->npins;
+	pctl->ngroups = pctl->npins;
 
 	/* Allocate groups */
 	pctl->groups = devm_kcalloc(&pdev->dev, pctl->ngroups,
@@ -1189,19 +1192,50 @@ static int stm32_pctrl_build_state(struct platform_device *pdev)
 	if (!pctl->grp_names)
 		return -ENOMEM;
 
-	for (i = 0; i < pctl->match_data->npins; i++) {
-		const struct stm32_desc_pin *pin = pctl->match_data->pins + i;
+	for (i = 0; i < pctl->npins; i++) {
+		const struct stm32_desc_pin *pin = pctl->pins + i;
 		struct stm32_pinctrl_group *group = pctl->groups + i;
 
 		group->name = pin->pin.name;
 		group->pin = pin->pin.number;
-
 		pctl->grp_names[i] = pin->pin.name;
 	}
 
 	return 0;
 }
 
+static int stm32_pctrl_create_pins_tab(struct stm32_pinctrl *pctl,
+				       struct stm32_desc_pin *pins)
+{
+	const struct stm32_desc_pin *p;
+	int i, nb_pins_available = 0;
+
+	for (i = 0; i < pctl->match_data->npins; i++) {
+		p = pctl->match_data->pins + i;
+		if (pctl->pkg && !(pctl->pkg & p->pkg))
+			continue;
+		pins->pin = p->pin;
+		pins->functions = p->functions;
+		pins++;
+		nb_pins_available++;
+	}
+
+	pctl->npins = nb_pins_available;
+
+	return 0;
+}
+
+static void stm32_pctl_get_package(struct device_node *np,
+				   struct stm32_pinctrl *pctl)
+{
+	if (of_property_read_u32(np, "st,package", &pctl->pkg)) {
+		pctl->pkg = 0;
+		dev_warn(pctl->dev, "No package detected, use default one\n");
+	} else {
+		dev_dbg(pctl->dev, "package detected: %x\n", pctl->pkg);
+	}
+}
+
 int stm32_pctl_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1241,6 +1275,19 @@ int stm32_pctl_probe(struct platform_device *pdev)
 
 	pctl->dev = dev;
 	pctl->match_data = match->data;
+
+	/*  get package information */
+	stm32_pctl_get_package(np, pctl);
+
+	pctl->pins = devm_kcalloc(pctl->dev, pctl->match_data->npins,
+				  sizeof(*pctl->pins), GFP_KERNEL);
+	if (!pctl->pins)
+		return -ENOMEM;
+
+	ret = stm32_pctrl_create_pins_tab(pctl, pctl->pins);
+	if (ret)
+		return ret;
+
 	ret = stm32_pctrl_build_state(pdev);
 	if (ret) {
 		dev_err(dev, "build state failed: %d\n", ret);
@@ -1253,18 +1300,18 @@ int stm32_pctl_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	pins = devm_kcalloc(&pdev->dev, pctl->match_data->npins, sizeof(*pins),
+	pins = devm_kcalloc(&pdev->dev, pctl->npins, sizeof(*pins),
 			    GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;
 
-	for (i = 0; i < pctl->match_data->npins; i++)
-		pins[i] = pctl->match_data->pins[i].pin;
+	for (i = 0; i < pctl->npins; i++)
+		pins[i] = pctl->pins[i].pin;
 
 	pctl->pctl_desc.name = dev_name(&pdev->dev);
 	pctl->pctl_desc.owner = THIS_MODULE;
 	pctl->pctl_desc.pins = pins;
-	pctl->pctl_desc.npins = pctl->match_data->npins;
+	pctl->pctl_desc.npins = pctl->npins;
 	pctl->pctl_desc.confops = &stm32_pconf_ops;
 	pctl->pctl_desc.pctlops = &stm32_pctrl_ops;
 	pctl->pctl_desc.pmxops = &stm32_pmx_ops;
@@ -1305,4 +1352,3 @@ int stm32_pctl_probe(struct platform_device *pdev)
 
 	return 0;
 }
-
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.h b/drivers/pinctrl/stm32/pinctrl-stm32.h
index 473a623..8acdf48 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.h
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.h
@@ -26,6 +26,7 @@ struct stm32_desc_function {
 struct stm32_desc_pin {
 	struct pinctrl_pin_desc pin;
 	const struct stm32_desc_function *functions;
+	const unsigned int pkg;
 };
 
 #define STM32_PIN(_pin, ...)					\
@@ -35,6 +36,13 @@ struct stm32_desc_pin {
 			__VA_ARGS__, { } },			\
 	}
 
+#define STM32_PIN_PKG(_pin, _pkg, ...)					\
+	{							\
+		.pin = _pin,					\
+		.pkg  = _pkg,				\
+		.functions = (struct stm32_desc_function[]){	\
+			__VA_ARGS__, { } },			\
+	}
 #define STM32_FUNCTION(_num, _name)		\
 	{							\
 		.num = _num,					\
-- 
2.7.4

