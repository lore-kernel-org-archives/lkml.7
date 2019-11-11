Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC532C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9CF2196E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WVIiS1ht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKKXXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 18:23:33 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32896 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfKKXXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 18:23:32 -0500
Received: by mail-pf1-f196.google.com with SMTP id c184so11880914pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 15:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oxtWsgiaO9hHHOVbAZFAfeAu9Vd1us+o4hytJ/76qh8=;
        b=WVIiS1htKtiPT6uonxisyXROD5bdwFNUZa/VU6hfGvdDaLOZHCF0BC9QpZWxCsm8RR
         Cji/2MyjHJeoBE8CgavCUOufGHPQylgTOLFEju+ySNDsUWFHbLW2dFMs9wQbcVG+05L4
         y3rW8HNOnethEc+GdYFOjIAu00B7/vVLwgfq5AYHhWbMCm18wueGFkryCv8OWVhxsW/4
         SPy9MXmkLVAwolCGB2Hnl2RT/UaztknU8OdWpjnCiddO5B85X/DoK2Pa33naS74tVHzU
         YXzCJtzAhn0WGuz3PdgFuOk0a0/IrN174kR2NMbx7QA8Zp8lSALC4vhMSn2XLq1xgv0v
         uwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oxtWsgiaO9hHHOVbAZFAfeAu9Vd1us+o4hytJ/76qh8=;
        b=XixM+/1EuiXdZD1+7xYO5J75VYK9xw1cG8ED/M3I8iRk4vvp4X/Z69M6HHtP5HgsF8
         iBHKdfjzltaq8A2ZtZSNGg87dvrAaKh953cFByLpMVKjxHx2ONFD+iIdkiZk2kgo78TJ
         zEFfT9rnSnBwepK8uk5lRL8/NVJjniVi13dGfzvqXtbxLNZDnF5CEic/BT55AZ1z/k+5
         M3fVzsWCd1Fn1aYoM/pXdypqwCFv3toc8Ey5JGPOZnzPbpub786D5NmBqrgR+LBF8y3L
         8NOydxnzO+Xb0Dd+wuu9Om0NaJCKeHaokTwcgnMOVcg64FQ2SH2NHc7AqmRg712tdcyu
         bjog==
X-Gm-Message-State: APjAAAVDziloJffM0nnLp0+c955MyJgoCsAXLhoZRz1u/5F8gGE+9oTK
        9G76xtf49IGgDW/JE1HQMYpO7w==
X-Google-Smtp-Source: APXvYqz3B8XfN3Nk5agppRnf//5mkG5LcoEJl4JIWX+jPdh1NoxipVBwsaA0WQ963B99tJZTRos6rg==
X-Received: by 2002:a17:90a:600f:: with SMTP id y15mr2129151pji.82.1573514611994;
        Mon, 11 Nov 2019 15:23:31 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r33sm489545pjb.5.2019.11.11.15.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 15:23:31 -0800 (PST)
Date:   Mon, 11 Nov 2019 15:23:29 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        s-anna@ti.com
Subject: Re: [PATCH 07/17] remoteproc/omap: Initialize and assign reserved
 memory node
Message-ID: <20191111232329.GI3108315@builder>
References: <20191028124238.19224-1-t-kristo@ti.com>
 <20191028124238.19224-8-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028124238.19224-8-t-kristo@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28 Oct 05:42 PDT 2019, Tero Kristo wrote:

> From: Suman Anna <s-anna@ti.com>
> 
> The reserved memory nodes are not assigned to platform devices by
> default in the driver core to avoid the lookup for every platform
> device and incur a penalty as the real users are expected to be
> only a few devices.
> 
> OMAP remoteproc devices fall into the above category and the OMAP
> remoteproc driver _requires_ specific CMA pools to be assigned
> for each device at the moment to align on the location of the
> vrings and vring buffers in the RTOS-side firmware images. So,
> use the of_reserved_mem_device_init/release() API appropriately
> to assign the corresponding reserved memory region to the OMAP
> remoteproc device. Note that only one region per device is
> allowed by the framework.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/remoteproc/omap_remoteproc.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
> index 0524f7e0ffa4..0b80570effee 100644
> --- a/drivers/remoteproc/omap_remoteproc.c
> +++ b/drivers/remoteproc/omap_remoteproc.c
> @@ -17,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/err.h>
>  #include <linux/of_device.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/remoteproc.h>
> @@ -454,14 +455,22 @@ static int omap_rproc_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto free_rproc;
>  
> +	ret = of_reserved_mem_device_init(&pdev->dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "device does not have specific CMA pool\n");
> +		goto free_rproc;
> +	}
> +
>  	platform_set_drvdata(pdev, rproc);
>  
>  	ret = rproc_add(rproc);
>  	if (ret)
> -		goto free_rproc;
> +		goto release_mem;
>  
>  	return 0;
>  
> +release_mem:
> +	of_reserved_mem_device_release(&pdev->dev);
>  free_rproc:
>  	rproc_free(rproc);
>  	return ret;
> @@ -473,6 +482,7 @@ static int omap_rproc_remove(struct platform_device *pdev)
>  
>  	rproc_del(rproc);
>  	rproc_free(rproc);
> +	of_reserved_mem_device_release(&pdev->dev);
>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
