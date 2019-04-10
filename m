Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F82C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9F62082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="omcqnR+4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kUS6Wykh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387797AbfDJQVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:21:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56826 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732371AbfDJQVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:21:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AC28E6110F; Wed, 10 Apr 2019 16:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554913304;
        bh=pNd7lVHHrssL47V9dZX7GhYMXr3besqq7sw8vsZqJPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=omcqnR+4NC3n7AtTWFwiPmvSjPEOsEe5e16tggdiA89xhoCyPQsQE5ytkR3dS9LkO
         pa72V04/pE8jjZlK6EPR0eIqss7sJsUJueqwqoRPLc5dow+NGpuBSU62VXDZFEk3Ro
         rq94+NO2krGkKFj7ULNB5hOBqt7M/Ajw21zxq7CA=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 526B960EA5;
        Wed, 10 Apr 2019 16:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554913303;
        bh=pNd7lVHHrssL47V9dZX7GhYMXr3besqq7sw8vsZqJPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kUS6Wykh9AACpej2G6ljREGjH3oaLvrbxO+ZirV2nI5xUtzsuvxeYPFAXrZsgjbQX
         32EmeA9AAjYe8nAAHexkfQMlOKPfpJDFucUuUTyUkMj8PuC4LRBfAEXhpVUeRTI6Y6
         Sap4VovEB6ruXnqiQHSxe5F69NaGvGu+db37I2EY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 526B960EA5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date:   Wed, 10 Apr 2019 10:21:40 -0600
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sharat Masetty <smasetty@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH 3/7] drm/msm: a5xx: fix possible object reference leak
Message-ID: <20190410162140.GA9296@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Wen Yang <wen.yang99@zte.com.cn>,
        linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sharat Masetty <smasetty@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
References: <1554307455-40361-1-git-send-email-wen.yang99@zte.com.cn>
 <1554307455-40361-4-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554307455-40361-4-git-send-email-wen.yang99@zte.com.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 12:04:11AM +0800, Wen Yang wrote:
> The call to of_get_child_by_name returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> 
> Detected by coccinelle with the following warnings:
> drivers/gpu/drm/msm/adreno/a5xx_gpu.c:57:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 47, but without a corresponding object release within this function.
> drivers/gpu/drm/msm/adreno/a5xx_gpu.c:66:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 47, but without a corresponding object release within this function.
> drivers/gpu/drm/msm/adreno/a5xx_gpu.c:118:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 47, but without a corresponding object release within this function.
> drivers/gpu/drm/msm/adreno/a5xx_gpu.c:57:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 51, but without a corresponding object release within this function.
> drivers/gpu/drm/msm/adreno/a5xx_gpu.c:66:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 51, but without a corresponding object release within this function.
> drivers/gpu/drm/msm/adreno/a5xx_gpu.c:118:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 51, but without a corresponding object release within this function.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Jordan Crouse <jcrouse@codeaurora.org>
> Cc: Mamta Shukla <mamtashukla555@gmail.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Sharat Masetty <smasetty@codeaurora.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: freedreno@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org (open list)


Sorry for the delay. This looks right to me and possibly appropriate for stable
as well.

Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>

> ---
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> index d5f5e56..270da14 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -34,7 +34,7 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname)
>  {
>  	struct device *dev = &gpu->pdev->dev;
>  	const struct firmware *fw;
> -	struct device_node *np;
> +	struct device_node *np, *mem_np;
>  	struct resource r;
>  	phys_addr_t mem_phys;
>  	ssize_t mem_size;
> @@ -48,11 +48,13 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname)
>  	if (!np)
>  		return -ENODEV;
>  
> -	np = of_parse_phandle(np, "memory-region", 0);
> -	if (!np)
> +	mem_np = of_parse_phandle(np, "memory-region", 0);
> +	of_node_put(np);
> +	if (!mem_np)
>  		return -EINVAL;
>  
> -	ret = of_address_to_resource(np, 0, &r);
> +	ret = of_address_to_resource(mem_np, 0, &r);
> +	of_node_put(mem_np);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.9.5
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
