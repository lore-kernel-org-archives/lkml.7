Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECADFC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD2720859
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wYliaoyk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731437AbfETIbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:31:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36739 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731401AbfETIbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:31:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id a3so6449616pgb.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wZmd2sSqxBswncIP49DIhHiOiWPLqbCT+QWxEkOy/co=;
        b=wYliaoykTkMBfrBtk1tyMUrq5pCqug2hVNjNDCjfWMPgRZxZ6r8MN4oCs0as2iaX94
         l49bbHxM/Ti/+pMIToe0NVyxo05Q8o0gotf2D7drpAiFeSQyPFce7ouk2hWMIO2ewDcH
         JC6lsKRqIABuvaVlrXyQqTXmgbzAWszMlw2xm1zaJUoJFg4G7hfuhMLQ9iRwbHUhtoM9
         lj3mGApdgSgzKfp+rtMsHkY1r/mdKPtaLoBvgCZlvTPz3/Dza8DVB6dRnSx3bBJi6tTW
         OWmmmVXz7I6sDmRs1+j8SrGk7+yGW4Pknp8FJigwuR1P747ZiuG9Xsu2ZmtYbaJSdj7i
         UaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wZmd2sSqxBswncIP49DIhHiOiWPLqbCT+QWxEkOy/co=;
        b=ggzcPE80viv1G/wG0EyjSw+N5rgsEj0wPOcNiG0y5VTjK5Frnz63ugkyEgMyVuJOHf
         1n12mENBEHWrC+CkspURQ2/4XLFP+4ehtJXNjGf9tjNIL8j7VVPJsRf1SFkspvm/sDz4
         zdrYwSWbQUwpwSp3PMHOupT06nlQtd27Bmwb6BIpoWJqPF6TLMwW7RgKtb/erxl2Wj16
         Po+KhO+pnzDFCzGhPpHEI1m2fqlzTrdHsHicjd2ewjB7/AgT7x75VyKOIi7aNqIv3cwP
         FceP6XAE72gozAy383e2yuv17FIm8Lp3f6VStvx21+xQ3who5FBrYCh1WhYCGHqayUk3
         Utng==
X-Gm-Message-State: APjAAAUTofe6sbL6r7tOpvVaYL8LwdmwXX+lF7o1YxfDStVCUb/p6er+
        m4v4ArI2U6zt4p+HbO3Z3PQy
X-Google-Smtp-Source: APXvYqxtgRk9hUYeKzUqFkTBf75l2tsN0xCN0ekdZ9P/6ymdT9+k/j2ax6QYys17dUs7LvLpFXwXGQ==
X-Received: by 2002:a62:86c4:: with SMTP id x187mr77900616pfd.34.1558341103495;
        Mon, 20 May 2019 01:31:43 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7203:2717:7d22:7fdb:b76e:242c])
        by smtp.gmail.com with ESMTPSA id s72sm24068220pgc.65.2019.05.20.01.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:31:43 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linus.walleij@linaro.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        linux-gpio@vger.kernel.org, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 5/5] pinctrl: Add pinconf support for BM1880 SoC
Date:   Mon, 20 May 2019 14:01:01 +0530
Message-Id: <20190520083101.10229-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190520083101.10229-1-manivannan.sadhasivam@linaro.org>
References: <20190520083101.10229-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinconf support for Bitmain BM1880 SoC. Pinconf support includes
pin bias, slew rate and schmitt trigger. Drive strength support will
be added later.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pinctrl/pinctrl-bm1880.c | 134 +++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-bm1880.c b/drivers/pinctrl/pinctrl-bm1880.c
index bddb705ea142..1aaed46d5c30 100644
--- a/drivers/pinctrl/pinctrl-bm1880.c
+++ b/drivers/pinctrl/pinctrl-bm1880.c
@@ -4,6 +4,8 @@
  *
  * Copyright (c) 2019 Linaro Ltd.
  * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ *
+ * TODO: Drive strength support
  */
 
 #include <linux/io.h>
