Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBBEC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3F72084D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJDz0No9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391620AbfGWSzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 14:55:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41727 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfGWSzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:55:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so41081555wrm.8;
        Tue, 23 Jul 2019 11:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uofN7ppO5lpu2W/w0X7jwZptyjk30DWo2WCuwRs1qEQ=;
        b=LJDz0No9XLAJGTv1sXKvOFaNgPg9sv6MM5Lo1bYMmmvVOaeaLUl96lQ0blrnDkMBK2
         RhByqPJg+ftBThBEDHmQjMQEzCTSVi/YfZxMiYa9JIakqR2YKWPdrrDW6xuiLX/PETf7
         L/1W7JNelejLi3Q63bJ6h4Dl9GZ93Inv9owOuquzk0WWxDNlzwhkWcEx69ablsLn3k5J
         2BdHIdqSZsAQvKJK0YWPxoBAs7V7XQdbvNFJI3+HbloI4oM44R6LoCznZVDwxjsNkqEl
         2HPWMDLWGjg0VrC2cAfFmt2W2YNFeWjo/m1CAJ/0LcQHxJAxg8t9UTEpsoBHpLtnm/IH
         bg0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uofN7ppO5lpu2W/w0X7jwZptyjk30DWo2WCuwRs1qEQ=;
        b=pqWWnxTa9yEofe0DxSzP9yraHYFhQ5Mqun+uSK6admqNTHqTDO35ux7UnDyF1IVYsP
         VftJd9N8mtcSebQihXh47KWAbUod1PlKzyTUhmr2mKhZSLvgZSSV4JIb5zw0Q/obTvmp
         GFbzqn2kcLantaFyy0oa1w9gkUEpD5AP7c75eQlJBpd0xYD0gXBFwSquzCcI067WoybI
         rTMLanVKhB4eT5HEwV3Be5lpb7tdnVIbtuivlObOLb/PTnsH6UUAVKA9zNA0qLxNtRgD
         P9NE0RSYNCKLmwAWYOz7abWD70osHSs4ZQb9/tJ+x2qW69FOAF5nDajeY+Zl9NGHMr+D
         cJRw==
X-Gm-Message-State: APjAAAUR8AknXhMgOpRRrjWxYREuiEnZNa9JKABQMo65/Nu12gfs2KMF
        2V21qrCgg597LR46uQoewNwvpM+I1Yv7pewPSzGB6A==
X-Google-Smtp-Source: APXvYqytEF/30ZRLvCDiDRUiLAC7Ki41TP937AiiImWIfRwtcmAZO1g6dOGFW8ThB6MwY+NEc5NDfzimhsYBX1OD/c4=
X-Received: by 2002:adf:dfc5:: with SMTP id q5mr26863661wrn.142.1563908123361;
 Tue, 23 Jul 2019 11:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190723142312.4013-1-colin.king@canonical.com>
In-Reply-To: <20190723142312.4013-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 23 Jul 2019 14:55:12 -0400
Message-ID: <CADnq5_Ni9T-jkLrv-s-v1VD8J=VQmyz6S43Na52=1sjdB-uJZA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: fix a missing null check on a
 failed kzalloc
To:     Colin King <colin.king@canonical.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
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

On Tue, Jul 23, 2019 at 10:23 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently the allocation of config may fail and a null pointer
> dereference on config can occur.  Fix this by added a null
> check on a failed allocation of config.
>
> Addresses-Coverity: ("Dereference null return")
> Fixes: c2cd9d04ecf0 ("drm/amd/display: Hook up calls to do stereo mux and dig programming to stereo control interface")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 168f4a7dffdf..7cce2baec2af 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1259,6 +1259,8 @@ bool dc_set_generic_gpio_for_stereo(bool enable,
>         struct gpio_generic_mux_config *config = kzalloc(sizeof(struct gpio_generic_mux_config),
>                            GFP_KERNEL);
>
> +       if (!config)
> +               return false;
>         pin_info = dal_gpio_get_generic_pin_info(gpio_service, GPIO_ID_GENERIC, 0);
>
>         if (pin_info.mask == 0xFFFFFFFF || pin_info.offset == 0xFFFFFFFF) {
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
