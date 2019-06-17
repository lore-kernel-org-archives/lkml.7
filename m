Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE43C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15CFC2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhnkPzcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfFQPG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:06:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39912 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfFQPG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:06:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so9496698wma.4;
        Mon, 17 Jun 2019 08:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oh4VL4iPNDaGaWS9B+IslavMbhg8v2O15rFQqtXr3DA=;
        b=AhnkPzcZlgpKjDEw3+xRxeOFXIR4rBRfDc37XV2fRn72EJMb4qZ8fbe4wJKA+CuT+D
         OLPOGYXVQcZPKfdya2ZqCLSSALJAxqIDWYRoQ1W93f5ujh5ji5/VxPnw8sUtRrx5/OUE
         Z2OE9rk24ODOJTwUVfqhAMNtFPIJ8floCpl/JgraI+yw+lntSaVl/G6A5Np8mXKpr5Cs
         Yz86ZLrNQdAJ7auSv5dsL0Hg7w8ndlxykvHk+PAa+IfsoDxUvYQPG+GFStswDfgOhu1V
         7oB6x9fs4FWi7kkSTMQrtr4vEDy7f6L81XpLC0Knnd1fteIdwHyKAkxZ/rn5BITnmGzt
         yHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oh4VL4iPNDaGaWS9B+IslavMbhg8v2O15rFQqtXr3DA=;
        b=TCNVYGXiFwCoyNmgJojEszyZUcz/TSo4Dexl4bwPk0E5QSLq+c5wqsOkavqYQ+3sy9
         MFXS4bdXgHXY2fYd/EBXy1HICArqw7a7TiQrkSHDa+oHJ05VJTY4cx3du5lZXCjhsWCL
         /vlFOVDeccv0Z84nYcOmD8CKkqDKQOvm9piXULA9UV2Fdr74fpbXj2SIuo60fPT5AS0U
         4ERTMv6CwP6hLyAJimSTAFmz590v0XlVSxADjN1RjjGLNxdWbEL7wbN5PXhijljTV6fO
         Tgp0K+sJ4F/OR7icc8ILHkDx7AkV6V/3LRDKgXZpsLEeMSJ/y+mec104edGrDrRxGWKN
         rRRQ==
X-Gm-Message-State: APjAAAWbCydFpyZ8E0+hTGX/Rv8XGYexUzIy1E7B5mCdes+i82vTVu6g
        wuOq4SMC3AhBf31BDQUhX2NWGRhJzTCIVxfxXfI=
X-Google-Smtp-Source: APXvYqzwnLdmhx4erTT42qjFTICvOKBGEP2f7RWvXDepAPvjY+Gfzf/lBcnfGne43PNShj8tK4VXq9LKd4uItxBeWRE=
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr18196950wmc.34.1560783986617;
 Mon, 17 Jun 2019 08:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <de3f6a5e-8ac4-bc8e-0d0c-3a4a5db283e9@web.de>
In-Reply-To: <de3f6a5e-8ac4-bc8e-0d0c-3a4a5db283e9@web.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 17 Jun 2019 11:06:14 -0400
Message-ID: <CADnq5_MKRU6-iCJZWwpR8z+mmdkgVh_STJtVJCiSTec21e+oqA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: Delete a redundant memory setting in vega20_set_default_od8_setttings()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Evan Quan <evan.quan@amd.com>, Rex Zhu <rex.zhu@amd.com>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied this and the dc patch.

Thanks!

Alex

On Mon, Jun 17, 2019 at 10:07 AM Markus Elfring <Markus.Elfring@web.de> wro=
te:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 17 Jun 2019 14:24:14 +0200
>
> The memory was set to zero already by a call of the function =E2=80=9Ckza=
lloc=E2=80=9D.
> Thus remove an extra call of the function =E2=80=9Cmemset=E2=80=9D for th=
is purpose.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm=
/amd/powerplay/vega20_ppt.c
> index 4aa8f5a69c4c..62497ad66a39 100644
> --- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> @@ -1295,7 +1295,6 @@ static int vega20_set_default_od8_setttings(struct =
smu_context *smu)
>         if (!table_context->od8_settings)
>                 return -ENOMEM;
>
> -       memset(table_context->od8_settings, 0, sizeof(struct vega20_od8_s=
ettings));
>         od8_settings =3D (struct vega20_od8_settings *)table_context->od8=
_settings;
>
>         if (smu_feature_is_enabled(smu, FEATURE_DPM_SOCCLK_BIT)) {
> --
> 2.22.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
