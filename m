Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594F4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272FE2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaVRZNSD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfCUN6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:58:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35267 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCUN6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:58:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so2839315wmd.0;
        Thu, 21 Mar 2019 06:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YEp3M6t4FBSPlO5ZD4nK9leHlqbh17uxC6jmRksqQIc=;
        b=CaVRZNSD5NeVOUNVr5G/ffnQ+g2U+uRVbrduct7Mw5YlIOdbmLDLPsO1pa6mBgl1Y5
         gJxB5I60h0E5SCKHZMkQDq0T8+FZIFQ+Hsb8vZiYNj5gWqPtnPBgZVBO9I2Lpjwx3lUN
         sa9xM4XiJx9s4uoZZwBOhKFyNJdygN0OorTxOsUzCHIk+8u1J0PFM/yW1AdfMaK/rktx
         eC48eW6QorsTxw9nnNZCAalSKNFvCy/ExRmnACSxMkgS3VqLZa+2tq1PEjO/1bd8n2+t
         C1yleqxi3kBEAx4H5+kowWaADz6eLkSfSG2qCKboUqYRwWX6dIjmjAmg7HpwQq241iRT
         pmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YEp3M6t4FBSPlO5ZD4nK9leHlqbh17uxC6jmRksqQIc=;
        b=DAb8w/N5L3+gmKHb6qCRom1QrrNs+cNaI+wZNvW81Aw+dEcm/boP+Rz4oZpg/tgBIy
         ej5la5iP3EaxnkosCN1grlxdTn8zZxkGOX1BxOPds2+neC8mpalxpm/pw3Ba64pOtu9q
         IQ6qhtAB7QUW7WCsq3k9kzD1h5jUSbeexwpsBZsE5CCHcsMUqUWhTKw+CSC1IJ/34fky
         Z1NegCBS6yQbwXiaIbO/HdVi5zVYWJdKvSVbM1X++SMA78O+wJK9WCVpq3mRzqeKDX4J
         yKegwuHpC2dSjTSOkFb3PJXic9PZNmDUQI4ULEeeg4jDu3VGhUKeBrHUeqBqowIY3CzH
         Mp5w==
X-Gm-Message-State: APjAAAWUbPCfLOzvLG3b1pSc6oqKooTrCVa+DpUG/BF9IixvZWevHbkc
        qncMPtvw0M2l+pk7fvboY4b2w+j1WWWf5DXxIis=
X-Google-Smtp-Source: APXvYqz+Rjnv3CiB0ig3/A0ePzeEGNf0A1NgPopBBF5YXSd5Lgvdqxi6yxaBCHm6lVcT1Nng4iaclTRfh2K8YESyinE=
X-Received: by 2002:a05:600c:246:: with SMTP id 6mr2551432wmj.153.1553176692646;
 Thu, 21 Mar 2019 06:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190320172909.10348-1-colin.king@canonical.com>
In-Reply-To: <20190320172909.10348-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 21 Mar 2019 09:58:00 -0400
Message-ID: <CADnq5_NXCeXkiXYy8pjSkJR6Dj6rqqt0P0pBJaUyRgkkzurg3g@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/powerplay: fix spelling mistake "unknow" -> "unknown"
To:     Colin King <colin.king@canonical.com>
Cc:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
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

On Wed, Mar 20, 2019 at 1:29 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in pr_warn message; fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 17143888e37e..026bebe6fb45 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -2024,6 +2024,6 @@ void smu_v11_0_set_smu_funcs(struct smu_context *smu)
>                 vega20_set_ppt_funcs(smu);
>                 break;
>         default:
> -               pr_warn("Unknow asic for smu11\n");
> +               pr_warn("Unknown asic for smu11\n");
>         }
>  }
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
