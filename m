Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAF7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE61D2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Utd2BA6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfCNSsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 14:48:51 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44644 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbfCNSsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 14:48:50 -0400
Received: by mail-qt1-f193.google.com with SMTP id d2so7269647qti.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 11:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8cM79lmLd/ECaJiKfKdj2dQxFYEDPHOyvVSsOhDFry8=;
        b=Utd2BA6XENNVHrWhIbBeXCShQSo9xKdm8WX38mB+ar02fi6zzTTqsSsO0ltygm883m
         +8eGc+d+XVChiLGVNZdNVbpk1Ta5F5q6S96iOeFowMS9Eav40WLNQpOHHhUHYftTrvGY
         lAc2XEXxVp72V90VkrXIQj6ijRNn4ditOYXuQSYI4hFuwWlYFkTs0vsWBCNZcK8IrYtb
         xHAEzoLV+GKHhVPmR3hJCbsQV+cG9tUaoXtvoqy0NsIW2rGQO7npVuDMfYcdehsdSj3b
         iQxOc9RSKzDeWIz/CqaBwjwxr4BrFr3aY+2UtxO+wOuwbMo8H0MmsaqnEUBfhXlwDT2J
         EXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8cM79lmLd/ECaJiKfKdj2dQxFYEDPHOyvVSsOhDFry8=;
        b=YfSnzJ/BtqimTIb2H9TY4VoD6zBG3mTdzrSbnWCqS29zqvju17eS7idtmi6du+S0dy
         acSo5ULVNxGE7tws74J9FNfwbzUrVdyqKTPvIaNOgeCsc+OD8TUGInoO8B0F/cVlYwAu
         TPLpH4WGHktcSwi8cdNEeHmERn5LeTGYWX09lpEdS3/GubdxnsxudtxJIkRQ3G60+xoA
         Gm0Hid6yx0y9KDXcqpExsdA5PTQiuxdcaD0mGm3u5cIR7Z18JbH6JNDMJ3TpMA48CZ4j
         bJ8y2jyyfc3tK0PrstRmK9lN2wKBnghF9QeX0RsO5EFr+Y0+ePGdJhxWUMRcn4lTsuiy
         x+sg==
X-Gm-Message-State: APjAAAXHbEkaAeb39BUdMGON/6lF1SEHfJ08LI4y7HP2ovjPH1D8zf9G
        IO6oeLxDD1AXtsv+Huwzm6wf5grGqME=
X-Google-Smtp-Source: APXvYqwHyo8jiEIxF7tRdJf4YX/JzDpgBTnwhfniMYeEAR891xtbMIxizsZe2E/GdEU2QXf/IOrrcg==
X-Received: by 2002:ac8:1789:: with SMTP id o9mr41037678qtj.234.1552589329290;
        Thu, 14 Mar 2019 11:48:49 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id l129sm8696028qkb.44.2019.03.14.11.48.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 14 Mar 2019 11:48:48 -0700 (PDT)
Date:   Thu, 14 Mar 2019 15:48:45 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] drm/atomic-helper: Make atomic_enable/disable crtc
 callbacks optional
Message-ID: <20190314184845.gjmvkamobj4dilyp@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow atomic_enable and atomic_disable operations from
drm_crtc_helper_funcs struct optional. With this, the target display
drivers don't need to define a dummy function if they don't need one.

Changes since v2:
* Don't make funcs optional
* Update kerneldoc for atomic_enable/disable
* Replace "if (funcs->atomic_enable)" by "if (funcs->commit)"
* Improve commit message

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/drm_atomic_helper.c      | 5 ++---
 include/drm/drm_modeset_helper_vtables.h | 4 ++++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 540a77a2ade9..d506e13c2945 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1034,7 +1034,7 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
 			funcs->atomic_disable(crtc, old_crtc_state);
 		else if (funcs->disable)
 			funcs->disable(crtc);
-		else
+		else if (funcs->dpms)
 			funcs->dpms(crtc, DRM_MODE_DPMS_OFF);
 
 		if (!(dev->irq_enabled && dev->num_crtcs))
@@ -1277,10 +1277,9 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
 		if (new_crtc_state->enable) {
 			DRM_DEBUG_ATOMIC("enabling [CRTC:%d:%s]\n",
 					 crtc->base.id, crtc->name);
-
 			if (funcs->atomic_enable)
 				funcs->atomic_enable(crtc, old_crtc_state);
-			else
+			else if (funcs->commit)
 				funcs->commit(crtc);
 		}
 	}
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index cfb7be40bed7..ce4de6b1e444 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -418,6 +418,8 @@ struct drm_crtc_helper_funcs {
 	 * Drivers can use the @old_crtc_state input parameter if the operations
 	 * needed to enable the CRTC don't depend solely on the new state but
 	 * also on the transition between the old state and the new state.
+	 *
+	 * This function is optional.
 	 */
 	void (*atomic_enable)(struct drm_crtc *crtc,
 			      struct drm_crtc_state *old_crtc_state);
@@ -441,6 +443,8 @@ struct drm_crtc_helper_funcs {
 	 * parameter @old_crtc_state which could be used to access the old
 	 * state. Atomic drivers should consider to use this one instead
 	 * of @disable.
+	 *
+	 * This function is optional.
 	 */
 	void (*atomic_disable)(struct drm_crtc *crtc,
 			       struct drm_crtc_state *old_crtc_state);
-- 
2.21.0
