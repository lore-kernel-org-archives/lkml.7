Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C46CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 03:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4844720857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 03:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qCuw0CXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfCRD1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 23:27:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42649 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbfCRD1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 23:27:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id b2so10370282pgl.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 20:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=p+4/obst91yE3W9s18pW/2gILbG+hmYGbmJadmhDXFA=;
        b=qCuw0CXICsVj+J9u3EJagsHPR6yPv0i24BBaQuglperlznQGIgjscbP9TUlcTsA4Pq
         epVSYE8Y2o0m/On+TOJjHAhXNy2mviar8e2HMcyAvMndPksppn7Y9NWCeU4tv2nOH6bX
         2PUR6IXeaEQHG66/+p0HmyEQwAMxWu8ZWD+oPxWsnWKKUA2nHzoUGa+fxi+p3QV3ohIZ
         Z3RiIUSa0+A+im0tWpzg0h/Qx2+zxKOZymCRBXNti5uu/dAP6bcL/eMCZhwTkdoe4peM
         /hE8wdwbhZoSi8Goaq5Lfcv782Jqtu6B+uRyiJppHT551ZJuY+CdrGnU75h+/vKBFtaU
         ihGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p+4/obst91yE3W9s18pW/2gILbG+hmYGbmJadmhDXFA=;
        b=fBjk9yQhqyDrkOQNdXIDMLe3qCCmvHr1sNhwzt3YL3yMdDRogc1q2E2wQFcbw1cOv0
         EOdTq1UbrkqqFnXKEFqjmwnddbUXw8pjDyWTif1Ej+/J9K8hANgMnnfIXBv9TKQ+JQt8
         annR83LedSNU8HZQ8RZeON0yLGL1LqI7pX35i8c7/u6OuvuKkQUMXcSaJpji/1SgAiey
         bW0tP51EdnyX53AlXOfX9kgQcm5EJ0usLMz6Fstut/sWnS8efW6vpzvUkQ8Dp0ZmA5i1
         9ivNu8OIryXu1JangKecJjcqCfpy96gdWxJJGk6Zg65bbvTJhO6/y3Askf1fva2vsAGu
         O9nA==
X-Gm-Message-State: APjAAAX594Ujkf7j2jPvcrJsZMHWGYrl2P1x+4v9PeVeS8AF8yirfdvX
        JWN70FqbrZuUvWQDxr5wRyAoIA==
X-Google-Smtp-Source: APXvYqyQkxaaxDAVYaq1rnq8U+IU565qNs/YVtCLsGXmNeB5Hghqhnga0dq7BvQk7KZeqEpOUi9hQg==
X-Received: by 2002:a62:3347:: with SMTP id z68mr9713827pfz.76.1552879627071;
        Sun, 17 Mar 2019 20:27:07 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id m79sm27477907pfi.60.2019.03.17.20.27.04
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Mar 2019 20:27:06 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     lee.jones@linaro.org
Cc:     arnd@arndb.de, broonie@kernel.org, orsonzhai@gmail.com,
        baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] mfd: sc27xx: Use SoC compatible string for PMIC devices
Date:   Mon, 18 Mar 2019 11:26:51 +0800
Message-Id: <af33f66a602462f14431e99433324b8523f74f78.1552879519.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should use SoC compatible string in stead of wildcard string for
PMIC child devices.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Hi Lee,

Could you merge this patch into v5.1-rc if no objection from you?
Since our DTS patches had been merged into v5.1, our PMIC can not
work without this patch. Thanks.
---
 drivers/mfd/sprd-sc27xx-spi.c |   42 ++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index 69df277..43ac716 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -53,67 +53,67 @@ struct sprd_pmic_data {
 static const struct mfd_cell sprd_pmic_devs[] = {
 	{
 		.name = "sc27xx-wdt",
-		.of_compatible = "sprd,sc27xx-wdt",
+		.of_compatible = "sprd,sc2731-wdt",
 	}, {
 		.name = "sc27xx-rtc",
-		.of_compatible = "sprd,sc27xx-rtc",
+		.of_compatible = "sprd,sc2731-rtc",
 	}, {
 		.name = "sc27xx-charger",
-		.of_compatible = "sprd,sc27xx-charger",
+		.of_compatible = "sprd,sc2731-charger",
 	}, {
 		.name = "sc27xx-chg-timer",
-		.of_compatible = "sprd,sc27xx-chg-timer",
+		.of_compatible = "sprd,sc2731-chg-timer",
 	}, {
 		.name = "sc27xx-fast-chg",
-		.of_compatible = "sprd,sc27xx-fast-chg",
+		.of_compatible = "sprd,sc2731-fast-chg",
 	}, {
 		.name = "sc27xx-chg-wdt",
-		.of_compatible = "sprd,sc27xx-chg-wdt",
+		.of_compatible = "sprd,sc2731-chg-wdt",
 	}, {
 		.name = "sc27xx-typec",
-		.of_compatible = "sprd,sc27xx-typec",
+		.of_compatible = "sprd,sc2731-typec",
 	}, {
 		.name = "sc27xx-flash",
-		.of_compatible = "sprd,sc27xx-flash",
+		.of_compatible = "sprd,sc2731-flash",
 	}, {
 		.name = "sc27xx-eic",
-		.of_compatible = "sprd,sc27xx-eic",
+		.of_compatible = "sprd,sc2731-eic",
 	}, {
 		.name = "sc27xx-efuse",
-		.of_compatible = "sprd,sc27xx-efuse",
+		.of_compatible = "sprd,sc2731-efuse",
 	}, {
 		.name = "sc27xx-thermal",
-		.of_compatible = "sprd,sc27xx-thermal",
+		.of_compatible = "sprd,sc2731-thermal",
 	}, {
 		.name = "sc27xx-adc",
-		.of_compatible = "sprd,sc27xx-adc",
+		.of_compatible = "sprd,sc2731-adc",
 	}, {
 		.name = "sc27xx-audio-codec",
-		.of_compatible = "sprd,sc27xx-audio-codec",
+		.of_compatible = "sprd,sc2731-audio-codec",
 	}, {
 		.name = "sc27xx-regulator",
-		.of_compatible = "sprd,sc27xx-regulator",
+		.of_compatible = "sprd,sc2731-regulator",
 	}, {
 		.name = "sc27xx-vibrator",
-		.of_compatible = "sprd,sc27xx-vibrator",
+		.of_compatible = "sprd,sc2731-vibrator",
 	}, {
 		.name = "sc27xx-keypad-led",
-		.of_compatible = "sprd,sc27xx-keypad-led",
+		.of_compatible = "sprd,sc2731-keypad-led",
 	}, {
 		.name = "sc27xx-bltc",
-		.of_compatible = "sprd,sc27xx-bltc",
+		.of_compatible = "sprd,sc2731-bltc",
 	}, {
 		.name = "sc27xx-fgu",
-		.of_compatible = "sprd,sc27xx-fgu",
+		.of_compatible = "sprd,sc2731-fgu",
 	}, {
 		.name = "sc27xx-7sreset",
-		.of_compatible = "sprd,sc27xx-7sreset",
+		.of_compatible = "sprd,sc2731-7sreset",
 	}, {
 		.name = "sc27xx-poweroff",
-		.of_compatible = "sprd,sc27xx-poweroff",
+		.of_compatible = "sprd,sc2731-poweroff",
 	}, {
 		.name = "sc27xx-syscon",
-		.of_compatible = "sprd,sc27xx-syscon",
+		.of_compatible = "sprd,sc2731-syscon",
 	},
 };
 
-- 
1.7.9.5

