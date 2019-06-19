Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E041C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E86420863
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWuu1Ni7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfFSCIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 22:08:00 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39390 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfFSCH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 22:07:59 -0400
Received: by mail-ed1-f67.google.com with SMTP id m10so24644600edv.6;
        Tue, 18 Jun 2019 19:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=s9lpMBH/IugmiFXNYI6ZpyhR++3sMpJb2daAAUrg87c=;
        b=pWuu1Ni7Pj1W/hQq6vtS/AHazRgRHRM9Y7pAnxIHlPNPp6BXKMhcu6/Tn5/pJhbGQ5
         vPGGQLKsfjVFADDj+ujB57FNC1EWIjbJTvto5xsdO4cvQVbAfVinkdDrBbRPrbdw9F+I
         jklYuAY0LP1WIV2QiiCA36FGAMYk+MswrcAPW/Sfze4f491rr9WEqVlAqgB6+dQEJddA
         IuCq61M1lW1DJKw84V3pP9YP41wIR/AuOw4qzzZyWaRfjXQbl6ps/M5QAILuNMM5cVTE
         ehUjrIf8MRNDvanyPP30lFjG79ieh+IhvWp7g9VERKAKow8gzilKfGkm8C5LTnWFkUbm
         c7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=s9lpMBH/IugmiFXNYI6ZpyhR++3sMpJb2daAAUrg87c=;
        b=JDzVKgyYP3iFF4mrk/DE8jFtHZFMTnGS/rMnmCu9J8YG2y3dm3hKLBHoVN4fE+Nbq1
         ObDouB6cUsHO+D49BBpHRJ2YWMW4WhJ9SoO8nP5rLCHO/xvGiqdfRErGfpDmWb5dEWZ/
         BKRQPZLSmqA/6bulzwGcuAYMUnhovNqQDbCzE/g6+hP1NVZ6w4IfaIdZjrBrYqCJd0wE
         0wlwxs2H6c9Beo5kpc5qd1YNzjjVr4zaayZz+FWDUE3D+xe8kQxmGjI64Gh0nITiHwu9
         b/CPFA6WvISstBw63p9ImgmUKnxUZweWF+Ir+bvnpD9Qn7KwlDRiJLaiForvewIul/rX
         kU3w==
X-Gm-Message-State: APjAAAV1Qja+hAHyGwUWv9AFYrIRIloJAB7nCPrUVyNTSNyoHkpbiOAV
        fuB0Q95J4N2GmdL7IESS130=
X-Google-Smtp-Source: APXvYqyV3lljKw+wProWO8jUjFZkqDRUPrpL6ShZ5xRp5iz2PaEe1L1taSJ0vgFMnRqhprl/oGHqww==
X-Received: by 2002:a17:906:2301:: with SMTP id l1mr54424834eja.92.1560910077820;
        Tue, 18 Jun 2019 19:07:57 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.146])
        by smtp.gmail.com with ESMTPSA id k11sm1974837edq.54.2019.06.18.19.07.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 19:07:57 -0700 (PDT)
Date:   Tue, 18 Jun 2019 23:07:50 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: [PATCH V4] drm/drm_vblank: Change EINVAL by the correct errno
Message-ID: <20190619020750.swzerehjbvx6sbk2@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For historical reason, the function drm_wait_vblank_ioctl always return
-EINVAL if something gets wrong. This scenario limits the flexibility
for the userspace make detailed verification of the problem and take
some action. In particular, the validation of “if (!dev->irq_enabled)”
in the drm_wait_vblank_ioctl is responsible for checking if the driver
support vblank or not. If the driver does not support VBlank, the
function drm_wait_vblank_ioctl returns EINVAL which does not represent
the real issue; this patch changes this behavior by return EOPNOTSUPP.
Additionally, some operations are unsupported by this function, and
returns EINVAL; this patch also changes the return value to EOPNOTSUPP
in this case. Lastly, the function drm_wait_vblank_ioctl is invoked by
libdrm, which is used by many compositors; because of this, it is
important to check if this change breaks any compositor. In this sense,
the following projects were examined:

* Drm-hwcomposer
* Kwin
* Sway
* Wlroots
* Wayland-core
* Weston
* Xorg (67 different drivers)

For each repository the verification happened in three steps:

* Update the main branch
* Look for any occurrence "drmWaitVBlank" with the command:
  git grep -n "drmWaitVBlank"
* Look in the git history of the project with the command:
  git log -SdrmWaitVBlank

Finally, none of the above projects validate the use of EINVAL which
make safe, at least for these projects, to change the return values.

Change since V3:
 - Return EINVAL for _DRM_VBLANK_SIGNAL (Daniel)

Change since V2:
 Daniel Vetter and Chris Wilson
 - Replace ENOTTY by EOPNOTSUPP
 - Return EINVAL if the parameters are wrong

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/drm_vblank.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 603ab105125d..bed233361614 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1582,7 +1582,7 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
 	unsigned int flags, pipe, high_pipe;
 
 	if (!dev->irq_enabled)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	if (vblwait->request.type & _DRM_VBLANK_SIGNAL)
 		return -EINVAL;
-- 
2.21.0
