Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761EBC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C08C218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="i4Ugx0xS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfGCQKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:10:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35216 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfGCQKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:10:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id c6so3038675wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 09:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=faSr0BZdKQhs1RffO7VKhziIeJj2W7NeV4mSOSkM8Kc=;
        b=i4Ugx0xSre9purhJaS7TXq3jMw7lB0quglTs3SY2Ncp2jOkbOttSK7jKJTSw9D9nyH
         /GAhKEiw4qSd/JOpULsQcyIBZIa146V80R9pYdwvzX0WsmCYZTOWmEiEjPY3jr9nPdUv
         mNAg70FdN3cLSoO7yVbgA0+TzjsGS6cYXBcb/bjRHkVKRZIN+DoZxeWl6sFoLozXvM19
         A6WF0RIyNFdaT7Z3ovh/XXTo7NrukCeJnprrN0nWt5cRjrtfYTska4SXWuMMdLISgVK6
         CWndREg6bwwe5h5g9sxG1gKvdPIGh7HVb+pilugPZQKf9VcsxM9nIEEdFE5gTCTA/B1f
         DiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=faSr0BZdKQhs1RffO7VKhziIeJj2W7NeV4mSOSkM8Kc=;
        b=k3izHTG6cRzFyonRqVSQfYwRcQLQlic0zih8rOj15vMQID/5eYBugM69AmDud2om49
         d2ofl5hpMwRUEcX6EryS4NJURUZ79R/k0Bco6UaN1aizGAIBHteDc3Uv2fsG1lmXNC9m
         jM1vbFOyXkXCkr6bEpeYvpffLRUaPpjW9wRgc8DXobjrfELStkrDskCH6SqCeeyRWTHx
         Dzmlfko02mMn24vMDzqFHW9QPIx3D8rXzCzAXOtKaoTYhlcnr/gZON4I8AfI5/AzKQ3q
         /8n38bgaQ0oOVIdRtob06ltiL7S9pyXW0ABRNPCKsUhYT3yMBun3dJgJ+oefkxDAQ7GO
         9SUw==
X-Gm-Message-State: APjAAAWLZXFah+G65R4xOJm803Wk0dcmaYhb01i1vE1d6KuEpKeF5VGU
        D3ZCWfnpnecVqI2ySfM8iusBJ9eEVCc=
X-Google-Smtp-Source: APXvYqxzUWANHJ8G/Rp3zbINFpcs4m28POSnoSZXIH5tU0dWJq0dwq2vrTAV90yCIuIItgzVNdMdpg==
X-Received: by 2002:a1c:be0a:: with SMTP id o10mr8497843wmf.91.1562170241406;
        Wed, 03 Jul 2019 09:10:41 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id t17sm3803572wrs.45.2019.07.03.09.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:10:40 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/2] regulator: implement selector stepping
Date:   Wed,  3 Jul 2019 18:10:34 +0200
Message-Id: <20190703161035.31808-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703161035.31808-1-brgl@bgdev.pl>
References: <20190703161035.31808-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Some regulators require that the requested voltage be reached gradually
by setting all or some of the intermediate values. Implement a new field
in the regulator description struct that allows users to specify the
number of selectors by which the regulator API should step when ramping
the voltage up/down.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/regulator/core.c         | 63 ++++++++++++++++++++++++++++++++
 include/linux/regulator/driver.h |  6 +++
 2 files changed, 69 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 9d3ed13b7f12..df82e2a8442a 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3106,6 +3106,66 @@ static int _regulator_call_set_voltage_sel(struct regulator_dev *rdev,
 	return ret;
 }
 
+static int _regulator_set_voltage_sel_step(struct regulator_dev *rdev,
+					   int uV, int new_selector)
+{
+	const struct regulator_ops *ops = rdev->desc->ops;
+	int diff, old_sel, curr_sel, ret;
+
+	/* Stepping is only needed if the regulator is enabled. */
+	if (!_regulator_is_enabled(rdev))
+		goto final_set;
+
+	if (!ops->get_voltage_sel)
+		return -EINVAL;
+
+	old_sel = ops->get_voltage_sel(rdev);
+	if (old_sel < 0)
+		return old_sel;
+
+	diff = new_selector - old_sel;
+	if (diff == 0)
+		return 0; /* No change needed. */
+
+	if (diff > 0) {
+		/* Stepping up. */
+		for (curr_sel = old_sel + rdev->desc->vsel_step;
+		     curr_sel < new_selector;
+		     curr_sel += rdev->desc->vsel_step) {
+			/*
+			 * Call the callback directly instead of using
+			 * _regulator_call_set_voltage_sel() as we don't
+			 * want to notify anyone yet. Same in the branch
+			 * below.
+			 */
+			ret = ops->set_voltage_sel(rdev, curr_sel);
+			if (ret)
+				goto try_revert;
+		}
+	} else {
+		/* Stepping down. */
+		for (curr_sel = old_sel - rdev->desc->vsel_step;
+		     curr_sel > new_selector;
+		     curr_sel -= rdev->desc->vsel_step) {
+			ret = ops->set_voltage_sel(rdev, curr_sel);
+			if (ret)
+				goto try_revert;
+		}
+	}
+
+final_set:
+	/* The final selector will trigger the notifiers. */
+	return _regulator_call_set_voltage_sel(rdev, uV, new_selector);
+
+try_revert:
+	/*
+	 * At least try to return to the previous voltage if setting a new
+	 * one failed.
+	 */
+	(void)ops->set_voltage_sel(rdev, old_sel);
+	return ret;
+}
+
 static int _regulator_set_voltage_time(struct regulator_dev *rdev,
 				       int old_uV, int new_uV)
 {
@@ -3179,6 +3239,9 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 				selector = ret;
 				if (old_selector == selector)
 					ret = 0;
+				else if (rdev->desc->vsel_step)
+					ret = _regulator_set_voltage_sel_step(
+						rdev, best_val, selector);
 				else
 					ret = _regulator_call_set_voltage_sel(
 						rdev, best_val, selector);
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 377da2357118..f0d7b0496e54 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -286,6 +286,11 @@ enum regulator_type {
  * @vsel_range_mask: Mask for register bitfield used for range selector
  * @vsel_reg: Register for selector when using regulator_regmap_X_voltage_
  * @vsel_mask: Mask for register bitfield used for selector
+ * @vsel_step: Specify the resolution of selector stepping when setting
+ *	       voltage. If 0, then no stepping is done (requested selector is
+ *	       set directly), if >0 then the regulator API will ramp the
+ *	       voltage up/down gradually each time increasing/decreasing the
+ *	       selector by the specified step value.
  * @csel_reg: Register for current limit selector using regmap set_current_limit
  * @csel_mask: Mask for register bitfield used for current limit selector
  * @apply_reg: Register for initiate voltage change on the output when
@@ -360,6 +365,7 @@ struct regulator_desc {
 	unsigned int vsel_range_mask;
 	unsigned int vsel_reg;
 	unsigned int vsel_mask;
+	unsigned int vsel_step;
 	unsigned int csel_reg;
 	unsigned int csel_mask;
 	unsigned int apply_reg;
-- 
2.21.0

