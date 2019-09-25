Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111B3C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFA12146E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQJFF7Qq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439798AbfIYQEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 12:04:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39947 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfIYQEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 12:04:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id l3so7599501wru.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 09:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rVfl8kpdiHnS1ptDn6UBfU0R6eJj6Us2UCfGbdbQiks=;
        b=UQJFF7QqglouBiozK+rZQFhqy9yX0DjGq6rCnCScMxjiVsTq0nqE5PeGmHCPjsYpYE
         oxtfpMe9CLFZyNx3fklf93kj6EgLCZUzTbh0n2k+yar3ZvH5VcDwRiit2P1ud3JfBLzE
         rffar6gaIm3OY3/eqIhqHzxgx33QSuBDhBtJCGv44wMVYgK1PVfTEkEEH9sf6hNSNUt3
         5W76iJvw8YnLOgofTAM1fXAMJXWJ1mEBITmBIKC2H2GYY+71CpKBTYAAFLfrUEl+Kmz0
         pl5aEOoTXCjoPQXQYAUBl7eKXPvykchZ72C/2XAL5ziV/s3ThIiEnZRNjkcKw+MfAKmK
         Z6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rVfl8kpdiHnS1ptDn6UBfU0R6eJj6Us2UCfGbdbQiks=;
        b=FxhF8VQqfxFX4fVX1A5MQaQNiZ0PU1rZmQ25ujifcdyYRyJIE4q/46GkrDXfwwmzOV
         hgTtmGIIenKgm3pPfDH9IjrtroUIrN1dJqAKVzOSkCon/2o3Jz/XP4uVSzQcsjxOKhkg
         Y/zwXcd6WUjW8K6FUGFj9AQRccePgwOVmGUvYsa+Fe8JGF8dMzaHkQnlEzaqZFhmYFFL
         u4rxgrtjuRjBOkTLPhkQLo57V5TV1k5VvT60NuqjemdIQJ9MYDc7s/23PABxgC5k4ixP
         BvaBparig5RbhmAfVrDkryHc5Clwx8GmW6udwwBoiwmzwxDpU1s0tN3kmW06GWjN4LwL
         vjrw==
X-Gm-Message-State: APjAAAUWv/ZB4qm19aym1vECJI9Hh7lUSbWPz8QNN06lbngnSoTAw4El
        7/d3HtR7AysjGYqLb2958Yz0L75nDiP/JlREOBTBLw==
X-Google-Smtp-Source: APXvYqxRruXG1tiHZDIaF3tCGEeKWglNDsJufOM6QBA9IkNPXE5AjQNzMrjeFdWdvUC0TxA4iPys96pbH7ROyIxGqlg=
X-Received: by 2002:a5d:4444:: with SMTP id x4mr9892045wrr.11.1569427475640;
 Wed, 25 Sep 2019 09:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190925042407.31383-1-navid.emamdoost@gmail.com> <5cb6dec0-7f88-5d14-82cb-919f1d190b2f@amd.com>
In-Reply-To: <5cb6dec0-7f88-5d14-82cb-919f1d190b2f@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 25 Sep 2019 12:04:22 -0400
Message-ID: <CADnq5_MuFQgTQn50DikASgNVjLaJxPcQdfMPXesxdSqhME_Dmg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: prevent memory leak
To:     Harry Wentland <hwentlan@amd.com>
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lei, Jun" <Jun.Lei@amd.com>, Sam Ravnborg <sam@ravnborg.org>,
        Wang Hai <wanghai26@huawei.com>,
        "Cheng, Tony" <Tony.Cheng@amd.com>,
        "Francis, David" <David.Francis@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "emamd001@umn.edu" <emamd001@umn.edu>,
        "Bernstein, Eric" <Eric.Bernstein@amd.com>,
        Su Sung Chung <Su.Chung@amd.com>,
        "smccaman@umn.edu" <smccaman@umn.edu>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "kjlu@umn.edu" <kjlu@umn.edu>, Aidan Wood <Aidan.Wood@amd.com>,
        "Wu, Hersen" <hersenxs.wu@amd.com>,
        "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
        "Chalmers, Kenneth" <Ken.Chalmers@amd.com>,
        Thomas Lim <Thomas.Lim@amd.com>,
        "Yang, Eric" <Eric.Yang2@amd.com>,
        "Chalmers, Wesley" <Wesley.Chalmers@amd.com>,
        "Li, Roman" <Roman.Li@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Laktyushkin, Dmytro" <Dmytro.Laktyushkin@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 9:54 AM Harry Wentland <hwentlan@amd.com> wrote:
>
>
>
> On 2019-09-25 12:23 a.m., Navid Emamdoost wrote:
> > In dcn*_create_resource_pool the allocated memory should be released if
> > construct pool fails.
> >
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>

Applied.  thanks!

Alex

> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c | 1 +
> >  drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c | 1 +
> >  drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 1 +
> >  drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 1 +
> >  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c   | 1 +
> >  5 files changed, 5 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> > index afc61055eca1..1787b9bf800a 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> > @@ -1091,6 +1091,7 @@ struct resource_pool *dce100_create_resource_pool(
> >       if (construct(num_virtual_links, dc, pool))
> >               return &pool->base;
> >
> > +     kfree(pool);
> >       BREAK_TO_DEBUGGER();
> >       return NULL;
> >  }
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> > index c66fe170e1e8..318e9c2e2ca8 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> > @@ -1462,6 +1462,7 @@ struct resource_pool *dce110_create_resource_pool(
> >       if (construct(num_virtual_links, dc, pool, asic_id))
> >               return &pool->base;
> >
> > +     kfree(pool);
> >       BREAK_TO_DEBUGGER();
> >       return NULL;
> >  }
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> > index 3ac4c7e73050..3199d493d13b 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> > @@ -1338,6 +1338,7 @@ struct resource_pool *dce112_create_resource_pool(
> >       if (construct(num_virtual_links, dc, pool))
> >               return &pool->base;
> >
> > +     kfree(pool);
> >       BREAK_TO_DEBUGGER();
> >       return NULL;
> >  }
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> > index 7d08154e9662..bb497f43f6eb 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> > @@ -1203,6 +1203,7 @@ struct resource_pool *dce120_create_resource_pool(
> >       if (construct(num_virtual_links, dc, pool))
> >               return &pool->base;
> >
> > +     kfree(pool);
> >       BREAK_TO_DEBUGGER();
> >       return NULL;
> >  }
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> > index 5a89e462e7cc..59305e411a66 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> > @@ -1570,6 +1570,7 @@ struct resource_pool *dcn10_create_resource_pool(
> >       if (construct(init_data->num_virtual_links, dc, pool))
> >               return &pool->base;
> >
> > +     kfree(pool);
> >       BREAK_TO_DEBUGGER();
> >       return NULL;
> >  }
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
