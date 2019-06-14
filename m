Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811E2C31E4E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 22:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589F621841
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 22:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZHrf0zet"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfFNWr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 18:47:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35502 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfFNWr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 18:47:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id d126so2246922pfd.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 15:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0MclKa4ww/GU4h0ModhXTnU03GxDuW7aam4X/xA5H20=;
        b=ZHrf0zetXblEGMrSWzFuV+TI9faYuEa+jhfVW9V/m0B9O+jKxO4+WjenDITlg+aFYZ
         rwkn7i/eEJwwpQKHMiEq0zlBvGsHMIF45Uf+FNPktBaKA1e7aETQITS6pxCwjG88fhY0
         xNrhAWXlbmUSTAcnqo9tAd0ptVAPAcMc7dGLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0MclKa4ww/GU4h0ModhXTnU03GxDuW7aam4X/xA5H20=;
        b=W1Xw7Po/M0H2ojwhxcrdgpsb01F1GM79zGaQ3qdAEgizfPLJhqjp8uOfwYio2U/tyT
         0KTiNV4dbQyrRJNAUb5jRsHSaNk+8+DZZF7l2knJ0186V6qsKyIZTyl5ndej6uOTj0aO
         MJduwChE15jOzKAVBxURa9OUQrFgzy3vCGGNaoby9yp2LG4TyKxtVceCcl+wdGQVQUbt
         pnBVhcN1hk2OZYdLt3eEtdeuseetZatA4ghX1jp3Jk9R0EDJbWDSCyl/pOITD2tOi6zR
         nWbainuXOM9kD+0PyjmZgPFd9602KtusaxhCa8fBY8y9UxzS8O1VQaEZec4e6NEVqHq2
         rmYA==
X-Gm-Message-State: APjAAAXxX5+1OwzaklzomQXZ5lYxNFvg2U4oDE4VURSNhV1FlyozEqnm
        WaG1f7HFK8ZnHgfyqd1by6JhNw==
X-Google-Smtp-Source: APXvYqzZ+CMlOlPiOf2LQv6uMUwI93prqIodMDLjqSqBeZ5oaQMYW0ftolCisN3PIf4q8UD0Rzr7Vg==
X-Received: by 2002:a17:90a:25af:: with SMTP id k44mr13019616pje.122.1560552476071;
        Fri, 14 Jun 2019 15:47:56 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id x7sm3706087pfm.82.2019.06.14.15.47.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 15:47:55 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Sandy Huang <hjc@rock-chips.com>, heiko@sntech.de,
        seanpaul@chromium.org
Cc:     linux-rockchip@lists.infradead.org, urjaman@gmail.com,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 2/2] drm/rockchip: Base adjustments of the mode based on prev adjustments
Date:   Fri, 14 Jun 2019 15:47:30 -0700
Message-Id: <20190614224730.98622-2-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190614224730.98622-1-dianders@chromium.org>
References: <20190614224730.98622-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vop_crtc_mode_fixup() we fixup the mode to show what we actually
will be able to achieve.  However we should base our adjustments on
any previous adjustments that were made.

As an example, the dw_hdmi driver may wish to make some small
adjustments to clock rates in its atomic_check() function.  If it
does, it will update the adjusted_mode.  We shouldn't throw away those
adjustments.

NOTE: the version of the dw_hdmi driver upstream doesn't _actually_
make such adjustments, but downstream in Chrome OS it does.  It is
plausible that one day we'll figure out how to cleanly make that
happen in an upstream-friendly way, so we should prepare by using the
right mode.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index d124f34ab9fc..09a790c2f3a1 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1006,8 +1006,8 @@ static bool vop_crtc_mode_fixup(struct drm_crtc *crtc,
 	struct vop *vop = to_vop(crtc);
 
 	adjusted_mode->clock =
-		DIV_ROUND_UP(clk_round_rate(vop->dclk, mode->clock * 1000),
-			     1000);
+		DIV_ROUND_UP(clk_round_rate(vop->dclk,
+					    adjusted_mode->clock * 1000), 1000);
 
 	return true;
 }
-- 
2.22.0.410.gd8fdbe21b5-goog

