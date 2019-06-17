Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA8BC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B112073F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQHtP8e8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfFQPCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:02:32 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36590 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfFQPCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:02:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id u8so9489199wmm.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 08:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DmHkxGavMTauI3qZzTGg9rhjrZkVmngbpoajc3r4ls8=;
        b=iQHtP8e8TmQLxOQJWVuM17S3FcmTJ/6Xulg9OvgS2LSHqn/ERZIiCBHr1+zr0a/Jx5
         lBkCIu2WLNZSx3EWsi/o6cD2CZsbhf0tr4bcO6rH6pbYeVgMhHYXrT3V0YejqKqZJK3I
         qtfLJ9wRvxDBl2qvwv+vU7D7MMGIBd4hKqojlm4nHN4n0m91tSGvuCA6wsW44hWhSDSJ
         j+RhLiBNOdDXbnnpGxT5d4W+8XQCjpFIYdE6lV6h0X07d5a9H1aCIorG4HhRzlChv4xB
         9Ed0hLbXYY0DlaPkKWOp0tzaYbkr9yODNokBz+qanK6E8VK2WY/hYgKBHUccb37ufD7q
         ilcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DmHkxGavMTauI3qZzTGg9rhjrZkVmngbpoajc3r4ls8=;
        b=WGuc/KQX0WHVdHUVuAJcPwNupqJLjkcmfDEOdpn8VRZymaSS/p3lhdcg3MIhdDZ3Bh
         glE7r5C5DtTCM3TLfMnl4QhxDmnBlnE8dsdr48El7IzFK8oFZzr6N0o5b8JHmM4S2Ds4
         eqtSWybjH8RrT2yYf6LpMoLfyh4hrjWrKNzDIKoPdAVVqhOfLpgtKYgxMkhDTTQ8a/po
         zCkj/c5bAaDwSVf0F76mCg7QNuLb92PNqG9VZA4vyAiBdBi5+TRwd7Xrg2nGUEUKwqP8
         9N5hbTi6yo3oyj82eRcjgIEcONhabkKqX5OSGLLakcU4zasWuYz+k44udrc3Q7gIdWzm
         y7aw==
X-Gm-Message-State: APjAAAXgR0m8ZSFK9BhqTwLQZJoA/VTowj7fG0W+q1VrWil0FQ7fjsi2
        7kguX/2WHjXnOOdPcCarQYpkbagO9d/j1THlPa6mf+EF
X-Google-Smtp-Source: APXvYqx7ZPkaUVBa6UQhD3BC90IpJUz4r9Xiw6YHDkWNZmD1Os0nIU+UcBeWVijbrxHoyJGZMJzpbglpEmnAm8R2avQ=
X-Received: by 2002:a05:600c:2149:: with SMTP id v9mr18974590wml.141.1560783750304;
 Mon, 17 Jun 2019 08:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190617125216.1439481-1-arnd@arndb.de>
In-Reply-To: <20190617125216.1439481-1-arnd@arndb.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 17 Jun 2019 11:02:18 -0400
Message-ID: <CADnq5_MLH9TW76Cji=pAOtpNd7UiB5w=J=3rT_6UYzgCvsS2pg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix error handling in df_v3_6_pmc_start
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Kim <jonathan.kim@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Colin Ian King <colin.king@canonical.com>,
        Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 8:57 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> When df_v3_6_pmc_get_ctrl_settings() fails for some reason, we
> store uninitialized data in a register, as gcc points out:
>
> drivers/gpu/drm/amd/amdgpu/df_v3_6.c: In function 'df_v3_6_pmc_start':
> drivers/gpu/drm/amd/amdgpu/amdgpu.h:1012:29: error: 'lo_val' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>  #define WREG32_PCIE(reg, v) adev->pcie_wreg(adev, (reg), (v))
>                              ^~~~
> drivers/gpu/drm/amd/amdgpu/df_v3_6.c:334:39: note: 'lo_val' was declared here
>   uint32_t lo_base_addr, hi_base_addr, lo_val, hi_val;
>                                        ^~~~~~
>
> Make it return a proper error code that we can catch in the caller.
>
> Fixes: 992af942a6cf ("drm/amdgpu: add df perfmon regs and funcs for xgmi")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/df_v3_6.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> index 8c09bf994acd..e079ee066d87 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> @@ -177,7 +177,7 @@ static void df_v3_6_pmc_get_read_settings(struct amdgpu_device *adev,
>  }
>
>  /* get control counter settings i.e. address and values to set */
> -static void df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
> +static int df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
>                                           uint64_t config,
>                                           uint32_t *lo_base_addr,
>                                           uint32_t *hi_base_addr,
> @@ -191,12 +191,12 @@ static void df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
>         df_v3_6_pmc_get_addr(adev, config, 1, lo_base_addr, hi_base_addr);
>
>         if (lo_val == NULL || hi_val == NULL)
> -               return;
> +               return -EINVAL;
>
>         if ((*lo_base_addr == 0) || (*hi_base_addr == 0)) {
>                 DRM_ERROR("DF PMC addressing not retrieved! Lo: %x, Hi: %x",
>                                 *lo_base_addr, *hi_base_addr);
> -               return;
> +               return -ENXIO;
>         }
>
>         eventsel = GET_EVENT(config);
> @@ -211,6 +211,8 @@ static void df_v3_6_pmc_get_ctrl_settings(struct amdgpu_device *adev,
>         es_7_0 = es_13_0 & 0x0FFUL;
>         *lo_val = (es_7_0 & 0xFFUL) | ((unitmask & 0x0FUL) << 8);
>         *hi_val = (es_11_8 | ((es_13_12)<<(29)));
> +
> +       return 0;
>  }
>
>  /* assign df performance counters for read */
> @@ -345,13 +347,16 @@ static int df_v3_6_add_xgmi_link_cntr(struct amdgpu_device *adev,
>         if (ret || is_assigned)
>                 return ret;
>
> -       df_v3_6_pmc_get_ctrl_settings(adev,
> +       ret = df_v3_6_pmc_get_ctrl_settings(adev,
>                         config,
>                         &lo_base_addr,
>                         &hi_base_addr,
>                         &lo_val,
>                         &hi_val);
>
> +       if (ret)
> +               return ret;
> +
>         WREG32_PCIE(lo_base_addr, lo_val);
>         WREG32_PCIE(hi_base_addr, hi_val);
>
> --
> 2.20.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
