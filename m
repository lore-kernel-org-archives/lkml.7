Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA568C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97BB420661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aoWJ3jb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfCHSWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:22:38 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:33126 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfCHSWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:22:37 -0500
Received: by mail-io1-f68.google.com with SMTP id b6so3982971iog.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 10:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=728tjrB/mPVe4ObjyZU9gbstsdRZdOqnDGnO5vOhmrE=;
        b=aoWJ3jb8ZSX7eLjI8KMSJQl2HBrnFy6BuqPhoke+XnFeX1+5toPUZnd6H2xNWpInjT
         CyqbvK9M9cGUqz2LXO6nFZBU1q4NnYdAAdHpUslgJIzuliQlBqS0KnhRx7TexhbdzUji
         SXly/U6XqCJqX9yFLEq413VCrAz7yI5kEhMbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=728tjrB/mPVe4ObjyZU9gbstsdRZdOqnDGnO5vOhmrE=;
        b=kZfvKQ9A4IjU0hQCbvDGLi72HMuyE9y30eRSTTa3vHglZ1IrfzhMS4KO4/GTr4nx8y
         zWRetXzZL1DpmPSbPHHLFhm41jqUT9W/v45n8F23G4VDNtPKiwKVBvrYxEhilVb2fpR1
         REgS5vcGsv3zKb3Xc6tbznIFoHLUafiUhUWcVsm4Hlnv53DfSQWwszmxlhNJcdDpEPzI
         WjgOjmHOlOuMLSH3urL3bLwf/2fzhbKSx3dY6NqUk5PNzIIs8FjdBh8lmE2b1gm+h7V7
         SczMNJUUfbdJhBvW16a64tGsxS6OGUkqHOlwX8e9O/08YytwSZvzvqPCnfwLKBw+XNEO
         ZCcQ==
X-Gm-Message-State: APjAAAWMC3Zc5O9zThfI6zsZhi73C9aszaAi0Mm6+M2ie47QBNXyMOWy
        XjBpTzdyBQ/QnwFIMLe6dOyNY1h0jPOk2lWaho5OmxCcGdQ=
X-Google-Smtp-Source: APXvYqyLu3TuJoyDDqmgCpespAmtrZ8p6k45Q9W/RNGHFsVXw7qlAacIVmyrEvOFnD6ZKtHXtxCQgHLO6Rk9s0Uz25k=
X-Received: by 2002:a5d:97c8:: with SMTP id k8mr10849983ios.267.1552069356927;
 Fri, 08 Mar 2019 10:22:36 -0800 (PST)
MIME-Version: 1.0
References: <20190308174336.7866-1-eric@anholt.net>
In-Reply-To: <20190308174336.7866-1-eric@anholt.net>
From:   Dave Emett <david.emett@broadcom.com>
Date:   Fri, 8 Mar 2019 18:22:26 +0000
Message-ID: <CAApk1dV2muXmJ8q+aimexr4d-5K9uPm0dHDqmrCgF9-0hczb7A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] drm/v3d: Handle errors from IRQ setup.
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Spurden <thomas.spurden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2019 at 17:43, Eric Anholt <eric@anholt.net> wrote:
>
> Noted in review by Dave Emett for V3D 4.2 support.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>

Reviewed-by: Dave Emett <david.emett@broadcom.com>

> ---
>  drivers/gpu/drm/v3d/v3d_drv.c |  8 ++++++--
>  drivers/gpu/drm/v3d/v3d_drv.h |  2 +-
>  drivers/gpu/drm/v3d/v3d_irq.c | 13 +++++++++++--
>  3 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
> index 3680ebd229f2..f9906cac7a88 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.c
> +++ b/drivers/gpu/drm/v3d/v3d_drv.c
> @@ -311,14 +311,18 @@ static int v3d_platform_drm_probe(struct platform_device *pdev)
>         if (ret)
>                 goto dev_destroy;
>
> -       v3d_irq_init(v3d);
> +       ret = v3d_irq_init(v3d);
> +       if (ret)
> +               goto gem_destroy;
>
>         ret = drm_dev_register(drm, 0);
>         if (ret)
> -               goto gem_destroy;
> +               goto irq_disable;
>
>         return 0;
>
> +irq_disable:
> +       v3d_irq_disable(v3d);
>  gem_destroy:
>         v3d_gem_destroy(drm);
>  dev_destroy:
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
> index d856159bd007..bb58ecb9d9c5 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.h
> +++ b/drivers/gpu/drm/v3d/v3d_drv.h
> @@ -304,7 +304,7 @@ void v3d_reset(struct v3d_dev *v3d);
>  void v3d_invalidate_caches(struct v3d_dev *v3d);
>
>  /* v3d_irq.c */
> -void v3d_irq_init(struct v3d_dev *v3d);
> +int v3d_irq_init(struct v3d_dev *v3d);
>  void v3d_irq_enable(struct v3d_dev *v3d);
>  void v3d_irq_disable(struct v3d_dev *v3d);
>  void v3d_irq_reset(struct v3d_dev *v3d);
> diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
> index 69338da70ddc..29d746cfce57 100644
> --- a/drivers/gpu/drm/v3d/v3d_irq.c
> +++ b/drivers/gpu/drm/v3d/v3d_irq.c
> @@ -156,7 +156,7 @@ v3d_hub_irq(int irq, void *arg)
>         return status;
>  }
>
> -void
> +int
>  v3d_irq_init(struct v3d_dev *v3d)
>  {
>         int ret, core;
> @@ -173,13 +173,22 @@ v3d_irq_init(struct v3d_dev *v3d)
>         ret = devm_request_irq(v3d->dev, platform_get_irq(v3d->pdev, 0),
>                                v3d_hub_irq, IRQF_SHARED,
>                                "v3d_hub", v3d);
> +       if (ret)
> +               goto fail;
> +
>         ret = devm_request_irq(v3d->dev, platform_get_irq(v3d->pdev, 1),
>                                v3d_irq, IRQF_SHARED,
>                                "v3d_core0", v3d);
>         if (ret)
> -               dev_err(v3d->dev, "IRQ setup failed: %d\n", ret);
> +               goto fail;
>
>         v3d_irq_enable(v3d);
> +       return 0;
> +
> +fail:
> +       if (ret != -EPROBE_DEFER)
> +               dev_err(v3d->dev, "IRQ setup failed: %d\n", ret);
> +       return ret;
>  }
>
>  void
> --
> 2.20.1
>
