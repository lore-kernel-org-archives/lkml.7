Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1D3ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7625E2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0oP86PS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbfJARvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:51:53 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41233 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfJARvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:51:53 -0400
Received: by mail-io1-f66.google.com with SMTP id n26so21738508ioj.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 10:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mGX7BVQOaWHiIMnos0xmrZKS+XQD/Jo055hvHQSrq70=;
        b=g0oP86PSCeSRoSbO5M5pvy0ob6eWOEV08YRCTBwTnM6ZfYx6dOyoVHvsZFz+9aEUrr
         CF+S9zX0AKzVI6JUCzhqUE+yQjWuEKyDvjRuCH4aVpinF5Y75ES9IP4pxM9iihus/r7Y
         1nEavDlo+aXh6SFxFMdNu2uhxDDIZhefkYMsYejV6nGHTpFda0Bg4PWaGMqCMm/A4odi
         s+4jS36igSFnsnR3oFRA2tREwD3XZ7X3l5PNz3mwbxjoDWJZhfef61Kdo/GE9Q09s9QS
         64HIRK5oW5DN4aePFjXWgl6w0HLpDj/plBfFY1lMCSPz7cqTp+X4epyWAPdSDViOBiEE
         GXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mGX7BVQOaWHiIMnos0xmrZKS+XQD/Jo055hvHQSrq70=;
        b=F8VN3DtwJgy29kLULWcnCS5MYiaphx57ric8QK8GEt2xFudeYF5ZPJZbByX24hLltn
         oBh47NIMMk1m68F8YrEqqiIcBaZR4rHIbX+dmdLjXp9zsg0muZEX/S487GncsvlvrWDR
         U1t3wsfLiMJKsp2PcMJJ6bKVtsjU1pcw18rk87vEJIyC47J5TvL4P7n1SPyMwMLmGkhh
         tvOdHgcQ8FjVHX3Y7iXchzQrb4TJC0vhZaEXZGPGv7WjgCmzphTPDTe/gCflSFYbIl9p
         YMNVzhmIMZFwlS5w2f46VjvKzKslwhawXuJJTzwpELi04S1H1pVibXIxgS1NgfXJTXMa
         d/Qg==
X-Gm-Message-State: APjAAAWa2FQimA2/1AVYSjJfT0jt0kAU5SCxkJyddDAyKSkkR71B3pzg
        8ySdKsmdohd73Vwo89ejIu+3NEeQfEKIe14Z8EI=
X-Google-Smtp-Source: APXvYqxKcMcUxJrDplQXptLyOKp2Zs8I7B8ewWRZZ263va6wQEGJwfSkkyy/uNesJ6f1l8o/vr7I5Jxw0WYGytEjiNc=
X-Received: by 2002:a05:6638:3a5:: with SMTP id z5mr2574450jap.95.1569952312092;
 Tue, 01 Oct 2019 10:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190917032106.32342-1-navid.emamdoost@gmail.com>
In-Reply-To: <20190917032106.32342-1-navid.emamdoost@gmail.com>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Tue, 1 Oct 2019 12:51:41 -0500
Message-ID: <CAEkB2ETM9zAnUMkx1GYJmGz2X_QYhkJEmr4Qi5xNV2AX=Qcb-Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: memory leak
To:     Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Nikola Cornij <nikola.cornij@amd.com>
Cc:     Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Eric Yang <Eric.Yang2@amd.com>, Jun Lei <Jun.Lei@amd.com>,
        Wesley Chalmers <Wesley.Chalmers@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Ken Chalmers <ken.chalmers@amd.com>,
        Eric Bernstein <Eric.Bernstein@amd.com>,
        Roman Li <Roman.Li@amd.com>, Thomas Lim <Thomas.Lim@amd.com>,
        hersen wu <hersenxs.wu@amd.com>,
        Charlene Liu <Charlene.Liu@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Would you please review this patch?


Thanks,
Navid.

On Mon, Sep 16, 2019 at 10:21 PM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
>
> In dcn*_clock_source_create when dcn20_clk_src_construct fails allocated
> clk_src needs release.
>
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c | 3 ++-
>  drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c | 1 +
>  drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 1 +
>  drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 1 +
>  drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c   | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c   | 1 +
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   | 1 +
>  7 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> index 6248c8455314..21de230b303a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> @@ -667,7 +667,8 @@ struct clock_source *dce100_clock_source_create(
>                 clk_src->base.dp_clk_src = dp_clk_src;
>                 return &clk_src->base;
>         }
> -
> +
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> index 764329264c3b..0cb83b0e0e1e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> @@ -714,6 +714,7 @@ struct clock_source *dce110_clock_source_create(
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> index c6136e0ed1a4..147d77173e2b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> @@ -687,6 +687,7 @@ struct clock_source *dce112_clock_source_create(
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> index 4a6ba3173a5a..0b5eeff17d00 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> @@ -500,6 +500,7 @@ static struct clock_source *dce120_clock_source_create(
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> index 860a524ebcfa..952440893fbb 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> @@ -701,6 +701,7 @@ struct clock_source *dce80_clock_source_create(
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> index a12530a3ab9c..3f25e8da5396 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> @@ -786,6 +786,7 @@ struct clock_source *dcn10_clock_source_create(
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src);
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> index b949e202d6cb..418fdcf1f492 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> @@ -955,6 +955,7 @@ struct clock_source *dcn20_clock_source_create(
>                 return &clk_src->base;
>         }
>
> +       kfree(clk_src)
>         BREAK_TO_DEBUGGER();
>         return NULL;
>  }
> --
> 2.17.1
>


-- 
Navid.
