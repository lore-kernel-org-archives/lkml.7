Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEBBC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 22:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4A9206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 22:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="K9jUC5ZV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RnSnNj1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfDYWww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 18:52:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57506 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfDYWww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 18:52:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2B62660252; Thu, 25 Apr 2019 22:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556232771;
        bh=D5eGQwtPsK+KFB8H0bbBPZv1fYvpokAlLVAkWuAxFGs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K9jUC5ZVQC5yhos2xgDlNDI15RmnqrfWcAsGcPKz/7Qi0LzVwzRgTAa7M7cXdjFSQ
         +YE1+sX2Ho58QIRxeBW9qSz/+PSFAcpfrq9goYOQWu6gbUqz8GDqJR7Z7uCMYvuQEr
         06xFPiRhbSqsiIw6h5C2f8amcDhljAMPsF7/olUg=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6B4A760746;
        Thu, 25 Apr 2019 22:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556232770;
        bh=D5eGQwtPsK+KFB8H0bbBPZv1fYvpokAlLVAkWuAxFGs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RnSnNj1To+jl8lzHTtFl0znyUO85DwTDUhMtJHKUprCyApnyHL3uwY/YTv6NLp26A
         wY8OW5CILNGuuMQ0TWTCrFJ/mNWQb3wX0v8/pmgmwYgKYdUDZV+aKRAQQXKEWDc/6K
         b2d8YRBcw4M8DyhT1lbLi1FeHFWvn4N0cX2xIcCU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 25 Apr 2019 15:52:50 -0700
From:   Abhinav Kumar <abhinavk@codeaurora.org>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Rob Clark <robdclark@gmail.com>, freedreno@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Sean Paul <sean@poorly.run>, Daniel Mack <daniel@zonque.org>
Subject: Re: [Freedreno] [PATCH] drm/msm: check for equals 0 only
In-Reply-To: <1556201031-3676-1-git-send-email-hofrat@osadl.org>
References: <1556201031-3676-1-git-send-email-hofrat@osadl.org>
Message-ID: <7dc496f1663fa788977b8b00bce9d695@codeaurora.org>
X-Sender: abhinavk@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-25 07:03, Nicholas Mc Guire wrote:
> wait_for_completion_timeout() returns 0 on timeout and aleast 1 
> otherwise
> so checking for < makes no sense here.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
> ---
> 
> Problem located with an experimental coccinelle script
> 
> While this check does no harm in this form - it should be fixed anyway
> to comply with the API see: kernel/sched/completion.c
> 
> Also noticed that get_maintainer.pl will not list 
> linux-kernel@vger.kernel.org
> when run on drivers/gpu/drm/msm/dsi/dsi_host.c - is that intentional ?
> 
> Patch was compile-tested with: qcom_defconfig (implies DRM_MSM_DSI=y)
> 
> Patch is against v5.1-rc6 (localversion-next is next-20190424)
> 
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c
> b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 610183d..dc16067 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -1049,7 +1049,7 @@ static void dsi_wait4video_done(struct
> msm_dsi_host *msm_host)
>  	ret = wait_for_completion_timeout(&msm_host->video_comp,
>  			msecs_to_jiffies(70));
> 
> -	if (ret <= 0)
> +	if (ret == 0)
>  		DRM_DEV_ERROR(dev, "wait for video done timed out\n");
> 
>  	dsi_intr_ctrl(msm_host, DSI_IRQ_MASK_VIDEO_DONE, 0);
