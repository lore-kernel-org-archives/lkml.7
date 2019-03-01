Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8035C10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 23:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA542083E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 23:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pn3kITrb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfCAXvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 18:51:53 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39180 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCAXvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 18:51:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id z84so13721182wmg.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 15:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=us4VmJS86fbJNOY+uXeMpjV67kwynewUJLh7fnokV9g=;
        b=Pn3kITrbmFePYxzP99OZeozAP9ofeqyp47lBw2W6kqBeRd0twvIfW7G1mKsxYzRXoG
         Xa0zcgOUV7Y/nwgLOkKjoCVWnPz44V8Wd82Rw3yTE23cFEuDdupcd6XcrcDEbwSwZIIm
         S/Lr9kLfkc9jQ42fgkVwlZ1UKMaZu9Pb6L1uwEqqu7KoVs/8Uy8mx7HVFlob4ulH4foV
         nno/isatG+Nglco+soYLv74A1fAT/X0XzdCw2JgEPU+N9IopyB1xg0upt1QhnHfq7IpH
         fCCDztdvTsyeds/oJl/Q+STfC2b6FjWNX2sdli45fFSmqliViuE4YiHwJJ2IfWlv8DPn
         751A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=us4VmJS86fbJNOY+uXeMpjV67kwynewUJLh7fnokV9g=;
        b=ntAiNTdUJJFtuxUfXdMpXUMSOTeVExR1X/lmu8ULl+l6gZUyQo1OXowW1iWVl2RK/m
         pgHO9pMtBm4GXdi25tqVB0J/4NVBwb5zbuaV0NTnP9dGwHPPT/MGxedDqLsCodezCyA+
         Yo5sypGCmApUMa7WS/tn6Wo9A4cALel+aQVqDpHZdfYyE7MyUkpRIZ7LAP0N4+EuJBXg
         rseofu5F0qCqWtQpaBdA6hYfz+gQAdESPfQjV3g5bo7NW2nZ4xq/0AVnwmljAt0hdd+Z
         nOAbZuLgW42AZ+Mky6uxnJVbQx1Bma9/zJVJt0/w7ZjwjQP6uE+9TyinoUnoek0jFaau
         clyw==
X-Gm-Message-State: APjAAAX96hHJxd4vSZiOmdrQkg7ZrzwdJlPazdf2bH0XhWzc8FuhOu2v
        DV2X3upUfR2KousEMUDvVmk9MGmtGVqhHckE5cg=
X-Google-Smtp-Source: APXvYqyFGEE6k0c4h6xLX+DVRMM45DAzBpmTq6ca5lbV1wUlB84gJkZETBXVoCAnsVwbwqW0PHqiXVPtmyUwPXrohbw=
X-Received: by 2002:a1c:6506:: with SMTP id z6mr4500198wmb.153.1551484311489;
 Fri, 01 Mar 2019 15:51:51 -0800 (PST)
MIME-Version: 1.0
References: <20190301205832.GA21783@embeddedor>
In-Reply-To: <20190301205832.GA21783@embeddedor>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 1 Mar 2019 18:51:39 -0500
Message-ID: <CADnq5_PPF0Z3fcrDxvu6F32TNuX1vSTB_4dJO15oZrrXRJnQkA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx_v8_0: Mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 3:58 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>
> This patch fixes the following warning:
>
> drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c: In function =E2=80=98gfx_v8_0_tili=
ng_mode_table_init=E2=80=99:
> ./include/linux/device.h:1487:2: warning: this statement may fall through=
 [-Wimplicit-fallthrough=3D]
>   _dev_warn(dev, dev_fmt(fmt), ##__VA_ARGS__)
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:3236:3: note: in expansion of macro=
 =E2=80=98dev_warn=E2=80=99
>    dev_warn(adev->dev,
>    ^~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:3240:2: note: here
>   case CHIP_CARRIZO:
>   ^~~~
>
> Warning level 3 was used: -Wimplicit-fallthrough=3D3
>
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index b8e50a34bdb3..02955e6e9dd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -3236,6 +3236,7 @@ static void gfx_v8_0_tiling_mode_table_init(struct =
amdgpu_device *adev)
>                 dev_warn(adev->dev,
>                          "Unknown chip type (%d) in function gfx_v8_0_til=
ing_mode_table_init() falling through to CHIP_CARRIZO\n",
>                          adev->asic_type);
> +               /* fall through */
>
>         case CHIP_CARRIZO:
>                 modearray[0] =3D (ARRAY_MODE(ARRAY_2D_TILED_THIN1) |
> --
> 2.21.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
