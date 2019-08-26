Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643CEC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FCD2173E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2HLiYva"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732922AbfHZPSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:18:37 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:34967 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbfHZPSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:18:37 -0400
Received: by mail-wm1-f43.google.com with SMTP id l2so16277472wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 08:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MJqE4e1y1WxXXZ8DFg+jhsnKJrwmmhLs+9XOzxV26SU=;
        b=N2HLiYvaM4PdUNOO2PtoZPCA6NElehowjRX0j5KIM468l9V2xXANYh5UlnYOU1zOWm
         LsbN0/D8d8+X879QeHvrtF8UjpDYT5lFnVduz3l2dyQ+ESSSKk1/RiFFl1D7nDBDZqed
         +1fGV84WqW0Xngi+syiQ9G4Y04eJn1eVKJsmCPqDY9zPEZDdl62X/a0yAL8C2NyqRWFO
         d78juY3fLRnAxxU5e4FTiXvkG2L0RGE5s+jy4y/nCTKWvKlHqNQ5n3ReNlseSv+qVSZ8
         iDeR+teCc/0naAMS5u8KveRSqA6MbQOxGbys+mM6H7NHnxYJP4kNcBmMoj5zQN0sARBc
         WO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MJqE4e1y1WxXXZ8DFg+jhsnKJrwmmhLs+9XOzxV26SU=;
        b=uFuswK+/u9578vxeWNGpjVhFRQYdDW6qIa1SUdtXKOYxw/mGxxrtgbBA7RrIcJRFHU
         cnEGLjsqJB+LMKejBt/VATDmkgl8nZcsPOzOWe5y00KW4ch9km6a4CtPdIJPH3j9PcJp
         qUoGh4JfuPwl9fyjb68il4DZ2N9HDb0aP+vEjpSpwK4vb+fjCmkkWdRshhsStseKQm6m
         j2lAm/lNGvqjRyLBpZNZ1q+Gxo+XHIERxopUi9gp/ahHcH63ce/0N86dLCw/g+YBBQkH
         1WEiFOrtp/vgCXM7wQyBVAAvXnw6EnD0pUraG03Ql0BFAQ8Dpbc8oOJjaITrRH/4o4D4
         zHpQ==
X-Gm-Message-State: APjAAAXsyhmb6faM2KVIrUByfOvyffE5NBwHajOSwvJLt3HoNS7kynN6
        zkyUEMKS1ubRRZ2erCzFXzSdvgyE7NUS59js+Gg=
X-Google-Smtp-Source: APXvYqyNb/6xrJ9fWSJ6ROzQi/4V9Sg49C3QASNejc6eEG8PQt6mE/AzgkYX44UEwm3Io3giXr6Ongh6bMh322OAAj0=
X-Received: by 2002:a1c:750f:: with SMTP id o15mr9960829wmc.67.1566832714319;
 Mon, 26 Aug 2019 08:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190826085707.12504-1-yuehaibing@huawei.com> <c324866d-855a-b259-4511-c69491a82c88@amd.com>
In-Reply-To: <c324866d-855a-b259-4511-c69491a82c88@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 26 Aug 2019 11:18:22 -0400
Message-ID: <CADnq5_OgDuFm_Huofu6S2O2dyzO42UdZm=cYgRKwH7f4gTCyvg@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu/display: fix build error without CONFIG_DRM_AMD_DC_DSC_SUPPORT
To:     Harry Wentland <hwentlan@amd.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>, "Lei, Jun" <Jun.Lei@amd.com>,
        "Laktyushkin, Dmytro" <Dmytro.Laktyushkin@amd.com>,
        "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
        "Aberback, Joshua" <Joshua.Aberback@amd.com>,
        "Liu, Wenjing" <Wenjing.Liu@amd.com>,
        "Liu, Charlene" <Charlene.Liu@amd.com>,
        "Leung, Martin" <Martin.Leung@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 9:22 AM Harry Wentland <hwentlan@amd.com> wrote:
>
>
>
> On 2019-08-26 4:57 a.m., YueHaibing wrote:
> > If CONFIG_DRM_AMD_DC_DSC_SUPPORT is not set, build fails:
> >
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c: In function dcn20_hw_sequencer_construct:
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c:2099:28:
> >  error: dcn20_dsc_pg_control undeclared (first use in this function); did you mean dcn20_dpp_pg_control?
> >   dc->hwss.dsc_pg_control = dcn20_dsc_pg_control;
> >                             ^~~~~~~~~~~~~~~~~~~~
> >                             dcn20_dpp_pg_control
> >
> > Use CONFIG_DRM_AMD_DC_DSC_SUPPORT to guard this.
> >
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Fixes: 8a31820b1218 ("drm/amd/display: Make init_hw and init_pipes generic for seamless boot")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>

Applied.  Thanks,

Alex

> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> > index e146d1d..54d67f6 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> > @@ -2092,7 +2092,11 @@ void dcn20_hw_sequencer_construct(struct dc *dc)
> >       dc->hwss.enable_power_gating_plane = dcn20_enable_power_gating_plane;
> >       dc->hwss.dpp_pg_control = dcn20_dpp_pg_control;
> >       dc->hwss.hubp_pg_control = dcn20_hubp_pg_control;
> > +#ifdef CONFIG_DRM_AMD_DC_DSC_SUPPORT
> >       dc->hwss.dsc_pg_control = dcn20_dsc_pg_control;
> > +#else
> > +     dc->hwss.dsc_pg_control = NULL;
> > +#endif
> >       dc->hwss.disable_vga = dcn20_disable_vga;
> >
> >       if (IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
