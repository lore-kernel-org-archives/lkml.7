Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5F9C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58EA206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="YON/zl/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfDOH3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:29:54 -0400
Received: from onstation.org ([52.200.56.107]:59946 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbfDOH3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:29:34 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id CAFB344714;
        Mon, 15 Apr 2019 07:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1555313373;
        bh=OKIVvQKYI6RV/fYWf5e0nrU27TDvBuXFNlS0LaeWJTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YON/zl/5zrZ5hMv/k5dDVakUJWTcTNK4kWn73EhLY+Ds2fEGB2G8TD5TkE9dqpkzo
         t5ry774aghfwLl8q4F9QUNzA4cmQnInN3H/dPdRoJFzy5T/zooet2EriBeb63U8R54
         76LugGLZ6Sz33k4Y7vddc50ZNTGG/cxDQKMNPIwE=
From:   Brian Masney <masneyb@onstation.org>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, robh+dt@kernel.org
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dmurphy@ti.com, jonathan@marek.ca
Subject: [PATCH v3 1/3] backlight: lm3630a: return 0 on success in update_status functions
Date:   Mon, 15 Apr 2019 03:29:03 -0400
Message-Id: <20190415072905.2861-2-masneyb@onstation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190415072905.2861-1-masneyb@onstation.org>
References: <20190415072905.2861-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lm3630a_bank_a_update_status() and lm3630a_bank_b_update_status()
both return the brightness value if the brightness was successfully
updated. Writing to these attributes via sysfs would cause a 'Bad
address' error to be returned. These functions should return 0 on
success, so let's change it to correct that error.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Fixes: 28e64a68a2ef ("backlight: lm3630: apply chip revision")
Acked-by: Pavel Machek <pavel@ucw.cz>
---
Changes since v2:
- None

 drivers/video/backlight/lm3630a_bl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 2030a6b77a09..ef2553f452ca 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -201,7 +201,7 @@ static int lm3630a_bank_a_update_status(struct backlight_device *bl)
 				      LM3630A_LEDA_ENABLE, LM3630A_LEDA_ENABLE);
 	if (ret < 0)
 		goto out_i2c_err;
-	return bl->props.brightness;
+	return 0;
 
 out_i2c_err:
 	dev_err(pchip->dev, "i2c failed to access\n");
@@ -278,7 +278,7 @@ static int lm3630a_bank_b_update_status(struct backlight_device *bl)
 				      LM3630A_LEDB_ENABLE, LM3630A_LEDB_ENABLE);
 	if (ret < 0)
 		goto out_i2c_err;
-	return bl->props.brightness;
+	return 0;
 
 out_i2c_err:
 	dev_err(pchip->dev, "i2c failed to access REG_CTRL\n");
-- 
2.20.1

