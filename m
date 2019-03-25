Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948A5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8DE2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="iyW1VlzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbfCYIbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:31:24 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41659 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729823AbfCYIbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:31:24 -0400
Received: by mail-ed1-f67.google.com with SMTP id a25so6694806edc.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 01:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZFjyvS17Z6wm20BxdnVTcZ5fFz/Oo19fffMdiwpVX+E=;
        b=iyW1VlzLnyb+08UN38l/cp3dWfmmjSiRoc8dJQCH6u3FrTlsP/PEOYPUXPdb11RHfE
         dN20v5ftAfXaP7/3DK3zgZQP5FPXTAGwoEJGFfpmXyNFD1okYUUrWdn/+Bg2J3wXTNQs
         4rqJgkqFbBcVF1hLuGFZxNDNJ4pzGQTsiTF7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ZFjyvS17Z6wm20BxdnVTcZ5fFz/Oo19fffMdiwpVX+E=;
        b=tQZUeuAtmE4zkrUCYX9t8/fS1jJFrFS2Ocka5626ICc7H88wBHU6cCV7YnIJILYwSe
         fsEJkkSvkAqGDU54zjF/tXmXw6CCrl3UYsi03AQedt534mbMLVkj5Ere5VcGa+yr2r3n
         nO/tTqIqnVeNvadJYjGV02+B+woW07Q6uP9WmcZSQMF7WnkaWLdTsWv2RGF22ZzzEhEe
         UgMCHTt1S+t541GyWryG1V/7hyy9hUro7LIxWYIe9nEO72nZLqz/hk8OdoIxEKMyC1Vd
         nkjQTH9Kl3SWP8wMt4Bk5pR6i77uh/5SMop8n10jblrcvauUWJN3VxeNNQmSsOZEwmie
         AfYg==
X-Gm-Message-State: APjAAAUMLp5TLQP0N2DlAx8xv68HY1KTXhdCHuHo3SiHyt1CT9dPhH60
        kerv/gZsL6L9Eg++Eoz1p1C48A==
X-Google-Smtp-Source: APXvYqylyWTMDdci9ny1J/iGd5MQVw9ZaSf24SZqE88bERgwzciaIjRaHa344CkBcbIGfJescifz4w==
X-Received: by 2002:a50:9485:: with SMTP id s5mr15029498eda.223.1553502682378;
        Mon, 25 Mar 2019 01:31:22 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id s20sm529289edb.57.2019.03.25.01.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 01:31:21 -0700 (PDT)
Date:   Mon, 25 Mar 2019 09:31:19 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm: vkms: check status of alloc_ordered_workqueue
Message-ID: <20190325083119.GB2665@phenom.ffwll.local>
Mail-Followup-To: Kangjie Lu <kjlu@umn.edu>, pakki001@umn.edu,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <955fbabe-e5f2-cfff-8dfd-1730243b0fff@codeaurora.org>
 <20190323214216.10824-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190323214216.10824-1-kjlu@umn.edu>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 04:42:16PM -0500, Kangjie Lu wrote:
> alloc_ordered_workqueue may fail and return NULL.
> The fix cleans up drm plans and returns ENOMEM when it fails to
> avoid potential NULL pointer dereference.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
> V2: clean up resources
> ---
>  drivers/gpu/drm/vkms/vkms_crtc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index 8a9aeb0a9ea8..018b52dd953a 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -219,6 +219,17 @@ int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
>  	spin_lock_init(&vkms_out->state_lock);
>  
>  	vkms_out->crc_workq = alloc_ordered_workqueue("vkms_crc_workq", 0);
> +	if (!vkms_out->crc_workq) {
> +		ret = -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	return ret;
>  
> +cleanup:

Style nit for the future, for clarity I'd label this err:, since this path
is only taken for failures, and not to do cleanup for all cases.

Aside from that, I think your v1 was correct, vkms_crtc_init only sets up
the crtc, it doesn't allocate the cursor/planes. That's done from
vkms_output_init, which already has the cleanup code to handle this case.
-Daniel

> +	if (!IS_ERR_OR_NULL(cursor))
> +		drm_plane_cleanup(cursor);
> +	if (!IS_ERR(primary))
> +		drm_plane_cleanup(primary);
>  	return ret;
>  }
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
