Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E768C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619A420815
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fLMsHHSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbfJASVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:21:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43379 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfJASVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 14:21:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id v27so10220971pgk.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 11:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gndIBZtxkWWYIAzCuv66ix3JWZKnnzO2W2vxGiAxUeY=;
        b=fLMsHHSkJQboFI/k5HicWHXG9rpQ4fTqhj5TQzrFXS/42QyqM7KE9ZH3kDzuYKxyeA
         al4S5uKvNB/A4Qde3e4x/ER4T2MYRZA8vMlWtfIXIHA8hJmSwjUL3UOKjQ2Lm2Uevccs
         dh4SZgcSRrKXNHYgCRHqyD3sdac1+Cw8fyru6QzVWeakRwE0EFFfqbmn78ijiX5Zw0yl
         HgZziPyFCONM67zfgoLqarfVoDM3kDp6qL7o/NzDcjrUGxD/6u41XXp8xa4xgaGc0Flq
         KdevpQUe7Huvq5CkcHpoDhEEQoD6qCylNHEdoVWwoRbpwDG4gCxthpBYHHT5KpyOJxi3
         RgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gndIBZtxkWWYIAzCuv66ix3JWZKnnzO2W2vxGiAxUeY=;
        b=IRYf+knHKu3VHzJ/cP62trMFFM6OLNHfCb7fWjZ0/LcUvw8AC1fv24iDzBL2iZhVoe
         zCHHrOyeYk9bSj74jIawZ7KK7W/3p146pTSOS4LYJI0xHHPZM7u7GP9GBKx7uNMxDC1K
         DjCK5cw3WE41gvbQrae6RG8wm2qeDOKr46Gn82jAs/nfGE+N3iuZr7fyDSRVv8M3UroZ
         TFDhi0ZULGioJGepLwDsejOm4QHJcLVHGCVmwXQzaj+G0IaBgxxOyzFAKglHxRlw8l85
         0bE2wPI/kNgW5IcWdemQS9S2OZIsj2ClyLsxtXCvXqjgXLWwg7BewmN6Rl5wb3VEqwfO
         gKRA==
X-Gm-Message-State: APjAAAVuweioDoZAim/VQRJEs5/YIY7jZcE+peey4zw+wI55J/GXAR6j
        6MmEIukmOWYf5xwvTo5PwVfnGhqBgAk=
X-Google-Smtp-Source: APXvYqwFrHFwrmB7SlH39LenzDjCzXbgqSF8QG9ob8+xV1BuJFN58Z4wzP1vqRL8k1G84YCxeyvy+Q==
X-Received: by 2002:a17:90a:26e3:: with SMTP id m90mr7101175pje.57.1569954082118;
        Tue, 01 Oct 2019 11:21:22 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id i10sm15464221pfa.70.2019.10.01.11.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 11:21:21 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Peter Griffin <peter.griffin@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Enrico Weigelt <info@metux.net>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH] reset: hi6220: Add support for AO reset controller
Date:   Tue,  1 Oct 2019 18:21:14 +0000
Message-Id: <20191001182114.69699-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Griffin <peter.griffin@linaro.org>

This is required to bring Mali450 gpu out of reset.

Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: Enrico Weigelt <info@metux.net>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/reset/hisilicon/hi6220_reset.c | 51 +++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/hisilicon/hi6220_reset.c b/drivers/reset/hisilicon/hi6220_reset.c
index 24e6d420b26b..d84674a2cead 100644
--- a/drivers/reset/hisilicon/hi6220_reset.c
+++ b/drivers/reset/hisilicon/hi6220_reset.c
@@ -33,6 +33,7 @@
 enum hi6220_reset_ctrl_type {
 	PERIPHERAL,
 	MEDIA,
+	AO,
 };
 
 struct hi6220_reset_data {
@@ -92,6 +93,47 @@ static const struct reset_control_ops hi6220_media_reset_ops = {
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
+			    unsigned long idx)
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
+			      unsigned long idx)
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
@@ -117,9 +159,12 @@ static int hi6220_reset_probe(struct platform_device *pdev)
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
@@ -134,6 +179,10 @@ static const struct of_device_id hi6220_reset_match[] = {
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
2.17.1

