Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6681EC74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 16:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290262064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 16:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="QB9XtGbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfGJQkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 12:40:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41853 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfGJQkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 12:40:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id p15so2800855eds.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 09:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dfuwXMh/PFSs/hNZrr4/4G7Y//4Qrkq5C3uMpNwhxbA=;
        b=QB9XtGbwlJ0dk+sdfcqtd+yhmZhSROLxmsepY6HorySiOWPEIyM9XwVmu5qtWE7dfm
         1RlLNpqPlmRxBfmeASPIzX/yL4xsMab7IBT5N5IqwU6jYb7+BaQhj9apEElx6Heb6oze
         P682jiJU2EuEAH4a1qhV08wm1emG/EFRuFK6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=dfuwXMh/PFSs/hNZrr4/4G7Y//4Qrkq5C3uMpNwhxbA=;
        b=n+H0DOvVL32pOBsVgnQt9lT6iRS6LOm4jjTx6APYK/JmqvXnUL0B0C9Fy8596M971s
         H4RkbKtOD62/VAGq9q3mksIIuBy7ejk1vSquWmiUQ1sCosNtUeTvGF6kjuZK82RBMM/a
         zWTIWjFQgWsn2tTOr/f0KQaliP5U9aRADrpz5G+Hcckam+WmjDIbG87Gkp9WMUPmwOT+
         8ict7MNteSMyWrlmrUOLzovQ8TfpIVXyde6lF+UUaboqdP+lBo1uC/WjKgmh+gLMtlA/
         DJLL7ffuCTRgLpFavK33VqO3KqNJdvPs+4OvzfNFhcxoWNskWtLrjJp7SQyRGimIpgjT
         o7bw==
X-Gm-Message-State: APjAAAVNcEy/c2sS0v+QY7ehtoRmWZp0T6DcYTRAHh4ZLBJdJt/WLECA
        4onQ6loExrFH3X8qBmaIrH8r2g==
X-Google-Smtp-Source: APXvYqwIMINglW2hmlI0ckWdmJ5NRNUHC2Hz0rtqpJFLfi1tlczsBrBMWvAG0a8ShZy1HwxjHtMscg==
X-Received: by 2002:a50:a4ef:: with SMTP id x44mr33058891edb.304.1562776838911;
        Wed, 10 Jul 2019 09:40:38 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id e43sm875876ede.62.2019.07.10.09.40.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 09:40:38 -0700 (PDT)
Date:   Wed, 10 Jul 2019 18:40:36 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Simon Ser <contact@emersion.fr>,
        Oleg Vasilev <oleg.vasilev@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] drm/vkms: Add support for vkms work without vblank
Message-ID: <20190710164036.GZ15868@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>, Simon Ser <contact@emersion.fr>,
        Oleg Vasilev <oleg.vasilev@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190710015514.42anrmx3r2ijaomz@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710015514.42anrmx3r2ijaomz@smtp.gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 10:55:14PM -0300, Rodrigo Siqueira wrote:
> Currently, vkms only work with enabled VBlank. This patch adds another
> operation model that allows vkms to work without VBlank support. In this
> scenario, vblank signaling is faked by calling drm_send_vblank_event()
> in vkms_crtc_atomic_flush(); this approach works due to the
> drm_vblank_get() == 0 checking.
> 
> Changes since V2:
>  - Rebase
> 
> Changes since V1:
>   Daniel Vetter:
>   - Change module parameter name from disablevblank to virtual_hw
>   - Improve parameter description
>   - Improve commit message
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_crtc.c | 10 ++++++++++
>  drivers/gpu/drm/vkms/vkms_drv.c  | 13 +++++++++++--
>  drivers/gpu/drm/vkms/vkms_drv.h  |  2 ++
>  3 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index 49a8ec2cb1c1..a0c75b8c4335 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -207,12 +207,22 @@ static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
>  static void vkms_crtc_atomic_enable(struct drm_crtc *crtc,
>  				    struct drm_crtc_state *old_state)
>  {
> +	struct vkms_output *vkms_out = drm_crtc_to_vkms_output(crtc);
> +
> +	if (vkms_out->disable_vblank)
> +		return;
> +
>  	drm_crtc_vblank_on(crtc);
>  }
>  
>  static void vkms_crtc_atomic_disable(struct drm_crtc *crtc,
>  				     struct drm_crtc_state *old_state)
>  {
> +	struct vkms_output *vkms_out = drm_crtc_to_vkms_output(crtc);
> +
> +	if (vkms_out->disable_vblank)
> +		return;
> +
>  	drm_crtc_vblank_off(crtc);
>  }
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 152d7de24a76..542a002ef9d5 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -34,6 +34,11 @@ bool enable_writeback;
>  module_param_named(enable_writeback, enable_writeback, bool, 0444);
>  MODULE_PARM_DESC(enable_writeback, "Enable/Disable writeback connector");
>  
> +bool virtual_hw;

Can be static, you only use this in vkms_drv.c.

> +module_param_named(virtual_hw, virtual_hw, bool, 0444);
> +MODULE_PARM_DESC(virtual_hw,
> +		 "Enable virtual hardware mode (disables vblanks and immediately completes flips)");
> +
>  static const struct file_operations vkms_driver_fops = {
>  	.owner		= THIS_MODULE,
>  	.open		= drm_open,
> @@ -154,9 +159,13 @@ static int __init vkms_init(void)
>  	if (ret)
>  		goto out_unregister;
>  
> -	vkms_device->drm.irq_enabled = true;
> +	vkms_device->output.disable_vblank = virtual_hw;
> +	vkms_device->drm.irq_enabled = !virtual_hw;
> +
> +	if (virtual_hw)
> +		DRM_INFO("Virtual hardware mode enabled");
>  
> -	ret = drm_vblank_init(&vkms_device->drm, 1);
> +	ret = (virtual_hw) ? 0 : drm_vblank_init(&vkms_device->drm, 1);
>  	if (ret) {
>  		DRM_ERROR("Failed to vblank\n");
>  		goto out_fini;
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 9ff2cd4ebf81..256e5e65c947 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -21,6 +21,7 @@
>  
>  extern bool enable_cursor;
>  extern bool enable_writeback;
> +extern bool virtual_hw;
>  
>  struct vkms_composer {
>  	struct drm_framebuffer fb;
> @@ -69,6 +70,7 @@ struct vkms_output {
>  	struct drm_connector connector;
>  	struct drm_writeback_connector wb_connector;
>  	struct hrtimer vblank_hrtimer;
> +	bool disable_vblank;
>  	ktime_t period_ns;
>  	struct drm_pending_vblank_event *event;
>  	/* ordered wq for composer_work */

I'm kinda wondering how this works at all ... does writeback/crc still
work if you set virtual mode? Writeback since this seems based on the
writeback series ...

btw if you send out patches that need other patches, point at that other
series in the cover letter or patch. Gets confusing fast otherwise.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
