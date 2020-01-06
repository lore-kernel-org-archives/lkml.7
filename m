Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8687CC00523
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4E72072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEmo0PFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgAFBGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 20:06:18 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35567 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbgAFBGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:06:17 -0500
Received: by mail-ua1-f65.google.com with SMTP id y23so16537759ual.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 17:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oD/TmYE7Rc3ZEG5cPZO14SpBA53dODt6EQBgZE8gYPI=;
        b=PEmo0PFq7DKBYxBtymV7LxJFLP5A+tQ61Dr0ltLhlVBdB2gwEN7SUZkn6EobnWvRem
         OOY+ffQNhh4/RyrTB7CjApYSGy04OicYqOgN/yxu270OCR+8vLKP3227IoaoKuTGEKNu
         9mzyotU7JeOQnzPwz/GVM78jUm8dSUOobw4X68g2pB4VcfT58ih1EbnaFfXHDuONOBLt
         zkcRL44LM3kClp35/K3eqEzB7Tj18SjIJxG0L66oSkyefi5kpoM4BRRt3Q/v9IoM8y/p
         Ezv/Odb3x3dSfYxliNTUjm+idMNtR37QhXGI9QJJ+qIvJc/pXupjc7rIhOdXerPBXK4U
         Q5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oD/TmYE7Rc3ZEG5cPZO14SpBA53dODt6EQBgZE8gYPI=;
        b=Fv/dZzN1lgOBUgC/HY/c+f4bFKyV0UPp9shngkhhMxVNWlWiKeG1ceuKxCO4qZfGJn
         rjvDC5YpZb82MN0DquHDVPMEvDMoSRAgcysND/qmpnv7zCzcMf2BMnIAahk9tVvzZ1RE
         Wxu39OEDPHGSXOciPnrsQezD1nQCGMkac24uWHjGxbScv9TPPV9GIC+dIy3z7FI8V5Ip
         mGk5YzwgHuwUXdQIrovWo5qiZhaby93xRhopPEcff02AW0AeQgmy4y6kd/GbJoBMnrRt
         hBgqUq2VtblRCBSAtzTa9kHc6V8RzvM/xusBxMQB8trT3GIF8ya0jreBWR21OX3lel4Q
         fkRA==
X-Gm-Message-State: APjAAAV9mjV62lLJEyooJzhyvSqJdPDljhJN5vBVqMXiu2bT4RcauVPs
        WfKCgvYNYvEdMk1UDFY7Uyr0lyXjLUr0TzN8OU4=
X-Google-Smtp-Source: APXvYqx3CyDfxmt7yEu8FyFHyU8Oa/0pVpqjMMDxszF13Rx1oXVB90+4EwrYBUaZfUuxGzrGM8cVVxOcDQ9zrjCmByw=
X-Received: by 2002:ab0:6029:: with SMTP id n9mr57299619ual.35.1578272776664;
 Sun, 05 Jan 2020 17:06:16 -0800 (PST)
MIME-Version: 1.0
References: <20191230024628.11820-1-yuehaibing@huawei.com>
In-Reply-To: <20191230024628.11820-1-yuehaibing@huawei.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Mon, 6 Jan 2020 11:06:05 +1000
Message-ID: <CACAvsv6GAO18farNBWy5t-tXyTkZHtNDxZEfHeNpZ475yMdGUA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH -next] drm/nouveau/nv04: Use match_string()
 helper to simplify the code
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Harry Wentland <harry.wentland@amd.com>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Dec 2019 at 12:48, YueHaibing <yuehaibing@huawei.com> wrote:
>
> match_string() returns the array index of a matching string.
> Use it instead of the open-coded implementation.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Thanks!

> ---
>  drivers/gpu/drm/nouveau/dispnv04/tvnv17.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> index 03466f0..3a9489e 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> @@ -644,16 +644,13 @@ static int nv17_tv_create_resources(struct drm_encoder *encoder,
>         int i;
>
>         if (nouveau_tv_norm) {
> -               for (i = 0; i < num_tv_norms; i++) {
> -                       if (!strcmp(nv17_tv_norm_names[i], nouveau_tv_norm)) {
> -                               tv_enc->tv_norm = i;
> -                               break;
> -                       }
> -               }
> -
> -               if (i == num_tv_norms)
> +               i = match_string(nv17_tv_norm_names, num_tv_norms,
> +                                nouveau_tv_norm);
> +               if (i < 0)
>                         NV_WARN(drm, "Invalid TV norm setting \"%s\"\n",
>                                 nouveau_tv_norm);
> +               else
> +                       tv_enc->tv_norm = i;
>         }
>
>         drm_mode_create_tv_properties(dev, num_tv_norms, nv17_tv_norm_names);
> --
> 2.7.4
>
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
