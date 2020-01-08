Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2D2C33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7BD2077B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="QcHkucgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgAHBn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 20:43:28 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38329 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgAHBn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 20:43:28 -0500
Received: by mail-pl1-f195.google.com with SMTP id f20so438354plj.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 17:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=spfY7D/FNI5gIKHICDFwu+Xdo8HUZHocUVySs6C8SL8=;
        b=QcHkucgf0gmzc/UHIlMiHT0Zs5zevnHdrAKbWR4au2r/kpOKK7wI8OSYbnhWlNRw2R
         SwK+vwwTu3IluZDR1o5rCp0TyOJ1xWsxptsWHdNModvZElXfh2kb4Fvm8IFWS848ISVr
         Q6xwnUH2BCxDxxKctixgdZ0YPfVJ0YFmGXHp5XD7F6PbEvwfoSVkjN0XGgtgfubdo8xp
         BSbvoCfn+RQRe9soyTR4kgsAC3R4Xor5cWnmp4w5xcTQ1cvnMfjBFUNqBZTm1uF2MqXz
         y4+y++4zdDH2tetig3gJQp8ZreERHgstVt9z8hwcMkSiGEia4b9wdbmiMQRf9MqMTYkf
         vDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=spfY7D/FNI5gIKHICDFwu+Xdo8HUZHocUVySs6C8SL8=;
        b=aNi5XlzVUnIPiZ0UUmWdNJwZ0mPDz/qN6NnMeMeC/zoHYOe4JiaFHLmDG312o1pCT1
         l68zsTrVQN6gDrVOKx4bVg3N7z4em0PNrb9BURv6BTbTts+SlmiNmx7Nxh+mxCSsdcFZ
         vvgZZ+xc1dY9QGzQVKrcFuSaNPZ2Qd7KY5/EUj9MA6VPkBvp1fJ6jUU+cSzFm2zzOTsE
         LiD9ZmNOdij3278E92AIoy5EecJUUelFokaK++hiRsR+vsKzxFkkWrA/wPGNVBfa2Jqk
         hlh6BpkzGCSe/4gQuIln5t0tjQyzSLmz8zUQgEdqOYPABpGQyEOzRALZHHQD1JGh5JJs
         qfjg==
X-Gm-Message-State: APjAAAVFHC+ABKTr+Wlo6RCRRbyFebmczsFL6+dH/QaHxwasO2UlgRpr
        Qm4dBcA+e9+1AOzWcDqvC1zA5Mh4esw=
X-Google-Smtp-Source: APXvYqx8FppAeuLTUK+Tq8ybPzIYA1EMDxjzWw/AKfeaLwmadbX8QIcZn2JZH9FVngSnCVUZpR8izQ==
X-Received: by 2002:a17:90a:b10a:: with SMTP id z10mr1676174pjq.115.1578447807092;
        Tue, 07 Jan 2020 17:43:27 -0800 (PST)
Received: from localhost.localdomain (118-171-129-36.dynamic-ip.hinet.net. [118.171.129.36])
        by smtp.gmail.com with ESMTPSA id u18sm1064511pgn.9.2020.01.07.17.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 17:43:26 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: bd718x7: Simplify the code by removing struct bd718xx_pmic_inits
Date:   Wed,  8 Jan 2020 09:42:55 +0800
Message-Id: <20200108014256.11282-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nowdays ROHM_CHIP_TYPE_AMOUNT includes not only BD71837/BD71847 but also
BD70528/BD71828 which are not supported by this driver. So it seems not
necessay to have pmic_regulators[ROHM_CHIP_TYPE_AMOUNT] as mapping table.
Simplify the code by removing struct bd718xx_pmic_inits and
pmic_regulators[ROHM_CHIP_TYPE_AMOUNT].

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/bd718x7-regulator.c | 34 +++++++++++----------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index 13a43eee2e46..8f9b2d8eaf10 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -1142,28 +1142,14 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 	},
 };
 
-struct bd718xx_pmic_inits {
-	const struct bd718xx_regulator_data *r_datas;
-	unsigned int r_amount;
-};
-
 static int bd718xx_probe(struct platform_device *pdev)
 {
 	struct bd718xx *mfd;
 	struct regulator_config config = { 0 };
-	struct bd718xx_pmic_inits pmic_regulators[ROHM_CHIP_TYPE_AMOUNT] = {
-		[ROHM_CHIP_TYPE_BD71837] = {
-			.r_datas = bd71837_regulators,
-			.r_amount = ARRAY_SIZE(bd71837_regulators),
-		},
-		[ROHM_CHIP_TYPE_BD71847] = {
-			.r_datas = bd71847_regulators,
-			.r_amount = ARRAY_SIZE(bd71847_regulators),
-		},
-	};
-
 	int i, j, err;
 	bool use_snvs;
+	const struct bd718xx_regulator_data *reg_data;
+	unsigned int num_reg_data;
 
 	mfd = dev_get_drvdata(pdev->dev.parent);
 	if (!mfd) {
@@ -1172,8 +1158,16 @@ static int bd718xx_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	if (mfd->chip.chip_type >= ROHM_CHIP_TYPE_AMOUNT ||
-	    !pmic_regulators[mfd->chip.chip_type].r_datas) {
+	switch (mfd->chip.chip_type) {
+	case ROHM_CHIP_TYPE_BD71837:
+		reg_data = bd71837_regulators;
+		num_reg_data = ARRAY_SIZE(bd71837_regulators);
+		break;
+	case ROHM_CHIP_TYPE_BD71847:
+		reg_data = bd71847_regulators;
+		num_reg_data = ARRAY_SIZE(bd71847_regulators);
+		break;
+	default:
 		dev_err(&pdev->dev, "Unsupported chip type\n");
 		err = -EINVAL;
 		goto err;
@@ -1215,13 +1209,13 @@ static int bd718xx_probe(struct platform_device *pdev)
 		}
 	}
 
-	for (i = 0; i < pmic_regulators[mfd->chip.chip_type].r_amount; i++) {
+	for (i = 0; i < num_reg_data; i++) {
 
 		const struct regulator_desc *desc;
 		struct regulator_dev *rdev;
 		const struct bd718xx_regulator_data *r;
 
-		r = &pmic_regulators[mfd->chip.chip_type].r_datas[i];
+		r = &reg_data[i];
 		desc = &r->desc;
 
 		config.dev = pdev->dev.parent;
-- 
2.20.1

