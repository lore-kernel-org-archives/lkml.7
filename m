Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7E5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE5F2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vBR6zerf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfCTRDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:03:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41757 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfCTRDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:03:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id k11so2229497pgb.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 10:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l3vs7YgqR+NCj73AWguWqT/+I9Cf6xgsHrfCXHYtClQ=;
        b=vBR6zerfi9ayOdShyFb2Esu7bIkR4t5OFTCWdC01n/5vSAPH0BCHB8tMz5noi9EVTS
         NdWbVFfYDpApleRKqPpE358G9CjMJh846R7yaJVYARyeCDoerwQn9wOJrsZ2LzqN5LzY
         5wzPRtT+S9RPnS/YTmZB90bcBCDYxU7OnaCkfenwTAqNUYMI2ZQPVR/iWrIRcxotCB56
         8Jc0vmoFvhdH4zQO/iUCh5/HQb/Cgg7sHgUcb6yeYdK3IsTHT6ksZ556ueUFFQlXkllp
         NZGbnGfXnI5RsnrHdaNLyqSOqlTDgLVi7GyjXSF2O1ftCsmpRVeMnkr0bJ5QdL5gMP6N
         p/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l3vs7YgqR+NCj73AWguWqT/+I9Cf6xgsHrfCXHYtClQ=;
        b=K52D5vy35LhcIFLPFk20XpC3Ttr7a6z6cI7a7w0Y2t07yH0VdrVBHh8iUpx+p4sPIx
         NC3qKbHQs3N+sLiNvCoT2bEL47KAlE3Kf6pDDkuMWlaj8Xs7vQtt4hJzCyVMOoCPQ3ge
         UBO62rUY8a+Q9F7Lvi11hIh6nWEY6xeuCMpfM+KZEKck0l70oFpFvDl30ixr1C8IwSrm
         xb1SpHYj5GPpafA5azsCAVN2u9ut4kXvzM0uHr6nDTAevFT1E2gZYULE+3PnJizM+NbQ
         yYYkMdfkIzJ448AEs4ynt0Jp9US1af2j1tZR6jphfg8NrxIi2QZUjDC2h8Q/xXPgcSIX
         D9sQ==
X-Gm-Message-State: APjAAAUVCoAXNxgofTA0TYMEAAuvwGAUCLqNmiSypoboshKz1/rO+vBe
        E1VP8XshELQbG4AGKj/U/9PXz8SC34DsoSqswuQppQ==
X-Google-Smtp-Source: APXvYqyJSLHi9kjwirjjHSK/IHzI4DppCY+Pxs+4O3zEo5Lzdj8qqH0vTyKCYax7ZC3eqhFxSHx3Q3OR+umkqJaj81A=
X-Received: by 2002:a62:7603:: with SMTP id r3mr8672719pfc.32.1553101383143;
 Wed, 20 Mar 2019 10:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190320005842.25383-1-natechancellor@gmail.com>
In-Reply-To: <20190320005842.25383-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 20 Mar 2019 10:02:51 -0700
Message-ID: <CAKwvOdmBfCarhfJZLmfALsdhCVDWLdzS3XALXRNLpQCjZE88Mg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: Zero initialize num_of_levels in vega20_set_single_dpm_table
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 6:00 PM Nathan Chancellor
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

Thanks for the simple fix.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Fixes: 870b996f955f ("drm/amd/powerplay: set defalut dpm table for smu")
> Link: https://github.com/ClangBuiltLinux/linux/issues/425
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
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


-- 
Thanks,
~Nick Desaulniers
