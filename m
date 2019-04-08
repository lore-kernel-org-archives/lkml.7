Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C70C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA3020880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cDvz/JfV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XOiXUkJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbfDHIty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:49:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56356 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfDHItx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:49:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C114F6043F; Mon,  8 Apr 2019 08:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554713392;
        bh=qZa5QtoDvEoBFWmWhgGfqwfNqvCgfFwncawFB8UPxkQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cDvz/JfVmL/UM/pHgAJ/Kl4PUow8z2IhldhjT7FoWmP+8YAkWRm/8EJnV0jfAD4Qn
         pTRmjkuGQINUaDWWYeuATLMVLSKqyTz7LxnffyjM3esL8HmyzvB2O6wqHR9Czyw8JJ
         J+7Kd51BM7e5LUMYsrLSUYMzJiK4OQ4jqXjtAA6M=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5D764612F1;
        Mon,  8 Apr 2019 08:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554713376;
        bh=qZa5QtoDvEoBFWmWhgGfqwfNqvCgfFwncawFB8UPxkQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XOiXUkJE4AXbWyCIAc1fjCT0GRv6oMbE4LwFw0juI+ZCx95t/EVJn4S5xr/Vvpw/+
         f9yrzgchPrft95/6dShYUmMdjDXSsHKdipipTQp8UJMs6k2M3ijIiLZE9LNQN9xJ7n
         w/tfbkLTVQjpFbTAgk7HVzQE+v0Ps26E3JXOAa7E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D764612F1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2] drm/omap: fix possible object reference leak
To:     Wen Yang <wen.yang99@zte.com.cn>, linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org,
        Markus Elfring <Markus.Elfring@web.de>
References: <1554692313-28882-1-git-send-email-wen.yang99@zte.com.cn>
 <1554692313-28882-2-git-send-email-wen.yang99@zte.com.cn>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <60d46048-950a-f6f1-0242-bcbfb093b647@codeaurora.org>
Date:   Mon, 8 Apr 2019 14:19:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554692313-28882-2-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/8/2019 8:28 AM, Wen Yang wrote:
> The call to of_find_matching_node returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
>
> Detected by coccinelle with the following warnings:
> drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c:212:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 209, but without a corresponding object release within this function.
> drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c:237:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 209, but without a corresponding object release within this function.
>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Markus Elfring <Markus.Elfring@web.de>
> ---
> v2->v1: add a jump target.
>
>   drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c b/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
> index 2b41c75..13b3b4a 100644
> --- a/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
> +++ b/drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
> @@ -209,7 +209,7 @@ static int __init omapdss_boot_init(void)
>   	dss = of_find_matching_node(NULL, omapdss_of_match);
>   
>   	if (dss == NULL || !of_device_is_available(dss))
> -		return 0;
> +		goto put_node;
>   
>   	omapdss_walk_device(dss, true);
>   
> @@ -234,6 +234,8 @@ static int __init omapdss_boot_init(void)
>   		kfree(n);
>   	}
>   
> +put_node:
> +	of_node_put(dss);
>   	return 0;
>   }
>   
