Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5993DC74A52
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 11:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F01520665
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 11:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="Bw634sPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfGKLfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 07:35:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39715 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbfGKLfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 07:35:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so2808949pgi.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 04:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=67fw6QhRHMwWqlxFHVRLJ0hZez6O5OTcXxHcRHOXrRA=;
        b=Bw634sPwkFJg+urMc35C+PN+dJgCSDq+c7FSfQULCXzUlVD/R+BsYhUWWVnDBu7vo0
         mDe3vsF94kpcJRLMUWi1fy2eOaYhh4jW6hVXR+XI5ysmorRSuLR0nK417pzQHlRiMPy2
         X/K6Xna+0l9PvG8RNrh6KJh1jFtTsOK2k1xEIGguD/SQ2AKW8M+87kQ2GIMokUyGRgTm
         e51Qym+vOAV1vqVwkEsmAsVFvu66bL9UPcmoMjvGw6iV7M0pkzldBK+9rFCHTPxcMIpt
         2/NBcrcuSizPAicO+Zaf1aVNxQWJmYam3cV+8RUIf1vrUHJJN+lqQrarLCmuR9OWgsi5
         X8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=67fw6QhRHMwWqlxFHVRLJ0hZez6O5OTcXxHcRHOXrRA=;
        b=HEitnq9QaELHsNEHOg4Ug6ZaOefnLLAZuHyxsyODOWMhPWb29iKvdwYigT5FQl2xFn
         NKzfBN/99hyOANfh+dai153leCYvGMC9/71suCbSgeSaoHvxzBaqKEwLW3cfOJ/dkdlk
         v9JSyXka09zAvf+YZflYHsAC1VEhBiQwMwrxANI8VApIxh45UhOJI63qryfRDIJsjIhC
         HHJ5nzNMy64U9+8qxNWhNlt80u9gMoH+x5Pmz6uJowQdVWY2ZtVcxt3qrFJcn6YEvoHx
         DrR4pBmdhcu2exNTge9OzAN7vzfQg0dqlKng2i7hb4+yKEe1C0jTQRzsTueNlWK3o1Ph
         H8cw==
X-Gm-Message-State: APjAAAUFQKg6+QsBJW5E39c2PxuReBKo0RrWYhL0trEHgDCa09ENeW2l
        9Ln74Uj87hOiDEYVycHcxbM=
X-Google-Smtp-Source: APXvYqyp60bdd7qSmSHug9ug6C8p8ZGfqeTLTLKVzXst++Ph9HoLAjVLMACXBYwSjmGR40rfgzdk5Q==
X-Received: by 2002:a63:3fc9:: with SMTP id m192mr3978050pga.429.1562844932022;
        Thu, 11 Jul 2019 04:35:32 -0700 (PDT)
Received: from localhost.localdomain (36-239-228-246.dynamic-ip.hinet.net. [36.239.228.246])
        by smtp.gmail.com with ESMTPSA id a10sm4529617pgq.2.2019.07.11.04.35.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 04:35:30 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] regulator: lp87565: Fix probe failure for "ti,lp87565"
Date:   Thu, 11 Jul 2019 19:35:17 +0800
Message-Id: <20190711113517.26077-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "ti,lp87565" compatible string is still in of_lp87565_match_table,
but current code will return -EINVAL because lp87565->dev_type is unknown.
This was working in earlier kernel versions, so fix it.

Fixes: 7ee63bd74750 ("regulator: lp87565: Add 4-phase lp87561 regulator support")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Keerthy,
The commit "regulator: lp87565: Add 4-phase lp87561 regulator support" does not
mention why it returns -EINVAL for "ti,lp87565" (The data field is not set for
.compatible = "ti,lp87565"), so I think the support for "ti,lp87565" was accidently
removed.
I don't have this h/w for test, maybe you can test it since you wrote this driver.

 drivers/regulator/lp87565-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
index 5d067f7c2116..0c440c5e2832 100644
--- a/drivers/regulator/lp87565-regulator.c
+++ b/drivers/regulator/lp87565-regulator.c
@@ -163,7 +163,7 @@ static int lp87565_regulator_probe(struct platform_device *pdev)
 	struct lp87565 *lp87565 = dev_get_drvdata(pdev->dev.parent);
 	struct regulator_config config = { };
 	struct regulator_dev *rdev;
-	int i, min_idx = LP87565_BUCK_0, max_idx = LP87565_BUCK_3;
+	int i, min_idx, max_idx;
 
 	platform_set_drvdata(pdev, lp87565);
 
@@ -182,9 +182,9 @@ static int lp87565_regulator_probe(struct platform_device *pdev)
 		max_idx = LP87565_BUCK_3210;
 		break;
 	default:
-		dev_err(lp87565->dev, "Invalid lp config %d\n",
-			lp87565->dev_type);
-		return -EINVAL;
+		min_idx = LP87565_BUCK_0;
+		max_idx = LP87565_BUCK_3;
+		break;
 	}
 
 	for (i = min_idx; i <= max_idx; i++) {
-- 
2.20.1

