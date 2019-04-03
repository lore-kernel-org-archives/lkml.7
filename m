Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B362FC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817CC20882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZmyutuHe";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Wjua8/Sx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfDCI7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:59:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43550 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDCI7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:59:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3360D6155F; Wed,  3 Apr 2019 08:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554281950;
        bh=fW4jmanjES6ir5RgWoO84NJy4jTJHtyauuRXo5lBlos=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZmyutuHeOaWzBqRMYq7I0OeYMVLSM1T3rFt8gjEe+/0vrxKSJzuZDqybL+kvJPGla
         Axd36kfJJmLBsJVDgPL+RvL9Ackgn+0OD/Mk2uejciNZEzBjeEBgukwIMNcTapo3Y/
         p2Q5jJEu+Vnw5+VGJZtKeWhXSoLb2ZX+5gMAkl9c=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 054F061214;
        Wed,  3 Apr 2019 08:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554281940;
        bh=fW4jmanjES6ir5RgWoO84NJy4jTJHtyauuRXo5lBlos=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Wjua8/SxfCkRoThkQxnC7Al64hkaAO5QEBK+kXoOXMXsMy/iU3HLWf/laZZToFBuE
         IfUusLI9DPEzQzZh/9mdmE86DpaM8J3VNHK86FpRsnA37BUyd/bAsc42S1rK6Naxux
         Y72seXOtJUltDBKw++s6Vrm8GVTOCWxq3wZwyuMs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 054F061214
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] drm/msm/a6xx: Fix build with !CONFIG_DEBUG_FS
To:     Yue Haibing <yuehaibing@huawei.com>, robdclark@gmail.com,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        jcrouse@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
References: <20190403064811.25832-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <58fdea0d-6c6c-e7dc-0be7-80df9f565250@codeaurora.org>
Date:   Wed, 3 Apr 2019 14:28:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403064811.25832-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/3/2019 12:18 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> When building CONFIG_DEBUG_FS is not set
> gcc warn this:
>
> drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c: In function a6xx_show:
> drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:1124:2: error: implicit declaration of function adreno_show; did you mean adreno_dump? [-Werror=implicit-function-declaration]
>    adreno_show(gpu, state, p);
>    ^~~~~~~~~~~
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 1707add81551 ("drm/msm/a6xx: Add a6xx gpu state")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> index e686331..d327eb5 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> @@ -1121,7 +1121,9 @@ void a6xx_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
>   	if (IS_ERR_OR_NULL(state))
>   		return;
>   
> +#if defined(CONFIG_DEBUG_FS) || defined(CONFIG_DEV_COREDUMP)
>   	adreno_show(gpu, state, p);
> +#endif
>   
>   	drm_puts(p, "registers:\n");
>   	for (i = 0; i < a6xx_state->nr_registers; i++) {
