Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25399C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6DA2173E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XN8fZPAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733012AbfHZPRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:17:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37690 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732922AbfHZPRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:17:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id z11so15733779wrt.4;
        Mon, 26 Aug 2019 08:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3OhNJIqCWkzD4aj6/1vV0aKfa5mah5B+lSn+3N0mtEc=;
        b=XN8fZPAJwzZ2tOPrFDwaQgVLLZv8Hh04gHCnCm6uzqsmUtX2SdvirNciE6EaARm07N
         JbwlxbVgQpmO07WidCup5FAlEu6d2kZ1dQhW/sFuxHzJj9UB3IgE+m35NRevPgThK1nB
         LQlyoyKMt5jwIus7qrYOlO9skf+B+mJDoB8fJ22gdqqXn1CAw+sUUD4g1izvtmEdm3sh
         NCC2nzoHUezK+Ufm47IbjyNL2ZZ9eI4HEhoAcHnddHeVy9/TY+RMsOgjgymGjbS2zo3R
         +BxAGlvmFPaiqGyVQhvojHWVpCs6X3f4rzpZI826c31leEYKD8Q3WfNV/nBNV43fK/Rb
         CAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3OhNJIqCWkzD4aj6/1vV0aKfa5mah5B+lSn+3N0mtEc=;
        b=DEY4DyAQSNoSioyaAYmf8A4PSqzK3x9tsvIBoLaF5bcSJo11yVzt/BjJN+SnenNL3G
         zzRammTV/5GKeG4aJcEqAE3DzFDOOrmMrWPTAPeuXZ21dDKNa8xHwm00FNWUS+9d52sM
         OWmjYMsERNvSBJ14xdR+BsWdnnNC8+IEgMlDEKLQ4mOW3jI0Hl0c1dF20BnpaUVI/zeX
         djLi1EV2Q92m2/ryY9mDgN6/h2T4S7Dw2ipFvZ3I4A573GsBv8FxztBW8zuUNSZaSDLY
         ifxetzLbL44X0OubyrXR0KIJREBSm/H50mboPbQGGUwsK92vSBm+j6ljwqdOdGOmtGOk
         R+vw==
X-Gm-Message-State: APjAAAUBgQAh1crKYl32u8stN70UAV3Sy13Y6x2cb3Yf36eovaiqdir1
        l6HcGU+Ty3lk48/fDjlhx/uMfdRL0pQ5I9CujRPWPA==
X-Google-Smtp-Source: APXvYqwu18NgSTZSGLc4mSMOMPegj7LnF3fT8AUKAC5AsFC3IwjtVYQCbU1apNw68rAgvTWINNfUrROfz2oa8RZWo6o=
X-Received: by 2002:a5d:4f91:: with SMTP id d17mr22795931wru.74.1566832627935;
 Mon, 26 Aug 2019 08:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190826132012.GB6840@mwanda>
In-Reply-To: <20190826132012.GB6840@mwanda>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 26 Aug 2019 11:16:55 -0400
Message-ID: <CADnq5_PEFyHP7cOxZOYroGx+Hf1qSuSg+7DUiAakZMc1GcWbsQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: Fix an off by one in navi10_get_smu_msg_index()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Kevin Wang <kevin1.wang@amd.com>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Huang Rui <ray.huang@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
        Evan Quan <evan.quan@amd.com>,
        Kenneth Feng <kenneth.feng@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 9:20 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The navi10_message_map[] array has SMU_MSG_MAX_COUNT elements so the ">"
> has to be changed to ">=" to prevent reading one element beyond the end
> of the array.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index d7e25f5113f1..fbecd25f150f 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -213,7 +213,7 @@ static int navi10_get_smu_msg_index(struct smu_context *smc, uint32_t index)
>  {
>         struct smu_11_0_cmn2aisc_mapping mapping;
>
> -       if (index > SMU_MSG_MAX_COUNT)
> +       if (index >= SMU_MSG_MAX_COUNT)
>                 return -EINVAL;
>
>         mapping = navi10_message_map[index];
> --
> 2.20.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
