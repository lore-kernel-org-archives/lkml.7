Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644D1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2174B218E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fswIhIsu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732290AbfB1KLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:11:12 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38879 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730388AbfB1KLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:11:12 -0500
Received: by mail-ed1-f65.google.com with SMTP id h58so16479359edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 02:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bo9i7KTcXtQgv0/VH5T4anA0mqi+UDd8Bz47QK2nyg0=;
        b=fswIhIsubAuYojF7/+g1ckjSJRws+t0IgkxiD0PK02wHfcEhdJr3AXcm9zcGUEkS34
         Sy9VzE7Pqu2LvMRCKgmvbY5qPu4NU0mezp4gJX0j+LliBJlBnZSEa0qpPod6irtgE0DX
         OV04LUrM+YmCpFVICtZoEwIOm9U7TosMIYMwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=bo9i7KTcXtQgv0/VH5T4anA0mqi+UDd8Bz47QK2nyg0=;
        b=KREg61v7T5D6W6eWl47eKw/ZHzwnE44R60LQsiaJiSrw4krJXHAUW3eBWgsNdTvRVM
         frwTSNyDoai4MJqyvf14EPqBmKes8zuEtr2ObDWSJNLN7zJPzZS9ry+eaDMI1SMrUn5g
         bMe6rxuwLTyTw35KFd9NhFkptKFg1ToDm6tcwqfaCEg2f3mX12ddvShHP25lFpuZ5jt0
         txuieQFhmfn6lsW+dcaC85KkGDwnBrDP0me/kAT3O0pm7Yw+/kN0Q5tderMOPlEAbkh1
         WtJou6FUIuCh2seJFbDD10NW9h/Qe4gsuT1ABvOM1SRGWC2YTMU4+il9bKwigzwtTLuV
         4k2A==
X-Gm-Message-State: AHQUAuZYCyIqjmDt+KDvkae+ENJwNjzhSiTvI+z0leHACAu1Hcy1EU3c
        NL0q8lz6m9l29bbUg1KnqYjf5g==
X-Google-Smtp-Source: AHgI3IYK89op/F5ZMU6LKU9NjidMocatKc0JaD402C20PzTk8y/zD2J1N8Eq+25oSkolni4tfO5nPw==
X-Received: by 2002:a17:906:a30f:: with SMTP id j15mr4824230ejz.109.1551348670483;
        Thu, 28 Feb 2019 02:11:10 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id z39sm2899437edc.96.2019.02.28.02.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 02:11:09 -0800 (PST)
Date:   Thu, 28 Feb 2019 11:11:07 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Shayenne Moura <shayenneluzmoura@gmail.com>
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: Solve bug on kms_crc_cursor tests
Message-ID: <20190228101107.GL2665@phenom.ffwll.local>
Mail-Followup-To: Shayenne Moura <shayenneluzmoura@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20190225142606.gov32asdq3qe375q@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225142606.gov32asdq3qe375q@smtp.gmail.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 11:26:06AM -0300, Shayenne Moura wrote:
> vkms_crc_work_handle needs the value of the actual frame to
> schedule the workqueue that calls periodically the vblank
> handler and the destroy state functions. However, the frame
> value returned from vkms_vblank_simulate is updated and
> diminished in vblank_get_timestamp because it is not in a
> vblank interrupt, and return an inaccurate value.
> 
> Solve this getting the actual vblank frame directly from the
> vblank->count inside the `struct drm_crtc`, instead of using
> the `drm_accurate_vblank_count` function.
> 
> Signed-off-by: Shayenne Moura <shayenneluzmoura@gmail.com>

Sorry for the delay, I'm a bit swamped right now :-/

Debug work you're doing here is really impressive! But I have no idea
what's going on. It doesn't look like it's just papering over a bug (like
the in_vblank_irq check we've discussed on irc), but I also have no idea
why it works.

I'll pull in Ville, he understands this better than me.
-Daniel

> ---
>  drivers/gpu/drm/vkms/vkms_crc.c  | 4 +++-
>  drivers/gpu/drm/vkms/vkms_crtc.c | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_crc.c b/drivers/gpu/drm/vkms/vkms_crc.c
> index d7b409a3c0f8..09a8b00ef1f1 100644
> --- a/drivers/gpu/drm/vkms/vkms_crc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crc.c
> @@ -161,6 +161,8 @@ void vkms_crc_work_handle(struct work_struct *work)
>  	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
>  	struct vkms_device *vdev = container_of(out, struct vkms_device,
>  						output);
> +	unsigned int pipe = drm_crtc_index(crtc);
> +	struct drm_vblank_crtc *vblank = &crtc->dev->vblank[pipe];
>  	struct vkms_crc_data *primary_crc = NULL;
>  	struct vkms_crc_data *cursor_crc = NULL;
>  	struct drm_plane *plane;
> @@ -196,7 +198,7 @@ void vkms_crc_work_handle(struct work_struct *work)
>  	if (primary_crc)
>  		crc32 = _vkms_get_crc(primary_crc, cursor_crc);
>  
> -	frame_end = drm_crtc_accurate_vblank_count(crtc);
> +	frame_end = vblank->count;
>  
>  	/* queue_work can fail to schedule crc_work; add crc for
>  	 * missing frames
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index 8a9aeb0a9ea8..9bf3268e2e92 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -10,6 +10,8 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
>  						  vblank_hrtimer);
>  	struct drm_crtc *crtc = &output->crtc;
>  	struct vkms_crtc_state *state = to_vkms_crtc_state(crtc->state);
> +	unsigned int pipe = drm_crtc_index(crtc);
> +	struct drm_vblank_crtc *vblank = &crtc->dev->vblank[pipe];
>  	u64 ret_overrun;
>  	bool ret;
>  
> @@ -20,7 +22,7 @@ static enum hrtimer_restart vkms_vblank_simulate(struct hrtimer *timer)
>  		DRM_ERROR("vkms failure on handling vblank");
>  
>  	if (state && output->crc_enabled) {
> -		u64 frame = drm_crtc_accurate_vblank_count(crtc);
> +		u64 frame = vblank->count;
>  
>  		/* update frame_start only if a queued vkms_crc_work_handle()
>  		 * has read the data
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
