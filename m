Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD513C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5712075E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jWHFk6Xq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbfFSHtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 03:49:03 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33241 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfFSHtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 03:49:02 -0400
Received: by mail-ed1-f65.google.com with SMTP id i11so25796470edq.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 00:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9yRPqLsy9SzgWIOIK5gO9H41NqMgtH7z8Lf0epnTSe8=;
        b=jWHFk6XqsoYXocFpSE0gn/gHZJ/0TrxElZKm42Ipe0ZdlxBiXBmyo9fX4/WGgeDDO3
         8AYZ0F+ufO1zlDHVBmH9vwwSvpWZI8HJCpZq3I4Sx2ZL54GWsm81cgHwZAzplxF8c3Me
         oI3KswqH2dD74mtl53UCCeWZ6zPk1dUxbOPMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9yRPqLsy9SzgWIOIK5gO9H41NqMgtH7z8Lf0epnTSe8=;
        b=XcQyYj4AT9CzjAaaBQ3hz778vsC3sFThe5DTwcJDTRYgXqspeFYrPbdcGzuZ11UDkt
         NRqhb2GEU/tUVYNMH/0EE+Qr9fIroy/Y+LJ0jb7jKA9zPbgNQOB6NntG9Vtr9/KlJuKB
         FATLYuFEmUKLIka11dbVakg0bCEAWG6x8lyiGliIkFEDSX7fI6aF6qjdAtYPH958fsDs
         2hGr2+eqEClHcUK49kxQaLlG8sQYN2yKnIBVAV4V1a5a9lqyilvT0glfxhnqvCqeULAx
         hnrQiZcC8TcoobfHJquyUbedrN3tthdMJZCOANRmqPeDYOium0dBxMjVwAWWMmM/ilrR
         w3jw==
X-Gm-Message-State: APjAAAXmJZXe+nqDQIKORzoFVwTfTas5QtCExELVX858Vh7Uns19frfW
        o4Forgr/cdu48FObu83RJNB+IQ==
X-Google-Smtp-Source: APXvYqzcQ/qJVFreUUsYyuaxNjvBsBySdJhnXRVOLZg1dyo7u4fZwHatDwiE/NN42tCU6BsQTm39fg==
X-Received: by 2002:a50:883b:: with SMTP id b56mr36295341edb.178.1560930540342;
        Wed, 19 Jun 2019 00:49:00 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x4sm5546030eda.22.2019.06.19.00.48.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 00:48:59 -0700 (PDT)
Date:   Wed, 19 Jun 2019 09:48:56 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH V4] drm/drm_vblank: Change EINVAL by the correct errno
Message-ID: <20190619074856.GJ12905@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, intel-gfx@lists.freedesktop.org
References: <20190619020750.swzerehjbvx6sbk2@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190619020750.swzerehjbvx6sbk2@smtp.gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 11:07:50PM -0300, Rodrigo Siqueira wrote:
> For historical reason, the function drm_wait_vblank_ioctl always return
> -EINVAL if something gets wrong. This scenario limits the flexibility
> for the userspace make detailed verification of the problem and take
> some action. In particular, the validation of “if (!dev->irq_enabled)”
> in the drm_wait_vblank_ioctl is responsible for checking if the driver
> support vblank or not. If the driver does not support VBlank, the
> function drm_wait_vblank_ioctl returns EINVAL which does not represent
> the real issue; this patch changes this behavior by return EOPNOTSUPP.
> Additionally, some operations are unsupported by this function, and
> returns EINVAL; this patch also changes the return value to EOPNOTSUPP
> in this case. Lastly, the function drm_wait_vblank_ioctl is invoked by
> libdrm, which is used by many compositors; because of this, it is
> important to check if this change breaks any compositor. In this sense,
> the following projects were examined:
> 
> * Drm-hwcomposer
> * Kwin
> * Sway
> * Wlroots
> * Wayland-core
> * Weston
> * Xorg (67 different drivers)
> 
> For each repository the verification happened in three steps:
> 
> * Update the main branch
> * Look for any occurrence "drmWaitVBlank" with the command:
>   git grep -n "drmWaitVBlank"
> * Look in the git history of the project with the command:
>   git log -SdrmWaitVBlank
> 
> Finally, none of the above projects validate the use of EINVAL which
> make safe, at least for these projects, to change the return values.
> 
> Change since V3:
>  - Return EINVAL for _DRM_VBLANK_SIGNAL (Daniel)
> 
> Change since V2:
>  Daniel Vetter and Chris Wilson
>  - Replace ENOTTY by EOPNOTSUPP
>  - Return EINVAL if the parameters are wrong
> 

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Apologies for the confusion on the last time around. btw if someone tells
you "r-b (or a-b) with these changes", then just apply the r-b/a-b tag
next time around. Otherwise people will re-review the same thing over and
over again.
-Daniel

> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> ---
>  drivers/gpu/drm/drm_vblank.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 603ab105125d..bed233361614 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -1582,7 +1582,7 @@ int drm_wait_vblank_ioctl(struct drm_device *dev, void *data,
>  	unsigned int flags, pipe, high_pipe;
>  
>  	if (!dev->irq_enabled)
> -		return -EINVAL;
> +		return -EOPNOTSUPP;
>  
>  	if (vblwait->request.type & _DRM_VBLANK_SIGNAL)
>  		return -EINVAL;
> -- 
> 2.21.0

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
