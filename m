Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E81C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AD7206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l27Q06IY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ft4YE5ht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfDCPgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:36:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46402 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCPgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:36:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 511DA616D3; Wed,  3 Apr 2019 15:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554305804;
        bh=vDIqhV5Fswiy4LeMz3nbTK3otB3FpYMsAdhApjFf7qk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l27Q06IY17ISmG76yKUeniHuCcQR0ftuKZegdPUd+KB1pTxOp9Qzhhc8Co634en/z
         594wiRCBpgxZP2EFSkiifKsK+OVENozoppRmg0Qg4abcRj8XKa4VtQ/TCE03D8NDRY
         89HmOsOWk+FgTPbGRuKlFlto7uzQ8J4thDTFun9A=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2479561544;
        Wed,  3 Apr 2019 15:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554305803;
        bh=vDIqhV5Fswiy4LeMz3nbTK3otB3FpYMsAdhApjFf7qk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ft4YE5ht7pdbnqAOayubT2oDuilMnUkTzVjNEoZvuHR2sUSEyjd2Kxffb6XzPnNih
         fk2ucgJPuHAdV6Rv4HaWZa/DfHmaIpTrX+LdYwjr7iZkH/f/pVvE/hwY2S5sGAwuCM
         kDME8mJcgDZWNJe1dqkXRnK8DzPLjk/lfnRrqdiI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2479561544
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Wed, 3 Apr 2019 09:36:40 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] drm/msm/a6xx: Fix build with !CONFIG_DEBUG_FS
Message-ID: <20190403153639.GA13713@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Yue Haibing <yuehaibing@huawei.com>, robdclark@gmail.com,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
References: <20190403064811.25832-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403064811.25832-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 02:48:11PM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> When building CONFIG_DEBUG_FS is not set
> gcc warn this:
> 
> drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c: In function a6xx_show:
> drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:1124:2: error: implicit declaration of function adreno_show; did you mean adreno_dump? [-Werror=implicit-function-declaration]
>   adreno_show(gpu, state, p);
>   ^~~~~~~~~~~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 1707add81551 ("drm/msm/a6xx: Add a6xx gpu state")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> index e686331..d327eb5 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> @@ -1121,7 +1121,9 @@ void a6xx_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
>  	if (IS_ERR_OR_NULL(state))
>  		return;
>  
> +#if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
>  	adreno_show(gpu, state, p);
> +#endif

I agree that this is a problem, but I think I would prefer if we just made a
stub function for adreno_show instead of doing a inline ifdef, so in
adreno_gpu.c:

#ifdef defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
...
#else
void adreno_show(struct msm_gpu *gpu, msm_gpu_state *state,
	struct drm_printer *p)
{
}
#endif

If you want, I can do a quick patch.

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
