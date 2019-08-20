Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD6DC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B60C23404
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zyuDY+Dz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfHTXHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:07:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37755 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfHTXHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:07:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id d1so159738pgp.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kPTZRFMdlMvsVJLbNqEMp+KDg1p/2/PzTgB54sSjI/U=;
        b=zyuDY+Dz9GS/ATmdo/KHEQi19IecSLdC2e6bTsUgY8jsteM9oMqvfXbaXAc221LP31
         yDMUOoUvjo/Bi9oOEz3JmkMbJIZIbvDJ9NOb6jy85smlKiLm+/XLeT245/yjrermAOY5
         IJyQFysEf15/jxU+Cv4Idz8tX4x6CfhARclR4mJwN+/o4teAp1RCRWNuFLhU2HFq8L/t
         Lvdu//m4AfDM1ZNAvfH7KbtLSJKvmK/agBLsSJHP/82IzWM8RBUtf8i6T+OerKLYFRho
         R7ljI1474mWznSb+KYDK0/c9Y5HW1lvd6goCAFrlpf9zCKH0OPMwy5y9GB7i73I8Zk/g
         9prQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kPTZRFMdlMvsVJLbNqEMp+KDg1p/2/PzTgB54sSjI/U=;
        b=tBMEAhCTB54qRmeil+1J8qcanJA+/L7fEMT+H1DAPJc9TZuOTOkAVato652+WuT+R8
         eNi5Q8CAuxd6SudpYVtb4bCRA8PGHiXeTFOoCeJFcBezYNm2L5r00ojQkMzbx1lrQJV7
         TZVjU/qaexXbIe2SI7YU2zIQUowmsToCCmFd3Yj4pByKFcmKI6IA01UC6oHu4tF0AuOE
         EACg35PAt0BOG63BGEiE5q0/FClUsa/jpf0RxleDgvHQAeXfLEYZyNZBn1ly5Yn7iiJj
         30yjWkV6MXIoTQI/+AjQUlev2PKGF/CxeXDUDd5qML2WpYwte8AE3vYDQCk9y4QtV+qW
         j23w==
X-Gm-Message-State: APjAAAUr1TpabIBEAuwf2jTe+X+u06IljZjPc7zm87p2Cx2Z8kvgg44R
        UfZ0Sn2L9JBgiqXq4E/CDgIM3n++E8c=
X-Google-Smtp-Source: APXvYqwPWi3hV1aULI47BdH1J86xCw7uOXUE660dq+vqeuPuIugq7A8By+kPCr/L6d0RdR//xPBKqQ==
X-Received: by 2002:aa7:8488:: with SMTP id u8mr33269995pfn.229.1566342423834;
        Tue, 20 Aug 2019 16:07:03 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id q4sm27564747pff.183.2019.08.20.16.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 16:07:03 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v5 21/25] drm: kirin: Fix dev->driver_data setting
Date:   Tue, 20 Aug 2019 23:06:22 +0000
Message-Id: <20190820230626.23253-22-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820230626.23253-1-john.stultz@linaro.org>
References: <20190820230626.23253-1-john.stultz@linaro.org>
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
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: Reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 1 -
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index e390b1b657b8..d8e40fcff386 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -999,7 +999,6 @@ static int ade_drm_init(struct platform_device *pdev)
 		DRM_ERROR("failed to alloc ade_data\n");
 		return -ENOMEM;
 	}
-	platform_set_drvdata(pdev, ade);
 
 	ctx = ade_hw_ctx_alloc(pdev, &ade->crtc.base);
 	if (IS_ERR(ctx)) {
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 68de8838da3c..7f8d4539b1a9 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -44,8 +44,6 @@ static int kirin_drm_kms_init(struct drm_device *dev)
 {
 	int ret;
 
-	dev_set_drvdata(dev->dev, dev);
-
 	/* dev->mode_config initialization */
 	drm_mode_config_init(dev);
 	dev->mode_config.min_width = 0;
@@ -140,6 +138,7 @@ static int kirin_drm_bind(struct device *dev)
 	drm_dev = drm_dev_alloc(driver_data->driver, dev);
 	if (IS_ERR(drm_dev))
 		return PTR_ERR(drm_dev);
+	dev_set_drvdata(dev, drm_dev);
 
 	ret = kirin_drm_kms_init(drm_dev);
 	if (ret)
-- 
2.17.1

