Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2001C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FEA62075B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 19:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BN6fTSTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfHFTEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 15:04:51 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37193 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfHFTEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 15:04:50 -0400
Received: by mail-wm1-f68.google.com with SMTP id f17so77503161wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 12:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H2Cunc+Unwf7KU+04domOtpvjoHMaWW2nIlPjO6jjTE=;
        b=BN6fTSTygoPjeCrvFUr+x4oz3yZvMdv1eG7K80Zk+VtKyHCKONyDXzLIi4SnpqyZjw
         8h2NKM38bkah9qUw9o+RETqEthm/8Dtf2DeewNDMxSSHR4EnJq5UMweNpx/6UysDkqEH
         GkkdkaXwmSvZEyLvnywl3/+vUHht6/p1JYfUHAd/jMh8Apfyo3/AETHY5OZvxy3uyVRx
         PEVi3gcqWN71WUijLkEYMXJsPjJOue5fM5bn54pAnvTfvwvWVSZa7WfJfZrdrYoDUipZ
         5ezCyTXq7qXijKhI1VQP1YyNXygcBJu5KcZrWVsFYqD0VmeWgWPuJYMIa9gUo/gUi2fS
         SZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H2Cunc+Unwf7KU+04domOtpvjoHMaWW2nIlPjO6jjTE=;
        b=WeKnFIOLD1d2yEw5kMHUAuOFZ8nzm1EKl4okhvDV5cOHOoFNl+qMMtFBJ1kMfrNOkn
         8agw8o756rNpYJUZAQ2FenqHsbevRBGt5zgmhOJCDVKsSiQEUoqTwB7JioKFTpGvVFpD
         ja5+bBNB8fUmhfXYD8i3YdQupS3GTVRcmFW6s5v4d1O1Le6iQJapFzvnUYhW3ppb2IYl
         X8Rz1H+F+G2KCLmMfXd1XTfJ5ll7g5IClALsJX4JI7Ha+CkyHqFcuD+trused0TF9/UV
         AGdt467SVPulaeevZ6gL3f24Thaqhim9IuHcHgc9qEnC1up5GXAu6EI493633r0qHDfQ
         Cuag==
X-Gm-Message-State: APjAAAVDZiInn0XEOi1q1e2UJLNOM1KyyWQCothYuDHRGqSSyVifVVfy
        rPLVLKlY/JWQitckcoqvJMYafpw7csiSf8J8jlM=
X-Google-Smtp-Source: APXvYqxt13CUFdoIsvF7s1UaYB4shCev9jOY+/A5iMYNG4jYXaQRzQ0A6X4y2qH2KhLwYuXooFHWxN94IO01gg/JqIo=
X-Received: by 2002:a7b:c751:: with SMTP id w17mr6322996wmk.127.1565118288585;
 Tue, 06 Aug 2019 12:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_OL1+bJUGh44AY48DP=G=xTtdrf+kO2233qjJzudWhw_Q@mail.gmail.com>
 <20190806174549.7856-1-harry.wentland@amd.com>
In-Reply-To: <20190806174549.7856-1-harry.wentland@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 6 Aug 2019 15:04:36 -0400
Message-ID: <CADnq5_NLTOQ31XXhw3o8aoJkRmzq6guurgUz13cxKD6U6M90Cw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Add number of slices per line to DSC
 parameter validation
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nikola Cornij <nikola.cornij@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 1:45 PM Harry Wentland <harry.wentland@amd.com> wrote:
>
> From: Nikola Cornij <nikola.cornij@amd.com>
>
> [why]
> Number of slices per line was mistakenly left out
>
> Cc: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>
> Thanks, Hariprasad, for your patch. The second condition should actually check
> for num_slices_h.
>
> Harry
>
>  drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
> index e870caa8d4fa..adb69c038efb 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
> @@ -302,7 +302,7 @@ static bool dsc_prepare_config(struct display_stream_compressor *dsc, const stru
>                     dsc_cfg->dc_dsc_cfg.linebuf_depth == 0)));
>         ASSERT(96 <= dsc_cfg->dc_dsc_cfg.bits_per_pixel && dsc_cfg->dc_dsc_cfg.bits_per_pixel <= 0x3ff); // 6.0 <= bits_per_pixel <= 63.9375
>
> -       if (!dsc_cfg->dc_dsc_cfg.num_slices_v || !dsc_cfg->dc_dsc_cfg.num_slices_v ||
> +       if (!dsc_cfg->dc_dsc_cfg.num_slices_v || !dsc_cfg->dc_dsc_cfg.num_slices_h ||
>                 !(dsc_cfg->dc_dsc_cfg.version_minor == 1 || dsc_cfg->dc_dsc_cfg.version_minor == 2) ||
>                 !dsc_cfg->pic_width || !dsc_cfg->pic_height ||
>                 !((dsc_cfg->dc_dsc_cfg.version_minor == 1 && // v1.1 line buffer depth range:
> --
> 2.22.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
