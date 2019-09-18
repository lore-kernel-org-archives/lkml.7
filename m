Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EE0C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 07:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7212054F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 07:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="PBQnipt0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfIRH7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 03:59:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36753 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfIRH7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 03:59:45 -0400
Received: by mail-ed1-f65.google.com with SMTP id f2so5765589edw.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 00:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9RAAszLOpdIvDldweaPkNLOitxpBV3SI+NOvvapdMHQ=;
        b=PBQnipt0tgT8m3MGkNMC7d8tYWy6wP232bRYATMSh+qc3+imbzkBvG6+QVXbpLsVT1
         9+P0Opb9/LQtRo7XYHAubAsDrZCes7mJ3txtNBwfxnmvURclx9W1r2U7Wpfr1BUDZOBi
         QGPIYb3ePJaZoKP2AsnoeSwkaSDB0F+TlyV68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=9RAAszLOpdIvDldweaPkNLOitxpBV3SI+NOvvapdMHQ=;
        b=PlgTCkcDhZBSlTroh0K4eBLslItfGHHDx0fs3k1d93yNJ1TXyBOgbhR9tdbbjU1y5d
         E+4C3+c6XbKxWP75PiGaL7R38FohNrLzPBGBs1ZFIKzviBFXGGIB+rXZSeks9/X7qmex
         UgMDpzPVP/+2309tj4xrlQFL4TCRPll04ApDwKGSbXcKNEDgEzvFb+R0kCcxrW67vCBu
         iuta5dglIipk6mWIlL2pAgOY8C8BCaRE3jzzQqMbJTc0unqzWRjeGA5LoFZVTlm+THyl
         N64O+agC/jhm/iS2OsncJfbj2i+8hBGRHehtLwtEDL7JAuUgfk/xG3hXWZWj7AqNplRP
         QeIA==
X-Gm-Message-State: APjAAAXcWKZ+xRfVe3QjHh5rv1rsGEIPzkCGdb43Am8E4qyOWzj35y77
        6dh4LUBijibVoEj+NjK2recD6Q==
X-Google-Smtp-Source: APXvYqwdTowkGcbqJWBiyUssJDPxqStLRSPXEVU9xDnvzaLO5HZLFcTS6gDV42cjcuNM5YUODE775Q==
X-Received: by 2002:a17:906:d185:: with SMTP id c5mr7830673ejz.139.1568793583476;
        Wed, 18 Sep 2019 00:59:43 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id b15sm894079edf.24.2019.09.18.00.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 00:59:42 -0700 (PDT)
Date:   Wed, 18 Sep 2019 09:59:39 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Liviu Dudau <Liviu.Dudau@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/komeda: Remove in-code use of ifdef
Message-ID: <20190918075939.GZ3958@phenom.ffwll.local>
Mail-Followup-To: Mihail Atanassov <Mihail.Atanassov@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CAKMK7uECMr46Ag8E=eqTKdZxgt_4M42t7GEyNGv0gxpv-TL3Pg@mail.gmail.com>
 <20190917150314.20892-1-mihail.atanassov@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917150314.20892-1-mihail.atanassov@arm.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 03:05:08PM +0000, Mihail Atanassov wrote:
> Provide a dummy static inline function in the header instead.
> 
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Lowry Li (Arm Technology China) <Lowry.Li@arm.com>
> Cc: james qian wang (Arm Technology China) <james.qian.wang@arm.com>
> Fixes: 4d74b25ee395 ("drm/komeda: Adds error event print functionality")
> Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.h | 2 ++
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> index e28e7e6563ab..8acf8c0601cc 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -220,6 +220,8 @@ struct komeda_dev *dev_to_mdev(struct device *dev);
>  
>  #ifdef CONFIG_DRM_KOMEDA_ERROR_PRINT
>  void komeda_print_events(struct komeda_events *evts);
> +#else
> +static inline void komeda_print_events(struct komeda_events *evts) {}
>  #endif
>  
>  #endif /*_KOMEDA_DEV_H_*/
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> index 18d7e2520225..dc85c08e614d 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -47,9 +47,7 @@ static irqreturn_t komeda_kms_irq_handler(int irq, void *data)
>  	memset(&evts, 0, sizeof(evts));
>  	status = mdev->funcs->irq_handler(mdev, &evts);
>  
> -#ifdef CONFIG_DRM_KOMEDA_ERROR_PRINT
>  	komeda_print_events(&evts);
> -#endif
>  
>  	/* Notify the crtc to handle the events */
>  	for (i = 0; i < kms->n_crtcs; i++)
> -- 
> 2.23.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
