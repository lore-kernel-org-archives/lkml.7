Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E6EC33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175A12073D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 16:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="it6jWsNZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgAGQOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:14:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41698 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgAGQOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 11:14:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so54618363wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 08:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=BnDKwUCZGErP+KyVZtLEwU8FgiR2KztEMGDlEQCZd7s=;
        b=it6jWsNZqZnJRkxU0QF0aJRe+H0+HCzalY18g4ewAHrgujNSc8aGGHJOyIkjkmXvPP
         5BXRcjhZEebBC8Fh/fPqNbuvXUVZRTPyF+QlRNp3popqzAHBTYNQLBz/Dzff+SBqtnJb
         i+pZDiEyjvepJxb7O5j423j2fpP6tNpbG9J18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=BnDKwUCZGErP+KyVZtLEwU8FgiR2KztEMGDlEQCZd7s=;
        b=KmeXwhi7r97FxRZipjlVeeMiTIxCb0cUp5HpGD7SmV1mSG6p14l+XJWg+meR5Xdrou
         LgYCzGO1IWTNPbMFCfkFWDoOGvt4tlqb+xcbK+jg9qwphOf1fNaNVvgo547rBX4SeQ3t
         C6uLEskiqhx5oWEP9ejAkkg6mHZDCvfT1SsE0My8x/lsr4eHlYdkCUEYdZ8BNHUM5bXz
         3k5NsjBz5wO9D/PuVKeMGLXIUhrarQgXOEtS62jbGe6rkO5LfUe3oeeaVnL7mzik0X4X
         s3Zk3/llqRaF6QLMenlmfnUZytJEEl5hmtnEnJx9cgLZcuT/NT5F9hfu5Ba5QzWxQtJU
         FrdA==
X-Gm-Message-State: APjAAAWDCquxamMdQQuiTmIF0GBuP0SCj2J54lZ+Hac1bRGfId9WN2ED
        Gxzmeyj9F27s4BSWZ0lEzfRnGw==
X-Google-Smtp-Source: APXvYqyQHK3dzkGnpN+A204ch3gC1JI6BVacIWD7/CNfZ+GZU0DG7Tm8hsvhn35Lq2tPf4RZVD7Biw==
X-Received: by 2002:a5d:4c8c:: with SMTP id z12mr79526820wrs.222.1578413643880;
        Tue, 07 Jan 2020 08:14:03 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:564b:0:7567:bb67:3d7f:f863])
        by smtp.gmail.com with ESMTPSA id q14sm133727wmj.14.2020.01.07.08.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 08:14:03 -0800 (PST)
Date:   Tue, 7 Jan 2020 17:14:01 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, kbuild-all@lists.01.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Steve Winslow <swinslow@gmail.com>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH] video: fbdev: mmp: fix platform_get_irq.cocci warnings
Message-ID: <20200107161401.GF43062@phenom.ffwll.local>
Mail-Followup-To: Julia Lawall <julia.lawall@inria.fr>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, kbuild-all@lists.01.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Steve Winslow <swinslow@gmail.com>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>
References: <alpine.DEB.2.21.2001042140310.6944@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2001042140310.6944@hadrien>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2020 at 09:43:31PM +0100, Julia Lawall wrote:
> From: kbuild test robot <lkp@intel.com>
> 
> Remove dev_err() messages after platform_get_irq*() failures.
> Line 450 is redundant because platform_get_irq() already prints
> an error.
> 
> Generated by: scripts/coccinelle/api/platform_get_irq.cocci
> 
> Fixes: dd90e9ae55a1 ("video: fbdev: mmp: add COMPILE_TEST support")
> Signed-off-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Julia Lawall <julia.lawall@inria.fr>

Applied to drm-misc-next, thanks for your patch.
-Daniel

> 
> ---
> 
> tree:   git://anongit.freedesktop.org/drm/drm-misc for-linux-next
> head:   80805774fc354f9ae7755a8e649a01dedfd0dcf8
> commit: dd90e9ae55a1e7efd3ac036afe9f7ae7bb64d39d [2/16] video: fbdev: mmp: add COMPILE_TEST support
> :::::: branch date: 11 hours ago
> :::::: commit date: 11 hours ago
> 
>  mmp_ctrl.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
> +++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
> @@ -447,7 +447,6 @@ static int mmphw_probe(struct platform_d
> 
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> -		dev_err(&pdev->dev, "%s: no IRQ defined\n", __func__);
>  		ret = -ENOENT;
>  		goto failed;
>  	}
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
