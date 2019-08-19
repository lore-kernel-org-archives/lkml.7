Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFFFC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD1120644
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ssMY1vMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbfHSXDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:03:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43109 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbfHSXDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:03:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id v12so2070458pfn.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rFkDVdxMKmvjHBJyGmUApN9b++k2zTF9quw3rYo2m6Q=;
        b=ssMY1vMBnfYeQHZ6nmDqVi7HELDW9OJq5zbSs5hi/zO5WohansKLHoLyT6vZCgdmS5
         y+MUgWtI7G5QQk354TwljfgSKN81Oh5F3pCuFAqUag8woabn0i2BKkxVwoGOKtonZ5v8
         DuvmOf07K8pwmeF7yM3CuTrM5rFeK1D/5oVG+MseohPlAXVE+1zF/Ryh8cz0sQwV5ggH
         QWEZKhBNYi2hDaXgnsH6zoSfdgCcxe5DxE9Dqp44qcSr2qxJrZvyCAalA1aEKUV6hyu2
         fCz8qdMyhY1r94feRwEO0f57ma5gBoDkxaxsja/NG8U1UQOUpWjHCVxqTW2acvn9RrTf
         aMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rFkDVdxMKmvjHBJyGmUApN9b++k2zTF9quw3rYo2m6Q=;
        b=chx77pVM9gpvuTavyf9zk08ulD7JXkrrOaF818FohfiySvvehzDzH0Ymn9ldtURj58
         2OBHQF+ddM6V39YoqUJyrmrfhEj483i/5mSokFtIfBSWhfy1ajUs81FAi+lNWkVAizdb
         vu9tB4Vw9DHVd1G5rfKzu9SjtPX8aRWdS9vp0QKdUKwGfcQjPx0yJhk/U4YPPAp/Y5Vh
         gpqrW2O0JdbLPt5l19CazQ1lP4LWuVGghqjVF0GngY/IQ2PsHsXkK+GnKUIiED8DyK+U
         NaKOBnSpDQghqXQQDG+NYnsD6kLodkqfPBpjxW+EqU9VIydWcOkvrfspvt/X4vh3C5PI
         KQ2A==
X-Gm-Message-State: APjAAAWxrezxwH39v500TmQilNoXd8JkLvX+mqzcUZX5oraD32rnYvgs
        CtbxulzfHcf+fOGb8793yy/6izUWoSU=
X-Google-Smtp-Source: APXvYqzTHLA7lx1VrFQUleoFllBiaEBYpVMyojNmAKc5BgBc6sj6Wpv2qDv54wM2tzLv9aWlq/ZHjQ==
X-Received: by 2002:aa7:946d:: with SMTP id t13mr27405973pfq.121.1566255808902;
        Mon, 19 Aug 2019 16:03:28 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id j15sm17256509pfr.146.2019.08.19.16.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:03:28 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v4 02/25] drm: kirin: Remove HISI_KIRIN_DW_DSI config option
Date:   Mon, 19 Aug 2019 23:02:58 +0000
Message-Id: <20190819230321.56480-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819230321.56480-1-john.stultz@linaro.org>
References: <20190819230321.56480-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG_HISI_KIRIN_DW_DSI option is only used w/ kirin
driver, so cut out the middleman and condense the config
logic down.

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/Kconfig  | 10 +---------
 drivers/gpu/drm/hisilicon/kirin/Makefile |  4 ++--
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/Kconfig b/drivers/gpu/drm/hisilicon/kirin/Kconfig
index 0fa29af08ad0..290553e2f6b4 100644
--- a/drivers/gpu/drm/hisilicon/kirin/Kconfig
+++ b/drivers/gpu/drm/hisilicon/kirin/Kconfig
@@ -5,16 +5,8 @@ config DRM_HISI_KIRIN
 	select DRM_KMS_HELPER
 	select DRM_GEM_CMA_HELPER
 	select DRM_KMS_CMA_HELPER
-	select HISI_KIRIN_DW_DSI
+	select DRM_MIPI_DSI
 	help
 	  Choose this option if you have a hisilicon Kirin chipsets(hi6220).
 	  If M is selected the module will be called kirin-drm.
 
-config HISI_KIRIN_DW_DSI
-	tristate "HiSilicon Kirin specific extensions for Synopsys DW MIPI DSI"
-	depends on DRM_HISI_KIRIN
-	select DRM_MIPI_DSI
-	help
-	 This selects support for HiSilicon Kirin SoC specific extensions for
-	 the Synopsys DesignWare DSI driver. If you want to enable MIPI DSI on
-	 hi6220 based SoC, you should selet this option.
diff --git a/drivers/gpu/drm/hisilicon/kirin/Makefile b/drivers/gpu/drm/hisilicon/kirin/Makefile
index c0501fa3fe53..c50606cfbbdb 100644
--- a/drivers/gpu/drm/hisilicon/kirin/Makefile
+++ b/drivers/gpu/drm/hisilicon/kirin/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 kirin-drm-y := kirin_drm_drv.o \
-	       kirin_drm_ade.o
+	       kirin_drm_ade.o \
+	       dw_drm_dsi.o
 
 obj-$(CONFIG_DRM_HISI_KIRIN) += kirin-drm.o
 
-obj-$(CONFIG_HISI_KIRIN_DW_DSI) += dw_drm_dsi.o
-- 
2.17.1

