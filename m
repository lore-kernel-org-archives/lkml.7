Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77310C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456D52082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jGBQLjDr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CnyBI54s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfDJRBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:01:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60212 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfDJRBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:01:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C8ACE61156; Wed, 10 Apr 2019 17:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554915705;
        bh=BhhwScty9AVyj8WwdSUhYUpwUYbHGX2kx3/9adA6eT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jGBQLjDrIxbwngCflKLXj94CLCLwiDYtCwLGWfMDgw8MlIExyftVViHJ4M6wuoSTn
         Z9Rcfo6DFDz3E2Y7J+axC8yeoDa/yRkrUe8MShr2N4vWgLMqjD0GNjKiZpmcok1iWm
         EZQtmNHuQD3MNWjUPKoS7peds1i31aWOM0D9irl4=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0FDDB60F3C;
        Wed, 10 Apr 2019 17:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554915704;
        bh=BhhwScty9AVyj8WwdSUhYUpwUYbHGX2kx3/9adA6eT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CnyBI54sc27ZrjqM1gJiIgyzY3hyOeWEPb9DB1L9Wu08aLO3toMpgoSGUA21uqdO6
         2YUmxbPpRHB9rwgYc951ujNKWhLE/ZN6zK4c84M0H6nBuVSyklkhUnyVvc8njnTV3S
         0gVLrZDHBfyPg7+fbwOeZeIQWBtDzNPW3siIk2T0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0FDDB60F3C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Wed, 10 Apr 2019 11:01:42 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [Freedreno] [PATCH] drm/msm/a6xx: Fix build with !CONFIG_DEBUG_FS
Message-ID: <20190410170142.GB9296@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: YueHaibing <yuehaibing@huawei.com>, robdclark@gmail.com,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
References: <20190403064811.25832-1-yuehaibing@huawei.com>
 <20190403153639.GA13713@jcrouse1-lnx.qualcomm.com>
 <a9871f50-f8f9-917d-9a6a-798805d698ad@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9871f50-f8f9-917d-9a6a-798805d698ad@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 10:02:07AM +0800, YueHaibing wrote:
> On 2019/4/3 23:36, Jordan Crouse wrote:
> > On Wed, Apr 03, 2019 at 02:48:11PM +0800, Yue Haibing wrote:
> >> From: YueHaibing <yuehaibing@huawei.com>
> >>
> >> When building CONFIG_DEBUG_FS is not set
> >> gcc warn this:
> >>
> >> drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c: In function a6xx_show:
> >> drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:1124:2: error: implicit declaration of function adreno_show; did you mean adreno_dump? [-Werror=implicit-function-declaration]
> >>   adreno_show(gpu, state, p);
> >>   ^~~~~~~~~~~
> >>
> >> Reported-by: Hulk Robot <hulkci@huawei.com>
> >> Fixes: 1707add81551 ("drm/msm/a6xx: Add a6xx gpu state")
> >> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> >> ---
> >>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> >> index e686331..d327eb5 100644
> >> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> >> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> >> @@ -1121,7 +1121,9 @@ void a6xx_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
> >>  	if (IS_ERR_OR_NULL(state))
> >>  		return;
> >>  
> >> +#if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
> >>  	adreno_show(gpu, state, p);
> >> +#endif
> > 
> > I agree that this is a problem, but I think I would prefer if we just made a
> > stub function for adreno_show instead of doing a inline ifdef, so in
> > adreno_gpu.c:
> > 
> > #ifdef defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
> > ...
> > #else
> > void adreno_show(struct msm_gpu *gpu, msm_gpu_state *state,
> > 	struct drm_printer *p)
> > {
> > }
> > #endif
> > 
> > If you want, I can do a quick patch.
> 
> Sure, it's ok for me.

Sorry for the delay.  I went back and looked at this and discovered that the
problem was a bit more extensive - none of a6xx_gpu_state.c is useful without
the dependencies, so I made a bit more extensive patch to handle the root of
that:

https://patchwork.freedesktop.org/series/59297/

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
