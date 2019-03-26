Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC486C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E85F20870
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582014;
	bh=dUA2IVFFiGz1KmODiGHA2nfjA4l2gBnFvY0uraXyLRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f29CW9l4ZuCCbPCj0G3kG0KT05wwaOxloirl4g0ZzOCasfF6d6nbyKP7kxWuIDz0Y
	 X/TdMzS9K6aZYo3Gufwk4uuQ+WULLPATdAmxU0hJDXkcUJ4+sCHhr6qLsysY21kwmo
	 6EmwoNjTLGQLalb+aLSLVY9RztCsnZo9KRSA7QkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbfCZGdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:33:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731639AbfCZGd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:33:28 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCFA820863;
        Tue, 26 Mar 2019 06:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582007;
        bh=dUA2IVFFiGz1KmODiGHA2nfjA4l2gBnFvY0uraXyLRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mokOOYvednkScL/Cr7FAFDKKZQEiN/dJOAtBveZgh321lDuBkQbuH2zNAWYVjKxm6
         w1E44SdERu5djTycNdFsrB2METWa30K6iWK3vSYUiAGMXIdghFgFQEXRe1aK29MJCx
         QI6COM9oiUaMdmKLXyof/GV3mobsNAFJj0T48rJc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
        Deepak Rawat <drawat@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH 4.14 02/41] drm/vmwgfx: Dont double-free the mode stored in par->set_mode
Date:   Tue, 26 Mar 2019 15:29:39 +0900
Message-Id: <20190326042650.024082856@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042649.889479098@linuxfoundation.org>
References: <20190326042649.889479098@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -588,11 +588,9 @@ static int vmw_fb_set_par(struct fb_info
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
@@ -603,11 +601,7 @@ static int vmw_fb_set_par(struct fb_info
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
@@ -677,8 +671,8 @@ static int vmw_fb_set_par(struct fb_info
 	schedule_delayed_work(&par->local_work, 0);
 
 out_unlock:
-	if (old_mode)
-		drm_mode_destroy(vmw_priv->dev, old_mode);
+	if (par->set_mode)
+		drm_mode_destroy(vmw_priv->dev, par->set_mode);
 	par->set_mode = mode;
 
 	drm_modeset_unlock_all(vmw_priv->dev);


