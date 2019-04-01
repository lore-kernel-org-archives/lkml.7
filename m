Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABACC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF2020883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="pbtTnCsW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbfDASSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:18:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43383 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbfDASS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:18:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id k17so13263144wrx.10;
        Mon, 01 Apr 2019 11:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R3qyE9o38IDDNxrUGtndSazeFTGkJiWYDt06NFgE664=;
        b=pbtTnCsWDQS+aT0oYhysB5TgrP5wDENRI6k/RVJRyFf1U5/o1aztpYHNElAbZ8g0s9
         swcHcBB2+wrbL3UzGzwsjSxQEXTIIu5VRW/MZo6+2Y9HyycC0ObQvL1qkw1/ig+TMFNx
         lz+qnd8JRP1ab38lILK1xi9tQzWJwFtIbnawR78ir3t6tNnE79S1xIQq84LntWrUFwwm
         FwA175mB0Z+04Kt06Z1WRbsHR44RJFNVo6s3v5dbDa/VqyFdXaVFZAqZl+qhZ7zFRvXg
         9EjY8ARRjZbj8wrBRTn2eCuVnjlc59bHI1ATZ+dv6s5jNdgQVotCF+7HM9gPO4WrR+C+
         XurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R3qyE9o38IDDNxrUGtndSazeFTGkJiWYDt06NFgE664=;
        b=ltdBGCtJ7TwnK12tf6IkSK29q76FtSYsVwXwbXsIBHFyNllOCgaLvg48I042XpeKCp
         xrpOzKa409JL0krSKsdFa4n0cKTccgAEYnA1Pugqq4ME37hCs+BMXsmAMC1Lvx6d9GHd
         knUk8dk3G9G9Mz7H2tCYm/1nZ68qD1vlsyIeMI0r4ICrsVsB1dRtF3CMuhpxJBOIXLCG
         d/QYMUhAOLyhD950d2ssUHaQaqfgYL+dxukBG4aAcaQduLpdjyjtwqnXdD1cvstL7BlW
         oOJ8wPXr2wUi0G9kbvsuDOfGeVHMjPn0LyHCeCWme0EbeVCzxvX7RKTycdddW1CZx3Zu
         JjHQ==
X-Gm-Message-State: APjAAAW4jyfOOEsnmBW5NUK9ZD7Y2QWRn4SEq71WbrZNBl/p3aU2hDso
        LIEo+NPReIqJ66ul7bybV5s=
X-Google-Smtp-Source: APXvYqxtLgmKu8IHhS83CT8F1S3O85W6YkaL6iYFw1+MwLNKYEaYAHhO9W2z5afn1DgfwXFP4SOzYQ==
X-Received: by 2002:a5d:488d:: with SMTP id g13mr28855114wrq.119.1554142706290;
        Mon, 01 Apr 2019 11:18:26 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD73A0800C9C8A7BE25478D36.dip0.t-ipconnect.de. [2003:dc:d73a:800:c9c8:a7be:2547:8d36])
        by smtp.googlemail.com with ESMTPSA id h10sm18131127wrs.27.2019.04.01.11.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 11:18:25 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u.kleine-koenig@pengutronix.de, bichao.zheng@amlogic.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/2] pwm: meson: don't disable pwm when setting duty repeatedly
Date:   Mon,  1 Apr 2019 20:18:17 +0200
Message-Id: <20190401181817.11999-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401181817.11999-1-martin.blumenstingl@googlemail.com>
References: <20190401181817.11999-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bichao Zheng <bichao.zheng@amlogic.com>

There is an abnormally low about 20ms,when setting duty repeatedly.
Because setting the duty will disable pwm and then enable. Delete
this operation now.

Fixes: 211ed630753d2f ("pwm: Add support for Meson PWM Controller")
Signed-off-by: Bichao Zheng <bichao.zheng@amlogic.com>
[ Dropped code instead of hiding it behind a comment ]
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pwm/pwm-meson.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 4b708c1fcb1d..e247ab632530 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -325,11 +325,6 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (state->period != channel->state.period ||
 	    state->duty_cycle != channel->state.duty_cycle ||
 	    state->polarity != channel->state.polarity) {
-		if (channel->state.enabled) {
-			meson_pwm_disable(meson, pwm->hwpwm);
-			channel->state.enabled = false;
-		}
-
 		if (state->polarity != channel->state.polarity) {
 			if (state->polarity == PWM_POLARITY_NORMAL)
 				meson->inverter_mask |= BIT(pwm->hwpwm);
-- 
2.21.0

