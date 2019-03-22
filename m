Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6788AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D4121939
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255851;
	bh=O+mFF63t0itZivdKTWeOADMf8IZoj+363RAuXPkeDfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z8/R1I4c52MBMJQoWAqlHlcbXxo3dzrtpHDCoGox8fIbFl70sSbCm4Kbw5ydX2nvc
	 fctYV6JSzY9uj38MW1R5A+HlQCgfgd35uidEXckWZikxmsBkVeNyMUQCLsXleczSWG
	 Zjesd8MqRhzJPrTXyX+7Zt68crOSArp5V3zhHkj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387665AbfCVL53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:57:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387636AbfCVL5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:57:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59A3A2192B;
        Fri, 22 Mar 2019 11:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255844;
        bh=O+mFF63t0itZivdKTWeOADMf8IZoj+363RAuXPkeDfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kS4dJ4lWD+ab1oxOVSRupVGDVyZV86dvtnDvR+YVvY1BrgTXvO41YyKgQvrSmynFO
         HsxbGUYwkHHTXhWS5inzIHd7H6jVHbkG27ygGeeUBGegRFW7bHMOSDQ9EWWgnjaYHW
         MlnCuADdu7WjVyuGIh1oT7337TIWLhQzHsJk7bUc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 032/280] Input: pwm-vibra - prevent unbalanced regulator
Date:   Fri, 22 Mar 2019 12:13:05 +0100
Message-Id: <20190322111308.113084697@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



