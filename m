Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5C7C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91282218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gzFKilZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbfHADpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:45:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33253 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730220AbfHADpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:45:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so33161106pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 20:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l0iGU7OjgEb+jEdW4ORscHtkcmdOvreVfILRvjj1+Oo=;
        b=gzFKilZEeoz2ZWeGIlMCgbyjJirnk+SAY0OJ2oLnv6TDgPgy7gDOwYDgjgIFUQubIG
         7+Y0HrHWaAB0e4dKi7eNz9DgY21doX491Hl5Sy+Sh8g5nK7pOWCIhguyG2hxQxlCJ3m+
         V4lAkD5jZ1rxH+J1N3BMCfzf18dtcWa/tWf/bedn8Eoqbl0x//3hvJmPq5KY71XxHIb8
         YdSwvhZxwjRcpluUmA+MymwndWUTD9T4yvsljP4JherbrCQlpvIfRr+p9hgxD0MBxlfi
         s3ziTT38BUOG0VrYrqLn0j3u59fVughR5SE25urd1EMxgHBxruMmZnuXjTImZQZ7Mj3O
         JUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l0iGU7OjgEb+jEdW4ORscHtkcmdOvreVfILRvjj1+Oo=;
        b=UaFTZSYYywKFktTdifsFqZ2xXLEkdAQVWdERZZo1wy/cc2sa/TVfpsdHMfDzm61PPK
         7ArKX+ovQzlTH26BdlHLP+hReNymQ4HLaG7o9AZqCfEEkkMyhYYxjzD5c7uHrEYLSxAx
         /44WU6Mk8eXAWKSDae8enSY1w7YcL3n7nD0i/Y/13VPwi25gsrRhrGMnu2FDaafbhFEO
         OK7Hz9AWE0eOeikKy4NBEexzZU4rpKsZXJGEbb1nj94aoqBIt+uETevf5K2bLPN331uA
         gs/l4X9AOPwDzwFU6o/GSU8iPHn6AOqE/CoNAPDVOe2crVAadkuNHtThzm65frm4eW1m
         n9RQ==
X-Gm-Message-State: APjAAAWmpMc56X3ttiKNysA9gLBwdl6PdYIlcSiP7lVcV+eE1vc1hhc7
        cVBS+1qzmFKpfqUsPgon1SoSMXQ83Kg=
X-Google-Smtp-Source: APXvYqwQrYrPD7WmSLedewQDsd/0ccueFsQ6lDrBBY/uwQkz1NbeQoHSUVHsVJakO64KiZOSs0/JsQ==
X-Received: by 2002:a17:90a:32ec:: with SMTP id l99mr6319509pjb.44.1564631119659;
        Wed, 31 Jul 2019 20:45:19 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id h70sm64775674pgc.36.2019.07.31.20.45.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 20:45:18 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v3 22/26] drm: kirin: Fix dev->driver_data setting
Date:   Thu,  1 Aug 2019 03:44:35 +0000
Message-Id: <20190801034439.98227-23-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801034439.98227-1-john.stultz@linaro.org>
References: <20190801034439.98227-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch changes the
dev->driver_data to point to a drm_device, not ade_data.

Thus we set the driver data to drm device after alloc.

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: Reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 1 -
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 0bdcac981d8b..09dc2c07533d 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -998,7 +998,6 @@ static int ade_drm_init(struct platform_device *pdev)
 		DRM_ERROR("failed to alloc ade_data\n");
 		return -ENOMEM;
 	}
-	platform_set_drvdata(pdev, ade);
 
 	ctx = ade_hw_ctx_alloc(pdev, &ade->crtc.base);
 	if (IS_ERR(ctx)) {
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 1c9658e9565e..f1853b84ab58 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -43,8 +43,6 @@ static int kirin_drm_kms_init(struct drm_device *dev)
 {
 	int ret;
 
-	dev_set_drvdata(dev->dev, dev);
-
 	/* dev->mode_config initialization */
 	drm_mode_config_init(dev);
 	dev->mode_config.min_width = 0;
@@ -139,6 +137,7 @@ static int kirin_drm_bind(struct device *dev)
 	drm_dev = drm_dev_alloc(driver_data->driver, dev);
 	if (IS_ERR(drm_dev))
 		return PTR_ERR(drm_dev);
+	dev_set_drvdata(dev, drm_dev);
 
 	ret = kirin_drm_kms_init(drm_dev);
 	if (ret)
-- 
2.17.1

