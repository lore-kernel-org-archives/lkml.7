Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73026C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CCB233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dO6MkOLx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393345AbfHVUzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:55:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41813 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387699AbfHVUzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:55:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id j16so6651614wrr.8;
        Thu, 22 Aug 2019 13:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lRbOPMDoE31doaBIKEM0yAs5zAE0Z+co7+P/zE3Deug=;
        b=dO6MkOLxdmPBc2RukZgga6fitB1oKcUHjkESVv57DByDxL25n69RQk4e6ArwcNptMo
         BQMKdYnlmRCIfaXGHfP2KR4XuUusE5UWlJfnYev1V9jvenGPRvN6RuYIHkHNVp4TrkN3
         fW3m5IwOZ2nTnJnHsxIdTVVYLGfPPaOv0o3QVWapwr3wnLH/An0YUzwLdkSo5ipGvL0p
         fluLI7i3+Ic48hP2ab92zS0fDrXNGrLDAnGdW3dRQEBQUbfBTCB+7bskuXrvTVQNS1gG
         KmauVkh5+ZN4913GAY2dz+U19ZDgfBQScjsC6Pob55UroJBZxP+L8HYWVqG/Avm3RoPe
         5xfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRbOPMDoE31doaBIKEM0yAs5zAE0Z+co7+P/zE3Deug=;
        b=Iams6K/UMyVa+xUBd+1c94LGBQX8dI4d08MFg7e5HXVKB18h0Xr9C/lOGJKBldt0s1
         6599z7W7WKOUICGzYxaRX2buniEqnNn7X47lBfzdSzeIYLaqqAdGc4xw+kPWuoUUIU7H
         xVemgrYqXzoodXsMMJKdd9qGg9uyla6pPPyjoY88fs4IWAgaVWZTNMLttg4P6b9MmED5
         Vsp0Q8DNZxm2EAQQU2aeLX93jhlrkh3k5f1JCGoFUP4dekLyIh/qI47XqNmcxyffH3BH
         H+GUNdWIi46S10tltDy5Kii8N08Je23bYfC/EPYuAh/1jmNjT/yH3rkeTguQZ2ZqBTnz
         Zv1Q==
X-Gm-Message-State: APjAAAVMgJraHWiNi9F4KbpkXQ8YEeZ+rYAw9PXqcg3k4vNGGK2Gi80U
        kaPbi9P1rWEq367COGxamUhbEqsjHsjCnH4/fmM=
X-Google-Smtp-Source: APXvYqxVuoG2YDL4c/4HLpmJucH4dmayX1vJ+tnYQOJyQWDNhMAnVIhulJpruEcIK1jr/0JSHbj+9O4UGbAaXMDgUJg=
X-Received: by 2002:a5d:4ecb:: with SMTP id s11mr866410wrv.323.1566507320236;
 Thu, 22 Aug 2019 13:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190816221011.10750-1-colin.king@canonical.com> <5981f677-3347-1450-f787-853e97496bd4@amd.com>
In-Reply-To: <5981f677-3347-1450-f787-853e97496bd4@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 22 Aug 2019 16:55:08 -0400
Message-ID: <CADnq5_M-7LQ1HAiV5-jzYZENRNqzRm939AyvVarDpWJEJZDNqw@mail.gmail.com>
Subject: Re: [PATCH][drm-next] drm/amd/display: fix a potential null pointer dereference
To:     Harry Wentland <hwentlan@amd.com>
Cc:     Colin King <colin.king@canonical.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 3:21 PM Harry Wentland <hwentlan@amd.com> wrote:
>
> On 2019-08-16 6:10 p.m., Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Currently the pointer init_data is dereferenced on the assignment
> > of fw_info before init_data is sanity checked to see if it is null.
> > Fix te potential null pointer dereference on init_data by only
> > performing dereference after it is null checked.
> >
> > Addresses-Coverity: ("Dereference before null check")
> > Fixes: 9adc8050bf3c ("drm/amd/display: make firmware info only load once during dc_bios create")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>

Applied.  Thanks!

Alex

> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> > index bee81bf288be..926954c804a6 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> > @@ -1235,7 +1235,7 @@ static bool calc_pll_max_vco_construct(
> >                       struct calc_pll_clock_source_init_data *init_data)
> >  {
> >       uint32_t i;
> > -     struct dc_firmware_info *fw_info = &init_data->bp->fw_info;
> > +     struct dc_firmware_info *fw_info;
> >       if (calc_pll_cs == NULL ||
> >                       init_data == NULL ||
> >                       init_data->bp == NULL)
> > @@ -1244,6 +1244,7 @@ static bool calc_pll_max_vco_construct(
> >       if (init_data->bp->fw_info_valid)
> >               return false;
> >
> > +     fw_info = &init_data->bp->fw_info;
> >       calc_pll_cs->ctx = init_data->ctx;
> >       calc_pll_cs->ref_freq_khz = fw_info->pll_info.crystal_frequency;
> >       calc_pll_cs->min_vco_khz =
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
