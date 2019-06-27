Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6038C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746CC2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="GsJ767+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfF0I7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 04:59:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46986 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfF0I7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 04:59:05 -0400
Received: by mail-ed1-f68.google.com with SMTP id d4so6265397edr.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 01:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LGczOakCSLer9ILQE8tNaqgNPozV8pb7PqeHtCzn1g0=;
        b=GsJ767+Bz59YQxnCnFMvFcSYh9soByANcFXUQ+dxUx5Q/FTIOZmR4kAWwuk9/HT1Gi
         raBZ4yVpCvC1kmTcyiq97Fnn6tEjrLxXJryKVmWHYVVzhGFre9eg61bQxVCoeFBrPx5W
         nbFSeFVId7v0Y/+FBuoxSRqzo2aQP3RbWafpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=LGczOakCSLer9ILQE8tNaqgNPozV8pb7PqeHtCzn1g0=;
        b=IJZ6dCPtkDqfbrof1YnZBzvWe1+NpIObGqaVOrz90Y9T1CcooJksPpYN0DASUUaXOq
         dFaDMb76tSdnIQ9aiZuNPqaM3WfmqyhpdH/cpFn0KROeHxt7thNG9r8TPBzkmai1WJaP
         xDwc3JVad+ufDSqZCYO3ii8O8HDz5YrTSjeQlqnnDHX9kYrFhPJvkIgPIy8udwoE1L0p
         QrWgUYfZ53dLZgXWPwbkuFchVRpMcGUNQb33ZZT+pBUyivv9IXeg4NcJOV5Rp55M0SNr
         GKeafnAfMZZzq+7iROK0MAi6anXe5qIxeQ0B71xRSKC7Ilq5SM03oid4UGSthyUa0MHC
         Fksg==
X-Gm-Message-State: APjAAAUh1ma7NRsSJmbUmEZGU3v+FH/q4BEQJ09k7BkHefPLXqrAxAiT
        ymcHFPilb34V5mCfcO3BtHbMBg==
X-Google-Smtp-Source: APXvYqztF4cKNAF9DjpaD52JmFXj0BdZd5GbwscnxOS6ZW0fc4x9KnKm97t+ztQ3ANKwIhFX1OJPwA==
X-Received: by 2002:a17:906:2f0b:: with SMTP id v11mr1993434eji.200.1561625944030;
        Thu, 27 Jun 2019 01:59:04 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id s26sm309794eja.81.2019.06.27.01.59.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 01:59:03 -0700 (PDT)
Date:   Thu, 27 Jun 2019 10:59:00 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, tzimmermann@suse.de,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/bochs: fix framebuffer setup.
Message-ID: <20190627085900.GI12905@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, tzimmermann@suse.de,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190627081206.23135-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627081206.23135-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 10:12:06AM +0200, Gerd Hoffmann wrote:
> The driver doesn't consider framebuffer pitch and offset, leading to a
> wrong display in case offset != 0 or pitch != width * bpp.  Fix it.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Yeah this looks more like it.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/bochs/bochs.h     |  2 +-
>  drivers/gpu/drm/bochs/bochs_hw.c  | 14 ++++++++++----
>  drivers/gpu/drm/bochs/bochs_kms.c |  3 ++-
>  3 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
> index cc35d492142c..2a65434500ee 100644
> --- a/drivers/gpu/drm/bochs/bochs.h
> +++ b/drivers/gpu/drm/bochs/bochs.h
> @@ -86,7 +86,7 @@ void bochs_hw_setmode(struct bochs_device *bochs,
>  void bochs_hw_setformat(struct bochs_device *bochs,
>  			const struct drm_format_info *format);
>  void bochs_hw_setbase(struct bochs_device *bochs,
> -		      int x, int y, u64 addr);
> +		      int x, int y, int stride, u64 addr);
>  int bochs_hw_load_edid(struct bochs_device *bochs);
>  
>  /* bochs_mm.c */
> diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
> index 791ab2f79947..ebfea8744fe6 100644
> --- a/drivers/gpu/drm/bochs/bochs_hw.c
> +++ b/drivers/gpu/drm/bochs/bochs_hw.c
> @@ -255,16 +255,22 @@ void bochs_hw_setformat(struct bochs_device *bochs,
>  }
>  
>  void bochs_hw_setbase(struct bochs_device *bochs,
> -		      int x, int y, u64 addr)
> +		      int x, int y, int stride, u64 addr)
>  {
> -	unsigned long offset = (unsigned long)addr +
> +	unsigned long offset;
> +	unsigned int vx, vy, vwidth;
> +
> +	bochs->stride = stride;

Might be nice to ditch these global/not-so-atomic things like
bochs->stride/bpp eventually.
-Daniel

> +	offset = (unsigned long)addr +
>  		y * bochs->stride +
>  		x * (bochs->bpp / 8);
> -	int vy = offset / bochs->stride;
> -	int vx = (offset % bochs->stride) * 8 / bochs->bpp;
> +	vy = offset / bochs->stride;
> +	vx = (offset % bochs->stride) * 8 / bochs->bpp;
> +	vwidth = stride * 8 / bochs->bpp;
>  
>  	DRM_DEBUG_DRIVER("x %d, y %d, addr %llx -> offset %lx, vx %d, vy %d\n",
>  			 x, y, addr, offset, vx, vy);
> +	bochs_dispi_write(bochs, VBE_DISPI_INDEX_VIRT_WIDTH, vwidth);
>  	bochs_dispi_write(bochs, VBE_DISPI_INDEX_X_OFFSET, vx);
>  	bochs_dispi_write(bochs, VBE_DISPI_INDEX_Y_OFFSET, vy);
>  }
> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
> index 5904eddc83a5..bc19dbd531ef 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -36,7 +36,8 @@ static void bochs_plane_update(struct bochs_device *bochs,
>  	bochs_hw_setbase(bochs,
>  			 state->crtc_x,
>  			 state->crtc_y,
> -			 gbo->bo.offset);
> +			 state->fb->pitches[0],
> +			 state->fb->offsets[0] + gbo->bo.offset);
>  	bochs_hw_setformat(bochs, state->fb->format);
>  }
>  
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
