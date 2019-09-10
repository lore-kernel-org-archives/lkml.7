Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9851DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 07:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704362084D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 07:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F/4DbNZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfIJH7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 03:59:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40041 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfIJH7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 03:59:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id x127so11056599pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 00:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ICqDZT0+Rww/hGCZQ9/7SaJeWoOs3iDbAih166xoms=;
        b=F/4DbNZMB0nf7DgnHlLG8hechqYzxn49BWwlDiqD6w5zAWKLdtCcwUMdYD1CsqN+Ng
         jzKPub20pUMRPuzTI4YvJD3AiyE28CCh4t/qGp+gjJYenrY9lh/BXg7sRph0NR66KjSF
         k6CBYACYO5XANiHDoc9soi/2ks1/EbDYV2mfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ICqDZT0+Rww/hGCZQ9/7SaJeWoOs3iDbAih166xoms=;
        b=nM4EdPhq+07KjKhBuycp5yQrbFNzrgQp/JdJlzelvsZtJJhkNJjw9tb7Yh1TqQvyYA
         +Ne5jdxeHjkJNnoZvbPnUEll0ixuzU16NabOaeNL8AqmI4irfqp9EIirVaq98WxooXY5
         GCslK2ZZ8HhH6qxxivTvwiRzfqgItTGAo3JHg2SD+XvUr5EhQhIjc4gJYKc2d6qh3vnV
         eW7uu4HGd/E5iRvqqU/l7D57QZ7P9F+AQ6SV7E5xvM+5Az5Vg232b2pQ8SG89K0Q0CsP
         pFvucO2eYE6H+heH3kXIn1zq3xg9zslE879pIj+jFurnom80OB0OL9vP7npV6FavIlDt
         3Mew==
X-Gm-Message-State: APjAAAX+/OW2lbFcc2h8RacITwoQkqnXORhVWxYr4MgJ/rt0hTPu+N5s
        90TTVEsnPbOD2k68Um32aqw0SQ==
X-Google-Smtp-Source: APXvYqyDn9hO++8SUhAPekxT/ojMiADYLdC41QbV41Z++f9OMrsB5LXCadAWjtEN/hNbyMZ7r2vYLg==
X-Received: by 2002:aa7:870c:: with SMTP id b12mr34260902pfo.122.1568102352293;
        Tue, 10 Sep 2019 00:59:12 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id c23sm16189538pgj.62.2019.09.10.00.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 00:59:11 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Eduardo Valentin <edubezval@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thermal-generic-adc: Silent error message for EPROBE_DEFER
Date:   Tue, 10 Sep 2019 15:59:07 +0800
Message-Id: <20190910075907.132200-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If devm_iio_channel_get() or devm_thermal_zone_of_sensor_register()
fail with EPROBE_DEFER, we shouldn't print an error message, as the
device will be probed again later.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/thermal/thermal-generic-adc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index dcecf2e8dc8e..ae5743c9a894 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -134,7 +134,8 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 	gti->channel = devm_iio_channel_get(&pdev->dev, "sensor-channel");
 	if (IS_ERR(gti->channel)) {
 		ret = PTR_ERR(gti->channel);
-		dev_err(&pdev->dev, "IIO channel not found: %d\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "IIO channel not found: %d\n", ret);
 		return ret;
 	}
 
@@ -142,8 +143,10 @@ static int gadc_thermal_probe(struct platform_device *pdev)
 							   &gadc_thermal_ops);
 	if (IS_ERR(gti->tz_dev)) {
 		ret = PTR_ERR(gti->tz_dev);
-		dev_err(&pdev->dev, "Thermal zone sensor register failed: %d\n",
-			ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"Thermal zone sensor register failed: %d\n",
+				ret);
 		return ret;
 	}
 
-- 
2.23.0.162.g0b9fbb3734-goog

