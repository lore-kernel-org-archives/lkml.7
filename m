Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81980C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AEBC21743
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dA1rYYZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbfHNSsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:48:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44734 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729006AbfHNSrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so2463pgl.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M6EfpO2AmlsI2DOe0XzrU1zVY/mWE6ZPcbT1wLb1NQk=;
        b=dA1rYYZ5AQz/pVgpowhEbvOMUR3T44a0HzOlt51pn+il3uCKhZ1XuZxJVRvMqYXO6A
         b5dcW0E4YtrL/peRKgkJQnkP7xE5X9KXNTRi1afVVJahW7vLlwMC8C1QOzps3oURjlxa
         dmvkVbJUVrQLAQr+OB1hx+B55EqNA+vqcy0tBLWMPwhiFX4yZymgd4YUaPYx6ZCJtGtz
         TkxhnKpSPggfA2E1jZLgohFbmEA4X9gfjXuhCvdcUp7rTSLlcc8muLLDNZuTcn0eO6rq
         vy2XzSSUA4+Y6CAiP98bXvrS1uc7oKYDMusQAlRtjhx2oCwTvGU4uijb0AGOZMJfMp8g
         PS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M6EfpO2AmlsI2DOe0XzrU1zVY/mWE6ZPcbT1wLb1NQk=;
        b=MEOUfGOFS75mT2xRyDlYxmUcADe4PG8QTwA0X3M56AMTv3udNDowEL8J+Zvefsiyuo
         2Ah6YAj74R7k5C1bPLj/JWx1mHBt/R/BgUaDPBg8LQofAvNwnHSEgUB/wtZ9j7u5P1tC
         ymZEUr9GDSHjEoq4UyLhQvB5xaEKlkDgIRRWtYU+F5wW9Vq3fVL34qs9dJqz5FFsZZnf
         YK5thcIKB5Dw1inXi/+uiSTFAeB+JgZMrQKH9LFtA+Jfx83C0mINIsceSUpvfJdxJsdt
         MiJOqUiSearOrl0T6jl9gbJhikLbgUZ7JkM2unV90vp4af5cXyZztL22YB8c4O6mRPjJ
         BNZA==
X-Gm-Message-State: APjAAAW88A4ofSEw/PjR6ZtOo9eh0Mucq7dBT2syuYvPylTcBjkoj40X
        9/B+vutIsc9lGx+2hka0ao9Eal44ogQ=
X-Google-Smtp-Source: APXvYqxqKGmy32Ujo0BCz2vrCYNtPj3gHXOFQuGtiab1Il7shpRxfNx4/7sGrlW0wTiMl4ACe65hCw==
X-Received: by 2002:a63:6a81:: with SMTP id f123mr510530pgc.348.1565808430529;
        Wed, 14 Aug 2019 11:47:10 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y16sm610855pfc.36.2019.08.14.11.47.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:47:09 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [RESEND][PATCH v3 02/26] drm: kirin: Get rid of drmP.h includes
Date:   Wed, 14 Aug 2019 18:46:38 +0000
Message-Id: <20190814184702.54275-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814184702.54275-1-john.stultz@linaro.org>
References: <20190814184702.54275-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove use of drmP.h in kirin driver

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 6 +++++-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c | 4 +++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index d69b5d458950..9a9e3b688ba3 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -17,8 +17,12 @@
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
+#include <linux/platform_device.h>
 
-#include <drm/drmP.h>
+#include <drm/drm_vblank.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_device.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 4a7fe10a37cb..fbab73c5851d 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -14,8 +14,10 @@
 #include <linux/of_platform.h>
 #include <linux/component.h>
 #include <linux/of_graph.h>
+#include <linux/module.h>
 
-#include <drm/drmP.h>
+#include <drm/drm_vblank.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
-- 
2.17.1

