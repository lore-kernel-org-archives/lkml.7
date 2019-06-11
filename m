Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B44C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213E12089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TDdftQpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbfFKMap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 08:30:45 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35801 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfFKMao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 08:30:44 -0400
Received: by mail-ed1-f66.google.com with SMTP id p26so15801938edr.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 05:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=98w8kwDvoFHXd9IwMdM47Fy1DAIHUsUmNhEulT8HBK4=;
        b=TDdftQpZMVzC4IfNr/u5BN6jeQVrrMKS019h77cvrJUOFVDKizki1g/tr26F8MSQ1q
         AO6qkfOfPQ6Yl+Ziymqed6eoJg3Un/jdD0/+RcRSsG0gKsD3mahTEkGa1ajRe0wgjIlz
         eijyc4arZLtf6hLGJtDiOguGvpspBBv2uf6bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=98w8kwDvoFHXd9IwMdM47Fy1DAIHUsUmNhEulT8HBK4=;
        b=HilsR0v58bbaVBG5NJz8X+/Koobhzv9M7BO2Q3ayT7gdHwzf04nk29cyHi+uiQnhc5
         rHaLAgqaMkY+d/HQ+HJkYkbOsMLeblQN+6DhOSJPYK+0WbY3nprjbH865X0JUl3Q/AaC
         f/hIxzwhc/J5m7LrD5+FEiCXIyapV5xtlg4XsDn4jhmjpfjykcotzH/z6A0YRML5pqBZ
         kfR63C4WMIiSErw+s2kVetdF21LVGDex/nfDIF7sHfD27fdj/v21OncQpwb1TykGApZz
         xo8HyelmGTTntJVrATg3w1oREwNKuwyP0skvtILjxARSJ0NBfve62V5dyI9sieDltiUe
         CLRQ==
X-Gm-Message-State: APjAAAVxQG1n8xwi/jP5tyGHU67i7XiKfNuAQ9sttPbtgfiodVbEC1Mo
        ipdt7g1O4ZL1pAqEZ4bHKCN5Tw==
X-Google-Smtp-Source: APXvYqzHQupV7Rmfh5ij3V00vLmNZH3ALvTxarM+XMmPX3T/9+vt9lBZBgQcrNIWb/U3FURLETC1mw==
X-Received: by 2002:a50:8465:: with SMTP id 92mr3529325edp.151.1560256242889;
        Tue, 11 Jun 2019 05:30:42 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id a9sm3781447edc.44.2019.06.11.05.30.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 05:30:40 -0700 (PDT)
Date:   Tue, 11 Jun 2019 14:30:38 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
Subject: Re: [PATCH v2 2/2] drm/komeda: Adds komeda_kms_drop_master
Message-ID: <20190611123038.GC2458@phenom.ffwll.local>
Mail-Followup-To: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
References: <1560251589-31827-1-git-send-email-lowry.li@arm.com>
 <1560251589-31827-3-git-send-email-lowry.li@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560251589-31827-3-git-send-email-lowry.li@arm.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 11:13:45AM +0000, Lowry Li (Arm Technology China) wrote:
> From: "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
> 
> The komeda internal resources (pipelines) are shared between crtcs,
> and resources release by disable_crtc. This commit is working for once
> user forgot disabling crtc like app quit abnomally, and then the
> resources can not be used by another crtc. Adds drop_master to
> shutdown the device and make sure all the komeda resources have been
> released and can be used for the next usage.
> 
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> index 8543860..647bce5 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -54,11 +54,24 @@ static irqreturn_t komeda_kms_irq_handler(int irq, void *data)
>  	return status;
>  }
>  
> +/* Komeda internal resources (pipelines) are shared between crtcs, and resources
> + * are released by disable_crtc. But if user forget disabling crtc like app quit
> + * abnormally, the resources can not be used by another crtc.
> + * Use drop_master to shutdown the device and make sure all the komeda resources
> + * have been released, and can be used for the next usage.
> + */

No. If we want this, we need to implement this across drivers, not with
per-vendor hacks.

The kerneldoc should have been a solid hint: "Only used by vmwgfx."
-Daniel

> +static void komeda_kms_drop_master(struct drm_device *dev,
> +				   struct drm_file *file_priv)
> +{
> +	drm_atomic_helper_shutdown(dev);
> +}
> +
>  static struct drm_driver komeda_kms_driver = {
>  	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC |
>  			   DRIVER_PRIME | DRIVER_HAVE_IRQ,
>  	.lastclose			= drm_fb_helper_lastclose,
>  	.irq_handler			= komeda_kms_irq_handler,
> +	.master_drop			= komeda_kms_drop_master,
>  	.gem_free_object_unlocked	= drm_gem_cma_free_object,
>  	.gem_vm_ops			= &drm_gem_cma_vm_ops,
>  	.dumb_create			= komeda_gem_cma_dumb_create,
> -- 
> 1.9.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
