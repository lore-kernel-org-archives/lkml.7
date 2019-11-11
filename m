Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB9DC17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156BC20659
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezStHSGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfKKR6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 12:58:05 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:46467 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfKKR6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 12:58:05 -0500
Received: by mail-wr1-f53.google.com with SMTP id b3so15602757wrs.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 09:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EpziU3n1BW5TLHQT8FQscf45CBaREelPg2coeu8/dVQ=;
        b=ezStHSGEGwVEJrQ2BSZyBOA0qUcZhjbVVj5Hte4teiC3bJFyEKVYPUSqYfAmvOit3o
         H10Yx+EBvcTFLI/I6dWQjNkRRL2ENKHmkZKKtbx76Jd1bbCESZ1zbdQD2rDKd5xuT8Xr
         5wC36jcM9CT+skEFLwhQ4wIfnNXXpWWY4uKSh19OT5CltAqQDXqCc0dA/YLg6Tc+Ayd0
         Ra91tYwjq/vMPjRJh73oq6Hseg3C0D0XJ+oREdGO7+oQ2wxiQGdKzeZAEdrUcuDIl+vs
         xidMWt1xUfXXwU1fPF27DJYJ7OocSrxCWfbrhTwVO1wGUO3bJHweTq/as7v8twDhp2LR
         r6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EpziU3n1BW5TLHQT8FQscf45CBaREelPg2coeu8/dVQ=;
        b=c0zKp+PRdwvfeH7nfyRqlZBF2uEpAPnkTrw+YrRBeSl+hKK8uvMzR8Rkb7LsBQQVDR
         VfDa8McXCatRiPJ8iyvt+E6FUPO2wlwYBcb1HbZC35xKTPOLj2iVkysBPk30fphpeCDq
         5CXEPeeYmJb6Vs18sLH4f5qUhe6mFMa0dJCGDvuuVvaNMqY2MICRGdL8KPgu7dcACIW3
         ku/1lo+7dQMA8Ny4DQl2m4BmBaqG7kEMiw4QsHvTLoYQLJKDMvLruT6IbSxrrI5wjXRh
         xyglAg6P7GS8NPp8nxfRY6gA9F5UVh0He9HQEnkpgGYUR9WcDWwkR2FsZ0/kmp7MPwSl
         jOVA==
X-Gm-Message-State: APjAAAX0q/nMYKKYd3k2BH7EtPk4YpYjMges/GZWTswvvLP22klSfocg
        Z4e31sE5eu8ugWnF9WcnJviMxugh7J/i/SbcEOY=
X-Google-Smtp-Source: APXvYqx3ye/RxIPpV3svQCJ4zX0dnZOKXMO8w79UOdtPMbx1hABpnBd3Hy5aphbwPtqSPIfRyTOPL8O8scVa13McSKk=
X-Received: by 2002:a5d:4688:: with SMTP id u8mr21495307wrq.40.1573495082976;
 Mon, 11 Nov 2019 09:58:02 -0800 (PST)
MIME-Version: 1.0
References: <20191109093725.42364-1-yuehaibing@huawei.com>
In-Reply-To: <20191109093725.42364-1-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 11 Nov 2019 12:57:49 -0500
Message-ID: <CADnq5_PcSdTm9yKdbv=QHFtGeO58a30wZ0KxjQUNqy3Aax9thg@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: remove set but not used variable 'ds_port'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

Alex

On Sun, Nov 10, 2019 at 9:29 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c: In function dp_wa_power_up_0010FA:
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:2320:35: warning:
>  variable ds_port set but not used [-Wunused-but-set-variable]
>
> It is never used, so can be removed.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 65de32f..b814b74 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -2910,7 +2910,6 @@ static void dp_wa_power_up_0010FA(struct dc_link *link, uint8_t *dpcd_data,
>                 int length)
>  {
>         int retry = 0;
> -       union dp_downstream_port_present ds_port = { 0 };
>
>         if (!link->dpcd_caps.dpcd_rev.raw) {
>                 do {
> @@ -2923,9 +2922,6 @@ static void dp_wa_power_up_0010FA(struct dc_link *link, uint8_t *dpcd_data,
>                 } while (retry++ < 4 && !link->dpcd_caps.dpcd_rev.raw);
>         }
>
> -       ds_port.byte = dpcd_data[DP_DOWNSTREAMPORT_PRESENT -
> -                                DP_DPCD_REV];
> -
>         if (link->dpcd_caps.dongle_type == DISPLAY_DONGLE_DP_VGA_CONVERTER) {
>                 switch (link->dpcd_caps.branch_dev_id) {
>                 /* 0010FA active dongles (DP-VGA, DP-DLDVI converters) power down
> --
> 2.7.4
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
