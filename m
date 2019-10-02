Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A039C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF5021D80
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmzgMvl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfJBNjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:39:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52019 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfJBNjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:39:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so7262063wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 06:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7C/lmvhnOK2ftbFYct5zRz8/v/Ze5kOZrnGinFzRgjI=;
        b=EmzgMvl/cYe7h2v3GRBOlUfZcm7b3Blw3Q6HGG1ZYwjZZjOM7qquPWWzUP4IIpRNuK
         x+OZTSIigZUvASgyv6pKxtCEp1TiiK6+tCqouiYPc5eKthuuiPBxg7+tWs0ByTx3iQ0x
         u6HHGYdd25KkRi2jYBZW0lK37XvFT9vLNeqdM7lXe1grBO7JdGhu1h5Dim1I+xr+LvGX
         WkfXB23EDKqMmy9YyooyQ+ixCwHfUwbXcedn54zJ7ovCteYTMdeBNKrluLQVjCEU7Eic
         v4t1xqdOyBtpaLbJCfeYGfdBgRoYybC+UaFGQqzzwbswCz8HniR3AKU1AWRj+UkIfonZ
         j0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7C/lmvhnOK2ftbFYct5zRz8/v/Ze5kOZrnGinFzRgjI=;
        b=DBLSUIKSsc6AeBSF3sZWyKgNR3HslTNLKYGIFuMDOUH+4q0PlxHX6dG4x41yKOq5Me
         dO0qqEbyQ0bhu4MbSIdBnefOYRH+5AghIGufMgcc32ANkReZ/BBiKE2W/SGQlcQkwmjM
         FV1exFInvDm3TUq1dk3xiWpPdsSVxI+RWFCKiypwV+pL0rf5cz5Mgz7+Tz6gwwSkrj9H
         R3s2p54M0Pv2DzpsMBEP9VYkzZ/cZIEI76CV+i78QC6CvPi+6zPMUYS5HfB0W26ubgYT
         5D19gyxcQonvYRf8lI4PrJ+uCmXsYeNdIM0hI7S8LastzlwryXeVF68JXHiZJY7bOblf
         7/hQ==
X-Gm-Message-State: APjAAAXaqBFyuu1bf9cb5WfnTYMjK89J+V1KjONSacu57XJj5R/Kdof5
        Xyv/TM24vz9uO7Nfhwkpje/+WdOh9qJd22AGow81HA==
X-Google-Smtp-Source: APXvYqx5i5lPDDGn9linzRM7km60QUouiBdUZ6pNR81GRD+PFpCXfkZdbsDh4kZ/25N4vrvmnxAAVd7MhXAnP4vB2fQ=
X-Received: by 2002:a05:600c:54a:: with SMTP id k10mr3134474wmc.127.1570023581249;
 Wed, 02 Oct 2019 06:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191002051759.GA161133@LGEARND20B15>
In-Reply-To: <20191002051759.GA161133@LGEARND20B15>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 2 Oct 2019 09:39:28 -0400
Message-ID: <CADnq5_OsUSP0OXWfB4=XfLuHmDMtPDyWY7EwbMPGEbz3+mi=SQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Drop unused variable and statement
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        "Quan, Evan" <evan.quan@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
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

On Wed, Oct 2, 2019 at 3:19 AM Austin Kim <austindh.kim@gmail.com> wrote:
>
> Even though 'smu8_smu' is declared, it is not used after below statement.
>
>    smu8_smu =3D hwmgr->smu_backend;
>
> So 'unused variable' could be safely removed
> to stop warning message as below:
>
>    drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu8_smumgr.c:180:22:
>    warning: variable =E2=80=98smu8_smu=E2=80=99 set but not used
>    [-Wunused-but-set-variable]
>
>    struct smu8_smumgr *smu8_smu;
>              ^
> Signed-off-by: Austin Kim <austindh.kim@gmail.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c b/drivers=
/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
> index 4728aa2..7dca04a 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
> @@ -177,12 +177,10 @@ static int smu8_load_mec_firmware(struct pp_hwmgr *=
hwmgr)
>         uint32_t tmp;
>         int ret =3D 0;
>         struct cgs_firmware_info info =3D {0};
> -       struct smu8_smumgr *smu8_smu;
>
>         if (hwmgr =3D=3D NULL || hwmgr->device =3D=3D NULL)
>                 return -EINVAL;
>
> -       smu8_smu =3D hwmgr->smu_backend;
>         ret =3D cgs_get_firmware_info(hwmgr->device,
>                                                 CGS_UCODE_ID_CP_MEC, &inf=
o);
>
> --
> 2.6.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
