Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F204C742A4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 18:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FB8208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 18:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eH2KfA7r";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NjoLyXsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbfGKSqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 14:46:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39580 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731077AbfGKSqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 14:46:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5F98C60E3F; Thu, 11 Jul 2019 18:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562870793;
        bh=EI1jgjG1YbcgyKV2IhlRjah8r6n6987BfEr7/Z60RmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eH2KfA7r5C37gX8OFVL3fxYX5YC6+AQ0ZwZ9pIUgSX4ttp08S94unKocEes4/ZBE4
         UDv7to+xLtAr/idZo5Torz+KV3kil2gVKF/UzLeM6BaTmCy+byqSylSFtAzbtlRUeF
         GLY2sD6YkfSITqugaPyQX6MCUxnDjlh69KZZmelA=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D127C60E40;
        Thu, 11 Jul 2019 18:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562870792;
        bh=EI1jgjG1YbcgyKV2IhlRjah8r6n6987BfEr7/Z60RmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NjoLyXsNlzpxotdgrYjsR//97d+kvvvs+UcjswWxQMQqnttEhPHK1vTSMAAlTfRHA
         5LSgqhaOmInCX0eeFcpyF5iHKpLea65MhHt+t/1v/nHZ6Zkp2vbl4NS9IwiRO7PnXb
         CbTYjQsSFqMNIER6gT6g7WfankxsdeuUBB225vP4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D127C60E40
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Thu, 11 Jul 2019 12:46:30 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Paul <sean@poorly.run>,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH 1/3] drm/msm: don't open-code governor name
Message-ID: <20190711184629.GB26247@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sean Paul <sean@poorly.run>,
        freedreno@lists.freedesktop.org
References: <20190630131445.25712-1-robdclark@gmail.com>
 <20190630131445.25712-2-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190630131445.25712-2-robdclark@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 30, 2019 at 06:14:41AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>

Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/msm/msm_gpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index 0a4c77fb3d94..e323259a16d3 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -106,7 +106,7 @@ static void msm_devfreq_init(struct msm_gpu *gpu)
>  	 */
>  
>  	gpu->devfreq.devfreq = devm_devfreq_add_device(&gpu->pdev->dev,
> -			&msm_devfreq_profile, "simple_ondemand", NULL);
> +			&msm_devfreq_profile, DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL);
>  
>  	if (IS_ERR(gpu->devfreq.devfreq)) {
>  		DRM_DEV_ERROR(&gpu->pdev->dev, "Couldn't initialize GPU devfreq\n");
> -- 
> 2.20.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
