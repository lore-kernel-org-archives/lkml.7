Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5544FC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 05:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F0F20720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 05:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jfjo+Fag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgAHFYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 00:24:08 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42636 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgAHFYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 00:24:05 -0500
Received: by mail-pl1-f196.google.com with SMTP id p9so627251plk.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 21:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VXWKPtv3cxE8lSp3PQIY49x0a4P+s/RHd/rRix+wGzg=;
        b=Jfjo+Faggwo7DaWWKVmhC7/00Vvhz+MTRYNmhAKQYX1HCOP3EYR8Lin5NwFPnmhjMY
         4+Fb5Qu0e1wDWqALzow5cVbQpRrmDtK6+s0MWVLSCLeAn/oBigTNqV6pS0G3uvjzNP7g
         ZOYd16bXAfTR+SPI/3E9hzT5bBEzHfFjf0IP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VXWKPtv3cxE8lSp3PQIY49x0a4P+s/RHd/rRix+wGzg=;
        b=YZSHtSOWS32msSqFWtb6R0iaf0Xv9jiD6K3LDMlG7pUex8BsfU3gtvBktm4yxJmSgu
         c/QXxTJaVunbdQDsfbETEwct4Z7qvYQkzVAbV+1aTZReEA6DEs2Ed4zAsbsSVyNlAsLO
         ghgrlL9w340uiuAfF6VUUIVm0eaXL8Ci2+qZxJUjSNbsdY5KnddpxiFUh99T3kCBRGGF
         Z3VGzy7UyWp1s76KYHerImFzahEJshUKIN5dNdcWOXUOmHgtEWca1yQQvOSRS9CVEHaJ
         skqmh7JQt+LCToclcXc9E3y1XBTlSCGcfg/kzn3/UEuuMORbHDOK4OZ7GeMIm/jx9YMZ
         mJeQ==
X-Gm-Message-State: APjAAAV/ebDdUKIAyqs29hMm5ke1F0aaaowj42OYmG8dtzHZukCI2zDN
        9scrBXGD3KFYcw0o5vgGsmBG6g==
X-Google-Smtp-Source: APXvYqyHC+8oOSDbkbTqCwSPnXshCUeDVww8reRuLxI2n62N7ExPieyrDCDC2ipIyCqYctUkgXWJYA==
X-Received: by 2002:a17:90a:3aaf:: with SMTP id b44mr2510426pjc.9.1578461044170;
        Tue, 07 Jan 2020 21:24:04 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id n24sm387505pff.12.2020.01.07.21.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 21:24:03 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org
Subject: [PATCH v2 3/7] drm/panfrost: Improve error reporting in panfrost_gpu_power_on
Date:   Wed,  8 Jan 2020 13:23:33 +0800
Message-Id: <20200108052337.65916-4-drinkcat@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20200108052337.65916-1-drinkcat@chromium.org>
References: <20200108052337.65916-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is useful to know which component cannot be powered on.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

---

Was useful when trying to probe bifrost GPU, to understand what
issue we are facing.
---
 drivers/gpu/drm/panfrost/panfrost_gpu.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index 8822ec13a0d619f..ba02bbfcf28c011 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -308,21 +308,26 @@ void panfrost_gpu_power_on(struct panfrost_device *pfdev)
 	gpu_write(pfdev, L2_PWRON_LO, pfdev->features.l2_present);
 	ret = readl_relaxed_poll_timeout(pfdev->iomem + L2_READY_LO,
 		val, val == pfdev->features.l2_present, 100, 1000);
+	if (ret)
+		dev_err(pfdev->dev, "error powering up gpu L2");
 
 	gpu_write(pfdev, STACK_PWRON_LO, pfdev->features.stack_present);
-	ret |= readl_relaxed_poll_timeout(pfdev->iomem + STACK_READY_LO,
+	ret = readl_relaxed_poll_timeout(pfdev->iomem + STACK_READY_LO,
 		val, val == pfdev->features.stack_present, 100, 1000);
+	if (ret)
+		dev_err(pfdev->dev, "error powering up gpu stack");
 
 	gpu_write(pfdev, SHADER_PWRON_LO, pfdev->features.shader_present);
-	ret |= readl_relaxed_poll_timeout(pfdev->iomem + SHADER_READY_LO,
+	ret = readl_relaxed_poll_timeout(pfdev->iomem + SHADER_READY_LO,
 		val, val == pfdev->features.shader_present, 100, 1000);
+	if (ret)
+		dev_err(pfdev->dev, "error powering up gpu shader");
 
 	gpu_write(pfdev, TILER_PWRON_LO, pfdev->features.tiler_present);
-	ret |= readl_relaxed_poll_timeout(pfdev->iomem + TILER_READY_LO,
+	ret = readl_relaxed_poll_timeout(pfdev->iomem + TILER_READY_LO,
 		val, val == pfdev->features.tiler_present, 100, 1000);
-
 	if (ret)
-		dev_err(pfdev->dev, "error powering up gpu");
+		dev_err(pfdev->dev, "error powering up gpu tiler");
 }
 
 void panfrost_gpu_power_off(struct panfrost_device *pfdev)
-- 
2.24.1.735.g03f4e72817-goog