@@ -872,6 +874,137 @@ static int bm1880_pinmux_set_mux(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
+#define BM1880_PINCONF(pin, idx) ((!((pin + 1) & 1) << 4) + idx)
+#define BM1880_PINCONF_PULLCTRL(pin)	BM1880_PINCONF(pin, 0)
+#define BM1880_PINCONF_PULLUP(pin)	BM1880_PINCONF(pin, 1)
+#define BM1880_PINCONF_PULLDOWN(pin)	BM1880_PINCONF(pin, 2)
+#define BM1880_PINCONF_SCHMITT(pin)	BM1880_PINCONF(pin, 9)
+#define BM1880_PINCONF_SLEW(pin)	BM1880_PINCONF(pin, 10)
+
+static int bm1880_pinconf_cfg_get(struct pinctrl_dev *pctldev,
+				  unsigned int pin,
+				  unsigned long *config)
+{
+	struct bm1880_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+	unsigned int param = pinconf_to_config_param(*config);
+	unsigned int arg = 0;
+	u32 regval, offset, bit_offset;
+
+	offset = (pin >> 1) << 2;
+	regval = readl_relaxed(pctrl->base + BM1880_REG_MUX + offset);
+
+	switch (param) {
+	case PIN_CONFIG_BIAS_PULL_UP:
+		bit_offset = BM1880_PINCONF_PULLUP(pin);
+		arg = !!(regval & BIT(bit_offset));
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		bit_offset = BM1880_PINCONF_PULLDOWN(pin);
+		arg = !!(regval & BIT(bit_offset));
+		break;
+	case PIN_CONFIG_BIAS_DISABLE:
+		bit_offset = BM1880_PINCONF_PULLCTRL(pin);
+		arg = !!(regval & BIT(bit_offset));
+		break;
+	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		bit_offset = BM1880_PINCONF_SCHMITT(pin);
+		arg = !!(regval & BIT(bit_offset));
+		break;
+	case PIN_CONFIG_SLEW_RATE:
+		bit_offset = BM1880_PINCONF_SLEW(pin);
+		arg = !!(regval & BIT(bit_offset));
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	*config = pinconf_to_config_packed(param, arg);
+
+	return 0;
+}
+
+static int bm1880_pinconf_cfg_set(struct pinctrl_dev *pctldev,
+				  unsigned int pin,
+				  unsigned long *configs,
+				  unsigned int num_configs)
+{
+	struct bm1880_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+	u32 regval, offset, bit_offset;
+	int i;
+
+	offset = (pin >> 1) << 2;
+	regval = readl_relaxed(pctrl->base + BM1880_REG_MUX + offset);
+
+	for (i = 0; i < num_configs; i++) {
+		unsigned int param = pinconf_to_config_param(configs[i]);
+		unsigned int arg = pinconf_to_config_argument(configs[i]);
+
+		switch (param) {
+		case PIN_CONFIG_BIAS_PULL_UP:
+			bit_offset = BM1880_PINCONF_PULLUP(pin);
+			regval |= BIT(bit_offset);
+			break;
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+			bit_offset = BM1880_PINCONF_PULLDOWN(pin);
+			regval |= BIT(bit_offset);
+			break;
+		case PIN_CONFIG_BIAS_DISABLE:
+			bit_offset = BM1880_PINCONF_PULLCTRL(pin);
+			regval |= BIT(bit_offset);
+			break;
+		case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+			bit_offset = BM1880_PINCONF_SCHMITT(pin);
+			if (arg)
+				regval |= BIT(bit_offset);
+			else
+				regval &= ~BIT(bit_offset);
+			break;
+		case PIN_CONFIG_SLEW_RATE:
+			bit_offset = BM1880_PINCONF_SLEW(pin);
+			if (arg)
+				regval |= BIT(bit_offset);
+			else
+				regval &= ~BIT(bit_offset);
+			break;
+		default:
+			dev_warn(pctldev->dev,
+				 "unsupported configuration parameter '%u'\n",
+				 param);
+			continue;
+		}
+
+		writel_relaxed(regval, pctrl->base + BM1880_REG_MUX + offset);
+	}
+
+	return 0;
+}
+
+static int bm1880_pinconf_group_set(struct pinctrl_dev *pctldev,
+				    unsigned int selector,
+				    unsigned long *configs,
+				    unsigned int  num_configs)
+{
+	int i, ret;
+	struct bm1880_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+	const struct bm1880_pctrl_group *pgrp = &pctrl->groups[selector];
+
+	for (i = 0; i < pgrp->npins; i++) {
+		ret = bm1880_pinconf_cfg_set(pctldev, pgrp->pins[i], configs,
+					     num_configs);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct pinconf_ops bm1880_pinconf_ops = {
+	.is_generic = true,
+	.pin_config_get = bm1880_pinconf_cfg_get,
+	.pin_config_set = bm1880_pinconf_cfg_set,
+	.pin_config_group_set = bm1880_pinconf_group_set,
+};
+
 static const struct pinmux_ops bm1880_pinmux_ops = {
 	.get_functions_count = bm1880_pmux_get_functions_count,
 	.get_function_name = bm1880_pmux_get_function_name,
@@ -885,6 +1018,7 @@ static struct pinctrl_desc bm1880_desc = {
 	.npins = ARRAY_SIZE(bm1880_pins),
 	.pctlops = &bm1880_pctrl_ops,
 	.pmxops = &bm1880_pinmux_ops,
+	.confops = &bm1880_pinconf_ops,
 	.owner = THIS_MODULE,
 };
 
-- 
2.17.1

