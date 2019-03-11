Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F91C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70952147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVMcRPSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfCKVBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:01:25 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34731 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbfCKVBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:01:25 -0400
Received: by mail-qt1-f193.google.com with SMTP id x20so241954qto.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 14:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=mwG+zHmuCaPJeXwYvKvLlC56+W7HMjxMgIZATYB69fo=;
        b=JVMcRPSuJeWepMuYXphIy+1fyq33EmsBtAzVtLw7q3uOvbBbWioDlYI/n2zQt3HYu9
         l1BMq5/iichDSb7EvAUSnBH6BoSrVmNQBX7MSf1fGfbbRriBFg+SNz4JEbQJj7ZrYB+6
         uSZ1zZp849RLUcCQ13/gYUntW3HKdx9uiQyfsbknYzY70vjgdFuH8WLjsxLMSKXIUf8O
         Bc4IqlEeverhwdve6eaLRoBl1vwTFy+fxiXkkHDCIOqgaRaI8+9gRBONIx7n1ghDKA+p
         Gt8jqFn9fBvH1TvFo5JU/wU+vhBQw9z/HYKLm3XZ5y8sHv1fmUBSDttMlgm4B6lGcn6c
         urrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=mwG+zHmuCaPJeXwYvKvLlC56+W7HMjxMgIZATYB69fo=;
        b=OfBQ1fkljb58q8oTrlX7M1TIXSHmHDMmGBSnssZCo2PAQt7jx+wZLNC3rmnMV57uPL
         mBI/mw+gU9QR5s3k6VFFGx0a1aTlFXs1+tEMzRbEUQ1MhiQGDlMYaUEPwbOHBoOoXSUt
         vlfPwaQpyn9rNcl8a+6abY3O8Gqm5kPUqZykAgT+03jKUh5K0/Q6otnuC/LdmS6k7p0q
         mYYZDJQ8Q3SYBkLj8Fpng6Az4d6j0lgAU6tQHtuyoEWefn2QwhqJduOmH15NNuR4XC/b
         cVJrq/VxlLI49JRtywYIU8A/2qp+vXWF2dWIWbWyqQXLqk/pUTYfB23ZAcgwuqmu8TgJ
         f8yQ==
X-Gm-Message-State: APjAAAVTLUMtaLohVt/iMsvg0s3kSa8yeDBQDkrdOjKmeahjZtcjvYX2
        FTpwdQsjN+bIC5ey26tiLcE=
X-Google-Smtp-Source: APXvYqxfvf7pB1CmraKzqEDgZYhqUMMyrzj1riqxCA/5zcIHpa4KbyAivIyMFKOUEEBDU21RbyhrEg==
X-Received: by 2002:ac8:1019:: with SMTP id z25mr8562670qti.85.1552338084040;
        Mon, 11 Mar 2019 14:01:24 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id z6sm4242504qtb.67.2019.03.11.14.01.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 11 Mar 2019 14:01:23 -0700 (PDT)
Date:   Mon, 11 Mar 2019 18:01:20 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/atomic-helper: Validate pointer before dereference
Message-ID: <20190311210120.fdixvenmqjoxuoqt@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function disable_outputs() and
drm_atomic_helper_commit_modeset_enables() tries to retrieve
helper_private from the target CRTC, for dereferencing some operations.
However, the current implementation does not check whether
helper_private is null and, if not, if it has a valid pointer to a dpms
and commit functions. This commit adds pointer validations before
trying to dereference the dpms and commit function.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 30 ++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 540a77a2ade9..fbeef7c461fc 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1028,14 +1028,16 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
 
 
 		/* Right function depends upon target state. */
-		if (new_crtc_state->enable && funcs->prepare)
-			funcs->prepare(crtc);
-		else if (funcs->atomic_disable)
-			funcs->atomic_disable(crtc, old_crtc_state);
-		else if (funcs->disable)
-			funcs->disable(crtc);
-		else
-			funcs->dpms(crtc, DRM_MODE_DPMS_OFF);
+		if (funcs) {
+			if (new_crtc_state->enable && funcs->prepare)
+				funcs->prepare(crtc);
+			else if (funcs->atomic_disable)
+				funcs->atomic_disable(crtc, old_crtc_state);
+			else if (funcs->disable)
+				funcs->disable(crtc);
+			else if (funcs->dpms)
+				funcs->dpms(crtc, DRM_MODE_DPMS_OFF);
+		}
 
 		if (!(dev->irq_enabled && dev->num_crtcs))
 			continue;
@@ -1277,11 +1279,13 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
 		if (new_crtc_state->enable) {
 			DRM_DEBUG_ATOMIC("enabling [CRTC:%d:%s]\n",
 					 crtc->base.id, crtc->name);
-
-			if (funcs->atomic_enable)
-				funcs->atomic_enable(crtc, old_crtc_state);
-			else
-				funcs->commit(crtc);
+			if (funcs) {
+				if (funcs->atomic_enable)
+					funcs->atomic_enable(crtc,
+							     old_crtc_state);
+				else if (funcs->atomic_enable)
+					funcs->commit(crtc);
+			}
 		}
 	}
 
-- 
2.21.0
