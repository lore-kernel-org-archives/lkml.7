Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44529C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E8B2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PIX/20a1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfFYUAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 16:00:48 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35979 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfFYUAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 16:00:48 -0400
Received: by mail-ed1-f68.google.com with SMTP id k21so28982983edq.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 13:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XpssnUNoV7k9sQMHO8u9aDEFoNx7wYIClQf7/yQbUY0=;
        b=PIX/20a13tlopYe5MjZtkxue6i24rmBvsP45Uiux0CQpbkmxtwGpmr/7eBjkm/2Axl
         0aQ8usb3w2c2JOtuXgx4gF82Z1W19tko4V3qoPKi8HdA9PTi6VLZjiZp9BhBq89SYYD9
         qVxpy44xV8uXY/jXVybR2J2JeSneJOQZ5zJ7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=XpssnUNoV7k9sQMHO8u9aDEFoNx7wYIClQf7/yQbUY0=;
        b=BFnbsGpWrs3SXgRQEG5/z7OVmkYWKOQwK6/PTajYhQIvZq5sM4otYkELf2DsHFFnEc
         CHMeqjsYUDrNpPoMjDqDCB/QkB38z+yCALOQEcQ67S6BUkpsltceaZMlYxbsZ1tl8Z8G
         AGYcvormH1ypSD94/uR1iNBcSFOXOv4tx9Ll+hQ6AkfqSvpzar5SUHiii+HTXMsfUqiQ
         cOfatkslvU1HOo0sU52HAnJeUmUKvDN5gZEZJgiF4JlW6lf1w8MQHFsBsYDwCFFn4AT4
         a86zZh9k6cUtaGZOz9lDM47cQxQ08R5+wNflsc16xZFApkvH72TT/Z9Av4zAINEdAm/2
         Lq6A==
X-Gm-Message-State: APjAAAVzjAe7e2K7IQ/FNq9BFd6x7bdxxS2uIaBLVZxXhqu6W+zSJRs4
        lkeJpyMBkcQH+wpH3ZMXcwxCb4uT0ic=
X-Google-Smtp-Source: APXvYqyTG93tA0iWwTWOk0YKYXLBLmXwTvzv6iuPCZBZPgk9VTRMb9iAhySyAfex9vBXh+r0aKQJ/w==
X-Received: by 2002:a17:906:facc:: with SMTP id lu12mr294752ejb.307.1561492845979;
        Tue, 25 Jun 2019 13:00:45 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id ay16sm304756ejb.2.2019.06.25.13.00.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 13:00:45 -0700 (PDT)
Date:   Tue, 25 Jun 2019 22:00:42 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Robert Beckett <bob.beckett@collabora.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] drm/vblank: warn on sending stale event
Message-ID: <20190625200042.GC12905@phenom.ffwll.local>
Mail-Followup-To: Robert Beckett <bob.beckett@collabora.com>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1561483965.git.bob.beckett@collabora.com>
 <a21034afa30246f31daa16e74a0772377a4791ef.1561483965.git.bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a21034afa30246f31daa16e74a0772377a4791ef.1561483965.git.bob.beckett@collabora.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 06:59:12PM +0100, Robert Beckett wrote:
> Warn when about to send stale vblank info and add advice to
> documentation on how to avoid.
> 
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> ---
>  drivers/gpu/drm/drm_vblank.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 603ab105125d..7dabb2bdb733 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -918,6 +918,19 @@ EXPORT_SYMBOL(drm_crtc_arm_vblank_event);
>   *
>   * See drm_crtc_arm_vblank_event() for a helper which can be used in certain
>   * situation, especially to send out events for atomic commit operations.
> + *
> + * Care should be taken to avoid stale timestamps. If:
> + *   - your driver has vblank support (i.e. dev->num_crtcs > 0)
> + *   - the vblank irq is off (i.e. no one called drm_crtc_vblank_get)

drm_crtc_vblank_get() so it becomes a neat hyperlink.

> + *   - from the vblank code's pov the pipe is still running (i.e. not
> + *     in-between a drm_crtc_vblank_off()/on() pair)

Not sure the above will lead to great markup, maybe spell out the
drm_crtc_vblank_on() and maybe make it a bit clearer like "i.e. not after
the call to drm_crtc_vblank_off() but before the next call to
drm_crtc_vblank_on()" so it's clear which said of this pair we're talking
about.

> + * If all of these conditions hold then drm_crtc_send_vblank_event is

style nit: the enumeration is one sentence (and and oxford comman missing
but whatever), but you don't continue it here. Also, does the enumeration
look pretty in the htmldocs output?

> + * going to give you a garbage timestamp and and sequence number (the last
> + * recorded before the irq was disabled). If you call drm_crtc_vblank_get/put
> + * around it, or after vblank_off, then either of those will have rolled things
> + * forward for you.

Again pls fix the markup so all the function reference stick out and work.

> + * So, drivers should call drm_crtc_vblank_off() before this function in their
> + * crtc atomic_disable handlers.

Imo this sentence here is needed but a bit confusing, and we have it
documented already in the atomic_disable hook.

Other option would be to list all the places where a driver might want to
call this and how they could get it wrong, which imo doesn't make sense.

With the nits addressed:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

>   */
>  void drm_crtc_send_vblank_event(struct drm_crtc *crtc,
>  				struct drm_pending_vblank_event *e)
> @@ -925,8 +938,12 @@ void drm_crtc_send_vblank_event(struct drm_crtc *crtc,
>  	struct drm_device *dev = crtc->dev;
>  	u64 seq;
>  	unsigned int pipe = drm_crtc_index(crtc);
> +	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
>  	ktime_t now;
>  
> +	WARN_ONCE(dev->num_crtcs > 0 && !vblank->enabled && !vblank->inmodeset,
> +		  "sending stale vblank info\n");
> +
>  	if (dev->num_crtcs > 0) {
>  		seq = drm_vblank_count_and_time(dev, pipe, &now);
>  	} else {
> -- 
> 2.18.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
