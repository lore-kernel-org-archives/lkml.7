Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8975C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8079C2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TF1phmml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfGSDQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 23:16:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36738 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfGSDQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 23:16:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so30768614wrs.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 20:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3MR4MLuXempgg9+XY38m1M8XagzI4pOkSRouisWIAwU=;
        b=TF1phmmlRr0DVid2bBr9bteJ34YiIud6lW4widI7y1Mji7POmzEXWMwYqwtoErMOBG
         3EAT/W8RVNeWBUDivec7SsX1Z6hMYXDcPIiiDJE3E/u0cnOBQJLFfICBh0jJupi7J7NI
         edRC9fEmbN2DD4FF4OCOBvUbjrChMbZJYh2MEZS0HCpwnMQr0Pc9WurBrB09KdEDGxSB
         EXsKstdjCMaVx+PTjibGvvVKfCo999S/cezfSIlZZVx8oPzrO/sEJ09TgWFgtckLVtpx
         O7cuHN5POAECjJGfNqdBqnMqiohUzMvpBvzQ6JkxAV23fvkGp8bXu82x/doTWtmki6Fa
         D/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3MR4MLuXempgg9+XY38m1M8XagzI4pOkSRouisWIAwU=;
        b=gDkn53QekMl/mATESldugVFrlc4qWr8x8sRA4N3QdLtqZDs7XP6w5Ez0B0Zwu6M6Zl
         oqDGjZrsSYhG9pC0XHhUZ5PD2sNVeoWykLwCrvIWHGm09ubPZ0fyzxSKwPHMvCF895nL
         S7nYBxAhQJgDMtbQ2BD9IT0/LUuwzHru+mTXrvtT2GRh+AzZlYBoFWwgv8AhToja16+N
         vWzBy2QtGqQ5a6N9QGGlreekt7QsWS4F2N+SS0AS4Pnfm9fguUky97SLdnLnShD4nEzV
         QSfiUaDMHlRxABng5ihux2Y6oUVDqEPVQPMWhH+m8bk2fChxrq9dZOoaDjW8arUvkKLP
         87RQ==
X-Gm-Message-State: APjAAAVFf/qrK8Xx08l0qm5cxpYxnD9SsK3qigMZisM6mFAh8ReJV1qx
        ycZBROLnlPu21bslzPvqlNjqobFP14A=
X-Google-Smtp-Source: APXvYqyKrJIFz1csxLUdaV88Iz1NIglBx65x891kgSb7B3wVhKVAwGwzhulfVHmiQu5mUksbDOuoPA==
X-Received: by 2002:adf:fc52:: with SMTP id e18mr50692871wrs.14.1563506210397;
        Thu, 18 Jul 2019 20:16:50 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id o7sm24911614wmc.36.2019.07.18.20.16.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 20:16:49 -0700 (PDT)
Date:   Thu, 18 Jul 2019 20:16:47 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, Rex Zhu <rex.zhu@amd.com>,
        Evan Quan <evan.quan@amd.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 5/7] drm/amd/display: Use proper enum conversion functions
Message-ID: <20190719031647.GA84028@archlinux-threadripper>
References: <20190704055217.45860-1-natechancellor@gmail.com>
 <20190704055217.45860-6-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704055217.45860-6-natechancellor@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 10:52:16PM -0700, Nathan Chancellor wrote:
> clang warns:
> 
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:336:8:
> warning: implicit conversion from enumeration type 'enum smu_clk_type'
> to different enumeration type 'enum amd_pp_clock_type'
> [-Wenum-conversion]
>                                         dc_to_smu_clock_type(clk_type),
>                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:421:14:
> warning: implicit conversion from enumeration type 'enum
> amd_pp_clock_type' to different enumeration type 'enum smu_clk_type'
> [-Wenum-conversion]
>                                         dc_to_pp_clock_type(clk_type),
>                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> There are functions to properly convert between all of these types, use
> them so there are no longer any warnings.
> 
> Fixes: a43913ea50a5 ("drm/amd/powerplay: add function get_clock_by_type_with_latency for navi10")
> Fixes: e5e4e22391c2 ("drm/amd/powerplay: add interface to get clock by type with latency for display (v2)")
> Link: https://github.com/ClangBuiltLinux/linux/issues/586
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> index eac09bfe3be2..0f76cfff9d9b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> @@ -333,7 +333,7 @@ bool dm_pp_get_clock_levels_by_type(
>  		}
>  	} else if (adev->smu.funcs && adev->smu.funcs->get_clock_by_type) {
>  		if (smu_get_clock_by_type(&adev->smu,
> -					  dc_to_smu_clock_type(clk_type),
> +					  dc_to_pp_clock_type(clk_type),
>  					  &pp_clks)) {
>  			get_default_clock_levels(clk_type, dc_clks);
>  			return true;
> @@ -418,7 +418,7 @@ bool dm_pp_get_clock_levels_by_type_with_latency(
>  			return false;
>  	} else if (adev->smu.ppt_funcs && adev->smu.ppt_funcs->get_clock_by_type_with_latency) {
>  		if (smu_get_clock_by_type_with_latency(&adev->smu,
> -						       dc_to_pp_clock_type(clk_type),
> +						       dc_to_smu_clock_type(clk_type),
>  						       &pp_clks))
>  			return false;
>  	}
> -- 
> 2.22.0
> 

Gentle ping for review, this is the last remaining warning that I see
from amdgpu on next-20190718.

Cheers,
Nathan
