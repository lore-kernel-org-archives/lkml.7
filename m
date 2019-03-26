Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239DBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E717620879
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582336;
	bh=t5IaXVavHflhl10dC/hKSROJL5gzKCgpAmls42TcEtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FXT2e18hgmWvPOSIuIiOJvJKQCg31LK4VdQqG5vdPF/OuGbv26lNgf9WbD+et+Uhv
	 HzK0wqZ16y7oqDWRwWzTBwl1QIGm+o7Q2fuv8wccUEWtJZUPuPJ6kH2YXLApKNnVkQ
	 rAQ7iw2N9Qxm4VBl0OxJXiwia0R1YcIhMLi5mOMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732610AbfCZGiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:38:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731674AbfCZGiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:38:51 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AC5B20863;
        Tue, 26 Mar 2019 06:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582331;
        bh=t5IaXVavHflhl10dC/hKSROJL5gzKCgpAmls42TcEtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q6/Y1eOk2bTPA9asDhr4DQzRI7Ux76uGkTj4CYvCadF9vHggb2dLMPAqM3tN6YUSx
         dVKTaf9FH1YOh8sTddtkZMKBuZIBaML2FyRGMB2PgXaf4+QIErAtTplul8wQgLyDW4
         /iWHeITjbrKvgJi48CzPvj5iPaj6jS0HYwbjhoDQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
        Deepak Rawat <drawat@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH 5.0 08/52] drm/vmwgfx: Dont double-free the mode stored in par->set_mode
Date:   Tue, 26 Mar 2019 15:29:55 +0900
Message-Id: <20190326042701.371797731@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -564,11 +564,9 @@ static int vmw_fb_set_par(struct fb_info
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
@@ -579,11 +577,7 @@ static int vmw_fb_set_par(struct fb_info
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
@@ -620,8 +614,8 @@ static int vmw_fb_set_par(struct fb_info
 	schedule_delayed_work(&par->local_work, 0);
 
 out_unlock:
-	if (old_mode)
-		drm_mode_destroy(vmw_priv->dev, old_mode);
+	if (par->set_mode)
+		drm_mode_destroy(vmw_priv->dev, par->set_mode);
 	par->set_mode = mode;
 
 	mutex_unlock(&par->bo_mutex);


