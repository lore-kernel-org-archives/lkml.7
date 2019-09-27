Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2E0C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 02:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC471206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 02:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FEoOSXSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfI0Clv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 22:41:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35650 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbfI0Clu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 22:41:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id a24so2633647pgj.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 19:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LM9q5Xx6Mzt9yNbUm921CBJVXXmEo2RSkhi8vTWfwXU=;
        b=FEoOSXSXSqQp6XKLpQiCMZx8ATRg0h8grRkbHWwInMqhiYcwMAItrMzi+ghR2GUzYj
         3tSCThNuGE2JgrilKGSBaIFFGvi9TwRLiltCvSuSemuIARRNxqQl9f+Jg2RYFm1+2jH9
         xaxzZwYO3LJCKMazz+B/esndrthuEYZxrkbRu5ujttXWPwrm0jgWOt8+pcWR2sTbmBXa
         g/TXEcFOtYo6MA0DICHkpeXYu1ygfjhXYF+BKGcrX+QZPjSF40mbCz2P7WcbmkaPrxVC
         YXKiAhQNMAgrXHdH/tLl6xfmPdvRLesQnJ9zxuCa1Iv0iOlMn8/ObGC4AdlzniNeHD4F
         0JUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LM9q5Xx6Mzt9yNbUm921CBJVXXmEo2RSkhi8vTWfwXU=;
        b=mHH+HLZEaNOI2cb6dBS/bsoJWxtAlH77YxaY0J31599dHznXewX5u7iLxDR6h8tYQh
         ZlNoa4lnDzmUir8zZkBlgm2tbb8f5i5I2EpYAZUnk3QUWjzbuBwBUXL/qTMfcjZ6M2UI
         +A0Ejn9b74qdjnD3MnwHxtyh/o2xZNtDcNRBbxktsu7LF5RNqj1FbRZkXI9xmWOEo9ig
         QHcpol1lzZfUfGcxXw6ENi8/4v44wzb0TzqOXnfr9i3MzlZuAdQCqbXcUnOHu0GgOOoM
         HS9TWDi6GXnh+78qE2crCTCaWryDRSE/7uKddUyGJ4vf/AAcroHsWyyujF+UtRrgIuYX
         2AUA==
X-Gm-Message-State: APjAAAXrDwO+2X+gjwlSqOBq/d4N9AmOjtyjKx8h+ma40FnR7ujSVnVd
        YO6gtSQ/meMdNZVdn6ZkVh3mUA==
X-Google-Smtp-Source: APXvYqwOOUwjmPwThJPsYd1/C2/373tC8gWUSVmdLIJPmZF2YA06UcB1XryMc12KjMbVSv4dUfl5Lw==
X-Received: by 2002:a17:90a:ac14:: with SMTP id o20mr3945944pjq.28.1569552109806;
        Thu, 26 Sep 2019 19:41:49 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id k95sm3955461pje.10.2019.09.26.19.41.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Sep 2019 19:41:48 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        freeman.liu@unisoc.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, baolin.wang@linaro.org,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
Subject: [PATCH] iio: adc: sc27xx: Use devm_hwspin_lock_request_specific() to simplify code
Date:   Fri, 27 Sep 2019 10:41:19 +0800
Message-Id: <dabc353394772cd27dc64b48278e2366a763269f.1569551672.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change to use devm_hwspin_lock_request_specific() to help to simplify the
cleanup code for drivers requesting one hwlock.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/iio/adc/sc27xx_adc.c |   16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index a6c0465..66b387f 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -477,13 +477,6 @@ static void sc27xx_adc_disable(void *_data)
 			   SC27XX_MODULE_ADC_EN, 0);
 }
 
-static void sc27xx_adc_free_hwlock(void *_data)
-{
-	struct hwspinlock *hwlock = _data;
-
-	hwspin_lock_free(hwlock);
-}
-
 static int sc27xx_adc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -520,19 +513,12 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	sc27xx_data->hwlock = hwspin_lock_request_specific(ret);
+	sc27xx_data->hwlock = devm_hwspin_lock_request_specific(dev, ret);
 	if (!sc27xx_data->hwlock) {
 		dev_err(dev, "failed to request hwspinlock\n");
 		return -ENXIO;
 	}
 
-	ret = devm_add_action_or_reset(dev, sc27xx_adc_free_hwlock,
-			      sc27xx_data->hwlock);
-	if (ret) {
-		dev_err(dev, "failed to add hwspinlock action\n");
-		return ret;
-	}
-
 	sc27xx_data->dev = dev;
 
 	ret = sc27xx_adc_enable(sc27xx_data);
-- 
1.7.9.5

