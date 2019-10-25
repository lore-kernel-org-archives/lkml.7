Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEBFCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A1E20679
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uX/O7oxq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfJYTWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 15:22:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55223 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfJYTWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 15:22:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id g7so3330792wmk.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 12:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ONdJaD+Bko4M9q05H7rLbK8ydzxyE4q+FendoDuboxU=;
        b=uX/O7oxqqh7F4O9wnJBwUlX/CUtM9dn/fvRUDEU5S4QgaxgaeuLIQL1qo0Sn2bfYQn
         +/frRViCfkeBSick98mDdTsVlgnxWhRgt0rg1TKvdBIj9XZHKR+DuC+Udnm9PdmPBZvm
         CSR11UVhOaOCQtTnLyILGcvXJjvARnpcgBQbgVhG3ATjwVwEsgFxW3ps0nDjnryeFXS7
         UHSE2gTXXJTAXzJlLW6Ne4SGkyUzO/NgbhUt26vyBstyphO9uBeH394CTVGU4F4Nkl77
         OPuLp6ScT0+KhydYku6a7MApIQ+c9yGF6XQ7zNWo6RYYGoVfDbKbBiHhZfAasZPaMsl+
         M/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ONdJaD+Bko4M9q05H7rLbK8ydzxyE4q+FendoDuboxU=;
        b=UWhxmT2s2gPUnn0FVpqNu/mKaGSz4QEIHoOsIRnFJZSEtQN4tmWfY7FefAG5Y8c1Nf
         qdUatiyTwMbdnkOo5v/w3PbWY9Ofld8Fp4FfLlZo15JRB1dABvjKhv/pKjheHB0TSTx1
         ufuzYmH5RPPfkWKH3DQ12QjzKM7hEo4vBW12zS7KVh33kwOL/o7Lopa6KfpsV8P8i8OE
         jO29hrupwQbNK119cX4VGKe+8z/gn4Aq/Rp0xIeoKyWWdns62xmGIKkYU7J/kOF6S8km
         ZhRwU1BQ/vT5WgfECImEVVDJnEMrOrs3a3nQDdSbNUkAXmesMxDi7vvXcTQXzc1sigtj
         XJQA==
X-Gm-Message-State: APjAAAVoYp9aGN75JoQ2c4C56Ax5Ais049KjuH91YZxbRqlkSE10f28a
        HihcYVoHDJxY+8PZZqiE1gGXNSlL46yLM2NEr2c=
X-Google-Smtp-Source: APXvYqwRv2/iWy/fTGJpjOGuyEoghj6/BcbdM2Z5bEz8jJLxdknf1fD8L9wYYYjuszJyRc5rN8V3iF64UUqAQW73Yo4=
X-Received: by 2002:a1c:2008:: with SMTP id g8mr4569469wmg.34.1572031363694;
 Fri, 25 Oct 2019 12:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <1571455431-104881-1-git-send-email-chenwandun@huawei.com>
In-Reply-To: <1571455431-104881-1-git-send-email-chenwandun@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 25 Oct 2019 15:22:31 -0400
Message-ID: <CADnq5_NiuOrH48a9qscT60kzhcSCgmRF8dmBj4Ga9Lkh_L1+4w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove gcc warning Wunused-but-set-variable
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        David Francis <David.Francis@amd.com>,
        "Cheng, Tony" <Tony.Cheng@amd.com>, abdoulaye.berthe@amd.com,
        Thomas Lim <Thomas.Lim@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2019 at 8:07 PM Chen Wandun <chenwandun@huawei.com> wrote:
>
> From: Chenwandun <chenwandun@huawei.com>
>
> drivers/gpu/drm/amd/display/dc/dce/dce_aux.c: In function dce_aux_configure_timeout:
> drivers/gpu/drm/amd/display/dc/dce/dce_aux.c: warning: variable timeout set but not used [-Wunused-but-set-variable]
>
> Signed-off-by: Chenwandun <chenwandun@huawei.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> index 976bd49..739f8e2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> @@ -432,7 +432,6 @@ static bool dce_aux_configure_timeout(struct ddc_service *ddc,
>  {
>         uint32_t multiplier = 0;
>         uint32_t length = 0;
> -       uint32_t timeout = 0;
>         struct ddc *ddc_pin = ddc->ddc_pin;
>         struct dce_aux *aux_engine = ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en];
>         struct aux_engine_dce110 *aux110 = FROM_AUX_ENGINE(aux_engine);
> @@ -446,25 +445,21 @@ static bool dce_aux_configure_timeout(struct ddc_service *ddc,
>                 length = timeout_in_us/TIME_OUT_MULTIPLIER_8;
>                 if (timeout_in_us % TIME_OUT_MULTIPLIER_8 != 0)
>                         length++;
> -               timeout = length * TIME_OUT_MULTIPLIER_8;
>         } else if (timeout_in_us <= 2 * TIME_OUT_INCREMENT) {
>                 multiplier = 1;
>                 length = timeout_in_us/TIME_OUT_MULTIPLIER_16;
>                 if (timeout_in_us % TIME_OUT_MULTIPLIER_16 != 0)
>                         length++;
> -               timeout = length * TIME_OUT_MULTIPLIER_16;
>         } else if (timeout_in_us <= 4 * TIME_OUT_INCREMENT) {
>                 multiplier = 2;
>                 length = timeout_in_us/TIME_OUT_MULTIPLIER_32;
>                 if (timeout_in_us % TIME_OUT_MULTIPLIER_32 != 0)
>                         length++;
> -               timeout = length * TIME_OUT_MULTIPLIER_32;
>         } else if (timeout_in_us > 4 * TIME_OUT_INCREMENT) {
>                 multiplier = 3;
>                 length = timeout_in_us/TIME_OUT_MULTIPLIER_64;
>                 if (timeout_in_us % TIME_OUT_MULTIPLIER_64 != 0)
>                         length++;
> -               timeout = length * TIME_OUT_MULTIPLIER_64;
>         }
>
>         length = (length < MAX_TIMEOUT_LENGTH) ? length : MAX_TIMEOUT_LENGTH;
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
