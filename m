Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_RHS_DOB autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2834DC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00B492183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389293AbfDRPD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:03:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37233 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388457AbfDRPD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:03:58 -0400
Received: by mail-ed1-f66.google.com with SMTP id f53so2085317ede.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 08:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=do3Q5N7x+BKvIjW65j+I6ssMfSgJE+0G0vPbUd4LDhs=;
        b=Yo0GGxFkJgPC1ts0iGP+fUpdFA/a/oC9BLDynE1ccYgk/KVkvfJY17HJ/ImYAMti6O
         wJxB+oaKTVoCkcr3RByvUn0wzTPqM8KNbUbKbkNr9arrYMwPh6NVCS9LZSB2vfl57f9L
         zcCljTnRDx6hq9oF10UAwyTLT7Z5K9W2S3zn0RwceT7IOUStqytKwsX5OKwRpie3LBMR
         0xnYnjmVxv+Y8VNqFQnhhKJwFZIU+wOU67w7LRyLcR3bhzo1RYUSfNXJ22PoVib/R5KX
         5NJB28jBsVI4PbSpy/5eteQHLYp5dz3V01bYXICEfrQ/f4FFnotzrcl5CcYyNL5Ubrej
         p6yA==
X-Gm-Message-State: APjAAAVD7vcZwe0vn0HvxkCEnrsPztmCz2Olm6Xzbrr6DLp45676z0Bj
        BTb7X/B5jwf2ExAZTowckLuqu7Xv4r0=
X-Google-Smtp-Source: APXvYqwamT5ufJMSHE3VMet609Nvv0wXy/RRth4WZkX2ZhfMNk8XaY8lG981cqvfS5cECo4LzOv7Rg==
X-Received: by 2002:a50:e442:: with SMTP id e2mr20750097edm.227.1555599836112;
        Thu, 18 Apr 2019 08:03:56 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id t51sm583660edb.30.2019.04.18.08.03.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 08:03:55 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id y197so3288549wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 08:03:55 -0700 (PDT)
X-Received: by 2002:a1c:2394:: with SMTP id j142mr3501895wmj.111.1555599834885;
 Thu, 18 Apr 2019 08:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190418132727.5128-1-paul.kocialkowski@bootlin.com> <20190418132727.5128-4-paul.kocialkowski@bootlin.com>
In-Reply-To: <20190418132727.5128-4-paul.kocialkowski@bootlin.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 18 Apr 2019 08:03:42 -0700
X-Gmail-Original-Message-ID: <CAGb2v67MYXQsdv7E_SGXALVVr0T7aTTP6AhwA3N8U7HNJkRH7w@mail.gmail.com>
Message-ID: <CAGb2v67MYXQsdv7E_SGXALVVr0T7aTTP6AhwA3N8U7HNJkRH7w@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 3/3] drm/sun4i: Fix component unbinding and
 component master deletion
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 6:27 AM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> For our component-backed driver to be properly removed, we need to
> delete the component master in sun4i_drv_remove and make sure to call
> component_unbind_all in the master's unbind so that all components are
> unbound when the master is.
>
> Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_drv.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
> index af07291544a4..0ea365e54de1 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> @@ -137,6 +137,8 @@ static void sun4i_drv_unbind(struct device *dev)
>         drm_mode_config_cleanup(drm);
>         of_reserved_mem_device_release(dev);
>         drm_dev_put(drm);
> +
> +       component_unbind_all(dev, NULL);

Shouldn't this be before drm_dev_put? Everything being in reverse order
of the complement calls in the bind function and all. The component
drivers might still be using the drm dev before they are unbound.

ChenYu

>  }
>
>  static const struct component_master_ops sun4i_drv_master_ops = {
> @@ -385,6 +387,8 @@ static int sun4i_drv_probe(struct platform_device *pdev)
>
>  static int sun4i_drv_remove(struct platform_device *pdev)
>  {
> +       component_master_del(&pdev->dev, &sun4i_drv_master_ops);
> +
>         return 0;
>  }
>
> --
> 2.21.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
