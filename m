Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DB7C31E4E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 22:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B0E21841
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 22:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ApCzoYVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfFNWr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 18:47:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38588 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfFNWrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 18:47:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id v11so2311958pgl.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 15:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B/paYYaNElnUhrLCMfr9aofzvSpDY7fIjtUGwDwrL/w=;
        b=ApCzoYVFWJ+gmiLTLvrC4zRCv/sxTzAUuGigYReuCPkwv8+JbQtTQ1ujJvy8eXWLqB
         +IQTzppqRJKhqe+8V7UEuUHo4bd+AM07L3HjWFZQQdGpjnep077mDCdlHdC1RIk2DgQq
         5mJV4O++xveG92zkhvhU6kYaRMIla/IEBvu+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B/paYYaNElnUhrLCMfr9aofzvSpDY7fIjtUGwDwrL/w=;
        b=GrZQT/05C9Nz3MgrvdN5SPSnS6ysJPGH6yBIDXs64Q7ud1JP/FFVQAg7vYTdNrFwU2
         uHubat7eUo9PSMvyu30lp36bXj1xIoBCzxQAamnaxjAQtPERqy1ck1dtQz0io5W4Q399
         9V8kXiwnYqoP2vT+rG7PFgdExDsGrRZw5NxQDfFy+l3hbUjWtmFcY6EGlxe4IaR32RWh
         xbJwqYnw4HOZF4xQ+rQRZkpmOXbCiG2EfhbG+c3iwMvJ9e0Hj3Xes8B2T24bx8q5lR1V
         SQhPFVeu9+YsT6fNk1Q7dZbdB2n3IQnK2uReAxf/sVwAMwzYlyMMR6j4KnWDAyxbW41D
         a2Ug==
X-Gm-Message-State: APjAAAWDUBPw+ZQqDFaxBUtmGTsg4FHAbN/wh5FOUrAlduu0k4rKq3T7
        fba80CaURRA9oGleMKPqx3imoQ==
X-Google-Smtp-Source: APXvYqwCFm4zexZwb/yHk0T7k2vyRVj2XJif4vKx4gUkaC3e6ysgiT29t7k5lmVupIUZSX9ZhqMjSw==
X-Received: by 2002:a63:441c:: with SMTP id r28mr37978657pga.255.1560552475017;
        Fri, 14 Jun 2019 15:47:55 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id x7sm3706087pfm.82.2019.06.14.15.47.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 15:47:54 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Sandy Huang <hjc@rock-chips.com>, heiko@sntech.de,
        seanpaul@chromium.org
Cc:     linux-rockchip@lists.infradead.org, urjaman@gmail.com,
        Douglas Anderson <dianders@chromium.org>,
        Yakir Yang <ykk@rock-chips.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 1/2] drm/rockchip: Properly adjust to a true clock in adjusted_mode
Date:   Fri, 14 Jun 2019 15:47:29 -0700
Message-Id: <20190614224730.98622-1-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fixing up the clock in vop_crtc_mode_fixup() we're not doing it
quite correctly.  Specifically if we've got the true clock 266666667 Hz,
we'll perform this calculation:
   266666667 / 1000 => 266666

Later when we try to set the clock we'll do clk_set_rate(266666 *
1000).  The common clock framework won't actually pick the proper clock
in this case since it always wants clocks <= the specified one.

Let's solve this by using DIV_ROUND_UP.

Fixes: b59b8de31497 ("drm/rockchip: return a true clock rate to adjusted_mode")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Reviewed-by: Yakir Yang <ykk@rock-chips.com>
---
Back in 2016 Mark Yao said he applied this to his drm fixes [1], but it's
2019 and it's still missing so I'm posting again.

[1] https://patchwork.freedesktop.org/patch/103872/

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index e4580d8f21e1..d124f34ab9fc 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1006,7 +1006,8 @@ static bool vop_crtc_mode_fixup(struct drm_crtc *crtc,
 	struct vop *vop = to_vop(crtc);
 
 	adjusted_mode->clock =
-		clk_round_rate(vop->dclk, mode->clock * 1000) / 1000;
+		DIV_ROUND_UP(clk_round_rate(vop->dclk, mode->clock * 1000),
+			     1000);
 
 	return true;
 }
-- 
2.22.0.410.gd8fdbe21b5-goog

