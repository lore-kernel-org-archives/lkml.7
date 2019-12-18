Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8B7C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A007D21D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 20:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3yyjml8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfLRULi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 15:11:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36178 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfLRULi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 15:11:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so3677637wru.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 12:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rbUYEIW7slNbxlu+nEtDsS40/Za9u8XEu+dlEeoKiho=;
        b=c3yyjml81B7N9WIQNvh7JhSGxrwNXD/QguSzK+Vi5D2OARt0A1pxOYak6b8P855cTH
         TkQVBp4XpQXm34UJHJ0DH+I1Bs8I7uy9nE8K0Z92nV27GviuaXPCo92xfhx+b20IzjlI
         pel38UTxZvsWct2NGrJNztBUIlsFbT0aMV2g2ZZGEE+tcZdPwmgjodIJU0YJoFVe75k3
         cHwyOVp4GUq/ZKQCO5TfCyUjhDVgb9JO1LR5qbotC6mIQN8iq8PeOUwALirOozdQjPej
         +XU0fzyNuUWAx6JfocIe7Xt+s/8syX8pAXBvLj2PUegAW4QT8GvKO4GFTV9kar+o6Y0/
         KIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rbUYEIW7slNbxlu+nEtDsS40/Za9u8XEu+dlEeoKiho=;
        b=J2QJoE9skgYGjU2jXLMTMY8PnuuiB+/+P1FRpzDDZQGCo4Dbn6tc3AJuzIzosudrf9
         PjV9P3tObDB09cjyMi4KPnBZtvXjm5otXhh2FZkwGrUZlUw9xtnHPIFaUpeJ27l8cJIV
         Zaev8dZNN6HS2xhuzomduUldyWQu1pgsmn9PW6s+TqLZpidWO3cXameSfixSTFpuQ8v9
         nSgM1w+Tup7lQ50sKTfwC+6+xoyK8BBEfc0Ud4MC/Q7Zny+bARS7IltAf6PGozlHGolD
         wn7r/i6aNuCyHfdS4D7ol2KcNpewITDMwpk6t0biEnLp5wkl3uZCu+VjE+n0Ul1wgrDL
         Vtyw==
X-Gm-Message-State: APjAAAVNybZn/PD55iKQ5S3Lz45qXSNLEJddLi4l6GDbnf1fVCEl/KTl
        4lCjhFo5seWZM0uOhC05Gg23DS4nDiE1jprrdg8hrw==
X-Google-Smtp-Source: APXvYqxvWOkornjFKC9yZx/AYAl3XzgmZvf2Cgv8ByZTr3LB9dcbEl9omnAbae9I0QkOdIPMgysZMMckqComySDr4rw=
X-Received: by 2002:a5d:4692:: with SMTP id u18mr1409287wrq.206.1576699896455;
 Wed, 18 Dec 2019 12:11:36 -0800 (PST)
MIME-Version: 1.0
References: <1576640988-14639-1-git-send-email-zhangpan26@huawei.com>
In-Reply-To: <1576640988-14639-1-git-send-email-zhangpan26@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 18 Dec 2019 15:11:24 -0500
Message-ID: <CADnq5_Oiksa0pd+6au5giwOeYBaNh4X5-kP=vxpo-617C3dSfA@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpu: drm: dead code elimination
To:     Pan Zhang <zhangpan26@huawei.com>
Cc:     hushiyuan@huawei.com,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 3:13 AM Pan Zhang <zhangpan26@huawei.com> wrote:
>
> this set adds support for removal of gpu drm dead code.
>
> patch1:
> `num` is a data of u8 type and ATOM_MAX_HW_I2C_READ == 255,
>
> so there is a impossible condition '(num > 255) => (0-255 > 255)'.
>
> Signed-off-by: Pan Zhang <zhangpan26@huawei.com>

This change was already made by someone else.

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/atombios_i2c.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_i2c.c b/drivers/gpu/drm/amd/amdgpu/atombios_i2c.c
> index 980c363..b4cc7c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atombios_i2c.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atombios_i2c.c
> @@ -76,11 +76,6 @@ static int amdgpu_atombios_i2c_process_i2c_ch(struct amdgpu_i2c_chan *chan,
>                 }
>                 args.lpI2CDataOut = cpu_to_le16(out);
>         } else {
> -               if (num > ATOM_MAX_HW_I2C_READ) {
> -                       DRM_ERROR("hw i2c: tried to read too many bytes (%d vs 255)\n", num);
> -                       r = -EINVAL;
> -                       goto done;
> -               }
>                 args.ucRegIndex = 0;
>                 args.lpI2CDataOut = 0;
>         }
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
