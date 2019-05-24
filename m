Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D65C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E862020675
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="axT/Z4Pe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389627AbfEXIdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:33:18 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15383 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389297AbfEXIdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:33:17 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce7ac4d0001>; Fri, 24 May 2019 01:33:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 24 May 2019 01:33:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 24 May 2019 01:33:17 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 May
 2019 08:33:15 +0000
Subject: Re: [PATCH] tegra_wm9712: Fix a memory leaking bug in
 tegra_wm9712_driver_probe()
To:     Gen Zhang <blackgod016574@gmail.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>
CC:     <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190524005014.GA2289@zhanggen-UX430UQ>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b2d43dfe-17e5-a975-435b-49f2aa2ad550@nvidia.com>
Date:   Fri, 24 May 2019 09:33:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524005014.GA2289@zhanggen-UX430UQ>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558686797; bh=vkCEueUAPlP/apgkFiyHjF374bXH/u7KlllgHip5zNw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=axT/Z4PeCAsNFCG1WqGLPh67ItaiJrqmcFul0qH19p84KXDA55OvlN4ub0AM0L0J1
         teyY8/SXfwb1dxPxEpSaeXje2VopUqvGzYWk6+mU1CtAGG1BbTQiUKDfDOPhexo7mc
         sJEqJMze0K4TiJKqMopCFG6TfZXtJJB3DI/bIMsQbEwfnEbyjSINU0WE9lzfTnv5mY
         Qaagp1ceWr+Q/+ct/YMtiaxD8m+09fWb5geSwovhV7gscDHq2fl6l7Xefn60virDA1
         A+SzHmxXgCnuhmFukoFr72M7KJCZUt7LN/30gwE3Wv/YePiHE6xi849yvhFBzI6nhq
         c27aizYhUb+2w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/05/2019 01:50, Gen Zhang wrote:
> In tegra_wm9712_driver_probe(), 'machine->codec' is allocated by
> platform_device_alloc(). When it is NULL, function returns ENOMEM.
> However, 'machine' is allocated by devm_kzalloc() before this site.
> Thus we should free 'machine' before function ends to prevent memory
> leaking.

Memory allocated by devm_xxx() is automatically freed on failure so this
is not correct.

> Further, we should free 'machine->util_data', 'machine->codec' and
> 'machine' before this function normally ends to prevent memory leaking.

This is also incorrect. Why would we free all resources after
successfully initialising the driver?

> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> ---
> diff --git a/sound/soc/tegra/tegra_wm9712.c b/sound/soc/tegra/tegra_wm9712.c
> index 864a334..295c41d 100644
> --- a/sound/soc/tegra/tegra_wm9712.c
> +++ b/sound/soc/tegra/tegra_wm9712.c
> @@ -86,7 +86,8 @@ static int tegra_wm9712_driver_probe(struct platform_device *pdev)
>  	machine->codec = platform_device_alloc("wm9712-codec", -1);
>  	if (!machine->codec) {
>  		dev_err(&pdev->dev, "Can't allocate wm9712 platform device\n");
> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto codec_free;
>  	}
>  
>  	ret = platform_device_add(machine->codec);
> @@ -127,6 +128,10 @@ static int tegra_wm9712_driver_probe(struct platform_device *pdev)
>  		goto asoc_utils_fini;
>  	}
>  
> +	tegra_asoc_utils_fini(&machine->util_data);
> +	platform_device_del(machine->codec);
> +	platform_device_put(machine->codec);
> +	devm_kfree(&pdev->dev, machine);
>  	return 0;

As stated above, this is incorrect.

Did you actually test this? I think you would find this would break the
driver.

Jon

-- 
nvpublic
