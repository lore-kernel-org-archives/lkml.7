Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2DFC2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615BA2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 22:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmVkTx3P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbfLLWgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 17:36:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33591 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731195AbfLLWgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 17:36:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id d139so4616340wmd.0;
        Thu, 12 Dec 2019 14:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ZC6V8vQF8U9+ro8xLo3meGZOer4fQgS0VnuTo8ZafQ=;
        b=gmVkTx3PNVS6vZfikSxq/vX+wmzj69MGa59qpbY2NWl3EvOhPqTOPWWmeGFZ4u5nNK
         k+iPsYmBoYn2jmm2gMhsL+DOW/p0+hBBLkXrXnl2Gue29VucKHDwHs9wXEOG4FlnXeCu
         EW2GY9uAHV3RCg5lDvrbeYFFf9HccOBVQuTXkk1gZi6N8LdmjxXF7vLXEawFXGUFcvNG
         7NXTmCHO45+OuRd9ORl3FDLdwoiGL4w6UPvATpFbP50hOGvBouxIXxhrGBYCM9Z2uDYm
         tIAXb3IKiLbvKEpArALrY0XijHMUTQ0ngJRjcTXkZlG0cVcURV/0mPSIlz7DRCqbc4HB
         NsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ZC6V8vQF8U9+ro8xLo3meGZOer4fQgS0VnuTo8ZafQ=;
        b=aiigWuz0P1CgLY0j+vSEuJRyqo4CqOSwqGNZm6zHshzz98LsdIj+1VJ170/i+rdgDa
         6OVIuefyUQoJvUflFUgaiuxzUQE0QQFQWTx2xW/7/+Q2twIt7ccR14k6eBd1xZ+axvIi
         lWrz8hnIPk4Tq3nv7szJyJjvCTnaAkr58ixehz1i/Ky6l+TRdKMAfPU/Vdyk5wPQ/uNA
         a1jIg0ct4QS5fe6QcEUWuo1t0PtxKQAh+hrPUhMMgpze7ShX4Ra2udEkKpgEb+xeKeJ8
         gsRhRpHxYf9duVBKa7PGbl7ebhmeMfhAFf7N4vISKsWWpzR1cGv+Z6sXGn6VcCSnEVhi
         fU2Q==
X-Gm-Message-State: APjAAAXTu1KFZcVmAZduv+FyYOaTyFICPatYxamRn/icVcrZzhYx57x1
        WeV+7/93L5mouKHtkSTXQfe/hAsMcAAR2hJuplzYkQ==
X-Google-Smtp-Source: APXvYqyLeeOFUEZADqvzUcHggdMQXLsgjtOr/m/4Zvbn8hRhUCgqU1csOP5xuGbzFDCXTv1TVSbMTLSXF/7P5SsNVSc=
X-Received: by 2002:a1c:6404:: with SMTP id y4mr4901765wmb.143.1576190160417;
 Thu, 12 Dec 2019 14:36:00 -0800 (PST)
MIME-Version: 1.0
References: <20191212181657.101381-1-colin.king@canonical.com>
In-Reply-To: <20191212181657.101381-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 12 Dec 2019 17:35:48 -0500
Message-ID: <CADnq5_PXb035J7yyfX1gB3oNsVQb-L=KZHR31KxLEH-VUZfT8g@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/powerplay: fix various dereferences of a
 pointer before it is null checked
To:     Colin King <colin.king@canonical.com>
Cc:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kenneth Feng <kenneth.feng@amd.com>,
        Yintian Tao <yttao@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 1:17 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There are several occurrances of the pointer hwmgr being dereferenced
> before it is null checked.  Fix these by performing the dereference
> of hwmgr after it has been null checked.
>
> Addresses-Coverity: ("Dereference before null check")
> Fixes: 8497d2bcdee1 ("drm/amd/powerplay: enable pp one vf mode for vega10")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/amd_powerplay.c |  6 +++---
>  drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c   | 15 +++------------
>  2 files changed, 6 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> index 5087d6bdba60..322c2015d3a0 100644
> --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> @@ -275,12 +275,12 @@ static int pp_dpm_load_fw(void *handle)
>  {
>         struct pp_hwmgr *hwmgr = handle;
>
> -       if (!hwmgr->not_vf)
> -               return 0;
> -
>         if (!hwmgr || !hwmgr->smumgr_funcs || !hwmgr->smumgr_funcs->start_smu)
>                 return -EINVAL;
>
> +       if (!hwmgr->not_vf)
> +               return 0;
> +
>         if (hwmgr->smumgr_funcs->start_smu(hwmgr)) {
>                 pr_err("fw load failed\n");
>                 return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
> index e2b82c902948..f48fdc7f0382 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
> @@ -282,10 +282,7 @@ int hwmgr_hw_init(struct pp_hwmgr *hwmgr)
>
>  int hwmgr_hw_fini(struct pp_hwmgr *hwmgr)
>  {
> -       if (!hwmgr->not_vf)
> -               return 0;
> -
> -       if (!hwmgr || !hwmgr->pm_en)
> +       if (!hwmgr || !hwmgr->pm_en || !hwmgr->not_vf)
>                 return 0;
>
>         phm_stop_thermal_controller(hwmgr);
> @@ -305,10 +302,7 @@ int hwmgr_suspend(struct pp_hwmgr *hwmgr)
>  {
>         int ret = 0;
>
> -       if (!hwmgr->not_vf)
> -               return 0;
> -
> -       if (!hwmgr || !hwmgr->pm_en)
> +       if (!hwmgr || !hwmgr->pm_en || !hwmgr->not_vf)
>                 return 0;
>
>         phm_disable_smc_firmware_ctf(hwmgr);
> @@ -327,13 +321,10 @@ int hwmgr_resume(struct pp_hwmgr *hwmgr)
>  {
>         int ret = 0;
>
> -       if (!hwmgr->not_vf)
> -               return 0;
> -
>         if (!hwmgr)
>                 return -EINVAL;
>
> -       if (!hwmgr->pm_en)
> +       if (!hwmgr->not_vf || !hwmgr->pm_en)
>                 return 0;
>
>         ret = phm_setup_asic(hwmgr);
> --
> 2.24.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
