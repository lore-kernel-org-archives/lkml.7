Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14D3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71ACB2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hzvfasmh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfCRTlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:41:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55158 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbfCRTlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:41:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id f3so14430757wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 12:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mCYuzjXjAhAdmGCTChMacQlApx18wWBt60iN6MyaJRQ=;
        b=HzvfasmhXnx4JtwlIbiPWvb50HOkNd7QnQnXq9U/+ESG1TejnfmEDg90Pc/oz36xGF
         3FSmmSmVBKgE++CMgTIp8QW5g5gcHWd7kvj4GAeLCLOdKbtbjGOK//MgjviiqWJxbOBS
         W1sIbjiPH+oUPWgpFovf9d7XNbVAkChWDuSYDGNFYuAFnpM0fUHfuAUZYuCDI76YIITj
         LuwAxB/14vsrp9U6YqS1qFMou5f/wHNbFs4t6Hvf8Kx4OsPFjT/b3w20mPWpKpUF/HI9
         Asnz4uFGvVG6eu6B+3MEFCUdYf5M19qG2hA1797dOk+6YQXG/F+Fjzp8bvbxhcBuF9v+
         tLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mCYuzjXjAhAdmGCTChMacQlApx18wWBt60iN6MyaJRQ=;
        b=OuQoyV4TYnDHnpk2N54lqQXDSgrTRXQrgh5fUvx7G29kGSV+8kmztMZWwQO6GhFt0Q
         kbErwcYHwhJR2OZ8WbUFteB2Pyjg/GpKHdZ/gDrkpNS6phV9rBl7fAn9+5+jdPb9JwjV
         CE90QPZGOSQhztaavY8SzVyoIgOBQBILxsRz31GvjlWyUzJJhABKi4ZxlVAk4OEsJDR3
         9Y9KomuCxNeHtOHDPxs/GA1EQm0V6ir1gcl3Fhnd8agHHYNQVWgmrMu51nozddQ2b5DB
         NEUv+yKozP04DYcpm40UZ538MWRFqxCNJyIM9VU808hYe59XfhhMJaTwgfT/1zgcbewJ
         I7Cg==
X-Gm-Message-State: APjAAAVeob9lXhmLdPJvNERBI38z2nf8SuWbuJhdhZMcXqfZiOUzUx2o
        tPOLdoHR5xfSaQ0zShos7BTdGg==
X-Google-Smtp-Source: APXvYqzhTusUZxAZX+UKsouiPFztVANdEtEHZhoPKs/a4eIOoxpW2MoOwRrgddVlTUDXw8v7v30Evg==
X-Received: by 2002:a1c:7517:: with SMTP id o23mr435554wmc.9.1552938058758;
        Mon, 18 Mar 2019 12:40:58 -0700 (PDT)
Received: from localhost.localdomain (cpc89244-aztw30-2-0-cust4998.18-1.cable.virginm.net. [86.31.179.135])
        by smtp.gmail.com with ESMTPSA id s10sm4583941wrv.56.2019.03.18.12.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 12:40:57 -0700 (PDT)
From:   Peter Griffin <peter.griffin@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, p.zabel@pengutronix.de, xuwei5@hisilicon.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     john.stultz@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        yuq825@gmail.com
Subject: [PATCH v1 4/6] reset: hi6220: Add support for AO reset controller
Date:   Mon, 18 Mar 2019 19:38:49 +0000
Message-Id: <1552937931-23050-5-git-send-email-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552937931-23050-1-git-send-email-peter.griffin@linaro.org>
References: <1552937931-23050-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required to bring Mali450 gpu out of reset.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/reset/hisilicon/hi6220_reset.c | 51 +++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/hisilicon/hi6220_reset.c b/drivers/reset/hisilicon/hi6220_reset.c
index d5e5229..0cd5f92 100644
--- a/drivers/reset/hisilicon/hi6220_reset.c
+++ b/drivers/reset/hisilicon/hi6220_reset.c
@@ -36,6 +36,7 @@
 enum hi6220_reset_ctrl_type {
 	PERIPHERAL,
 	MEDIA,
+	AO,
 };
 
 struct hi6220_reset_data {
@@ -95,6 +96,47 @@ static const struct reset_control_ops hi6220_media_reset_ops = {
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
+	ret |= regmap_write(regmap, AO_SCTRL_SC_PW_ISOEN0, BIT(idx));
+	ret |= regmap_write(regmap, AO_SCTRL_SC_PW_CLKDIS0, BIT(idx));
+	return ret;
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
+	ret |= regmap_write(regmap, AO_SCTRL_SC_PW_ISODIS0, BIT(idx));
+	ret |= regmap_write(regmap, AO_SCTRL_SC_PW_CLKEN0, BIT(idx));
+	return ret;
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
@@ -120,9 +162,12 @@ static int hi6220_reset_probe(struct platform_device *pdev)
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
@@ -137,6 +182,10 @@ static const struct of_device_id hi6220_reset_match[] = {
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

