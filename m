Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D804C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CDA20857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1lLmnT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfDBFzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 01:55:16 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37154 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfDBFzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 01:55:15 -0400
Received: by mail-it1-f193.google.com with SMTP id u65so3218252itc.2;
        Mon, 01 Apr 2019 22:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qt5uJUmPgzt/XTJh2RvvZTMxGpN9TNTsByW9OIky07U=;
        b=I1lLmnT6bLTnCmS9YEjLzDYyQiacCz1msXB52kTui7vEHg8Zc3Q4PVyM0Np3SN7vRP
         oKaJe7en6JD/GjZCW8B00zYF4I51i6mR6YFBYGzhgUG+K+hLLZncaR94fey2phG2D12J
         0tWaXB3500LUp4ExNXIRtICH9dL3aX/MHwEXNTXVpQeMuP5I6xHzwoJOwP1iCIvZAj2k
         HIjquSvUX8wwGqqZTlooeuBeP0um/v8T8rZO6OtaOaOvpYcuxmL/641ljku9hd3i88W0
         uq1hWkQS16468A2CawsTjI+IWUcc2H0qtDHmuL1/MCXF7k89Rug/iFCpqP1AaKBM4xeE
         Isgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qt5uJUmPgzt/XTJh2RvvZTMxGpN9TNTsByW9OIky07U=;
        b=pcRiFjOVEReLQBmCiq8MQgKO5Z9+A0L5hLyAi308ag3GT6XY8GL9Jb6iPN9A+cx4U0
         rVP47VBwVnhmmrXA2NVAEs2LuK6YeMK5x0w2GZMduILUy+yyelTSNHkmLyTqQNq25zgw
         7e8WOZEdd8sov3Erev9Q/z+pN35wYIHvqaeLtkxosQp4ifaDX1lMIjvdmX7wYRjgd2Z1
         A7i5P3U8onPzJZrg9ZV8+5eIewpGTKH0UyBZdhGnJFYJt6WRQxcXWakwja136IiDTb9p
         TyqRCUWSmMqiuOh1AJ1XzOcTUU8GMTvIrD3fPWuDM6lfN1jGC1ZmEKa+F6jDez2CAw3y
         9cRg==
X-Gm-Message-State: APjAAAWEJLgMjX1Bq5Jcr4pIZnIp2cHnl/PU5xFiRdGaDcdBcX9l2EJc
        TrlkK3ggD7I2LXynEWXcrQjBAHf2DySwx/iMPbA=
X-Google-Smtp-Source: APXvYqwRvYSdTLcS6RoZv+7WgqhvwitYDcABS8QxtxIl0KWZD61TZkx6MuK8Re+HFoSD5a0s7OtzBinQ11z/8gvBHgg=
X-Received: by 2002:a02:c496:: with SMTP id t22mr1975022jam.53.1554184514999;
 Mon, 01 Apr 2019 22:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190402105006.48f93e53@canb.auug.org.au>
In-Reply-To: <20190402105006.48f93e53@canb.auug.org.au>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Tue, 2 Apr 2019 13:55:03 +0800
Message-ID: <CAKGbVbvj9cZnJuey_ra7U+xm-JhoB17bpTgcXKiKaHWbjB9Sxw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Anholt <eric@anholt.net>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, patch is:
Reviewed-by: Qiang Yu <yuq825@gmail.com>

Regards,
Qiang

On Tue, Apr 2, 2019 at 7:50 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the drm-misc tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> In file included from include/linux/kernel.h:7,
>                  from include/asm-generic/bug.h:18,
>                  from arch/x86/include/asm/bug.h:83,
>                  from include/linux/bug.h:5,
>                  from include/linux/mmdebug.h:5,
>                  from include/linux/gfp.h:5,
>                  from include/linux/slab.h:15,
>                  from drivers/gpu/drm/lima/lima_ctx.c:4:
> drivers/gpu/drm/lima/lima_ctx.c: In function 'lima_ctx_create':
> include/linux/limits.h:13:18: warning: passing argument 3 of 'xa_alloc' makes pointer from integer without a cast [-Wint-conversion]
>  #define UINT_MAX (~0U)
>                   ^~~~~
> drivers/gpu/drm/lima/lima_ctx.c:26:36: note: in expansion of macro 'UINT_MAX'
>   err = xa_alloc(&mgr->handles, id, UINT_MAX, ctx, GFP_KERNEL);
>                                     ^~~~~~~~
> In file included from include/linux/radix-tree.h:31,
>                  from include/linux/idr.h:15,
>                  from include/drm/drm_device.h:7,
>                  from drivers/gpu/drm/lima/lima_device.h:7,
>                  from drivers/gpu/drm/lima/lima_ctx.c:6:
> include/linux/xarray.h:817:9: note: expected 'void *' but argument is of type 'unsigned int'
>    void *entry, struct xa_limit limit, gfp_t gfp)
>    ~~~~~~^~~~~
> drivers/gpu/drm/lima/lima_ctx.c:26:46: error: incompatible type for argument 4 of 'xa_alloc'
>   err = xa_alloc(&mgr->handles, id, UINT_MAX, ctx, GFP_KERNEL);
>                                               ^~~
> In file included from include/linux/radix-tree.h:31,
>                  from include/linux/idr.h:15,
>                  from include/drm/drm_device.h:7,
>                  from drivers/gpu/drm/lima/lima_device.h:7,
>                  from drivers/gpu/drm/lima/lima_ctx.c:6:
> include/linux/xarray.h:817:32: note: expected 'struct xa_limit' but argument is of type 'struct lima_ctx *'
>    void *entry, struct xa_limit limit, gfp_t gfp)
>                 ~~~~~~~~~~~~~~~~^~~~~
>
> Caused by commit
>
>   a1d2a6339961 ("drm/lima: driver for ARM Mali4xx GPUs")
>
> interacting with commit
>
>   a3e4d3f97ec8 ("XArray: Redesign xa_alloc API")
>
> from Linus' tree (v5.1-rc1).
>
> I have applied the following patch for today.  It could be applied as
> part of a merge of v5.1-rc1 into drm-misc.
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 2 Apr 2019 10:45:32 +1100
> Subject: [PATCH] drm/lima: update for xa_alloc API change
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/gpu/drm/lima/lima_ctx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_ctx.c b/drivers/gpu/drm/lima/lima_ctx.c
> index c8d12f7c6894..bafa00d74cc5 100644
> --- a/drivers/gpu/drm/lima/lima_ctx.c
> +++ b/drivers/gpu/drm/lima/lima_ctx.c
> @@ -23,7 +23,7 @@ int lima_ctx_create(struct lima_device *dev, struct lima_ctx_mgr *mgr, u32 *id)
>                         goto err_out0;
>         }
>
> -       err = xa_alloc(&mgr->handles, id, UINT_MAX, ctx, GFP_KERNEL);
> +       err = xa_alloc(&mgr->handles, id, ctx, XA_LIMIT(*id, UINT_MAX), GFP_KERNEL);
>         if (err < 0)
>                 goto err_out0;
>
> --
> 2.20.1
>
> --
> Cheers,
> Stephen Rothwell
