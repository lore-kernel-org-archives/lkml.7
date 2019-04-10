Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8550BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567FC2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBV9PJJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731918AbfDJSub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:50:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33285 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbfDJSua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:50:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id k19so2101843pgh.0;
        Wed, 10 Apr 2019 11:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TDrXnyIs8oOL7DcF64n3ORZvYUJp5oWfgvqC2wsWW9Q=;
        b=UBV9PJJriLPA8Q7cxq/oyO4jIW3KXkwu9lcfODese2STtUj7NEOcRwMXoguzPtzDal
         mo4ECQRWwbIqTHCtNj2ruy+Ckgrg4Hll/ozyPUhhqN1xopWqxCYTFOn5eqjyUpC8aRmN
         GnltGflQKx1S09mDD10PdgJg8vin0VY9KY6VJE6ugXBX36ymtcMePD3H2n5+ssGp4yji
         79WX/dHzbj4VkkJqn4qzbwQnYfbSZq7wVhr8XVE4pmUb9+EjcOQpGR4YGjHt027Ibfka
         ebQ1+ewEvkB49uVFTFlyMRCDsnRYU63ADYjJ26X/zcw4pXGspfZRfH7uuVx18VGF1H6c
         6Ccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TDrXnyIs8oOL7DcF64n3ORZvYUJp5oWfgvqC2wsWW9Q=;
        b=Rv/iDMMOmFHGykuOExnOmHHGABrrmO81I0d524BWlpuFFT2AKU4rh1K+KN3dNTkcid
         tD+jY2Eo9JAy397zajBowljR2sthl2sui+zqHOSUKV1n3h5CFdrGLA64fxm3ojvynMou
         Y2wVm0yE1s8Dkd4jygYrXwBRq4Pws04OC37+w5rxeMNJeVeMZzN8Lztbi5ZL4TzLrwND
         PfpjolIszQ9Tuwlj+T5X0Mar2bbq/V0C+XyfSliPfLFnV/TTTPgbaJJUvpOwOdk9Z6Os
         0EzCwMqLfRdflxjpM9ZxR32FazHtptr8eQYUH/zOpLVoWhGuqe6BdWmAE/mX5v9P7pPU
         nIrQ==
X-Gm-Message-State: APjAAAV1esNJDgg1itSUZkvEbaAw06Kt29bYOQRyd1A6No81+7/ZEiqb
        hjw3SDM72DYHSwGYiv6/efU=
X-Google-Smtp-Source: APXvYqy43fuM/1JqTWcuORCFicdTm7XWtWcTHU1OcUQWzPaWJesBeLbQzJ83lRxEQJE60KfmfK/NQg==
X-Received: by 2002:a63:cc0d:: with SMTP id x13mr7213861pgf.280.1554922229857;
        Wed, 10 Apr 2019 11:50:29 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id a8sm61667389pfo.144.2019.04.10.11.50.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 11:50:29 -0700 (PDT)
Subject: Re: [PATCH] of: del redundant type conversion
To:     xiaojiangfeng <xiaojiangfeng@huawei.com>, robh+dt@kernel.org,
        robh@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1554884981-20309-1-git-send-email-xiaojiangfeng@huawei.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <8835e19b-e63b-41c9-7c87-1d68a130a319@gmail.com>
Date:   Wed, 10 Apr 2019 11:50:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1554884981-20309-1-git-send-email-xiaojiangfeng@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 1:29 AM, xiaojiangfeng wrote:
> The type of variable l in early_init_dt_scan_chosen is
> int, there is no need to convert to int.
> 
> Signed-off-by: xiaojiangfeng <xiaojiangfeng@huawei.com>
> ---
>  drivers/of/fdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 4734223..de893c9 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1091,7 +1091,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>  	/* Retrieve command line */
>  	p = of_get_flat_dt_prop(node, "bootargs", &l);
>  	if (p != NULL && l > 0)
> -		strlcpy(data, p, min((int)l, COMMAND_LINE_SIZE));
> +		strlcpy(data, p, min(l, COMMAND_LINE_SIZE));
>  
>  	/*
>  	 * CONFIG_CMDLINE is meant to be a default in case nothing else
> 

Thanks for catching the redundant cast.

There is a second problem detected by sparse on that line:

  drivers/of/fdt.c:1094:34: warning: expression using sizeof(void)

Can you please fix both issues?

Thanks,

Frank
