Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F255EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 23:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC1F206DD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 23:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcWd4QrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfCAXyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 18:54:32 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42897 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCAXyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 18:54:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id r5so27591444wrg.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 15:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kmgsxa2P8T2ooVO7aPAOIQBPVM5WW83KC//cWWo3GV0=;
        b=jcWd4QrKyHXEvnjeNyPZTBwhxgc6J7qmrGJRWI42w3c60ZvYwEidiuozoO2nCCtCpg
         D1ony0ihuYrA4nAb3pygmZDGaeZJUGI/wo/eAc4yUhOEr8qcvX3OSus9W+ZGUh+9pMMM
         9q/I4GLsixSsHzkokKJjzvclCQ2IBKjX+N9n/kc+xbmXjj29Le0KZGD5EIxENeYPc1GW
         zhidufsmEUqiGlbUpbWiX+uWt26DKYwdaPawJomzkBoauMGSAoJqBf6zL3i+un4sEZSB
         CYVSgZjmsxEWIUZNvbPaAmIXlqsy4ZZljZ0JPjzpn5QBOgHcZCUV2BDrq2WJD2L6h2By
         utPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kmgsxa2P8T2ooVO7aPAOIQBPVM5WW83KC//cWWo3GV0=;
        b=jOxt9IhEiNuFPnv2uhmQmnSx5/rTFGiWr4CXWNXG8O1volBgp1igbgFBI1mYAH+7dj
         NPeN18ygPCe5/cFBnWAYYb9x73U7LfkDZ5Dox4NdRV73G7wpyvMyZKoftpV7JdC3SHdV
         s5iWafCsI4HFn9SdIVUdrrW3WcCnyFOBidtVRUWLo1g0C0WvWA5x16IlWdr26QEfbaEy
         E2yvMH8z6Fd5RJ1M6gcjuQn/QrtdW1KDxzjopxPbiOCQhvoox6aDfZwZKPQ9SprlnWtr
         uXWD/sRVapkAynG/+JwiNGqOXs5yZ727K7MNe5YRBSWgD2IqKTrDTSEfJvfcyt/Qcz8Z
         MOiQ==
X-Gm-Message-State: APjAAAUCFOwbV6La/vnl8SwXAFdSRt6TTbLXz5Z68jf8yxtM+EFiK6so
        AVFGAOLJdpT+I+ZFjLCgHcs334eBs3XyHwmNJ8o=
X-Google-Smtp-Source: APXvYqxUrh3nFslD3XuXz6dUDqv88OE7NR5I/pMxmmIRpe/uWZ3TX7SPETSa1bFDp/JHt4ASVyX7L5IngvfXeGyiIRI=
X-Received: by 2002:adf:f3d0:: with SMTP id g16mr5063134wrp.29.1551484469897;
 Fri, 01 Mar 2019 15:54:29 -0800 (PST)
MIME-Version: 1.0
References: <20190301212943.GA21585@embeddedor>
In-Reply-To: <20190301212943.GA21585@embeddedor>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 1 Mar 2019 18:54:18 -0500
Message-ID: <CADnq5_NdT3R141uSGxYd7yZ0nimo2uW_WgfWF8jGxYr68F4Kqg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/powerplay: Fix missing break in switch statement
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 4:51 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Add missing break statement in order to prevent the code from falling
> through to case SMU_Discrete_DpmTable.
>
> This bug was found thanks to the ongoing efforts to enable
> -Wimplicit-fallthrough.
>
> Fixes: 34a564eaf528 ("drm/amd/powerplay: implement fw image related smum interface for Polaris.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Already fixed:
https://cgit.freedesktop.org/~agd5f/linux/commit/?h=drm-next-5.2-wip&id=6feaa4194c18578623565017f95d1b2f6b243567

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> index 52abca065764..222fb79d319e 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> @@ -2330,6 +2330,7 @@ static uint32_t polaris10_get_offsetof(uint32_t type, uint32_t member)
>                 case DRAM_LOG_BUFF_SIZE:
>                         return offsetof(SMU74_SoftRegisters, DRAM_LOG_BUFF_SIZE);
>                 }
> +               break;
>         case SMU_Discrete_DpmTable:
>                 switch (member) {
>                 case UvdBootLevel:
> --
> 2.21.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
