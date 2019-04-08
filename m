Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992C6C282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6794820880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aIcd4DoW";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lx6EIUR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfDHIqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:46:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52138 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfDHIqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:46:09 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9934A60131; Mon,  8 Apr 2019 08:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554713168;
        bh=EMEIQEKJTNwNbWQeCZv3+1KkAY8TRGlmFR9uZ8/nMzo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aIcd4DoWc3PW0U6CWfT2viqDqRwj4t3HnQUeSouLuRcs+CmdZ2qcqpqfZHaqRH+yS
         B3eHdFwnAXFAhYJX6U0XLFKmHtDNxIQ85H7HXIVh4cyBmOmhiVUwwp/fDtmwbjk9nD
         TMMdk3XaosuEXqDuynK6YJwsPvuEEFE1KzclGw4E=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AE75A60FEA;
        Mon,  8 Apr 2019 08:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554713165;
        bh=EMEIQEKJTNwNbWQeCZv3+1KkAY8TRGlmFR9uZ8/nMzo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lx6EIUR2+ewPHs6CBWjVV82bigLoLtJDTImg6dGPOwW1CzjGO1tuYTznO6O7wJnjW
         4oYxT9OcTlPEvJ0RikSgpB2wbtBm6fEpkxI7lG23WpzaJgb5czftojQu69UiN/4dT4
         rozDIJ5yGyOFl2nyYn+Ir1U3FcHox5p+e0Z7ekCo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE75A60FEA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2] drm: rcar-du: fix possible object reference leak
To:     Wen Yang <wen.yang99@zte.com.cn>, linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
References: <1554692313-28882-1-git-send-email-wen.yang99@zte.com.cn>
 <1554692313-28882-3-git-send-email-wen.yang99@zte.com.cn>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <c794daff-aca2-b3e7-cf19-e79b1cae7a0e@codeaurora.org>
Date:   Mon, 8 Apr 2019 14:15:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554692313-28882-3-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/8/2019 8:28 AM, Wen Yang wrote:
> The call to of_get_parent returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
>
> Detected by coccinelle with the following warnings:
> drivers/gpu/drm/rcar-du/rcar_du_of.c:235:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 216, but without a corresponding object release within this function.
> drivers/gpu/drm/rcar-du/rcar_du_of.c:236:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 209, but without a corresponding object release within this function.
>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org (open list)
> ---
> v2->v1: turn the return into a goto done.
>
>   drivers/gpu/drm/rcar-du/rcar_du_of.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_of.c b/drivers/gpu/drm/rcar-du/rcar_du_of.c
> index afef696..782bfc7 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_of.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_of.c
> @@ -232,7 +232,7 @@ static void __init rcar_du_of_lvds_patch(const struct of_device_id *of_ids)
>   	lvds_node = of_find_compatible_node(NULL, NULL, compatible);
>   	if (lvds_node) {
>   		of_node_put(lvds_node);
> -		return;
> +		goto done;
>   	}
>   


you might have to create multiple level to do handling it.. there are 
unnecessary put being done on "done" which is not valid

for this case.

-Mukesh

>   	/*
