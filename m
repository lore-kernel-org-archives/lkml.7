Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76995C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C67323429
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YIPSVYup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfHTXG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:06:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44110 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfHTXGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:06:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id c81so76973pfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 16:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9wPcbIoBPT/8L74pQuiXRIt1kMA2rrNdraftIyGCKRU=;
        b=YIPSVYupeR5GBL+4iP8KgubrHAAyoTX6x00LkJOHx1jvD0oh7M/xQwqeVwTMOWIXSl
         dZcTZfD+t1RJWSjCmcaq32LJsCbNAz/AqoyzNmpk+vyQiRgfQkMZNLDg2cuk5CE06kYu
         gYaP/UrYI8prOQAmd6gyd4g9yr2xhR+zAdWTUb9nVzmOmDJ0LkolQ+a5a/HMfu2ZK4le
         LLbj8fT2Fqx18tTcdS7M6kKWkE0+PH7N5+7UP7ckP0124Fwr2yfo3HnUIcxcSbkCAxo0
         /ZdKrXBTUkj5c01ATSf05PQAQ4u3sZbsirGuxw3zR8kDDFrChpxxLeJflZz9FcGzERAy
         yFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9wPcbIoBPT/8L74pQuiXRIt1kMA2rrNdraftIyGCKRU=;
        b=tzHm7rMQnsFc19ZDPEHv0SbcaOT9v6bcCigCkdE8OAwk1DaKRTY9z58XeerZU/ZKTM
         FCBw9FOcXM/Jok08rqt1DP5Xe9uP9jsQ55ybWb3iZIRIwGA8tQCSxUoeibCxc/OkfFtq
         vZ8/FEJ5e00VRidbqBttLcH2ubVQHIbBZFduxdBSUSHT+5M0fsyJBj4MtaNBrDJKd5yu
         w+uD3OqOgvXVNAtaY1leXpT2NkYo9SfwMbBhUxs0ZPrmZD/cRPxDz2qjYXx+hAPmzg93
         C/qaWxzQQmZLJmb1q16Cx8jE4nfd/W9VVyFcT/mOnZ5vo7Wf2Ig+wGkzfGY8n7RbIlUp
         ntkw==
X-Gm-Message-State: APjAAAWPOF2UAizGsqSvVAxqyvqxZU97iNeIw/xtqr75DrrBg6r3esqc
        Bt3dTqy/zSCtqdfw2vsWYHN3MkwhXe8=
X-Google-Smtp-Source: APXvYqwA2vG86Xa3XTeAfvmUNiasYaGiBQjfDhnTGPdGcYyITx4aN+Pjv6qz3iMqskAQpDZRDQcpYQ==
X-Received: by 2002:a17:90a:6581:: with SMTP id k1mr2350909pjj.47.1566342413486;
        Tue, 20 Aug 2019 16:06:53 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id q4sm27564747pff.183.2019.08.20.16.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 16:06:52 -0700 (PDT)
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
Subject: [PATCH v5 16/25] drm: kirin: Move plane number and primay plane in driver data
Date:   Tue, 20 Aug 2019 23:06:17 +0000
Message-Id: <20190820230626.23253-17-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190820230626.23253-1-john.stultz@linaro.org>
References: <20190820230626.23253-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch moves the number of
planes and the primary plane value to the kirin_drm_data
structure

This will make it easier to add support for new devices
via a new kirin_drm_data structure.

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v5: checkpatch --strict whitespace fixups noticed by Sam
---
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   | 21 ++++++++++++-------
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.h   |  2 ++
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 94d74c467a81..a74b2623dbbb 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -35,7 +35,6 @@
 #include "kirin_drm_drv.h"
 #include "kirin_ade_reg.h"
 
-#define PRIMARY_CH	ADE_CH1 /* primary plane */
 #define OUT_OVLY	ADE_OVLY2 /* output overlay compositor */
 #define ADE_DEBUG	1
 
@@ -991,7 +990,7 @@ static int ade_drm_init(struct platform_device *pdev)
 	struct kirin_plane *kplane;
 	enum drm_plane_type type;
 	int ret;
-	int i;
+	u32 ch;
 
 	ade = devm_kzalloc(dev->dev, sizeof(*ade), GFP_KERNEL);
 	if (!ade) {
@@ -1015,12 +1014,15 @@ static int ade_drm_init(struct platform_device *pdev)
 	 * TODO: Now only support primary plane, overlay planes
 	 * need to do.
 	 */
-	for (i = 0; i < ADE_CH_NUM; i++) {
-		kplane = &ade->planes[i];
-		kplane->ch = i;
+	for (ch = 0; ch < ade_driver_data.num_planes; ch++) {
+		kplane = &ade->planes[ch];
+		kplane->ch = ch;
 		kplane->hw_ctx = ctx;
-		type = i == PRIMARY_CH ? DRM_PLANE_TYPE_PRIMARY :
-			DRM_PLANE_TYPE_OVERLAY;
+
+		if (ch == ade_driver_data.prim_plane)
+			type = DRM_PLANE_TYPE_PRIMARY;
+		else
+			type = DRM_PLANE_TYPE_OVERLAY;
 
 		ret = ade_plane_init(dev, kplane, type);
 		if (ret)
@@ -1028,7 +1030,8 @@ static int ade_drm_init(struct platform_device *pdev)
 	}
 
 	/* crtc init */
-	ret = ade_crtc_init(dev, &kcrtc->base, &ade->planes[PRIMARY_CH].base);
+	ret = ade_crtc_init(dev, &kcrtc->base,
+			    &ade->planes[ade_driver_data.prim_plane].base);
 	if (ret)
 		return ret;
 
@@ -1047,6 +1050,8 @@ static const struct drm_mode_config_funcs ade_mode_config_funcs = {
 };
 
 struct kirin_drm_data ade_driver_data = {
+	.num_planes = ADE_CH_NUM,
+	.prim_plane = ADE_CH1,
 	.channel_formats = channel_formats,
 	.channel_formats_cnt = ARRAY_SIZE(channel_formats),
 	.crtc_helper_funcs = &ade_crtc_helper_funcs,
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
index ce9ddccc67a8..2b660df60293 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -37,6 +37,8 @@ struct kirin_plane {
 struct kirin_drm_data {
 	const u32 *channel_formats;
 	u32 channel_formats_cnt;
+	u32 num_planes;
+	u32 prim_plane;
 
 	const struct drm_crtc_helper_funcs *crtc_helper_funcs;
 	const struct drm_crtc_funcs *crtc_funcs;
-- 
2.17.1

