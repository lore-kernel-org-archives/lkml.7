Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1929C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815812184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 10:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="e1l3K37T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfCNKlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 06:41:25 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43287 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfCNKlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 06:41:25 -0400
Received: by mail-ed1-f68.google.com with SMTP id m35so4155178ede.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 03:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1MN4UARItAnk1V4JjuFJVbNZzUL8OQw0dh+ogZWJ23g=;
        b=e1l3K37TfpL3mJpyLsg41S0wVgEt/qkOHMa79vS4YXI7Ze9X2Z3Pk8jgMzfO7Z/Xsz
         LuytpMdnOUsXih58rDNWGhieLO8HikXlSB4XXDaAbeVLJYrtVXiEdOuCuPDOaLVZ4OxW
         q26q5VW/JEjECMSmz2hGWtpKl8bFsWUteTJLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=1MN4UARItAnk1V4JjuFJVbNZzUL8OQw0dh+ogZWJ23g=;
        b=SJ//6iP3iJ5BYc0oq3hbCVLwEJ6+kg42sihO5tQjM2O6K+bBfUJ5DCEOCasSRNpgSI
         vFYElbOgVIG1Fctqg1zPZm66vcxnJCql4ssgt0Jk/iFlPbope/qLWKwjsOa491FLzVqH
         Xp5XoR6V1KDRIrb+8I/hQbZAttR07LKZZY9HMC35DRYTN19S6LyD5UhjU6LxpABwKzN5
         m4ZWWPMTBzW4YqPoiVg7U60AUxJuSYpHihnpCs5XYjbI24X9uir6FSc45ejp8S7sZ8U0
         DmdAtuycgKgjEUlAWec/K7gNs0au9AbhYEmQ5uOILiND4KKpafQDZ3dRSeqNaoc7vNyX
         v8Ng==
X-Gm-Message-State: APjAAAVW6DjzMJTDmmYKBf9GtExoN20WwEuKkj2t4VK9JwbBKd7WGBME
        /bPjnwtMA9FiRvFY7gUKimrhVw==
X-Google-Smtp-Source: APXvYqxgcR4pvti+e+GNDSrlmO6Ltl8W0FzD3Kz4/dSQe/F42m8GGlfjFbTnlCHklNKGvI72QuT0tA==
X-Received: by 2002:a50:af81:: with SMTP id h1mr11060335edd.243.1552560083109;
        Thu, 14 Mar 2019 03:41:23 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id i5sm1003887eja.47.2019.03.14.03.41.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 03:41:22 -0700 (PDT)
Date:   Thu, 14 Mar 2019 11:41:20 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/doc: fix kerneldoc syntax
Message-ID: <20190314104120.GR2665@phenom.ffwll.local>
Mail-Followup-To: Luca Ceresoli <luca@lucaceresoli.net>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
References: <20190313153537.22654-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313153537.22654-1-luca@lucaceresoli.net>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 04:35:36PM +0100, Luca Ceresoli wrote:
> The probe() reference renders incorrectly and without a link, fix it.
> 
> Also fix a typo reported by checkpatch in the context lines.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  drivers/gpu/drm/drm_drv.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 381581b01d48..585f5d079046 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -264,13 +264,13 @@ void drm_minor_release(struct drm_minor *minor)
>   * DOC: driver instance overview
>   *
>   * A device instance for a drm driver is represented by &struct drm_device. This
> - * is initialized with drm_dev_init(), usually from bus-specific ->probe()
> - * callbacks implemented by the driver. The driver then needs to initialize all
> - * the various subsystems for the drm device like memory management, vblank
> - * handling, modesetting support and intial output configuration plus obviously
> - * initialize all the corresponding hardware bits. Finally when everything is up
> - * and running and ready for userspace the device instance can be published
> - * using drm_dev_register().
> + * is initialized with drm_dev_init(), usually from bus-specific
> + * &drm_driver.probe() callbacks implemented by the driver. The driver then

drm_driver.probe isn't a thing, and definitely not bus specific. What
could work here is:

"... instead of a bus specific probe function like e.g.
&pci_driver.probe or &platform_driver.probe."

When updating docs please make sure the rendering looks correct and the
hyperlinks all work.

Cheers, Daniel

> + * needs to initialize all the various subsystems for the drm device like memory
> + * management, vblank handling, modesetting support and initial output
> + * configuration plus obviously initialize all the corresponding hardware
> + * bits. Finally when everything is up and running and ready for userspace the
> + * device instance can be published using drm_dev_register().
>   *
>   * There is also deprecated support for initalizing device instances using
>   * bus-specific helpers and the &drm_driver.load callback. But due to
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
