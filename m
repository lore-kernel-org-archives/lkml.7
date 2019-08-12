Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B41FC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9D320665
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5HAHlqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfHLQK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 12:10:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53458 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfHLQK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:10:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id 10so68277wmp.3;
        Mon, 12 Aug 2019 09:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VH0bD6Zqxl2UMVE/ud11TtREj58uFJR0VOEIpjfuEjY=;
        b=D5HAHlqpU6pTku0pfGYqwy2A4bgUNc5r9L52lEoWEY1rE6eUVq8WOgo8PvqU/6mxY0
         xlk1ba82jd12C7Scbd+rcpcNisq1GaSBTjikRcUeO86BqXyErWYe3vzh+hL9vYifJnl/
         ggwEG1cRXgR9dDZ60R4T4eU5BNl9Qy1+m3jwk7NK8l2vLXXG4FsgFTmGdaSGiN4u7Vx0
         WYICKKFIdYher1FFDlf4u0zGrWwKMdL79VRTu0OpHcBL+kr8j/Pok0N3AukmEwJw5Dpu
         utWDwP+ZhrjmA9d8vYxxlvxBLvAFKrZznNlEuZSTApvZCAgXE9lCLvqE8hPsNawQ6NLp
         sE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VH0bD6Zqxl2UMVE/ud11TtREj58uFJR0VOEIpjfuEjY=;
        b=g1KZNFAEdhVFNse7jU6bPMXDzeWX3WGL39R/851arXQK6lQMvM8cCXZLWau8zs4rj1
         yTMMBh0CNQpwi9TPIoKB6sPw/8VN0HrWx2KqN0X6xu4ezOQL6s0lNAfO24/K91P76pc0
         Zu2TgKQN9A42vzCeSlWOQcpvvDASBgfgI+7K2Je9IrKd1bpLJlLmxi/kaO6i40h0hWmF
         7/ENKJOkNyLAbV6qUxe37LNCBGayBZmu15N24UdDXjOj/x0oSMJRFzV+Iz/SRhZGxKPe
         Gz1YbYkKAEi10UYboBcT8uAKNufqf7nW/GH3PdbLowWLuh6+Of23o20JaUGk0VBZIgRJ
         CVVQ==
X-Gm-Message-State: APjAAAWh1lOKbI9t9LuOFZxo8QDNTE1HWs/gYH8RjQsQlgsgFGLhvudo
        UjPbzJvTSFaaFNCrYqo7cAaF3pCFw3FQ5rUvFZAbiQ==
X-Google-Smtp-Source: APXvYqzMmmiiBtu9iT+6ihajz+xiA3zVSQ+uVani2o/4ymn7ct6L10oLnal8jSYD96FkxAmLgS6mB2QQBpqen6xqqSs=
X-Received: by 2002:a1c:4e10:: with SMTP id g16mr38319wmh.67.1565626255907;
 Mon, 12 Aug 2019 09:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190805102940.26024-1-colin.king@canonical.com>
In-Reply-To: <20190805102940.26024-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 12 Aug 2019 12:10:42 -0400
Message-ID: <CADnq5_MKp-x-aEEFtL3B8T7PJ+JusqJAykZwZ4Eu25ieOEPuhg@mail.gmail.com>
Subject: Re: [PATCH][drm-next] drm/amd/powerplay: remove redundant duplicated
 return check
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

Applied.  thanks!

Alex

On Mon, Aug 5, 2019 at 6:29 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The check on ret is duplicated in two places, it is redundant code.
> Remove it.
>
> Addresses-Coverity: ("Logically dead code")
> Fixes: b94afb61cdae ("drm/amd/powerplay: honor hw limit on fetching metrics data for navi10")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index d62c2784b102..b272c8dc8f79 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -941,8 +941,6 @@ static int navi10_get_gpu_power(struct smu_context *smu, uint32_t *value)
>         ret = navi10_get_metrics_table(smu, &metrics);
>         if (ret)
>                 return ret;
> -       if (ret)
> -               return ret;
>
>         *value = metrics.AverageSocketPower << 8;
>
> @@ -1001,8 +999,6 @@ static int navi10_get_fan_speed_rpm(struct smu_context *smu,
>         ret = navi10_get_metrics_table(smu, &metrics);
>         if (ret)
>                 return ret;
> -       if (ret)
> -               return ret;
>
>         *speed = metrics.CurrFanSpeed;
>
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
