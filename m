Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0699EC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 20:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37F121670
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 20:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWlp+1ux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfGEUcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 16:32:54 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35825 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfGEUcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 16:32:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so3548813wmg.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 13:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yoxxCJSZxSTE9St2leMIv+/L5lNU4jc2bI6FtTm18Vo=;
        b=YWlp+1ux3L09iNQ+B6wbqMHO1Z6hMUvH3hk6l+IfauxLlrkkzcX6VUSLGaV00RpJfQ
         b3bD+R5XvH6BRa9VK7j/hWmKsUPd/AV58VVBvKGmIz4jeqjGuHKqISQcnpWo+Pa2dBuq
         4hVoqp9NsQpM2qdEgyE4iQEBUAAQTLkvgBfly0agOg8JzaJuugzRMMhCTZtUh1iVfsuQ
         BSQA9/CeTA5mP29J7aP3QzqAvrkRK13l+2Lc9lnkIITQhAnFbHXonCFlipvKFwXJHC5D
         b7bIhUUCgfrss1m/lu3T+K1N4wI/9nod/TAILbLI/pH/cYPyjbDcwiH9YJ1oBTVvpYiS
         PQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yoxxCJSZxSTE9St2leMIv+/L5lNU4jc2bI6FtTm18Vo=;
        b=BpFCY4Z0f2z3YN5420o3OS3bqcm3wZrFL930GbwulP/e42nvRYqT329UaFulXOu4PG
         3LHYxrkrQVfkbxP1fm/Kl2sDrrz4/k2aEhrqOPQa5yhTC4744Vj2w/gdMR/m3fv7B4gd
         /BB9Cze1Af41DLEMk8h7KKuf5Pty4po5Sbut6JfK7DDQ2FkUY+NVlZa+moMZhul6q5At
         +8V/IkL4cWVMYZVw9SssLpHORoyxapOOr9eEJpUzl3FZ1Q00nNfnNcv3fFAUyV+aB6tD
         7joQJFbZSfYZfNM7qaYpeRHuTeb12B912/9s0S232FE0w5ptZp72IhVO93TxUjm2uJFJ
         SZFQ==
X-Gm-Message-State: APjAAAUOX7d1WX9+/88iMjv0+48tTxzYs2bVeqUYuitOc19mMa4tVQBX
        M3xBWcs2Ghlp1S/CchMBiLCOMQMxW49A8QXBQ8XH0MfX
X-Google-Smtp-Source: APXvYqwfDP/THUkpCtIM4cUZw/Yfty+ps9KY+d54LP6mdlU+haOrDt6MQjz6RaQlZues5DSTJFl6119KvB99/4BPxqU=
X-Received: by 2002:a05:600c:20d:: with SMTP id 13mr4557378wmi.141.1562358770831;
 Fri, 05 Jul 2019 13:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190703162718.32184-1-huangfq.daxian@gmail.com>
In-Reply-To: <20190703162718.32184-1-huangfq.daxian@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 5 Jul 2019 16:32:39 -0400
Message-ID: <CADnq5_Pr1=69rwce-bkDA7y-16MgYwCg8z2ghOvDqooMMj3r6A@mail.gmail.com>
Subject: Re: [PATCH v2 07/35] drm/amdgpu: Use kmemdup rather than duplicating
 its implementation
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Leo Li <sunpeng.li@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 1:13 PM Fuqian Huang <huangfq.daxian@gmail.com> wrote:
>
> kmemdup is introduced to duplicate a region of memory in a neat way.
> Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
> write the size twice (sometimes lead to mistakes), kmemdup improves
> readability, leads to smaller code and also reduce the chances of mistakes.
> Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.
>
> Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
> Changes in v2:
>   - Fix a typo in commit message (memset -> memcpy)
>
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c           | 5 ++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c           | 5 ++---
>  drivers/gpu/drm/amd/display/dc/core/dc.c        | 6 ++----
>  drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 4 +---
>  4 files changed, 7 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 02955e6e9dd9..48e38479d634 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -3925,11 +3925,10 @@ static int gfx_v8_0_init_save_restore_list(struct amdgpu_device *adev)
>
>         int list_size;
>         unsigned int *register_list_format =
> -               kmalloc(adev->gfx.rlc.reg_list_format_size_bytes, GFP_KERNEL);
> +               kmemdup(adev->gfx.rlc.register_list_format,
> +                       adev->gfx.rlc.reg_list_format_size_bytes, GFP_KERNEL);
>         if (!register_list_format)
>                 return -ENOMEM;
> -       memcpy(register_list_format, adev->gfx.rlc.register_list_format,
> -                       adev->gfx.rlc.reg_list_format_size_bytes);
>
>         gfx_v8_0_parse_ind_reg_list(register_list_format,
>                                 RLC_FormatDirectRegListLength,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index b610e3b30d95..09d901ef216d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2092,11 +2092,10 @@ static int gfx_v9_1_init_rlc_save_restore_list(struct amdgpu_device *adev)
>         u32 tmp = 0;
>
>         u32 *register_list_format =
> -               kmalloc(adev->gfx.rlc.reg_list_format_size_bytes, GFP_KERNEL);
> +               kmemdup(adev->gfx.rlc.register_list_format,
> +                       adev->gfx.rlc.reg_list_format_size_bytes, GFP_KERNEL);
>         if (!register_list_format)
>                 return -ENOMEM;
> -       memcpy(register_list_format, adev->gfx.rlc.register_list_format,
> -               adev->gfx.rlc.reg_list_format_size_bytes);
>
>         /* setup unique_indirect_regs array and indirect_start_offsets array */
>         unique_indirect_reg_count = ARRAY_SIZE(unique_indirect_regs);
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 18c775a950cc..6ced3b9cdce2 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1263,14 +1263,12 @@ struct dc_state *dc_create_state(struct dc *dc)
>  struct dc_state *dc_copy_state(struct dc_state *src_ctx)
>  {
>         int i, j;
> -       struct dc_state *new_ctx = kzalloc(sizeof(struct dc_state),
> -                                          GFP_KERNEL);
> +       struct dc_state *new_ctx = kmemdup(src_ctx,
> +                       sizeof(struct dc_state), GFP_KERNEL);
>
>         if (!new_ctx)
>                 return NULL;
>
> -       memcpy(new_ctx, src_ctx, sizeof(struct dc_state));
> -
>         for (i = 0; i < MAX_PIPES; i++) {
>                         struct pipe_ctx *cur_pipe = &new_ctx->res_ctx.pipe_ctx[i];
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> index 96e97d25d639..d4b563a2e220 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> @@ -167,12 +167,10 @@ struct dc_stream_state *dc_copy_stream(const struct dc_stream_state *stream)
>  {
>         struct dc_stream_state *new_stream;
>
> -       new_stream = kzalloc(sizeof(struct dc_stream_state), GFP_KERNEL);
> +       new_stream = kzalloc(stream, sizeof(struct dc_stream_state), GFP_KERNEL);

This doesn't compile.  I've gone ahead and fixed it up locally and
applied it.  Please check that your patches compile before sending
them out.

Thanks,

Alex

>         if (!new_stream)
>                 return NULL;
>
> -       memcpy(new_stream, stream, sizeof(struct dc_stream_state));
> -
>         if (new_stream->sink)
>                 dc_sink_retain(new_stream->sink);
>
> --
> 2.11.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
