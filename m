Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DC8C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E845E214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S8WtfFat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfKKXh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 18:37:59 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40536 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfKKXh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 18:37:59 -0500
Received: by mail-pg1-f196.google.com with SMTP id 15so10500036pgt.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 15:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MsnyjGFe6RoiVQKxeXrC3wHfBh1UTFjBzfDKoYAlahU=;
        b=S8WtfFatOtmT/GYrH3OBgXecciof/Mcr4gZQnwNxMA3666p1bhHqhvCndv8c2DlY7q
         2kMoiBzCNzN7UR5v7AvHz2o0lho1jwLz6hjrUQ3PhN3zUqItyAmj5AisrDI9UqZMvlaX
         FY/hy1nTwVBEsA9TA1k2BH7SXj/xO3sfDhvWf9gKS6brwkA3Vnpx5FiqUvyjbI/L1Lxj
         JrwQFiq8BVR5X0ERDnWS5AaauyJwDlUeUmw8wS9pQeiNjHledSOilU4ymbnYkHELComI
         GJ5XgaDM6LQpK/qqRoCqVtqaJ3sZzzgUQZ4GUiTe3PxfOgGClgRNc2TIzOsc6r+D5ctp
         WYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MsnyjGFe6RoiVQKxeXrC3wHfBh1UTFjBzfDKoYAlahU=;
        b=QaTKA0mEXGaH8eG917daNtptMcaawkVdZuuC+ptDMKddSthKSihx2NNhOfu0ZfrSY8
         SmAhihE65tYG06Oyi0nlMQNHJfnSL8Pi22Baa95+K4li8G9IzyKselPRN06AZbOXyI3Z
         2YuVcmIFNox0CxhnYs3HNOOUc3aH62q68aXi9eJlRJegOaXp+7CNdHWPzWpqkvGxMtdA
         UL1KrTLqKsr6DQFADLYnQFMznePfFPojbNobHDsizr0z3pbRvAE9OO6vIvKmjZEkCFdt
         SJ5VCbZ49fr8aH7nQFXEP7dXRxWq397fRNbX9BwdxNKLNiXptAR8wXIkgAXLC4i093Q3
         0GuA==
X-Gm-Message-State: APjAAAWOPN+95/rOVKwNsZQR41wSJew+jibZ9u8MsNkRvQJOWoQhHOiJ
        3fvZlSS4o0f4bAxoXf6IpgJghQ==
X-Google-Smtp-Source: APXvYqwedNiuHkmNSgCLK8ShDTISGvxxcBN5EaxdEjPwwrqGPB5ZaDfrLAVVlA43jyjQsBOdHSpRUA==
X-Received: by 2002:a62:e219:: with SMTP id a25mr32268779pfi.252.1573515478601;
        Mon, 11 Nov 2019 15:37:58 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x2sm16623628pfn.167.2019.11.11.15.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 15:37:58 -0800 (PST)
Date:   Mon, 11 Nov 2019 15:37:56 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        s-anna@ti.com
Subject: Re: [PATCH 10/17] remoteproc/omap: Remove the omap_rproc_reserve_cma
 declaration
Message-ID: <20191111233756.GL3108315@builder>
References: <20191028124238.19224-1-t-kristo@ti.com>
 <20191028124238.19224-11-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028124238.19224-11-t-kristo@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28 Oct 05:42 PDT 2019, Tero Kristo wrote:

> From: Suman Anna <s-anna@ti.com>
> 
> The omap_rproc_reserve_cma() function is not defined at the moment.
> This prototype was to be used to define a function to declare a
> remoteproc device-specific CMA pool.
> 
> The remoteproc devices will be defined through DT going forward. A
> device specific CMA pool will be defined under the reserved-memory
> node, and will be associated with the appropriate remoteproc device
> node. This function prototype will no longer be needed and has
> therefore been cleaned up.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  include/linux/platform_data/remoteproc-omap.h | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/include/linux/platform_data/remoteproc-omap.h b/include/linux/platform_data/remoteproc-omap.h
> index 6bea01e199fe..49c78805916f 100644
> --- a/include/linux/platform_data/remoteproc-omap.h
> +++ b/include/linux/platform_data/remoteproc-omap.h
> @@ -21,16 +21,4 @@ struct omap_rproc_pdata {
>  	int (*device_shutdown)(struct platform_device *pdev);
>  };
>  
> -#if defined(CONFIG_OMAP_REMOTEPROC) || defined(CONFIG_OMAP_REMOTEPROC_MODULE)
> -
> -void __init omap_rproc_reserve_cma(void);
> -
> -#else
> -
> -static inline void __init omap_rproc_reserve_cma(void)
> -{
> -}
> -
> -#endif
> -
>  #endif /* _PLAT_REMOTEPROC_H */
> -- 
> 2.17.1
> 
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
