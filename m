Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E58C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B0B218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zr0/ngFt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbfHADp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:45:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34803 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730199AbfHADpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:45:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id b13so33156792pfo.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 20:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WjHqeb4FH0iNPLGVjtm/IuQE2HpCUqPIHkrvBOle06A=;
        b=zr0/ngFt5h5LHU72dl+EtYw2C13wCz8o1t7dZMhdyUVncveQH7+C+i5FhpQD7uH03n
         /jIlvAzXiSVskXqndgi4tjf0TksEDwJJOzk44IMe27eMSWRiMfMyHSZpJYs8kKSFL23X
         OdcQh+IUi+060D487nmTDlDzz6iXtLb6P63tMjbSjzkEQ34dKDLpR3jtDFz4ty7UU79d
         zecB7/VA0b4oc7whmXb37/mD7m+1gRLLZPMrOXCzXl9dow5nM/qZ0As6xg3KNddln4pa
         kpSqieLfnQ4DCgTXp+dzk1BxOVGqkYHfWxeLfV8QnOWJBbMHU1Y3NPzDwakC48jNrn3I
         9CUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WjHqeb4FH0iNPLGVjtm/IuQE2HpCUqPIHkrvBOle06A=;
        b=ejlEswhMYPTbPT5Pqayq0pMHfgiSyFmkX2QSaLOVvkofQraf306sW9pI43wY0xmIh7
         PE5CBn0BZNRU+VyKymz/IoSbaNkcOeGD4XmGKTlmdcoDLpsDKDgQMHHvVMhtoxB3qa5d
         c6Pdvx3z2avivQSTqf/+JcOV5Fu26hp2RPp//DK21H7BWK576t5VLEKCWJ1IsCmfIct4
         s7qQX8TCTKYCW/75Aw3wtXH0JKxbzcYzHaT/1F6XKzamyQD2HnC+Tne9V4+5MAm2b9D2
         PBuoiWkU/uEa/LkKxIzbfbfly+fLM4wCvt93LOwFgqA1GfiXmA6jGZiLrWU5kRIWhf1U
         KS3Q==
X-Gm-Message-State: APjAAAUvixz/QG6r6xenFFioLfOFBAMUpiplcvV5TV2QUdd+kin9zLYd
        mB5wHN4taPRLZDNbOrj+l9X67i/FFgE=
X-Google-Smtp-Source: APXvYqyVvZeMN6yRDkQ4uJom/1mFt8PdcwoWOHTKKQIAhsK+H2xzvml2+Hg38NdQbaAZeqmJIa0zMQ==
X-Received: by 2002:a65:6497:: with SMTP id e23mr112657820pgv.89.1564631118292;
        Wed, 31 Jul 2019 20:45:18 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id h70sm64775674pgc.36.2019.07.31.20.45.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 20:45:17 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH v3 21/26] drm: kirin: Rename plane_init and crtc_init
Date:   Thu,  1 Aug 2019 03:44:34 +0000
Message-Id: <20190801034439.98227-22-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801034439.98227-1-john.stultz@linaro.org>
References: <20190801034439.98227-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch renames
ade_crtc/plane_init kirin_plane/crtc_init, as they will later be
moved to kirin drm drv and shared with the kirin960 hardware
support.

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 66434c0cce6e..0bdcac981d8b 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -571,7 +571,7 @@ static const struct drm_crtc_funcs ade_crtc_funcs = {
 	.disable_vblank	= ade_crtc_disable_vblank,
 };
 
-static int ade_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
+static int kirin_drm_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 			 struct drm_plane *plane)
 {
 	struct device_node *port;
@@ -892,8 +892,9 @@ static struct drm_plane_funcs ade_plane_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
 };
 
-static int ade_plane_init(struct drm_device *dev, struct kirin_plane *kplane,
-			  enum drm_plane_type type)
+static int kirin_drm_plane_init(struct drm_device *dev,
+				struct kirin_plane *kplane,
+				enum drm_plane_type type)
 {
 	int ret = 0;
 
@@ -1024,13 +1025,13 @@ static int ade_drm_init(struct platform_device *pdev)
 		else
 			type = DRM_PLANE_TYPE_OVERLAY;
 
-		ret = ade_plane_init(dev, kplane, type);
+		ret = kirin_drm_plane_init(dev, kplane, type);
 		if (ret)
 			return ret;
 	}
 
 	/* crtc init */
-	ret = ade_crtc_init(dev, &kcrtc->base,
+	ret = kirin_drm_crtc_init(dev, &kcrtc->base,
 				&ade->planes[ade_driver_data.prim_plane].base);
 	if (ret)
 		return ret;
-- 
2.17.1

