Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621CFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3905B2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334873;
	bh=5oZYfJ9/oa6CVJCyhd7FQwoWxRUpD40wPy1ruGJIUvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PzdTf1fH+Mr/HctmtIJS/EvHSvEentjo8G7q0MNuGgzXx3A5Lr7jkcy5BR4ZV6ZF4
	 m2FWB2JRRW1vINQ6Gh4skZMEDfGLlRiBXUd4gy05BY5RjVr6tIdwsgtviQJHyixCNo
	 3QlNjJ8pGXVWUmV8d2d1UIZFtsHQR5MieQkMcTEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfCKUHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:07:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbfCKT5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:57:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E37F2084F;
        Mon, 11 Mar 2019 19:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334241;
        bh=5oZYfJ9/oa6CVJCyhd7FQwoWxRUpD40wPy1ruGJIUvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zlgWACxRmKtVnOUi1mawiWvLnTC+6kF05SnjVJsA/BDIsF+vMHGR37/I8LQUWdk8h
         6UEMet6y7mfKUPNNbl7n/hAk2/X1SwZ/8bIfCH9TBNqFTUdQnynTnHmCBpg9MLZlca
         s3JrR9qZdOYpmLFzERt3t7UCkWekW06EtezDr4os=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 10/44] Input: pwm-vibra - prevent unbalanced regulator
Date:   Mon, 11 Mar 2019 15:56:26 -0400
Message-Id: <20190311195700.138462-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195700.138462-1-sashal@kernel.org>
References: <20190311195700.138462-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

[ Upstream commit 3ca232df9921f083c3b37ba5fbc76f4d9046268b ]

pwm_vibrator_stop disables the regulator, but it can be called from
multiple places, even when the regulator is already disabled. Fix this
by using regulator_is_enabled check when starting and stopping device.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/misc/pwm-vibra.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/input/misc/pwm-vibra.c b/drivers/input/misc/pwm-vibra.c
index 55da191ae550..9df87431d7d4 100644
--- a/drivers/input/misc/pwm-vibra.c
+++ b/drivers/input/misc/pwm-vibra.c
@@ -34,6 +34,7 @@ struct pwm_vibrator {
 	struct work_struct play_work;
 	u16 level;
 	u32 direction_duty_cycle;
+	bool vcc_on;
 };
 
 static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
@@ -42,10 +43,13 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
 	struct pwm_state state;
 	int err;
 
-	err = regulator_enable(vibrator->vcc);
-	if (err) {
-		dev_err(pdev, "failed to enable regulator: %d", err);
-		return err;
+	if (!vibrator->vcc_on) {
+		err = regulator_enable(vibrator->vcc);
+		if (err) {
+			dev_err(pdev, "failed to enable regulator: %d", err);
+			return err;
+		}
+		vibrator->vcc_on = true;
 	}
 
 	pwm_get_state(vibrator->pwm, &state);
@@ -76,7 +80,10 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
 
 static void pwm_vibrator_stop(struct pwm_vibrator *vibrator)
 {
-	regulator_disable(vibrator->vcc);
+	if (vibrator->vcc_on) {
+		regulator_disable(vibrator->vcc);
+		vibrator->vcc_on = false;
+	}
 
 	if (vibrator->pwm_dir)
 		pwm_disable(vibrator->pwm_dir);
-- 
2.19.1

