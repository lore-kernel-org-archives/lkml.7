Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADA6C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C799206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CK3YSSqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfDPMTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:19:14 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42711 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfDPMTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 08:19:13 -0400
Received: by mail-ed1-f67.google.com with SMTP id x61so17674699edc.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 05:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nHF9XJqFQuD9UoI91jWbQxMStT/2DXQZkyAN+huoJF4=;
        b=CK3YSSqOta8CqNFWYr9y/P5bRo+ZqohsiBrBp/NVf/6msnRSCr6qhMl1rWGH7CnS10
         iwBgBHT3MrPIBiiIbn6ebodO5ItKGVynovFc3U+N+KBJCTaebTSUyem4NqtOdbgrDhve
         0l9EA+VUPcd8bXcf566ljECzjQsbbxuCCq6AQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=nHF9XJqFQuD9UoI91jWbQxMStT/2DXQZkyAN+huoJF4=;
        b=choepsC+wBSAqMmGvJJV4MnqFfAksB1nSqXxzjzFJuWUAd093393fhXPDZLu882JYV
         h1n4VE8Vx99hnzRtbbqVtGoLg604KxIY7cXdNvgBjhGKXDjUrFWRzP1McrmY8HhMbj5y
         HvPyP4Y8D1Cg307cRKRbTR+bJj8XfKZHrcxKx1lBrIdRtQGQLIiMFUm+mmoPF9YBxdIy
         m7dBNcnhDHbHDv4HopmPEUU6V6R0mYPV3TPH4G/1POlSNhWlCj2vVhrJV172Ao+5Jbyk
         gwN6T/Ac3HhdQzxxc5YCR45IAew8n930eXqF6oncA31Mm0EMMdxFghTXzWY4gGcLY6vv
         /6sQ==
X-Gm-Message-State: APjAAAU+0Ph5zhyhB+TRbPoD9UNwxF96agaX995M5Ze/7OFFo9UKfdvt
        GNNDGz9sOkyWM4+Db4ipCzWuBw==
X-Google-Smtp-Source: APXvYqwJ2gNREaibz9YH4XUsPh0OuK6xFHBg6KArJGqJ/0JZjt8DCBYpDwfTkmDWe3Qw1tZLmqo2fg==
X-Received: by 2002:a50:9265:: with SMTP id j34mr16893394eda.243.1555417151484;
        Tue, 16 Apr 2019 05:19:11 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id g14sm5452648ejs.49.2019.04.16.05.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 05:19:10 -0700 (PDT)
Date:   Tue, 16 Apr 2019 14:19:08 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: add drm_format_helper.c to kerneldoc
Message-ID: <20190416121908.GH13337@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190416090533.28374-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416090533.28374-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 11:05:33AM +0200, Gerd Hoffmann wrote:
> Also drop the dstclip parameter sphinx has warned about (leftolver from
> an earlier patch version).
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Assuming it all builds cleanly and all the links work and no warnings from
sphinx:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/drm_format_helper.c   | 1 -
>  Documentation/gpu/drm-kms-helpers.rst | 6 ++++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
> index da388012df2a..a18da35145b7 100644
> --- a/drivers/gpu/drm/drm_format_helper.c
> +++ b/drivers/gpu/drm/drm_format_helper.c
> @@ -235,7 +235,6 @@ static void drm_fb_xrgb8888_to_rgb888_line(u8 *dbuf, u32 *sbuf,
>   * @vaddr: XRGB8888 source buffer
>   * @fb: DRM framebuffer
>   * @clip: Clip rectangle area to copy
> - * @dstclip: Clip destination too.
>   *
>   * Drivers can use this function for RGB888 devices that don't natively
>   * support XRGB8888.
> diff --git a/Documentation/gpu/drm-kms-helpers.rst b/Documentation/gpu/drm-kms-helpers.rst
> index 58b375e47615..14102ae035dc 100644
> --- a/Documentation/gpu/drm-kms-helpers.rst
> +++ b/Documentation/gpu/drm-kms-helpers.rst
> @@ -107,6 +107,12 @@ fbdev Helper Functions Reference
>  .. kernel-doc:: drivers/gpu/drm/drm_fb_helper.c
>     :export:
>  
> +format Helper Functions Reference
> +=================================
> +
> +.. kernel-doc:: drivers/gpu/drm/drm_format_helper.c
> +   :export:
> +
>  Framebuffer CMA Helper Functions Reference
>  ==========================================
>  
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
