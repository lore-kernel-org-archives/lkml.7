Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6D7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D61A2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="SiwG4mNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfCLQeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:34:22 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43114 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfCLQeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:34:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id q17so2196301pfh.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 09:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MdlpnDoVo9dKfx/6LIYHmupF9JDmWUniblRplevLAOs=;
        b=SiwG4mNm1wVYXkRMTV/OMGLSk1V2pGzMwt58TANxiu9sUb7W6noOv60+7f2D33Tzts
         K8p47MV9pxhjp1QT0JKZ07Apm+xHwEqMl8QdbpeiL4m297JE8oI/YG/aUFeNNXF07sUo
         DmmjYX2KMkevL63Q+XS6Orgy3TFGrchUND32olB0M9i6PmBXxVgDvDUFohNTqXkfe5xV
         6E5/v9VYFy7Xb3gjwpGOaex/Pm7T/go4yQ0c7Sk6DFzBbH39hMHRk861Er39bs0pMJhp
         ynNKA5+ASBwaqflix38gjasV+3iIqQUgWpG9KTqKxw+TUGdgtOxDDDk9bXLGlUhABNdX
         hGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MdlpnDoVo9dKfx/6LIYHmupF9JDmWUniblRplevLAOs=;
        b=GGGjTk6sZ5iDgJgU2FXoGHMWsAguys5xKrDT+UinTJyo6UyvBzWpZnxnr1XIsBHUgP
         zIYcM/g/Vb/KkxJW5QnF62gBnjzzQ6zf9/qb7qcqODzhC0G1wTna6fbdIVycS+LwV6BW
         5F+QVQM/FWGJFCymZ0mnfWIoeDIopSpHONh9oOE3pEcZeKF9SCaKOC0Oa/gYZbsv7hdd
         sf2zpXS2PItnr+PyAw502BIk2EOrBsBjfUFPDpo5bXYktIcaGXY65g+0ta0vmel34BIX
         NRcaDQJZkjAh0Ie6NwthuG9md7gBfn9nIpp6V3IUa2noWu3nYovCrzT4klZ6DRdRVvuV
         9nVw==
X-Gm-Message-State: APjAAAW3nAhUlI5rix5iFSkCaFQewnl6QI7+TN/AShUWbMeMGAsQy4pX
        PpZH/sZncFkNHVYkDmk10K++QQ==
X-Google-Smtp-Source: APXvYqx6WBKqQHQAUc4+eiO26GIpo4IPRoZiFfjdHp0XjXkfWANQpasU9Yj2JEQjPcJaKJNYPF2QMg==
X-Received: by 2002:a62:3001:: with SMTP id w1mr39537215pfw.59.1552408459179;
        Tue, 12 Mar 2019 09:34:19 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id s79sm17447467pfa.61.2019.03.12.09.34.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 09:34:18 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 4/4] regulator: wm8350: Convert to use regulator_set/get_current_limit_regmap
Date:   Wed, 13 Mar 2019 00:33:57 +0800
Message-Id: <20190312163357.27785-4-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190312163357.27785-1-axel.lin@ingics.com>
References: <20190312163357.27785-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regulator_set/get_current_limit_regmap helpers to save some code.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/wm8350-regulator.c | 81 ++++------------------------
 1 file changed, 11 insertions(+), 70 deletions(-)

diff --git a/drivers/regulator/wm8350-regulator.c b/drivers/regulator/wm8350-regulator.c
index d1758a2bc769..0eb3f3a33caa 100644
--- a/drivers/regulator/wm8350-regulator.c
+++ b/drivers/regulator/wm8350-regulator.c
@@ -28,7 +28,7 @@
 #define WM8350_DCDC_MAX_VSEL 0x66
 
 /* Microamps */
