Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CC5C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B555C20679
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsPY4rhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388012AbfHASz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 14:55:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35725 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbfHASzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 14:55:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id y4so74699270wrm.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 11:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XLDUQPAarNvEYMITiXzpnSJXfvDRcc50bI5EKnKqsKE=;
        b=XsPY4rhIKCMCCnMcZl4ZRgfWcK6xBMvhuMPwKm52SbUJaJ2LapPlJ4rLIiow9EBzA5
         +3JRFt03n5pxTjmeQ7VITCykdIyRhoUS7bp/kdfGgaetzICsmM5lbYXxH1+NWh0SaxF6
         Bneth6+76bmNSliwf12qh1/YBzn6Lt9lGX17tq5SBbAz/vmpgYnAcDBb75LbXUQrHipv
         d7p/LGOwG4Fh0lXI+sGZXsEeuWqn/iCPqnTwYjn88wCEWxG48WOImtGggUDYRzm9gE+j
         qFCvzrKIKuloglZC5gCNj5SgUJPX9Lkm2mLHdDf34oX8wC9ulAO8tWc/eu/6xiG6Ph+L
         vwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLDUQPAarNvEYMITiXzpnSJXfvDRcc50bI5EKnKqsKE=;
        b=nh38pqy5Reu9jJ2xOSPIT3lRYmMli3a6a8s55V9lyM6y6fuFs5H9xNCtCOXTIrkgL5
         +pQm9L/yVNKG7DxDjcdXOUoC9itIyncFwVZEQH3xZSBqWAVnnPClNL08BYRlXFCrf5by
         JKMONHePN42WhbI0Yt48hfOwhUiM7Dq4twewAl2orUE1GuakSaQvfbXCG0LMQ4Ob4UVv
         zEv7WiSd55zHF/Van2Yqjdz9rLWvsNHMZGULsiM0OgH/iREX5vQiburqPc8f/z5lPHjT
         FwOYdgerOPj/asceoQ/N/9ctb1YsTkLvb9kbkjNd4Ip1En5zjksAavWTMX/ej9cuq71H
         /liQ==
X-Gm-Message-State: APjAAAXdRVqabJHwi1ipH4soo10cChdthhnjeqywTaUJvynNLgoHk4gG
        pf8kEgIzaPPIn500+5bendIbEITLHSc5XSE9zg0=
X-Google-Smtp-Source: APXvYqzkkgT5tP7neI5/thRq8Z8tl7mKoMEea2IoQpPgVU0tlEhxkCRevSubS9rdBNXGPL4jHr6RlNbiu9tuCqVLaCI=
X-Received: by 2002:adf:a299:: with SMTP id s25mr134452086wra.74.1564685753415;
 Thu, 01 Aug 2019 11:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190729083644.29160-1-baijiaju1990@gmail.com>
In-Reply-To: <20190729083644.29160-1-baijiaju1990@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 1 Aug 2019 14:55:42 -0400
Message-ID: <CADnq5_ND4=Vtkfxhxj0OAmUFT33NR+QuV7_Uv-yc-xzhZCWSbA@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: radeon: Fix a possible null-pointer dereference
 in radeon_connector_set_property()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 11:08 AM Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
>
> In radeon_connector_set_property(), there is an if statement on line 743
> to check whether connector->encoder is NULL:
>     if (connector->encoder)
>
> When connector->encoder is NULL, it is used on line 755:
>     if (connector->encoder->crtc)
>
> Thus, a possible null-pointer dereference may occur.
>
> To fix this bug, connector->encoder is checked before being used.
>
> This bug is found by a static analysis tool STCheck written by us.

I believe we always have an encoder for every connector, but never
hurts to be safe.  Thanks.  Applied.

Alex

>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/gpu/drm/radeon/radeon_connectors.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
> index c60d1a44d22a..b684cd719612 100644
> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> @@ -752,7 +752,7 @@ static int radeon_connector_set_property(struct drm_connector *connector, struct
>
>                 radeon_encoder->output_csc = val;
>
> -               if (connector->encoder->crtc) {
> +               if (connector->encoder && connector->encoder->crtc) {
>                         struct drm_crtc *crtc  = connector->encoder->crtc;
>                         struct radeon_crtc *radeon_crtc = to_radeon_crtc(crtc);
>
> --
> 2.17.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
