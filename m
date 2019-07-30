Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39179C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D666206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p5bsKDg7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbfG3PZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:25:38 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35960 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732332AbfG3PZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:25:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id q26so45052544lfc.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 08:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a8k87dhuTxTzS+n3u2Ou7NXh77Uav3wOrh0j/WlwUGo=;
        b=p5bsKDg7tMBnd5qo4asPd25ewkYLyTBvTiDchpZUVrlXTDmyMEYZ5sLLXxeZE+FEJu
         fFFNjoTLkv5d2pa5xGLx9vkfp2kN2vnddjucaeZvUkFXRynv1VNzJ1pUcqmxb2Txe3do
         JzVko3L/nJk6RDWynthGjwo+jRTerO6ZGya1/kDLuC6bMX9B/IbVW/JZHrLMlgpcKLym
         sItTVYZ8Z+4m2Qww3kRTK+O9+PXHRF8M/C9S5nnxW1x3N3BsbW8oNQ7YaNaUDMO60oA1
         XF9/tnA4qlzGsdu85SFUrd6yfss+zvC3BltZJqm8Q5sMSfDSix3SZ+AP1EjUxazCFJ4I
         wdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a8k87dhuTxTzS+n3u2Ou7NXh77Uav3wOrh0j/WlwUGo=;
        b=ZsG7b8B6D/GWYLet3L2wGbGMo1V0yGSuaRS33LX6kg/QZ20+IcLL5tiTObze9gNXuF
         7WLTR1eFLX8VuaTHx4xS//Gcz0Wiwms8Vk1xDUnUKroC3CTwHCU/zLYOxhVXXPWQmg/1
         rFuqS2EbMfVRpzr1t09giW8T/U1WlDA7YE90c7aC4HXFHfBpiewLCt2bcD0a/WI4Ecg2
         0n7GjjjNUDUlHWRMeb+4KD17MU5xjki6xmll8aKdXIsFfa6/oi3xqSMA/CpeBnw7XzAz
         98Nh9Jva50MR3BVXmJKIQwUhvMJ45OW3GxyJn88OAgYd81CdlYlWTvrsw3R68OzkzbCm
         kiVA==
X-Gm-Message-State: APjAAAUVxy/rZzjBQCrNydsqv/k4H9dmrXyaIH8Jr8XJ189dI+LJrehg
        i2yIjQjdJ05s6ZaBBwJU90MNL8Wu8UykWg==
X-Google-Smtp-Source: APXvYqzrh7p3FQO75/hpL7dUe20p/p24BxIUA3XsEMf3aeLRuCyAOWaX12fBPsDhGMCzfbDEd2eHKQ==
X-Received: by 2002:a19:41cc:: with SMTP id o195mr10890679lfa.166.1564500336500;
        Tue, 30 Jul 2019 08:25:36 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id t5sm13280728ljj.10.2019.07.30.08.25.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 08:25:35 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     b.zolnierkie@samsung.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, gustavo@embeddedor.com,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] video: fbdev: Mark expected switch fall-through
Date:   Tue, 30 Jul 2019 17:25:30 +0200
Message-Id: <20190730152530.3055-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that -Wimplicit-fallthrough is passed to GCC by default, the
following warnings shows up:

../drivers/video/fbdev/sh_mobile_lcdcfb.c: In function ‘sh_mobile_lcdc_channel_fb_init’:
../drivers/video/fbdev/sh_mobile_lcdcfb.c:2086:22: warning: this statement may fall
 through [-Wimplicit-fallthrough=]
   info->fix.ypanstep = 2;
   ~~~~~~~~~~~~~~~~~~~^~~
../drivers/video/fbdev/sh_mobile_lcdcfb.c:2087:2: note: here
  case V4L2_PIX_FMT_NV16:
  ^~~~
../drivers/video/fbdev/sh_mobile_lcdcfb.c: In function ‘sh_mobile_lcdc_overlay_fb_init’:
../drivers/video/fbdev/sh_mobile_lcdcfb.c:1596:22: warning: this statement may fall
 through [-Wimplicit-fallthrough=]
   info->fix.ypanstep = 2;
   ~~~~~~~~~~~~~~~~~~~^~~
../drivers/video/fbdev/sh_mobile_lcdcfb.c:1597:2: note: here
  case V4L2_PIX_FMT_NV16:
  ^~~~

Rework to address a warnings due to the enablement of
-Wimplicit-fallthrough.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index ac0bcac9a865..c249763dbf0b 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -1594,6 +1594,7 @@ sh_mobile_lcdc_overlay_fb_init(struct sh_mobile_lcdc_overlay *ovl)
 	case V4L2_PIX_FMT_NV12:
 	case V4L2_PIX_FMT_NV21:
 		info->fix.ypanstep = 2;
+		/* Fall through */
 	case V4L2_PIX_FMT_NV16:
 	case V4L2_PIX_FMT_NV61:
 		info->fix.xpanstep = 2;
@@ -2084,6 +2085,7 @@ sh_mobile_lcdc_channel_fb_init(struct sh_mobile_lcdc_chan *ch,
 	case V4L2_PIX_FMT_NV12:
 	case V4L2_PIX_FMT_NV21:
 		info->fix.ypanstep = 2;
+		/* Fall through */
 	case V4L2_PIX_FMT_NV16:
 	case V4L2_PIX_FMT_NV61:
 		info->fix.xpanstep = 2;
-- 
2.20.1

