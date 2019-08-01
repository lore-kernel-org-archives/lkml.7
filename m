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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6C7C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC39C206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyYiP0D6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388534AbfHATMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:12:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44602 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbfHATMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:12:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id p17so74713026wrf.11;
        Thu, 01 Aug 2019 12:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=29eX/7Ti8XYPdnzI29FfnnfKBQG8Yx8Y8+IXP8UDyjQ=;
        b=IyYiP0D64J6DV1eYBS943TYBTz8YgAE88T9bDGFQVgMS2JdnLsmgSB3nY/zz4tLmCV
         bISNAx/148/e0txOpysXy3hWzALkLZ8Gk70I2YfSlIwMW8YQVDTfHNyhDa2FjuvRRBCp
         0M+XN9hlp8rlRFUiyGrXK/llF6njsT0mqv83BLKi1RfWXq0GyOe8p3oQwonFahspM698
         E+TM5d8NI+M5voTh5UeWCNnsOS7KFbgvur8iqB8O5E0SiLAwJm/gtzPZ3hauk81Ffl05
         CdB3fVDmwon7Tu5WkEEXcBWWPhp9zKXiWvQKFjQN709TI8/U/6k7honECL8ZUxsqlcmJ
         aUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=29eX/7Ti8XYPdnzI29FfnnfKBQG8Yx8Y8+IXP8UDyjQ=;
        b=ILpgOEA6G+UsC9Ve47iECvPPx5UBGWR9XlniW2p2nCz8+MriIIOn4hMHHrQNM18sTT
         RSELcDcoez0vtWbjA4nNrG2oND/8v5fIPtcHgFl28rNiwY7YmquLbdrOPRwOBvUXwVzf
         5ZsaBW0QPXwXrmLPPS4/2r7CoQ4d+SMdPyhCAM2bKSKznQ1+UKaIUu9wB6r5X0IHEmf8
         AVrKdMy7akxMkb2V2TsGHoWeXLiYJG+RQQ5ENmn8MUxyiG5xLUBKT3I39sv+CCaqCl8H
         bvZknvhIfKBSgCLwnKwlUwshVRjg6RSTzgo9ydlcgZ9jSVlcZv1r0bCiyMMAwdIPUaWN
         E6OA==
X-Gm-Message-State: APjAAAWO+59NtngUA6GnETc29rol3Pw1ASxLGeWtbjP1ZUD+NSCAJmsm
        zWNOgENyJl7doyMR4fo0HFW/QcxP7Kw+mTp6Js4=
X-Google-Smtp-Source: APXvYqz1dtgJsKtH3HyoA320M+YjnfJkgSzjwkowOb7aXNJJczt8kJkwziW03I18NJKTuyBaxgF+2VNOywn1TUuBUTQ=
X-Received: by 2002:adf:a299:: with SMTP id s25mr134496190wra.74.1564686748120;
 Thu, 01 Aug 2019 12:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190801110145.10803-1-colin.king@canonical.com>
In-Reply-To: <20190801110145.10803-1-colin.king@canonical.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 1 Aug 2019 15:12:16 -0400
Message-ID: <CADnq5_Oo8AthzgGsRCRaiNqn7skzGCGMZGdMcNo8Et+5Zt12Og@mail.gmail.com>
Subject: Re: [PATCH][drm-next] drm/amdgpu: fix unsigned variable instance
 compared to less than zero
To:     Colin King <colin.king@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Le Ma <le.ma@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 7:01 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Currenly the error check on variable instance is always false because
> it is a uint32_t type and this is never less than zero. Fix this by
> making it an int type.
>
> Addresses-Coverity: ("Unsigned compared against 0")
> Fixes: 7d0e6329dfdc ("drm/amdgpu: update more sdma instances irq support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index a33bd867287e..92257f2bf171 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -1962,7 +1962,8 @@ static int sdma_v4_0_process_trap_irq(struct amdgpu_device *adev,
>  static int sdma_v4_0_process_ras_data_cb(struct amdgpu_device *adev,
>                 struct amdgpu_iv_entry *entry)
>  {
> -       uint32_t instance, err_source;
> +       uint32_t err_source;
> +       int instance;
>
>         instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
>         if (instance < 0)
> --
> 2.20.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
