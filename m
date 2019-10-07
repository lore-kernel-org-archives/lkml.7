Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1F9C352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4161E21835
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="TeiGFPbc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfJGLuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:50:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37853 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfJGLuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:50:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id p1so6282070pgi.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 04:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AhK3JnyGUW7qZJr60DzEXut5NcyNr8gmHXJ+FQkaXK8=;
        b=TeiGFPbc5aUsownF4GnzWm4qBIKX82ftwgNpgwZRGEhgagIJgwjrtfnF6zfOwZZDSN
         y/jvz0eQ0Bvoc9PpzwVyzrFRKHfux4m4vfSL0XebCwHWQBK/kBiKziMRICyEug3b9DNe
         A8gOzjiQqI1v1OcXA+k3B6VIzAoOVOL0bPn/G0SpMlh+m1P7nlQsBG7Nf8sA516C3wY9
         beqPwEhWCpm7A2G6ikqbEwmnTNNwwyUg5WSIuW8Rkn4Kmju9XGnMaIBUK+2Y0+TqvDEZ
         mEGW9yivyPmVOyROqVZyryFF7K24xqSsmj2RPuh4NAReceMGaeC1qlODjIFYjOZuIwU4
         A0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AhK3JnyGUW7qZJr60DzEXut5NcyNr8gmHXJ+FQkaXK8=;
        b=EZXKaraIhFzXGsyPOB7/8oI082CkmqOaUVtPhC+Mr/bX3LexrfZLjVa1QkLVo09rTK
         cqSG9SLTwUHiHEwQ5ecEbYaJ8NlxbyqWa2OnHWZoBCK2u0uJvNNAAWgnxh5ETjIgiQHZ
         qSOOzWvvLsv8dKQ3Bcuozpa/5MknwVBn+EluQhYbtflfpl9qDv5QCCvP39kNqVR1sqJn
         C7ZUuGNtccI2XhRxDGb9VzK+1mj4T0oK9uiucDzVnUCoRXADRIalzXe2f9vvm7h5urUS
         /tw/GAkhvEswVeEiEftC0LN4FwBwu7s6hxeJyGMbJhulH1RmEY0BILcSqMA0xd6lK9wm
         /g8w==
X-Gm-Message-State: APjAAAUwLJImFEUUFM+drzsuGRYbAc33xeVFZ0oXnn02dUueS7bbQ3pV
        m+qGaqW81easTN2/w8m5ltEIJw==
X-Google-Smtp-Source: APXvYqxAqhQ1WWWLnH/4uMiXuYfqUmTwgIcgfloZuzMHqPaVwfsFJtoE1yFHw+TSZrhoumrFRvBY2w==
X-Received: by 2002:a17:90a:c383:: with SMTP id h3mr34060184pjt.14.1570449020514;
        Mon, 07 Oct 2019 04:50:20 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id e21sm10986067pgk.57.2019.10.07.04.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 04:50:20 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Steve Twiss <stwiss.opensource@diasemi.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [RESEND][PATCH 2/2] regulator: da9062: Simplify da9062_buck_set_mode for BUCK_MODE_MANUAL case
Date:   Mon,  7 Oct 2019 19:50:09 +0800
Message-Id: <20191007115009.25672-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191007115009.25672-1-axel.lin@ingics.com>
References: <20191007115009.25672-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sleep flag bit decides the mode for BUCK_MODE_MANUAL case, simplify
the logic as the result is the same.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
This was sent on https://lkml.org/lkml/2019/9/26/24 with Adam's Review.
 drivers/regulator/da9062-regulator.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index 9bb895006455..4b24518f75b5 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -136,7 +136,7 @@ static int da9062_buck_set_mode(struct regulator_dev *rdev, unsigned mode)
 static unsigned da9062_buck_get_mode(struct regulator_dev *rdev)
 {
 	struct da9062_regulator *regl = rdev_get_drvdata(rdev);
-	unsigned int val, mode = 0;
+	unsigned int val;
 	int ret;
 
 	ret = regmap_field_read(regl->mode, &val);
@@ -146,7 +146,6 @@ static unsigned da9062_buck_get_mode(struct regulator_dev *rdev)
 	switch (val) {
 	default:
 	case BUCK_MODE_MANUAL:
-		mode = REGULATOR_MODE_FAST | REGULATOR_MODE_STANDBY;
 		/* Sleep flag bit decides the mode */
 		break;
 	case BUCK_MODE_SLEEP:
@@ -162,11 +161,9 @@ static unsigned da9062_buck_get_mode(struct regulator_dev *rdev)
 		return 0;
 
 	if (val)
-		mode &= REGULATOR_MODE_STANDBY;
+		return REGULATOR_MODE_STANDBY;
 	else
-		mode &= REGULATOR_MODE_NORMAL | REGULATOR_MODE_FAST;
-
-	return mode;
+		return REGULATOR_MODE_FAST;
 }
 
 /*
-- 
2.20.1

