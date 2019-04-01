Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3D4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A071320830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139902;
	bh=nY9Tg0EwRZUB7q4YUmtswoKzuzRFM1oxQZVHDHNo0xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uZa5/gSUCUKMUZMeEYNPg9bxl2GQ4O+MLAK+UL8yfUCAZz6J+VQjj6xCUgTdS9BeG
	 W5gfDu+KibnzOMMH63dY40+1sJCjY7F6WIFwX/nsIX34G5wyFap4NBAUzoVvEJamb1
	 QTFbhv+lHevDwZVJncfmmZHQI2REcgssOh6iAFUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733288AbfDARbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:31:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733078AbfDARbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:31:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 269132070B;
        Mon,  1 Apr 2019 17:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139897;
        bh=nY9Tg0EwRZUB7q4YUmtswoKzuzRFM1oxQZVHDHNo0xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LfBWlmFHuPBiMxQgv1yk0FHLCd2ZCr4i3QP1vZ1kTd9dffXW55Mx2ngEbuCvv+C5R
         5hm12RBI1D9hbhcv0NZLAPZjv2Kj1s47IaYnBQJdaun+c5ajzTwIQB4rXUEaPAU4gz
         Qkym+GM04vGHfvv/TY8f985IHCWxH6wKlHeJX2H8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
        Deepak Rawat <drawat@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH 4.4 002/131] drm/vmwgfx: Dont double-free the mode stored in par->set_mode
Date:   Mon,  1 Apr 2019 19:01:12 +0200
Message-Id: <20190401170051.875045312@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

commit c2d311553855395764e2e5bf401d987ba65c2056 upstream.

When calling vmw_fb_set_par(), the mode stored in par->set_mode gets free'd
twice. The first free is in vmw_fb_kms_detach(), the second is near the
end of vmw_fb_set_par() under the name of 'old_mode'. The mode-setting code
only works correctly if the mode doesn't actually change. Removing
'old_mode' in favor of using par->set_mode directly fixes the problem.

Cc: <stable@vger.kernel.org>
Fixes: a278724aa23c ("drm/vmwgfx: Implement fbdev on kms v2")
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Deepak Rawat <drawat@vmware.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
@@ -531,11 +531,9 @@ static int vmw_fb_set_par(struct fb_info
 		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 		DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_PVSYNC)
 	};
-	struct drm_display_mode *old_mode;
 	struct drm_display_mode *mode;
 	int ret;
 
-	old_mode = par->set_mode;
 	mode = drm_mode_duplicate(vmw_priv->dev, &new_mode);
 	if (!mode) {
 		DRM_ERROR("Could not create new fb mode.\n");
@@ -546,11 +544,7 @@ static int vmw_fb_set_par(struct fb_info
 	mode->vdisplay = var->yres;
 	vmw_guess_mode_timing(mode);
 
-	if (old_mode && drm_mode_equal(old_mode, mode)) {
-		drm_mode_destroy(vmw_priv->dev, mode);
-		mode = old_mode;
-		old_mode = NULL;
-	} else if (!vmw_kms_validate_mode_vram(vmw_priv,
+	if (!vmw_kms_validate_mode_vram(vmw_priv,
 					mode->hdisplay *
 					DIV_ROUND_UP(var->bits_per_pixel, 8),
 					mode->vdisplay)) {
@@ -613,8 +607,8 @@ static int vmw_fb_set_par(struct fb_info
 	schedule_delayed_work(&par->local_work, 0);
 
 out_unlock:
-	if (old_mode)
-		drm_mode_destroy(vmw_priv->dev, old_mode);
+	if (par->set_mode)
+		drm_mode_destroy(vmw_priv->dev, par->set_mode);
 	par->set_mode = mode;
 
 	drm_modeset_unlock_all(vmw_priv->dev);


