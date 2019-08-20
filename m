Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98115C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AB420C01
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yFWWviao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfHTXGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:06:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46270 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfHTXGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:06:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id q139so71165pfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a1GVwhYagMUqR4YrGTGm12es7UZSRELJ0+S6Uqb2xtg=;
        b=yFWWviaoJKvZh1gOUEEuvxQyXX8glgCMCwN+TIErGjfUlBngteyvmSPNhOofiL4Mii
         Zbop9rO9WeLspnC+iAyTRUzfQxjE0X7FR3LQ5A1amxtR1piWk0eyqPKNBvLkjhft2YgQ
         X0jPP1nB5GA03sEkSLeQwBSzMwgaNgn/joRlvd2tIjyt3cOwRVZk8+2tgd/HDUEH4wJ3
         jue0x0mf0hH83Pi/S34CETHHke/BbfFjwoAfxSgh4OUtbGoO38fwqqCPgmvxQQDVgftO
         dM5+qSshsRvTfLN2y7XS1oZf1DVuar/RI+KH01AtphduE0GzPy0N2Y8o3LTivXll9sZS
         t7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a1GVwhYagMUqR4YrGTGm12es7UZSRELJ0+S6Uqb2xtg=;
        b=okb3J8TytybGdhiyvwUaLZBPFRhMj1W82zDepC6LQWtoB7c1RzRM/yG/MvaI4sCJri
         emzjHdLYclZq4CjzkZJobPfeYzvF0ifGNUseTu1XSMkqvkb5RqeIJ9jeW3+MIeikc9H9
         6jsqY7ESD6MLaPnv9ULVCrhzFQ/tSm0pfndudKbyL7AKa6C+C3djZW0teVqtveR1pj6K
         SD/q/l9AxABmavrpquKxr+0LyaSEf15j1p4RiAwUgfUaa8ypeBAubnuYygL+QcjOlb4Q
         rfJtpf6ko1bCnE20zPEEX9H4nhtDTtNXcuCqWNwTW+w/wo0jVwRucEBhjC09Ha5NClab
         vqVA==
X-Gm-Message-State: APjAAAXDfA7/Q8lIfP7OPxFWZTHhh7E9VVimUnuKQ5KvHwj8xMycdrN9
        Xi9JiLn5gLxDZeKdG/uOWPrz99l4nh8=
X-Google-Smtp-Source: APXvYqxT0eCJKaQPFDkMyQyR74+WfkWox/lmoKEdkV85flDMF6esaDLd5hpaiKtRGi2yjMmv8A+vDQ==
X-Received: by 2002:aa7:96dc:: with SMTP id h28mr32692331pfq.86.1566342392992;
        Tue, 20 Aug 2019 16:06:32 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id q4sm27564747pff.183.2019.08.20.16.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 16:06:32 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v5 02/25] drm: kirin: Remove HISI_KIRIN_DW_DSI config option
Date:   Tue, 20 Aug 2019 23:06:03 +0000
Message-Id: <20190820230626.23253-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820230626.23253-1-john.stultz@linaro.org>
References: <20190820230626.23253-1-john.stultz@linaro.org>
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
v5: Build fixup for module config noticed by Sam
---
 drivers/gpu/drm/hisilicon/kirin/Kconfig  | 10 +---------
 drivers/gpu/drm/hisilicon/kirin/Makefile |  3 +--
 2 files changed, 2 insertions(+), 11 deletions(-)

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
index c0501fa3fe53..d9323f66a7d4 100644
--- a/drivers/gpu/drm/hisilicon/kirin/Makefile
+++ b/drivers/gpu/drm/hisilicon/kirin/Makefile
@@ -2,6 +2,5 @@
 kirin-drm-y := kirin_drm_drv.o \
 	       kirin_drm_ade.o
 
-obj-$(CONFIG_DRM_HISI_KIRIN) += kirin-drm.o
+obj-$(CONFIG_DRM_HISI_KIRIN) += kirin-drm.o dw_drm_dsi.o
 
-obj-$(CONFIG_HISI_KIRIN_DW_DSI) += dw_drm_dsi.o
-- 
2.17.1

