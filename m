Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD4EC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6722A2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 09:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbfGOJZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 05:25:47 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40888 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729394AbfGOJZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 05:25:46 -0400
Received: by mail-qk1-f196.google.com with SMTP id s145so11046293qke.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 02:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rPkUhtxg4MFrjNr+Dr5xrJl5bg2MfLxjRYrMvZrd2ec=;
        b=gP7sh1dNi+v9wtb47wHxlGhwMMdYRbmdbnQeqiu2B0LNj4+FOncY/hWbvCfQiayCSp
         dT2V/gVMT0ZPWxCFIbjOw+FGF7a6RJIbbvnAeO9HVCHVO21TYl32Q7LE76OrylmhX22m
         9TdpvTL8t3N25WkU9MxWO5woO0MKbciGjFn1Zki5C+HEt3kWmjaCV0rZmU2WmR5LZzgy
         2Vr+NC5Ih7+dBsBAb+TN2IwziABnV9SXXjRaHE5IFT55tc3Am/9lc2UJSm5czq2yF0QE
         WEPxgXGTFpcK8hJ7sDaTackqhdOoQwFMS0h5uVEBCxvaMCxYcxMD1hofBZXghqmrlvy4
         Rdkg==
X-Gm-Message-State: APjAAAX+jnBAv625A4OCxQSDcFLrkWfUxnBlnFKRx6ZQlnsrjTBOXPbB
        +fuSGSBMWDGOyXCtyC6Gq6PgB4QZq/g3a1ax/0o=
X-Google-Smtp-Source: APXvYqx2eckByQGU+dfHfehnNGjeOF0hufPzEc5ZbZv1szybdVE20KchvrVMo/4bumusNmT5/oravdpEMduU41KKuic=
X-Received: by 2002:a37:5f45:: with SMTP id t66mr15941069qkb.286.1563182746083;
 Mon, 15 Jul 2019 02:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190704055217.45860-1-natechancellor@gmail.com> <20190704055217.45860-7-natechancellor@gmail.com>
In-Reply-To: <20190704055217.45860-7-natechancellor@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 15 Jul 2019 11:25:29 +0200
Message-ID: <CAK8P3a1e4xKTZc1Fcd9KLwaGG_wpcAnSNu7mrB6zw+aBJ0e0CA@mail.gmail.com>
Subject: Re: [PATCH 6/7] drm/amd/powerplay: Use proper enums in vega20_print_clk_levels
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, Rex Zhu <rex.zhu@amd.com>,
        Evan Quan <evan.quan@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 7:52 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> clang warns:
>
> drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:995:39: warning:
> implicit conversion from enumeration type 'PPCLK_e' to different
> enumeration type 'enum smu_clk_type' [-Wenum-conversion]
>                 ret = smu_get_current_clk_freq(smu, PPCLK_SOCCLK, &now);
>                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:1016:39: warning:
> implicit conversion from enumeration type 'PPCLK_e' to different
> enumeration type 'enum smu_clk_type' [-Wenum-conversion]
>                 ret = smu_get_current_clk_freq(smu, PPCLK_FCLK, &now);
>                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:1031:39: warning:
> implicit conversion from enumeration type 'PPCLK_e' to different
> enumeration type 'enum smu_clk_type' [-Wenum-conversion]
>                 ret = smu_get_current_clk_freq(smu, PPCLK_DCEFCLK, &now);
>                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
>
> The values are mapped one to one in vega20_get_smu_clk_index so just use
> the proper enums here.
>
> Fixes: 096761014227 ("drm/amd/powerplay: support sysfs to get socclk, fclk, dcefclk")
> Link: https://github.com/ClangBuiltLinux/linux/issues/587
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---

Adding Kevin Wang for further review, as he sent a related patch in
d36893362d22 ("drm/amd/powerplay: fix smu clock type change miss error")

I assume this one is still required as it triggers the same warning.
Kevin, can you have a look?

      Arnd

>  drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> index 0f14fe14ecd8..e62dd6919b24 100644
> --- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> @@ -992,7 +992,7 @@ static int vega20_print_clk_levels(struct smu_context *smu,
>                 break;
>
>         case SMU_SOCCLK:
> -               ret = smu_get_current_clk_freq(smu, PPCLK_SOCCLK, &now);
> +               ret = smu_get_current_clk_freq(smu, SMU_SOCCLK, &now);
>                 if (ret) {
>                         pr_err("Attempt to get current socclk Failed!");
>                         return ret;
> @@ -1013,7 +1013,7 @@ static int vega20_print_clk_levels(struct smu_context *smu,
>                 break;
>
>         case SMU_FCLK:
> -               ret = smu_get_current_clk_freq(smu, PPCLK_FCLK, &now);
> +               ret = smu_get_current_clk_freq(smu, SMU_FCLK, &now);
>                 if (ret) {
>                         pr_err("Attempt to get current fclk Failed!");
>                         return ret;
> @@ -1028,7 +1028,7 @@ static int vega20_print_clk_levels(struct smu_context *smu,
>                 break;
>
>         case SMU_DCEFCLK:
> -               ret = smu_get_current_clk_freq(smu, PPCLK_DCEFCLK, &now);
> +               ret = smu_get_current_clk_freq(smu, SMU_DCEFCLK, &now);
>                 if (ret) {
>                         pr_err("Attempt to get current dcefclk Failed!");
>                         return ret;
