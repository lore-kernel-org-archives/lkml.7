Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59CD3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E35121850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="swR6sdEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731983AbfB1Nle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:41:34 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41349 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfB1Nld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:41:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id d25so9749571pfn.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 05:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vtTGwUejXgguh3usIOSkA2LjGatLjq9nOVtB790HeP8=;
        b=swR6sdEvXmYxCRoKQtS7cqbj26KsVI0EgGKujtUSW0ez5gQulX6G7GrmV/kgGEghnr
         uMKvI5uLQFUw5zSjIgixrteq+YtcWGacUbRQiRESjKbmrYVSm3IA4tWvSUAkEdHFo4V8
         ea7H/WfegBjDQZZTNtB/05o3ziiDwoAxCZIBEyeF8W4loNwY5mkrIbARYBx9HzRBn02h
         v4zbAVyHNMIriyYM6Q/OdfDzxCd48tPbVcGuiHbuXTRL5UOQ030mH/8B345QthsbDxDz
         c5ilftyMz+Gqw4n0qveGKrc80iqCQC7DkfKTEvxwMiJ00EAOn7EwOL7AYprooxY8HDSS
         M2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vtTGwUejXgguh3usIOSkA2LjGatLjq9nOVtB790HeP8=;
        b=Ry/7RV1q/Sw6Oc2mehyApygmecFrdTtjlhXy73lEfhxfs0uPCf39U5KyeYQxo9HhHu
         xr1RMAIAcGrZzeRkEnxdwVQ2vevN4a4xKyPsPCLam5TAif8RbLqLky0+uWW8i/zjZ+DL
         w+IqWjth0s06yFS3MFVPoOKAky3zJHZLMpWQXWtK7RsZU7xFAm/H8InYUyjwKjUls1Kn
         Jb+bba4q5nojhsSx4iL7PM0R45cF6YpB9lvDIoaOuxCam93lyLfpNqaMqFLWevTsADdz
         53uGwGNcDbMEdGZv6uml6/muIqTQhcoTgFsYrBWajtfAY838CfHWC0EYcO7vRbVguLeI
         Bk4Q==
X-Gm-Message-State: AHQUAuZtL7GLKo9AhFyY9JxWe0f6eYK1Tgjl5iTjegVTU//tnU4bOBgx
        j+avpQ641heIFWnULJqLAPZF8g==
X-Google-Smtp-Source: AHgI3IaGd8fAhGRSfwOFXNo+o+XKWOEfbfMqKhdT/uiS8b+oBzs4D58yV0YHBjrXv1oy4IBujTQs0Q==
X-Received: by 2002:a62:6453:: with SMTP id y80mr7421268pfb.203.1551361292437;
        Thu, 28 Feb 2019 05:41:32 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e706-b6eb-8c00-6a08-1689-4d5a.emome-ip6.hinet.net. [2001:b400:e706:b6eb:8c00:6a08:1689:4d5a])
        by smtp.gmail.com with ESMTPSA id 186sm36777133pga.36.2019.02.28.05.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:41:31 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        patches@opensource.cirrus.com,
        Ashish Jangam <ashish.jangam@kpitcummins.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Paul Kocialkowski <contact@paulk.fr>,
        Milo Kim <milo.kim@ti.com>, Keerthy <j-keerthy@ti.com>,
        James Ban <James.Ban.opensource@diasemi.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 11/11] regulator: wm831x-dcdc: Convert to use regulator_set/get_current_limit_regmap
Date:   Thu, 28 Feb 2019 21:40:22 +0800
Message-Id: <20190228134022.32625-12-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228134022.32625-1-axel.lin@ingics.com>
References: <20190228134022.32625-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator_set/get_current_limit_regmap helpers to save some code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/wm831x-dcdc.c | 42 +++++----------------------------
 1 file changed, 6 insertions(+), 36 deletions(-)

diff --git a/drivers/regulator/wm831x-dcdc.c b/drivers/regulator/wm831x-dcdc.c
index 828f262d6be0..12b422373580 100644
--- a/drivers/regulator/wm831x-dcdc.c
+++ b/drivers/regulator/wm831x-dcdc.c
@@ -308,48 +308,14 @@ static const unsigned int wm831x_dcdc_ilim[] = {
 	125000, 250000, 375000, 500000, 625000, 750000, 875000, 1000000
 };
 
-static int wm831x_buckv_set_current_limit(struct regulator_dev *rdev,
-					   int min_uA, int max_uA)
-{
-	struct wm831x_dcdc *dcdc = rdev_get_drvdata(rdev);
-	struct wm831x *wm831x = dcdc->wm831x;
-	u16 reg = dcdc->base + WM831X_DCDC_CONTROL_2;
-	int i;
-
-	for (i = ARRAY_SIZE(wm831x_dcdc_ilim) - 1; i >= 0; i--) {
-		if ((min_uA <= wm831x_dcdc_ilim[i]) &&
-		    (wm831x_dcdc_ilim[i] <= max_uA))
-			return wm831x_set_bits(wm831x, reg,
-					       WM831X_DC1_HC_THR_MASK,
-						i << WM831X_DC1_HC_THR_SHIFT);
-	}
-
-	return -EINVAL;
-}
-
-static int wm831x_buckv_get_current_limit(struct regulator_dev *rdev)
-{
-	struct wm831x_dcdc *dcdc = rdev_get_drvdata(rdev);
-	struct wm831x *wm831x = dcdc->wm831x;
-	u16 reg = dcdc->base + WM831X_DCDC_CONTROL_2;
-	int val;
-
-	val = wm831x_reg_read(wm831x, reg);
-	if (val < 0)
-		return val;
-
-	val = (val & WM831X_DC1_HC_THR_MASK) >> WM831X_DC1_HC_THR_SHIFT;
-	return wm831x_dcdc_ilim[val];
-}
-
 static const struct regulator_ops wm831x_buckv_ops = {
 	.set_voltage_sel = wm831x_buckv_set_voltage_sel,
 	.get_voltage_sel = wm831x_buckv_get_voltage_sel,
 	.list_voltage = regulator_list_voltage_linear_range,
 	.map_voltage = regulator_map_voltage_linear_range,
 	.set_suspend_voltage = wm831x_buckv_set_suspend_voltage,
-	.set_current_limit = wm831x_buckv_set_current_limit,
-	.get_current_limit = wm831x_buckv_get_current_limit,
+	.set_current_limit = regulator_set_current_limit_regmap,
+	.get_current_limit = regulator_get_current_limit_regmap,
 
 	.is_enabled = regulator_is_enabled_regmap,
 	.enable = regulator_enable_regmap,
@@ -475,6 +441,10 @@ static int wm831x_buckv_probe(struct platform_device *pdev)
 	dcdc->desc.owner = THIS_MODULE;
 	dcdc->desc.enable_reg = WM831X_DCDC_ENABLE;
 	dcdc->desc.enable_mask = 1 << id;
+	dcdc->desc.csel_reg = dcdc->base + WM831X_DCDC_CONTROL_2;
+	dcdc->desc.csel_mask = WM831X_DC1_HC_THR_MASK;
+	dcdc->desc.n_current_limits = ARRAY_SIZE(wm831x_dcdc_ilim);
+	dcdc->desc.curr_table = wm831x_dcdc_ilim;
 
 	ret = wm831x_reg_read(wm831x, dcdc->base + WM831X_DCDC_ON_CONFIG);
 	if (ret < 0) {
-- 
2.17.1

