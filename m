Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB65C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE00D218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7GmprAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfCUN6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:58:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55033 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCUN6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:58:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id f3so2865577wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 06:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Gw//nYt9S8QZfn+EpM+5zbgYH9FoIS4DUIONPLZ5ds=;
        b=e7GmprAKvV1EUvw4zpcWZU+HD79Lf5Kla9KHCJD30zmeBQ4BKqWPdCXlJKiQWDdffH
         B9eCXHvQ8UInc4RLNQAKwgtmMQRdQey7+Vq/uHyZ8zMIhjVDjgB31ZRi2p+4dvK7nNXG
         LIa4lNXpS1xyAi5K305dmU4vwbt1cl0hpyrl6tnGNYLbvOavPPQzrJ9yZZXIZMUWm32W
         G5zH8PukwHXtbi+0Wz403ATDoKT7YsaLT/n35EQuNosMGlLSi5Z5eh4lqMw4x6t4+B7H
         CACsoQdcVWh5HDJHqZUYyaoTGxpepc9iIq43ipT7BOr3CxQnl16NOADMMsxLG6b5kaMv
         TvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Gw//nYt9S8QZfn+EpM+5zbgYH9FoIS4DUIONPLZ5ds=;
        b=OJlGKUkn6j1FzXbdpHX628Vl35qbjKDUin+T32tfxCynuA+Q3dTfhq4SGyQyh0347w
         12zMOHFOdMj7CvTpM9kXCLbOG2lfqyPsAKk/FXLJldYbZPxhlpyzzoAld5mQa+Q9B/Ty
         fqSMQts21oqe0BZl3pVKP//7+X9qq+fJwRJtxhj5lFtOBC/3lxfK6otD2+DyL0Tt0PN8
         ngAeSbdvoV1xf1Os2cVW9l/10h9TwZJnQlH8HebnW8PYZYhytNQ3FDqrSNOe8RCS8yOW
         PavdjKcjBWokWjeApxEJl2SImkf9agjEnt92P3VL+2N4ROkTQexIVFXOX3LqkJ60HpUe
         sb0Q==
X-Gm-Message-State: APjAAAUbRq27j4R9CJGWvh8bpitbMw46YCKaz/JBnTAFlB82B7LXnDPL
        oTrKiXHLyen/73rW1kGPvOMu1lOxVhaErvJTQH4=
X-Google-Smtp-Source: APXvYqyttp5RzNAgq0JnhS8P2FDjNGwxjUzJpScLT+NJDxKr7IXIUigc/1U8rnqCKqz6bteKi5FuWU065Ni0zZv04NI=
X-Received: by 2002:a7b:c344:: with SMTP id l4mr2582817wmj.121.1553176715517;
 Thu, 21 Mar 2019 06:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190320005842.25383-1-natechancellor@gmail.com>
In-Reply-To: <20190320005842.25383-1-natechancellor@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 21 Mar 2019 09:58:23 -0400
Message-ID: <CADnq5_N_5ooTiVzEH15o_YfHkryGx+VbFLoy=XYDhSKGmHTDtQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: Zero initialize num_of_levels in vega20_set_single_dpm_table
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        clang-built-linux@googlegroups.com,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 4:33 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with -Wsometimes-uninitialized, Clang warns:
>
> drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:456:2: warning:
> variable 'num_of_levels' is used uninitialized whenever '?:' condition
> is false [-Wsometimes-uninitialized]
>         smu_read_smc_arg(smu, &num_of_levels);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:608:3: note:
> expanded from macro 'smu_read_smc_arg'
>         ((smu)->funcs->read_smc_arg? (smu)->funcs->read_smc_arg((smu), (arg)) : 0)
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:457:7: note:
> uninitialized use occurs here
>         if (!num_of_levels) {
>              ^~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:456:2: note: remove
> the '?:' if its condition is always true
>         smu_read_smc_arg(smu, &num_of_levels);
>         ^
> drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:608:3: note:
> expanded from macro 'smu_read_smc_arg'
>         ((smu)->funcs->read_smc_arg? (smu)->funcs->read_smc_arg((smu), (arg)) : 0)
>          ^
> drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:446:27: note:
> initialize the variable 'num_of_levels' to silence this warning
>         uint32_t i, num_of_levels, clk;
>                                  ^
>                                   = 0
> 1 warning generated.
>
> The if statement it mentions as potentially problematic is currently
> always true because the read_smc_arg callback is assigned at the
> bottom of this file but Clang can't tell that. If the callback were
> ever to disappear, num_of_levels would never be initialized. Just
> zero initialize it to ensure that the intent behind this code
> remains the same.
>
> Fixes: 870b996f955f ("drm/amd/powerplay: set defalut dpm table for smu")
> Link: https://github.com/ClangBuiltLinux/linux/issues/425
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>


Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> index 7e9e8ad9a300..41e6f49c9cb6 100644
> --- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> @@ -443,7 +443,7 @@ vega20_set_single_dpm_table(struct smu_context *smu,
>                             PPCLK_e clk_id)
>  {
>         int ret = 0;
> -       uint32_t i, num_of_levels, clk;
> +       uint32_t i, num_of_levels = 0, clk;
>
>         ret = smu_send_smc_msg_with_param(smu,
>                         SMU_MSG_GetDpmFreqByIndex,
> --
> 2.21.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
