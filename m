Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6B5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69B821773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="a3NQlXpq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbfC2Ifk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:35:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38876 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbfC2Ifj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:35:39 -0400
Received: by mail-ed1-f68.google.com with SMTP id q14so1294846edr.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 01:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+ZdFhwwiqQSWEHGRuBQZrT8aspWLzFfbpYFYWTarALE=;
        b=a3NQlXpqawv6jIaPK1UPmfS/miE7rG8c85wJoXiREKQ2IpLJtWKK1dtyvDN/ItaOSd
         lcExuT48Kmw2jwL+3TZoJyMT5UhzUjDU0reiuYVO8n7fjdPyGkXKHW4zUgmmLb740jXZ
         eQV5OTwtQfY4+EEaDcPEjEwAOsyNtaOXsB+Xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=+ZdFhwwiqQSWEHGRuBQZrT8aspWLzFfbpYFYWTarALE=;
        b=fo7z/68eDH/M3YcCS51yWspmbEcoB8M4/QoaSJhSR3XBGjLY0qWaDmGqz72NXVMAdL
         a6+SR+hQT4zb3cxjblnKBFyBc07ixK5b5PMUxhYeT8hBQSQpE8iMRHgSwuVZbenbfv0r
         Q6BNLaqe82i+h7AkbWdJ6mzfDM0yAa/C7pLVvucj+klz30aw/S8h+xucffR1L1+DS323
         D5b+oC9IL/T7Ti8QoJZEo3Ozlkc+z30u+h+X73Htju4mxF22VLH8ArmqZEBqzM0xVR5g
         bURVP4MwaPhVhtbT/81YlZodKManp87XgjZOcX1DzzUI8o9SoXbf54tSCp/PXTyddM+w
         vGtw==
X-Gm-Message-State: APjAAAXQkOpCx6rr7yd3Bn93jtnGKxXcg6uO7fC1anu3ujhkIpuv36wL
        nbARLT4F905pu0OAZnVn2zM4+g==
X-Google-Smtp-Source: APXvYqwXRl8xdRMlcF25bYelrCy/7Q4bo0hw0/eJx99P+4kkqRjPLBwK4iJKBHX05bCc0+Oc6pVebQ==
X-Received: by 2002:a17:906:708d:: with SMTP id b13mr25350179ejk.120.1553848537347;
        Fri, 29 Mar 2019 01:35:37 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id d20sm473120eda.82.2019.03.29.01.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 01:35:36 -0700 (PDT)
Date:   Fri, 29 Mar 2019 09:35:34 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 1/2] drm/file: Rehabilitate the firstopen hook for
 non-legacy drivers
Message-ID: <20190329083534.GC2665@phenom.ffwll.local>
Mail-Followup-To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Eric Anholt <eric@anholt.net>, Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20190328161306.22757-1-paul.kocialkowski@bootlin.com>
 <20190328161306.22757-2-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328161306.22757-2-paul.kocialkowski@bootlin.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 05:13:05PM +0100, Paul Kocialkowski wrote:
> The firstopen DRM driver hook was initially used to perform hardware
> initialization, which is now considered legacy. Only a single user of
> firstopen remains at this point (savage).
> 
> In some specific cases, non-legacy drivers may also need to implement
> these hooks. For instance on VC4, we need to allocate a 16 MiB buffer
> for the GPU. Because it's not required for fbcon, it's a waste to
> allocate it before userspace starts using the DRM device.
> 
> Using firstopen and lastclose for this allocation seems like the best
> fit, so re-habilitate the hook to allow it to be called for non-legacy
> drivers.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> Reviewed-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/gpu/drm/drm_file.c | 3 +--
>  include/drm/drm_drv.h      | 3 ---
>  2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index b1838a41ad43..c011b5cbfb6b 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -266,8 +266,7 @@ static int drm_setup(struct drm_device * dev)
>  {
>  	int ret;
>  
> -	if (dev->driver->firstopen &&
> -	    drm_core_check_feature(dev, DRIVER_LEGACY)) {
> +	if (dev->driver->firstopen) {

If you guys insist on this (still not a fan myself) pls pull it out of
drm_setup - that's all just legacy hw setup in there. I still think
tracking this a bit more accurately (if you want to bother with this)
would be better.
-Daniel

>  		ret = dev->driver->firstopen(dev);
>  		if (ret != 0)
>  			return ret;
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index ca46a45a9cce..de5637494503 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -234,9 +234,6 @@ struct drm_driver {
>  	 * kernel driver does not really own the hardware. Instead ownershipe is
>  	 * handled with the help of userspace through an inheritedly racy dance
>  	 * to set/unset the VT into raw mode.
> -	 *
> -	 * Legacy drivers initialize the hardware in the @firstopen callback,
> -	 * which isn't even called for modern drivers.
>  	 */
>  	void (*lastclose) (struct drm_device *);
>  
> -- 
> 2.21.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
