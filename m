Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2026C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF3320651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="To0p/iLH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nI4Ff8NR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbfC0PJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:09:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39642 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfC0PJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:09:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 09B33605A2; Wed, 27 Mar 2019 15:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553699373;
        bh=k+haHaRe1TZOHBANroUtcnh4q6SKSmDcIMaVCROLxSI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=To0p/iLHfEGsJtGfzOLUaUdGU05k2RIqQDycKEo14ga5oqr+eIG7AkbBm9QAxFu34
         6Isax1qw3TywRLiMIES6EUlSOXthlEVhHxh5nIsP94cxeV4XbIAZvG9Z9Di+EKWCTY
         1SLoPSa/XsewZaUOcB78PN0sDLpFRTBEZkRrAnhM=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E7708608A5;
        Wed, 27 Mar 2019 15:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553699372;
        bh=k+haHaRe1TZOHBANroUtcnh4q6SKSmDcIMaVCROLxSI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nI4Ff8NR7xQWTpfD3Eu4ECItkSY52vtFLa2QjSl8RGcC+Lx92UsLb+eBSdjlAESZr
         2htfRFXuiZ9IZr3DzxFeakP8nScgCRt91oWAsK1WeMFmocbngOHlfRG4HY/JM4KHVi
         QDCxSuTztWLTycsgCQIiG5hKrrKPAlIMC2iGtONU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E7708608A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] gpu: v3d: fix a missing check of pm_runtime_get_sync
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Eric Anholt <eric@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190324231602.2436-1-kjlu@umn.edu>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <a2cf16d9-a4a0-6c64-4733-6acaf413af56@codeaurora.org>
Date:   Wed, 27 Mar 2019 20:39:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190324231602.2436-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/25/2019 4:46 AM, Kangjie Lu wrote:
> pm_runtime_get_sync could fail and thus deserves a check.
>
> The patch adds such a check and return its error code upstream
> if it indeed failed.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh
> ---
>   drivers/gpu/drm/v3d/v3d_drv.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
> index f0afcec72c34..99daad11fac2 100644
> --- a/drivers/gpu/drm/v3d/v3d_drv.c
> +++ b/drivers/gpu/drm/v3d/v3d_drv.c
> @@ -101,6 +101,8 @@ static int v3d_get_param_ioctl(struct drm_device *dev, void *data,
>   			return -EINVAL;
>   
>   		ret = pm_runtime_get_sync(v3d->dev);
> +		if (ret < 0)
> +			return ret;
>   		if (args->param >= DRM_V3D_PARAM_V3D_CORE0_IDENT0 &&
>   		    args->param <= DRM_V3D_PARAM_V3D_CORE0_IDENT2) {
>   			args->value = V3D_CORE_READ(0, offset);
