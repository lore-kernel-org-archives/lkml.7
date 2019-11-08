Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF76FC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B595E21D6C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVNk52qI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfKHQaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:30:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35999 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfKHQaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:30:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id c22so6866357wmd.1;
        Fri, 08 Nov 2019 08:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EED96u0MROcQsaLKPUjUV7sfzZCF299jzLkw6fCEdJA=;
        b=XVNk52qIAH0ewjDgU12L5VGNadrbMzDitR2kaaNnkXh/wVBajNXt3WqVa+oB2CTpYt
         dKDBk+v7+YPaKibDa60jJk4p8laJYzu9st8tWdQT8FQ0fMy0KlArSNSIhI1q33HYBJmz
         L6OUsOIUDJKq60n/lFk6COu76EbufO9fZH98rUeph6ivJIZUSldNl7nns0+ygQ02Q7w2
         gTdS/RuixOWvJhGJLvdvjsoHXGIY7T38kzlyzrUH7qMA1P5+aVbnnXJC6kCAgPNUHu9q
         kng4IFQ+Eo0xOdTcn2YB6tGPpiBfndTguUjZPsjf9i4YRQg3g20YzPYmHsVL4fJ6LGhp
         hu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EED96u0MROcQsaLKPUjUV7sfzZCF299jzLkw6fCEdJA=;
        b=SItEXT/DgU76ELFiLbGhsTINskHoihWr6wpGN1q9RHT05DujlVSWoQALk0UAi9XIiM
         4AyFTU0rUsZoX7M8u6phtAPZdwFgpBFfJ7+7unpnPII6Z79LBias18LIrxaK13A1cDDG
         VoRakWzUHOqS0x8slZBs1JofqGM0xRN+rvT9AtJvRvjej92LvVth+0WWwYuS4/5z2O2A
         tHP8O94TIW6lR1rqHc52FK80INvCh2wOoxtcg790/vfU/iaUrwjJik+0DV9rKq0T1hI8
         zRQTyAMghqfHJ+e4keEDcyFzzKk/Mx01EpUQ5tuskcgXcKJLf5dI2UGXjx+XmBmxa2X6
         4jsg==
X-Gm-Message-State: APjAAAVw0I5iHdw7TySORC9Tdw0DkkObVc5od5pmPl40uoDgKyNdkty8
        /smMnGQvuOLSn9a707muzPdAnKfrgK4QYVpCvcg=
X-Google-Smtp-Source: APXvYqwnwgFN7PmKJaC/TvBNAIFdaFPEhM03t/7vQSSSYo65qRHUuRkwfS/XgnjDQ7qqT10NV7TNYBo0JuiHqCt/WKk=
X-Received: by 2002:a1c:790b:: with SMTP id l11mr9449471wme.127.1573230632691;
 Fri, 08 Nov 2019 08:30:32 -0800 (PST)
MIME-Version: 1.0
References: <20191108144527.120927-1-colin.king@canonical.com>
In-Reply-To: <20191108144527.120927-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Nov 2019 11:30:19 -0500
Message-ID: <CADnq5_PdP3=gMbbcvTqf07=3mP-ZXdrvxWzmcpoFEd2_B9cTqg@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: remove duplicated assignment to grph_obj_type
To:     Colin King <colin.king@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 8, 2019 at 9:45 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Variable grph_obj_type is being assigned twice, one of these is
> redundant so remove it.
>
> Addresses-Coverity: ("Evaluation order violation")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Applied.  Thanks!

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> index be6d0cfe41ae..9ba80d828876 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> @@ -365,8 +365,7 @@ bool amdgpu_atombios_get_connector_info_from_object_table(struct amdgpu_device *
>                         router.ddc_valid = false;
>                         router.cd_valid = false;
>                         for (j = 0; j < ((le16_to_cpu(path->usSize) - 8) / 2); j++) {
> -                               uint8_t grph_obj_type=
> -                               grph_obj_type =
> +                               uint8_t grph_obj_type =
>                                     (le16_to_cpu(path->usGraphicObjIds[j]) &
>                                      OBJECT_TYPE_MASK) >> OBJECT_TYPE_SHIFT;
>
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
