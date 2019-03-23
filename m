Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B46C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 10:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9432196F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 10:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CgywDg93";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CgywDg93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfCWKF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 06:05:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54246 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfCWKF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 06:05:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C641060744; Sat, 23 Mar 2019 10:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553335525;
        bh=pBdEEZubPvVz719nusovDIQoBewY7OeC40ze3oeECVc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CgywDg93c124f0WqbXTF9OjEszoU1DiYv8pxN3la4nRwDzKtLvIBZd9RSeUtrwC2T
         7/nLv29rEzzu22ee+XBrq9u9bdm246oEzPXJ/l07hZlgJtSQ3gXIZoKVJ+lMcT5MO4
         8LbBXwILhxZyhKpevSC70iaP4Gs18rczmmvHmO4g=
Received: from [10.79.165.251] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CDF8D60A43;
        Sat, 23 Mar 2019 10:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553335525;
        bh=pBdEEZubPvVz719nusovDIQoBewY7OeC40ze3oeECVc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CgywDg93c124f0WqbXTF9OjEszoU1DiYv8pxN3la4nRwDzKtLvIBZd9RSeUtrwC2T
         7/nLv29rEzzu22ee+XBrq9u9bdm246oEzPXJ/l07hZlgJtSQ3gXIZoKVJ+lMcT5MO4
         8LbBXwILhxZyhKpevSC70iaP4Gs18rczmmvHmO4g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CDF8D60A43
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] drm: vkms: check status of alloc_ordered_workqueue
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190309043628.6078-1-kjlu@umn.edu>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <955fbabe-e5f2-cfff-8dfd-1730243b0fff@codeaurora.org>
Date:   Sat, 23 Mar 2019 15:35:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190309043628.6078-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/9/2019 10:06 AM, Kangjie Lu wrote:
> alloc_ordered_workqueue may fail and return NULL.
> The fix returns ENOMEM when it fails to avoid potential NULL
> pointer dereference.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>   drivers/gpu/drm/vkms/vkms_crtc.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index 8a9aeb0a9ea8..bb66dbcd5e3f 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -219,6 +219,8 @@ int vkms_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
>   	spin_lock_init(&vkms_out->state_lock);
>   
>   	vkms_out->crc_workq = alloc_ordered_workqueue("vkms_crc_workq", 0);
> +	if (!vkms_out->crc_workq)
> +		return -ENOMEM;
>   
>   	return ret;
>   }


Check the clean up path more carefully, you have undo which you have 
done successfully in drm_crtc_init_with_planes.


Thanks,
  Mukesh

