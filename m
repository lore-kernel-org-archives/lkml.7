Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C23C04A6B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 01:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC0F2184C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 01:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkNDRldw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfEKBhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 21:37:05 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39843 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbfEKBhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 21:37:04 -0400
Received: by mail-ed1-f68.google.com with SMTP id e24so7602111edq.6;
        Fri, 10 May 2019 18:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cMq/4MVOYTLAY5QCZFXsiVplr0BJ1X0QHMo57CSt7M0=;
        b=CkNDRldwZfIz+X4uABrZClSDUWHjBfaBuu7G2n7Gpczgt75QH0WclEqN4k6TsURw68
         Qxt3ESXCC/ATWtJOOqRe8qpgnsqNovPgvq7dC6tbcHMU//mqFVvwAEq8Vx8JBSaaxhM6
         /YSqC/tKAAnWDQDclisONzDZbVRc27N7lIsH+WlXYnFkSQf5NFehFX5vSY5JVk/9UQEx
         vx4BLyFZ5CtxqH6lTtR5r28RR3GuuEHO+fh/73/LD8XPw1rzG5BFaBmLlnM1KoBRatqE
         NtyXxvSkhlNSavw0FGRj4B7inEBomdaBSgl1ZgZ1PAJ2H4tP4CxfFG1YiknsYFqrurQJ
         PcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cMq/4MVOYTLAY5QCZFXsiVplr0BJ1X0QHMo57CSt7M0=;
        b=X6v/0xH0uwJ0c4JP/4MjntMkkNskrk6LrhlR3q5Hj1FrW0pWfxCCl0b08ocCJqt5Tj
         ekxHxEvJ4bA6Jm7CYdSVKkDmrMupN3SlMHJAKc1HD7pddVSWwKSTKQqWqNJ6soNwYqQu
         oWYKZFEU8CsEWMk8iBzdVEQvI3pRh3OlV72kCMC0agGcM4dbFS0GZyWcBJxrxFE2onwU
         omzsxOUckXkE2DyhZsWkJiTvCh8cpvCZTCB5Z/C4uWAdTR0kKFajMVpqPCy8H/kb4h+K
         SgEp7bxsi1cR6jkODBHcxHYfa+Z+J3MspIwwrW1SnibYoirRaTZvgL5eoh28mNOVCw4b
         pDDg==
X-Gm-Message-State: APjAAAXcEvc2j9c93uwolGE2GCmCD3/1Eee4Dvo84AziIaeIWnAhcszg
        /Ox9YMIRtBXBlB0LRoM7z8c=
X-Google-Smtp-Source: APXvYqwEslwWnu/DDdBLnHiDjFx0U3EFjNGO7nlU7JO0Cna0SAFoYxwor0qw9RJIv7RkJryDnJDIzQ==
X-Received: by 2002:a50:87ab:: with SMTP id a40mr14362661eda.188.1557538622698;
        Fri, 10 May 2019 18:37:02 -0700 (PDT)
Received: from archlinux-i9 ([2a01:4f9:2b:2b84::2])
        by smtp.gmail.com with ESMTPSA id x49sm1943909edm.25.2019.05.10.18.37.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 10 May 2019 18:37:01 -0700 (PDT)
Date:   Fri, 10 May 2019 18:37:00 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/amdgpu: fix return of an uninitialized value
 in variable ret
Message-ID: <20190511013700.GA3530@archlinux-i9>
References: <20190510100842.30458-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510100842.30458-1-colin.king@canonical.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 11:08:42AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the case where is_enable is false and lo_base_addr is non-zero the
> variable ret has not been initialized and is being checked for non-zero
> and potentially garbage is being returned. Fix this by not returning
> ret but instead returning -EINVAL on the zero lo_base_addr case.
> 
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: a6ac0b44bab9 ("drm/amdgpu: add df perfmon regs and funcs for xgmi")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

This fixes a clang warning complaining about the same thing.

> ---
>  drivers/gpu/drm/amd/amdgpu/df_v3_6.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> index a5c3558869fb..8c09bf994acd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> @@ -398,10 +398,7 @@ static int df_v3_6_start_xgmi_link_cntr(struct amdgpu_device *adev,
>  				NULL);
>  
>  		if (lo_base_addr == 0)
> -			ret = -EINVAL;
> -
> -		if (ret)
> -			return ret;
> +			return -EINVAL;
>  
>  		lo_val = RREG32_PCIE(lo_base_addr);
>  
> -- 
> 2.20.1
> 
