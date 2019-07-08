Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C8DC606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CE820656
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEgp7AyT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388388AbfGHQDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:03:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53089 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbfGHQDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:03:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so62848wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 09:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zwoXAr/YNraRlmud8ofRWI6jVpzq0UG/Go1e/PNZA/M=;
        b=HEgp7AyTbjYWLeCAAQX1BlSI+ssrq+tgWEq10oiHUs1MLTYPNUuMgOS4QnBo07Vtz5
         wGiL74MWxOQirVB+oechXWQizTURBG2jh7ostX/okYLA70+7GJ3Qe4NsuGB133YRRaZZ
         7sbbsH8CDtSl+/x+nBsMocbSN5XYnpxifFKD2vQmMFd8/PGQpxkY9QCaSNdt0mKkfq1T
         FCKSWJjlMQA533NSTDZjDsG1csU4xH1RUNJj1+ihP9CoM1sClZ/6qmuAuzw816ziVfhr
         EXFYnylRFjGBEBJABxTmndHvDg39Ir0aqfU3ZQQuozRQNoMk+sWOxguK9gHBkpfFu8vh
         xFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zwoXAr/YNraRlmud8ofRWI6jVpzq0UG/Go1e/PNZA/M=;
        b=Aq5myYRtc2HwO+DPs8yrM79qw/qywEDhgRz00io6MHWToYhXr/zUouKMusws3MRib1
         efLm+gWKnuj2bxaWuoNw6rXvqJENnSBo6GqXQVRF0ED/Mr/gdpsSjyH08dJzJ9PtY6BL
         66DyskZVtwPSsTWNsSoV61JB+H1ogGuiEnwl9E4Hn7+qICd4Odf06XCANM00lLVwxjVl
         pobOqkiijD6OtghDSrTu0ShgGskKa44zRs+ZqhWmUb5g8JFyXQxa/etkBR8gnaAY7NqT
         mJsqq+oOzQopHdXqGKL/K/Y/HWKX6T+ioWxcLzYTY3uX/oiMD1BUrPiUuPtxHeY8BTg5
         CGdw==
X-Gm-Message-State: APjAAAWyAmydCJ3x5wCcc9mJgxuUsOwsdIcVdx+W1NHb44sMsNfHS5Lp
        cSWbrMukcJYfK76Mb+0bhlU3h/Q8NP37OaSS7ZU=
X-Google-Smtp-Source: APXvYqxvGyIVUErqo8OhUg9JaNXt2H+yturKvRRXX8m8NFeFsdtR9mdkMgFR2pXW6NIq+vpW5Sz7xUViqHqNMEfDJ5Q=
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr16482999wmc.34.1562601800950;
 Mon, 08 Jul 2019 09:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190708140816.1334640-1-arnd@arndb.de> <20190708140816.1334640-2-arnd@arndb.de>
In-Reply-To: <20190708140816.1334640-2-arnd@arndb.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 8 Jul 2019 12:03:09 -0400
Message-ID: <CADnq5_NGiM+Bs_AwBC5GUOv2Dx11_fvaqJXtQZKR_drVy68O8w@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/powerplay: vega20: fix uninitialized variable use
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chengming Gui <Jack.Gui@amd.com>,
        Kevin Wang <kevin1.wang@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Huang Rui <ray.huang@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 10:08 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> If smu_get_current_rpm() fails, we can't use the output,
> as that may be uninitialized:
>
> drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:3023:8: error: variable 'current_rpm' is used uninitialized whenever '?:' condition is false [-Werror,-Wsometimes-uninitialized]
>         ret = smu_get_current_rpm(smu, &current_rpm);
>               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:735:3: note: expanded from macro 'smu_get_current_rpm'
>         ((smu)->funcs->get_current_rpm ? (smu)->funcs->get_current_rpm((smu), (speed)) : 0)
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:3024:12: note: uninitialized use occurs here
>         percent = current_rpm * 100 / pptable->FanMaximumRpm;
>                   ^~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:3023:8: note: remove the '?:' if its condition is always true
>         ret = smu_get_current_rpm(smu, &current_rpm);
>               ^
> drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:735:3: note: expanded from macro 'smu_get_current_rpm'
>         ((smu)->funcs->get_current_rpm ? (smu)->funcs->get_current_rpm((smu), (speed)) : 0)
>          ^
> drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:3020:22: note: initialize the variable 'current_rpm' to silence this warning
>         uint32_t current_rpm;
>
> Propagate the error code in that case.
>
> Fixes: ee0db82027ee ("drm/amd/powerplay: move PPTable_t uses into asic level")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> index 9ce3f1c8ae0f..20d477f8dc84 100644
> --- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> @@ -3021,10 +3021,13 @@ static int vega20_get_fan_speed_percent(struct smu_context *smu,
>         PPTable_t *pptable = smu->smu_table.driver_pptable;
>
>         ret = smu_get_current_rpm(smu, &current_rpm);
> +       if (ret)
> +               return ret;
> +
>         percent = current_rpm * 100 / pptable->FanMaximumRpm;
>         *speed = percent > 100 ? 100 : percent;
>
> -       return ret;
> +       return 0;
>  }
>
>  static int vega20_get_gpu_power(struct smu_context *smu, uint32_t *value)
> --
> 2.20.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