-static const int isink_cur[] = {
+static const unsigned int isink_cur[] = {
 	4,
 	5,
 	6,
@@ -95,73 +95,6 @@ static const int isink_cur[] = {
 	223191
 };
 
-static int get_isink_val(int min_uA, int max_uA, u16 *setting)
-{
-	int i;
-
-	for (i = ARRAY_SIZE(isink_cur) - 1; i >= 0; i--) {
-		if (min_uA <= isink_cur[i] && max_uA >= isink_cur[i]) {
-			*setting = i;
-			return 0;
-		}
-	}
-	return -EINVAL;
-}
-
-static int wm8350_isink_set_current(struct regulator_dev *rdev, int min_uA,
-	int max_uA)
-{
-	struct wm8350 *wm8350 = rdev_get_drvdata(rdev);
-	int isink = rdev_get_id(rdev);
-	u16 val, setting;
-	int ret;
-
-	ret = get_isink_val(min_uA, max_uA, &setting);
-	if (ret != 0)
-		return ret;
-
-	switch (isink) {
-	case WM8350_ISINK_A:
-		val = wm8350_reg_read(wm8350, WM8350_CURRENT_SINK_DRIVER_A) &
-		    ~WM8350_CS1_ISEL_MASK;
-		wm8350_reg_write(wm8350, WM8350_CURRENT_SINK_DRIVER_A,
-				 val | setting);
-		break;
-	case WM8350_ISINK_B:
-		val = wm8350_reg_read(wm8350, WM8350_CURRENT_SINK_DRIVER_B) &
-		    ~WM8350_CS1_ISEL_MASK;
-		wm8350_reg_write(wm8350, WM8350_CURRENT_SINK_DRIVER_B,
-				 val | setting);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int wm8350_isink_get_current(struct regulator_dev *rdev)
-{
-	struct wm8350 *wm8350 = rdev_get_drvdata(rdev);
-	int isink = rdev_get_id(rdev);
-	u16 val;
-
-	switch (isink) {
-	case WM8350_ISINK_A:
-		val = wm8350_reg_read(wm8350, WM8350_CURRENT_SINK_DRIVER_A) &
-		    WM8350_CS1_ISEL_MASK;
-		break;
-	case WM8350_ISINK_B:
-		val = wm8350_reg_read(wm8350, WM8350_CURRENT_SINK_DRIVER_B) &
-		    WM8350_CS1_ISEL_MASK;
-		break;
-	default:
-		return 0;
-	}
-
-	return isink_cur[val];
-}
-
 /* turn on ISINK followed by DCDC */
 static int wm8350_isink_enable(struct regulator_dev *rdev)
 {
@@ -982,8 +915,8 @@ static const struct regulator_ops wm8350_ldo_ops = {
 };
 
 static const struct regulator_ops wm8350_isink_ops = {
-	.set_current_limit = wm8350_isink_set_current,
-	.get_current_limit = wm8350_isink_get_current,
+	.set_current_limit = regulator_set_current_limit_regmap,
+	.get_current_limit = regulator_get_current_limit_regmap,
 	.enable = wm8350_isink_enable,
 	.disable = wm8350_isink_disable,
 	.is_enabled = wm8350_isink_is_enabled,
@@ -1138,6 +1071,10 @@ static const struct regulator_desc wm8350_reg[NUM_WM8350_REGULATORS] = {
 		.irq = WM8350_IRQ_CS1,
 		.type = REGULATOR_CURRENT,
 		.owner = THIS_MODULE,
+		.curr_table = isink_cur,
+		.n_current_limits = ARRAY_SIZE(isink_cur),
+		.csel_reg = WM8350_CURRENT_SINK_DRIVER_A,
+		.csel_mask = WM8350_CS1_ISEL_MASK,
 	 },
 	{
 		.name = "ISINKB",
@@ -1146,6 +1083,10 @@ static const struct regulator_desc wm8350_reg[NUM_WM8350_REGULATORS] = {
 		.irq = WM8350_IRQ_CS2,
 		.type = REGULATOR_CURRENT,
 		.owner = THIS_MODULE,
+		.curr_table = isink_cur,
+		.n_current_limits = ARRAY_SIZE(isink_cur),
+		.csel_reg = WM8350_CURRENT_SINK_DRIVER_B,
+		.csel_mask = WM8350_CS2_ISEL_MASK,
 	 },
 };
 
-- 
2.17.1

