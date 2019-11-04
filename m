Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BD0CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25617214D8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gdP/u/Z2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbfKDRkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:40:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35043 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbfKDRkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:40:13 -0500
Received: by mail-wr1-f65.google.com with SMTP id l10so18119339wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 09:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qFzvOj2kIekmlBTNitL0550GXXjfDa5dHZ2hXfb84nE=;
        b=gdP/u/Z2502qMOMIX5Abj0e+tGILbSh4sD07/PoMKUAftazcuxy2XTGaZjYj+8Y19c
         jl5h1aJYvLfqDcB8eqkoKVzhyat5T/4msDgTalhzxCq2SVhe9oHqkxd/+PjOAxGwl3Ed
         qpZOsqJ65cSsHMYFmVqVPi64e8qn3nq44jM5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=qFzvOj2kIekmlBTNitL0550GXXjfDa5dHZ2hXfb84nE=;
        b=PWEvrCYh+Dmr4IE6/fCuzykJY9HYdkKQ1bgWnDZrh+tLID6atawnZ7rA5Lrjut02qT
         AKWIMdHO/CsiFJG7cEwvd5cO5oWXXRVbdwBptWzinaPPy6bC/F+jWMZvYoQzOsK5I4/B
         mSCwTN14ajeUF9cJxf7wSsYVtxdxq73aYg4HEciAwrQcobg1UhRGf9ba2vO0+jWBf/rM
         TquMh0yjzTK3Jf1Wuw2/hqLFDrlHcJS8LkdAfCOrKdbh0JVAB0zkydP40UffyyJxvHRQ
         9AqHTboFF1ZAmpk1ZM228hySqw0nj0TOgRSbdgsKy9wv2QQHbr2/0a5/2G0Fo+tAGL30
         /9Dg==
X-Gm-Message-State: APjAAAXDkHyRqLnllJhjhxrimUtsF/PW5nWUdbY608hX3nJuKqYydRyS
        INT96OPeAlFOhjKK8Ay04hajhQ==
X-Google-Smtp-Source: APXvYqw29YqfrGgjpwh0uFd5WKrqiAbjecSm6tcDlvpk+V7LLi/5MabZh6lMzWqoH8T6/X2qsoJ4jQ==
X-Received: by 2002:adf:e747:: with SMTP id c7mr24315449wrn.384.1572889211910;
        Mon, 04 Nov 2019 09:40:11 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id b17sm8647949wru.36.2019.11.04.09.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 09:40:10 -0800 (PST)
Date:   Mon, 4 Nov 2019 18:40:08 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, manasi.d.navare@intel.com,
        rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Subject: Re: [PATCH] drm/vkms: Update VKMS documentation
Message-ID: <20191104174008.GK10326@phenom.ffwll.local>
Mail-Followup-To: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        outreachy-kernel@googlegroups.com, manasi.d.navare@intel.com,
        rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
References: <20191101223735.2425-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101223735.2425-1-gabrielabittencourt00@gmail.com>
X-Operating-System: Linux phenom 5.2.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 07:37:35PM -0300, Gabriela Bittencourt wrote:
> Small changes in the driver documentation, clarifing the description.
> 
> Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>

lgtm, applied.
-Daniel

> 
> ---
> 
> Tested using: make htmldocs
> ---
>  drivers/gpu/drm/vkms/vkms_drv.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index 80524a22412a..52e761bd6c2d 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -3,10 +3,10 @@
>  /**
>   * DOC: vkms (Virtual Kernel Modesetting)
>   *
> - * vkms is a software-only model of a kms driver that is useful for testing,
> - * or for running X (or similar) on headless machines and be able to still
> - * use the GPU. vkms aims to enable a virtual display without the need for
> - * a hardware display capability.
> + * VKMS is a software-only model of a KMS driver that is useful for testing
> + * and for running X (or similar) on headless machines. VKMS aims to enable
> + * a virtual display with no need of a hardware display capability, releasing
> + * the GPU in DRM API tests.
>   */
>  
>  #include <linux/module.h>
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
