Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D51C31E5C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3EA2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 02:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8VmLcSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfFRCnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 22:43:55 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43862 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFRCny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 22:43:54 -0400
Received: by mail-qk1-f195.google.com with SMTP id m14so7589527qka.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 19:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nX4Lct0hRbElfJ7uVhNvumeaI9+AxXzXyu4vjSUGo1M=;
        b=j8VmLcSzvjdb/VBg88RycwCMFYoVkDiyB70BREVjLnI/rS6u7tf/YgKFXMOIV7OKHB
         8VPlv8dGUplv7FJGFKjN0ABKXZMTHe41UEEUvXk6p7BtBJZ1D6szk37oWN7ZKgb6Qpgs
         14eohDBOf87aorOYeSkujUDc9oX9h/+dDCOLawoClLJ1qfRQdTMak3OFX9iG9F0V/0c8
         pr4tRwousOtxRo2gbdlnWu2B/kvd0Zb8f3dUepLMfPlrKHRceNrLX1w8uGZm8u3G7ics
         lXf2VT2u2YBom8lUs7lotfXTJ+wwuUioh1iqUgoaA2DrZoztAYGlDE7lMHuMIs+cmOAj
         FSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nX4Lct0hRbElfJ7uVhNvumeaI9+AxXzXyu4vjSUGo1M=;
        b=C1xym+L054TJQqG+xFfEosd5YXfb81O0jlzD/hIvlYWX3WxQXeHPqwmIqIpsVjhTTw
         dOkhm+5i+h1SMUVuTdmXG7vML4euU/T3jwTpLYXLeYIlC+xtzTEBBa27IbQpsUmKvXtc
         PyccWySgi8pgw/b7RpDBBWMSl4OhULufmZaG0wwelDLmdryivMSzx1jPPl5DPfkFnxf7
         hpL/Gtbl8MYpZWZ0wZ87XU8LH1IeIX8S9K86qwv6wZ+ob4P8S9JGAwsEsCsfiwoePu2j
         XaxZop75BfQXp6aItuUVXykSe9rZy6S56vgmkpH9LqknYMDS38UCbbA3ajNsV5LhPWh4
         DpZA==
X-Gm-Message-State: APjAAAXyrODfBHAXYFg6DpuZD2fRe/MnKZpFuXU3povc+PoJsRObWhuu
        Tr5++wqbZGFPYdCvW1Cvkd8=
X-Google-Smtp-Source: APXvYqxaHjMOISQ9guRRmzpA9K7fPxEPwKahaqRJEEU3Oyiu+UsHUkxZRTlsd8Vnef+dSkF65wG1AA==
X-Received: by 2002:a05:620a:1407:: with SMTP id d7mr80111271qkj.20.1560825833481;
        Mon, 17 Jun 2019 19:43:53 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.146])
        by smtp.gmail.com with ESMTPSA id n10sm7926370qke.72.2019.06.17.19.43.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 19:43:53 -0700 (PDT)
Date:   Mon, 17 Jun 2019 23:43:48 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/5] drm/vkms: Rename crc_enabled to composer_enabled
Message-ID: <1ac8e97f5884ad441e849c0399cd48ed8b6df5cb.1560820888.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1560820888.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1560820888.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename crc_enabled to composer_enabled since it does more than just
compute a CRC.

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_crc.c  | 2 +-
 drivers/gpu/drm/vkms/vkms_crtc.c | 2 +-
 drivers/gpu/drm/vkms/vkms_drv.h  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_crc.c b/drivers/gpu/drm/vkms/vkms_crc.c
index 3c6a35aba494..8b215677581f 100644
--- a/drivers/gpu/drm/vkms/vkms_crc.c
+++ b/drivers/gpu/drm/vkms/vkms_crc.c
@@ -165,7 +165,7 @@ int vkms_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 	ret = vkms_crc_parse_source(src_name, &enabled);
 
 	spin_lock_irq(&out->lock);
-	out->crc_enabled = enabled;
+	out->composer_enabled = enabled;
 	spin_unlock_irq(&out->lock);
 
 	return ret;
diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 14156ed70415..24a3ff0f7ff1 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -25,7 +25,7 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
 		DRM_ERROR("vkms failure on handling vblank");
 
 	state = output->crc_state;
-	if (state && output->crc_enabled) {
+	if (state && output->composer_enabled) {
 		u64 frame = drm_crtc_accurate_vblank_count(crtc);
 
 		/* update frame_start only if a queued vkms_crc_work_handle()
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 4e7450111d45..a887c05ff70e 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -72,7 +72,7 @@ struct vkms_output {
 	spinlock_t lock;
 
 	/* protected by @lock */
-	bool crc_enabled;
+	bool composer_enabled;
 	struct vkms_crtc_state *crc_state;
 
 	spinlock_t crc_lock;
-- 
2.21.0
