Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F68C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 03:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B692C207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 03:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P6EtdWzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfI0DMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 23:12:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40053 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfI0DMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 23:12:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id d22so478206pll.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 20:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IDR1u0tDazDoFj1oRmQ9KT0VVbtUGa9TuFv0cKouQkY=;
        b=P6EtdWzEqrjcSWvJz9Q82B8ZrokpEFTk/HoxeaTU6JsOyMOYnMReWnaztjl3LhLGN6
         f6qqI+TcRmSOYK86B3MQnrvFUrCwyPeO8brcTVvNWHlFcHV72z/itw6PSSdEwLncBo6D
         XsMZ3zVkZD49szd/mVC4kUBaQbaywFKfEBQgGWE8S45rN7YOt0/UX359vZXNI5xpo+Xq
         9cqEbHKW5FeTBvCWD21chvkCESH5Ifdg4kkWRrq8S+bvzH5mCojGhPju1tzU+4pYjT3r
         Ndf0VRb6b6xVNa96Ydqu7kUq2mQ9a9JrqT+ROQH/DSSO6C0gUSzKZwQUDUejM8C07Rq7
         VQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IDR1u0tDazDoFj1oRmQ9KT0VVbtUGa9TuFv0cKouQkY=;
        b=OXaQIqra/96KD2Z63x/NiQ1IkL2omzG0txEIBxRqnmxhCgbTZhVkGvh+49chQF2TJb
         tm+rXx5Q4gARywjmCxA279jQlrNAAzU09hYOl9SPIv0tqBP7gUr9P2z82IjdpbU6vcB6
         NvenYuVvajNgfinv58W+OEWyOFR1uoEPpnBW49cm7GFwpIvmozvaL29DsbyDKGS0UNvq
         Y+h4MOUfr72kb75W0uFEKq97PzAi8T9vbJJ/t3HajcSp89ytvjV2jEvoh2XYYB+2T/6V
         90Nt93JVYXKVdnfnZiWvMWeKLAEkzc1arPJMbjadqgLfj3GNiSk3JJqtN3zOlFhyo26+
         m7sQ==
X-Gm-Message-State: APjAAAWf0xMAYP3gU5jpixgImTuYi62jAW/sCqMhrERHfJvTIQhvTFGO
        20ECqcVXnABJ3hXuMO1sx/PGnQ==
X-Google-Smtp-Source: APXvYqzz8depITs7C2HiRe1qosJl+0b3VACHo5Q+9/tUN3HE9QCWnGM+Zanvas1EiE95qj7x90LWGA==
X-Received: by 2002:a17:902:b787:: with SMTP id e7mr2180823pls.134.1569553956410;
        Thu, 26 Sep 2019 20:12:36 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id g24sm697965pfi.81.2019.09.26.20.12.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Sep 2019 20:12:35 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     srinivas.kandagatla@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org,
        freeman.liu@unisoc.com, linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: sc27xx: Change to use devm_hwspin_lock_request_specific() to request one hwlock
Date:   Fri, 27 Sep 2019 11:12:19 +0800
Message-Id: <b2ad55edbb1185c52dc73622ddccbdb7c1b52efd.1569552692.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change to use devm_hwspin_lock_request_specific() to help to simplify the
cleanup code for drivers requesting one hwlock. Thus we can remove the
redundant sc27xx_efuse_remove() and platform_set_drvdata().

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/nvmem/sc27xx-efuse.c |   13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/nvmem/sc27xx-efuse.c b/drivers/nvmem/sc27xx-efuse.c
index c6ee210..ab5e7e0 100644
--- a/drivers/nvmem/sc27xx-efuse.c
+++ b/drivers/nvmem/sc27xx-efuse.c
@@ -211,7 +211,7 @@ static int sc27xx_efuse_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	efuse->hwlock = hwspin_lock_request_specific(ret);
+	efuse->hwlock = devm_hwspin_lock_request_specific(&pdev->dev, ret);
 	if (!efuse->hwlock) {
 		dev_err(&pdev->dev, "failed to request hwspinlock\n");
 		return -ENXIO;
@@ -219,7 +219,6 @@ static int sc27xx_efuse_probe(struct platform_device *pdev)
 
 	mutex_init(&efuse->mutex);
 	efuse->dev = &pdev->dev;
-	platform_set_drvdata(pdev, efuse);
 
 	econfig.stride = 1;
 	econfig.word_size = 1;
@@ -232,21 +231,12 @@ static int sc27xx_efuse_probe(struct platform_device *pdev)
 	nvmem = devm_nvmem_register(&pdev->dev, &econfig);
 	if (IS_ERR(nvmem)) {
 		dev_err(&pdev->dev, "failed to register nvmem config\n");
-		hwspin_lock_free(efuse->hwlock);
 		return PTR_ERR(nvmem);
 	}
 
 	return 0;
 }
 
-static int sc27xx_efuse_remove(struct platform_device *pdev)
-{
-	struct sc27xx_efuse *efuse = platform_get_drvdata(pdev);
-
-	hwspin_lock_free(efuse->hwlock);
-	return 0;
-}
-
 static const struct of_device_id sc27xx_efuse_of_match[] = {
 	{ .compatible = "sprd,sc2731-efuse" },
 	{ }
@@ -254,7 +244,6 @@ static int sc27xx_efuse_remove(struct platform_device *pdev)
 
 static struct platform_driver sc27xx_efuse_driver = {
 	.probe = sc27xx_efuse_probe,
-	.remove = sc27xx_efuse_remove,
 	.driver = {
 		.name = "sc27xx-efuse",
 		.of_match_table = sc27xx_efuse_of_match,
-- 
1.7.9.5

