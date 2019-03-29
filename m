Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB96C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65132183E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 06:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TzBdHLN7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DHvjLmdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfC2G5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 02:57:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49910 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728651AbfC2G5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 02:57:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A882D60A24; Fri, 29 Mar 2019 06:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553842640;
        bh=1gxmQxuk3yyax1HdDebP5caU2lwb2VCo51Y4et8nY0c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TzBdHLN7frw0nQwa7XB7Bt4VBgtX3k+vntnZw/SRiNOC7P+SY4I4YDLblIUFObycO
         26S/cPaXfU0O2ahGcPOF4vw+amDnYkvjhsH7yee/um8WYQU8iWqbJUC60pNHSGujHI
         8v1+25deiF40dwKERCKx9haF8Xli/z8FzqFpsGX8=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 097F760A42;
        Fri, 29 Mar 2019 06:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553842635;
        bh=1gxmQxuk3yyax1HdDebP5caU2lwb2VCo51Y4et8nY0c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DHvjLmduL4COoHYJNm0nQ1RxWRjjacFzT/Vq81TraWmN/oovrqn7ZGfuh6udZefXo
         nBvlilZDL15db2SF3Y2yhMj5sE3I6YLUYvhyfi4ceD9ab7utoyqesnpqg6lu1w3lrZ
         OP+E0sdNdYUJNLt/H3f9/da8vzTmShegZjKmc4EA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 097F760A42
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] drm/omap: Use PTR_ERR_OR_ZERO in hdmi4_core_init()
To:     YueHaibing <yuehaibing@huawei.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Matteo Croce <mcroce@redhat.com>,
        Benoit Parrot <bparrot@ti.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190329014136.20318-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <f99b8eb0-b758-7781-8bd8-bb1c95ecb8fa@codeaurora.org>
Date:   Fri, 29 Mar 2019 12:27:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190329014136.20318-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/29/2019 7:11 AM, YueHaibing wrote:
> Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
>   drivers/gpu/drm/omapdrm/dss/hdmi4_core.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c b/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
> index e384b95ad857..8287ade5ece0 100644
> --- a/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
> +++ b/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
> @@ -934,8 +934,5 @@ int hdmi4_core_init(struct platform_device *pdev, struct hdmi_core_data *core)
>   
>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "core");
>   	core->base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(core->base))
> -		return PTR_ERR(core->base);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(core->base);
>   }



>
>
>
>
>
