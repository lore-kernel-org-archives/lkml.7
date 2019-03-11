Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769B7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CB8206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ILkzq7Wi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfCKMnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:43:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38973 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfCKMnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:43:10 -0400
Received: by mail-ed1-f68.google.com with SMTP id p27so3875311edc.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 05:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KQBrvQP+L13V9nO1eoxGN88Md9/UFFo9/SVsGA8Kcog=;
        b=ILkzq7Wil8UEHRA/C5YrFWms0U/+pemc92+sQDfT8dBvqQAhlYJi4pJz0VEHVLWuyr
         UXdTro/6pqC6Mou3TTnVtX0oxJ8chwcX2H3ge2ySdxrqP1l/NKWyi5yvdnhbxouGhIr0
         nl9S3GIKhHawN5zkq5wA2TuqJIgPxN1axwzR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=KQBrvQP+L13V9nO1eoxGN88Md9/UFFo9/SVsGA8Kcog=;
        b=nxRcOQabpVlYu9uZU+gvKsurfjCJwEKI0LMt7JP7TAWWdxte3FTLzho9bohDohcs7x
         zTKQ7S4zWfsHvloEoHkRvjEw/w5qAcMuCN+NWRCoCFiRO/53K8PGHwe+18MNX/XLPGWf
         DNaWRfKtWUjvHZiIyoSHuvbJxC4cBhBquNB9ImYeyNsY6d7VdbGPdsKRSgTJ2oqmWIPL
         osozfRPF3/PlmLO+JpLwsbWTt7+gjUetCLruCSqwwnV81jhLNL6ODZ6c1hVoCem9yKzO
         mwwIEfI5wLBnxLQ/hK6hYdfzs8hL4gvwCQVhxkckvNgNUbKfDCLLbUwgYLGChpkECJou
         nQNw==
X-Gm-Message-State: APjAAAVMoczcKWhqEjSv5sdDWitXNFvsFuY0EWFOsZpq5Som9vpDB/5o
        J5VyatQ7tu3r2ibaVhTrBttfnr9m6eKuKg==
X-Google-Smtp-Source: APXvYqzq1uE3YyTDTt7Pb8a8w0hec+KlUaxWUV4BH1BfjIB7UnRjb/HOXmRT0S0ktbblDHSGeM1QNA==
X-Received: by 2002:a17:906:2797:: with SMTP id j23mr5827986ejc.128.1552308188473;
        Mon, 11 Mar 2019 05:43:08 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x7sm3060312eju.12.2019.03.11.05.43.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 05:43:07 -0700 (PDT)
Date:   Mon, 11 Mar 2019 13:43:05 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        daniel@ffwll.ch, Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 4/4] drm/i915: switch to
 drm_fb_helper_remove_conflicting_pci_framebuffers
Message-ID: <20190311124305.GB2665@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20190301092502.30948-1-kraxel@redhat.com>
 <20190301092502.30948-5-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301092502.30948-5-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 10:25:02AM +0100, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/i915/i915_drv.c | 38 ++------------------------------------
>  1 file changed, 2 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
> index 9df65d386d11..c6f1e0dbdd58 100644
> --- a/drivers/gpu/drm/i915/i915_drv.c
> +++ b/drivers/gpu/drm/i915/i915_drv.c
> @@ -732,31 +732,6 @@ static int i915_load_modeset_init(struct drm_device *dev)
>  	return ret;
>  }
>  
> -static int i915_kick_out_firmware_fb(struct drm_i915_private *dev_priv)
> -{
> -	struct apertures_struct *ap;
> -	struct pci_dev *pdev = dev_priv->drm.pdev;
> -	struct i915_ggtt *ggtt = &dev_priv->ggtt;
> -	bool primary;
> -	int ret;
> -
> -	ap = alloc_apertures(1);
> -	if (!ap)
> -		return -ENOMEM;
> -
> -	ap->ranges[0].base = ggtt->gmadr.start;
> -	ap->ranges[0].size = ggtt->mappable_end;
> -
> -	primary =
> -		pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_SHADOW;
> -
> -	ret = drm_fb_helper_remove_conflicting_framebuffers(ap, "inteldrmfb", primary);
> -
> -	kfree(ap);
> -
> -	return ret;
> -}
> -
>  static void intel_init_dpio(struct drm_i915_private *dev_priv)
>  {
>  	/*
> @@ -1377,22 +1352,13 @@ static int i915_driver_init_hw(struct drm_i915_private *dev_priv)
>  	if (ret)
>  		goto err_perf;
>  
> -	/*
> -	 * WARNING: Apparently we must kick fbdev drivers before vgacon,
> -	 * otherwise the vga fbdev driver falls over.
> -	 */
> -	ret = i915_kick_out_firmware_fb(dev_priv);
> +	ret = drm_fb_helper_remove_conflicting_pci_framebuffers(pdev, 2,
> +								"inteldrmfb");

Ok I reviewed this more carefully, it moves around:

- gen2: bar 0
- gen3-5: bar 1
- gen6+: bar 2

I think the 100% future proof version would be to change the helper in the
fb core to just have apertures mapping all bars of the passed-in pci
device, and remove the bar number. Then we could apply this patch without
having to duplicate the knowledge about which pci bar the fb can sit in.

If you don't feel like typing this (since quite a bit of scope creep with
my comments already ...) a patch to add it to todo.rst would be great.

Thanks, Daniel

>  	if (ret) {
>  		DRM_ERROR("failed to remove conflicting framebuffer drivers\n");
>  		goto err_ggtt;
>  	}
>  
> -	ret = vga_remove_vgacon(pdev);
> -	if (ret) {
> -		DRM_ERROR("failed to remove conflicting VGA console\n");
> -		goto err_ggtt;
> -	}
> -
>  	ret = i915_ggtt_init_hw(dev_priv);
>  	if (ret)
>  		goto err_ggtt;
> -- 
> 2.9.3
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
