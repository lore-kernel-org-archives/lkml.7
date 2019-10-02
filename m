Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D21C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0D621783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eG+t83qe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfJBNxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:53:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50535 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfJBNxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:53:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id 5so7327200wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 06:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aqSjigfY7p4Yb42doAbeJgtTy2xM6snKumCbJQAPbZY=;
        b=eG+t83qemvZkor9r7JgrjbhMLcTSSL2TdhS5P6S1sYX8MaMXEhfYZwyS5efibXib0C
         wRKUZM9wlm6OjKabpMw2/ZdFx+sPRMTKvssehqwwjH5ACEvwYuUjusxF4XyZ4RQwgeGC
         YJe3JeD1oTZtDyJxmrfUtUbqU6TxFVUx0hhhTv5jolm9toxhKor/cMZXDVrQGgtnxbuP
         e1pkhShn4hMpFgd/xTthl3L8hwOAmt2GC/sKOdxcJC2D3kqacBGWFBKTaj6Q4QOt9cbO
         1SWvWIdUTRAARZrru+2lp7unsltCONYu37Ajf1y16HxouoZX52S7TMD1MIswPkSqt/zG
         nU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aqSjigfY7p4Yb42doAbeJgtTy2xM6snKumCbJQAPbZY=;
        b=OTpZMqNnY+QfZ+PMcH0cgSEjN7Oa5Kx1s6KQl0tXs/M71WNduUVVZJaOuluMlHOAh4
         3xwm4AkMVnn4ucbgw4qz9I8PNNNAs8AdCHbobCrE2Bh7EQNiWYt/O/sBk7F/iBnYvCq+
         fE9nwfK9mLFPnC3YkmvTz137XG4nctvvdGv5Px/z36HDOFUvIQZXIZ/FcQR1PrMGLo6I
         PiN8x6yLD6DGF+QK0oo4Bq8HlGW4U6Xlaukds1m/cOX5uYtFK0bUN1sa50YGMZ80b5dG
         aJRFDsAA0NguU4kwo4A9PH6nP4vdAHUaLING1Hc6dicBftSmTfYZx9GSwU3HGMJOTL8F
         tI0w==
X-Gm-Message-State: APjAAAXdCqTPzCBQ219cvgvYUsGiG6nbDCdxgKqepDPJsVMx+NGW/Ukq
        +GRHYRaHGx1cUM+rOyLQ0/a4ywjoifGQrta8s3k=
X-Google-Smtp-Source: APXvYqyPvHSbPXW+UE7lB4SzAIzxQEjtgRbdKHaZ4YC4kKszT3QOLL9sVC/glKqlY73eoWNp30WuAmxQwjL0NWNzMEw=
X-Received: by 2002:a05:600c:54a:: with SMTP id k10mr3183855wmc.127.1570024382909;
 Wed, 02 Oct 2019 06:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190917032106.32342-1-navid.emamdoost@gmail.com> <CAEkB2ETM9zAnUMkx1GYJmGz2X_QYhkJEmr4Qi5xNV2AX=Qcb-Q@mail.gmail.com>
In-Reply-To: <CAEkB2ETM9zAnUMkx1GYJmGz2X_QYhkJEmr4Qi5xNV2AX=Qcb-Q@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 2 Oct 2019 09:52:49 -0400
Message-ID: <CADnq5_N_s9qyERmh7BgJhPjvfFb8aZvzbBjBuw9JttQFr85DTA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: memory leak
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Nikola Cornij <nikola.cornij@amd.com>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, Jun Lei <Jun.Lei@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Navid Emamdoost <emamd001@umn.edu>,
        Eric Bernstein <Eric.Bernstein@amd.com>,
        Stephen McCamant <smccaman@umn.edu>,
        Charlene Liu <Charlene.Liu@amd.com>,
        Leo Li <sunpeng.li@amd.com>, Kangjie Lu <kjlu@umn.edu>,
        hersen wu <hersenxs.wu@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Ken Chalmers <ken.chalmers@amd.com>,
        Thomas Lim <Thomas.Lim@amd.com>,
        Eric Yang <Eric.Yang2@amd.com>,
        Wesley Chalmers <Wesley.Chalmers@amd.com>,
        Roman Li <Roman.Li@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 5:00 PM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
>
> Would you please review this patch?
>

Applied.  thanks!

Alex

>
> Thanks,
> Navid.
>
> On Mon, Sep 16, 2019 at 10:21 PM Navid Emamdoost
> <navid.emamdoost@gmail.com> wrote:
> >
> > In dcn*_clock_source_create when dcn20_clk_src_construct fails allocated
> > clk_src needs release.
> >
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c | 3 ++-
> >  drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c | 1 +
> >  drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 1 +
> >  drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 1 +
> >  drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c   | 1 +
> >  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c   | 1 +
> >  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c   | 1 +
> >  7 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> > index 6248c8455314..21de230b303a 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> > @@ -667,7 +667,8 @@ struct clock_source *dce100_clock_source_create(
> >                 clk_src->base.dp_clk_src = dp_clk_src;
> >                 return &clk_src->base;
> >         }
> > -
> > +
> > +       kfree(clk_src);
> >         BREAK_TO_DEBUGGER();
> >         return NULL;
> >  }
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> > index 764329264c3b..0cb83b0e0e1e 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> > @@ -714,6 +714,7 @@ struct clock_source *dce110_clock_source_create(
> >                 return &clk_src->base;
> >         }
> >
> > +       kfree(clk_src);
> >         BREAK_TO_DEBUGGER();
> >         return NULL;
> >  }
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> > index c6136e0ed1a4..147d77173e2b 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> > @@ -687,6 +687,7 @@ struct clock_source *dce112_clock_source_create(
> >                 return &clk_src->base;
> >         }
> >
> > +       kfree(clk_src);
> >         BREAK_TO_DEBUGGER();
> >         return NULL;
> >  }
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> > index 4a6ba3173a5a..0b5eeff17d00 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> > @@ -500,6 +500,7 @@ static struct clock_source *dce120_clock_source_create(
> >                 return &clk_src->base;
> >         }
> >
> > +       kfree(clk_src);
> >         BREAK_TO_DEBUGGER();
> >         return NULL;
> >  }
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> > index 860a524ebcfa..952440893fbb 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> > @@ -701,6 +701,7 @@ struct clock_source *dce80_clock_source_create(
> >                 return &clk_src->base;
> >         }
> >
> > +       kfree(clk_src);
> >         BREAK_TO_DEBUGGER();
> >         return NULL;
> >  }
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> > index a12530a3ab9c..3f25e8da5396 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> > @@ -786,6 +786,7 @@ struct clock_source *dcn10_clock_source_create(
> >                 return &clk_src->base;
> >         }
> >
> > +       kfree(clk_src);
> >         BREAK_TO_DEBUGGER();
> >         return NULL;
> >  }
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> > index b949e202d6cb..418fdcf1f492 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> > @@ -955,6 +955,7 @@ struct clock_source *dcn20_clock_source_create(
> >                 return &clk_src->base;
> >         }
> >
> > +       kfree(clk_src)
> >         BREAK_TO_DEBUGGER();
> >         return NULL;
> >  }
> > --
> > 2.17.1
> >
>
>
> --
> Navid.
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
