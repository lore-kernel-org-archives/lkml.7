Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2BCC3A59E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 02:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769F822CF7
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 02:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIlXKeAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbfHVCkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 22:40:35 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:34338 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbfHVCke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 22:40:34 -0400
Received: by mail-wr1-f43.google.com with SMTP id s18so3889447wrn.1;
        Wed, 21 Aug 2019 19:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2CWiDloBanvTA4UPTrbF7OF6nI8ojFqUh/DcikOnd90=;
        b=hIlXKeAXDt479x2EtwiJlj0FTnsca6lNlIOXGAfSwL5ia4/UiWbEPVWq4VF5t6Q3co
         5oAZw7cYTLrkFM1ok9F4Ao7545uOmmgZeQL0xg92DsUDwvq6n7eCwAKfjBt5W0CCjhsJ
         1cOQNexM7Untgwq+JuQrNpVoWVyjvSoETv4oYeGu4Q/n4zA8yFcTa7Bv/23kXeBaQe35
         FF/pbYQBXNUzBQPYZ61EeNSDe3TYTS/aKLggd44Bh9+YnPzLcnWqIww06/ldSsX5CRyx
         oHCKgaXAn1jC1PAXbqTUW5xeB0OjCt779yJRadGxrXuJlXIY6w2X3Rk3+vyiwlaiytjG
         /Dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2CWiDloBanvTA4UPTrbF7OF6nI8ojFqUh/DcikOnd90=;
        b=MwLTiaNdKLRua9QwQf4ZIrwI8qcunIcY2tlzCxvnatO0hse0EuMXATuAUHO15fykKi
         WzsmoJ7whJtWc/PdxjXcRk1pGhXwF0V5zG77+TeWsQ1jE8wEOc+krsngLZRGyuRoshS6
         07yUWzu5dmSTuCnY1aD1WZdnlofoTC5gWOKnHMvDye3jvXQKCI75My5et5j6hq7FWEvX
         HmjAHYzdnphVRbRWqXvuvvLnqLpyslPDcHrkGnqJjFXYuYkoH0hSzft6JwRKRclKD8m/
         0Al/F1J9B+wEX2pVpXG+7eKLl+tj9xzxfXLq/M0/5B6FxJF2Sww28Lp1uTq0o7mrSYJI
         tFJA==
X-Gm-Message-State: APjAAAVdYpG0VgwoE6GZWJu15IJhQTMk8SgYYRW/2GRpQauv/KNjfcdp
        mHAHWLxAb4uJZYaxH0p5Ii9Ot74ScUyUjCUk+ME=
X-Google-Smtp-Source: APXvYqzr2GWzF1+u7N2L7j/1p/Kp0hGUUMxfJH3ERizmHnob1SxP5PVPzIQ/k6UYs7jVVpTLtHB1EyIafZRgw0MVXaM=
X-Received: by 2002:adf:dfc5:: with SMTP id q5mr4708309wrn.142.1566441632459;
 Wed, 21 Aug 2019 19:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190710015720.107326-1-yuehaibing@huawei.com>
In-Reply-To: <20190710015720.107326-1-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 21 Aug 2019 22:40:20 -0400
Message-ID: <CADnq5_OFd8N1PpBXwr5mC0=SvZsKx7QUPqavLDEJ+d43hOO4Ng@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu: remove duplicated include from gfx_v9_0.c
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Feifei Xu <Feifei.Xu@amd.com>,
        Likun Gao <Likun.Gao@amd.com>, James Zhu <James.Zhu@amd.com>,
        "S, Shirish" <shirish.s@amd.com>, "Quan, Evan" <evan.quan@amd.com>,
        Huang Rui <ray.huang@amd.com>, Rex Zhu <Rex.Zhu@amd.com>,
        kernel-janitors@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied. thanks!

Alex

On Tue, Jul 9, 2019 at 11:03 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Remove duplicated include.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 5ba332376710..822f45161240 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -39,7 +39,6 @@
>  #include "vega10_enum.h"
>  #include "hdp/hdp_4_0_offset.h"
>
> -#include "soc15.h"
>  #include "soc15_common.h"
>  #include "clearstate_gfx9.h"
>  #include "v9_structs.h"
>
>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
