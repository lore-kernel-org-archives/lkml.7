Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C360C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599B5206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LnjvjKG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfDPHY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:24:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46743 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfDPHY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:24:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id d1so16939823edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 00:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=++7GNxojVLlwznIFjjwVt5D6h/jm9btpA+lc+r10FF4=;
        b=LnjvjKG4+1gvHHKqt+GrmossZ+Cam5CQvr306UV2C0YVdAYmVbHh5mSJ1O7MmSDLl1
         MAxudnSTnaDkvolyi9OAfMwZsznm6XasRIZWvr+dLj5w4NHDdEhehn6zTMp5DG3soFhM
         pdug8gA/L4BbwQE1pf2EIimiIlFuVpRL6t0o0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=++7GNxojVLlwznIFjjwVt5D6h/jm9btpA+lc+r10FF4=;
        b=RIn/lAGjQ4PIYzEZ0pPBJPSmEsnqNZcEEjJxabpK3I9yHz5J2Ku+nNaHpDignJYGkA
         IqqXwLrREJNwgd/XS907Rxa1DLnzDHGpWSA3v9jZA4jcSoJpSeFCWb8VLHdzTM/dG9af
         fFk77moJOkmoP2BbPSXRfuQwykF1BLlC2ezCqzGWJnzS5xH35f0W44QcPIX2FJDYCKyJ
         /goGdt6iwa/IzZuA8XDWl03JToD0tsS67c+/BgkO5OajFx9UKgH8picCBe31tXBO0vof
         Q/2NaRu+akzp3r0DmdFfzV6pg7vEYzzPNybgPRBe2DD2Hd5AbBXWda1GCZmOu7i+nJaY
         3Jjw==
X-Gm-Message-State: APjAAAULlVVL9c/nvVTvxtGS8W3IwLdpKUSa6iVOtT7e6SKLQ8o3yJXV
        iRhV9eLqzcPLj5QscCr7IYP2hg==
X-Google-Smtp-Source: APXvYqzxkXrC1BjZF3W+95CROoGuedoLjl82otWOcyzcZcd6uaVIHO+QVl1NT16GDQFSPFEr7I38eQ==
X-Received: by 2002:a50:eacb:: with SMTP id u11mr44725846edp.212.1555399496177;
        Tue, 16 Apr 2019 00:24:56 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id y5sm9315547eds.7.2019.04.16.00.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 00:24:55 -0700 (PDT)
Date:   Tue, 16 Apr 2019 09:24:53 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: fix drm_fb_xrgb8888_to_rgb888_dstclip()
Message-ID: <20190416072453.GL2665@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20190411044932.13247-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411044932.13247-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 06:49:32AM +0200, Gerd Hoffmann wrote:
> Oops, the __iomem annotation was added to the header file only.
> Add it to the implementation (and documentation) too.
> 
> Fixes: 5c5373b51bec ("drm: switch drm_fb_xrgb8888_to_rgb888_dstclip to accept __iomem dst")
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/drm_format_helper.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
> index 319de608a088..da388012df2a 100644
> --- a/drivers/gpu/drm/drm_format_helper.c
> +++ b/drivers/gpu/drm/drm_format_helper.c
> @@ -230,7 +230,7 @@ static void drm_fb_xrgb8888_to_rgb888_line(u8 *dbuf, u32 *sbuf,
>  
>  /**
>   * drm_fb_xrgb8888_to_rgb888_dstclip - Convert XRGB8888 to RGB888 clip buffer
> - * @dst: RGB565 destination buffer
> + * @dst: RGB565 destination buffer (iomem)
>   * @dst_pitch: destination buffer pitch
>   * @vaddr: XRGB8888 source buffer
>   * @fb: DRM framebuffer
> @@ -241,9 +241,9 @@ static void drm_fb_xrgb8888_to_rgb888_line(u8 *dbuf, u32 *sbuf,
>   * support XRGB8888.
>   *
>   * This function applies clipping on dst, i.e. the destination is a
> - * full framebuffer but only the clip rect content is copied over.
> + * full (iomem) framebuffer but only the clip rect content is copied over.
>   */

All this nice kerneldoc isn't pulled into the docs in
Documentation/gpu/drm-kms-helper.rst anywhere. Can you pls fix that too?

Thanks, Daniel

> -void drm_fb_xrgb8888_to_rgb888_dstclip(void *dst, unsigned int dst_pitch,
> +void drm_fb_xrgb8888_to_rgb888_dstclip(void __iomem *dst, unsigned int dst_pitch,
>  				       void *vaddr, struct drm_framebuffer *fb,
>  				       struct drm_rect *clip)
>  {
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
