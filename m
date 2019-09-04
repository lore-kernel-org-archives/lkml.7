Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADF2C3A5A2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 03:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF98622CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 03:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CztmP3Vr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfIDDT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 23:19:26 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33572 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbfIDDT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 23:19:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so7224852pfl.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 20:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=02+eBEQJWm6NHimkROpVhmoHyIo4/pLc4YR1Y2rVwOA=;
        b=CztmP3VrmOz2/mU3Ni+FHnjEZCeJ2OyXfo8+ajDcZ79r5MxkWd3rA4/inLzPD+RhqT
         G65tPOsl5mK/jUAMnnKUdXSuWwlD0EwrbbcevxYgEMrozddxtZpG38f2rD/pBHqu7oXj
         c4SIl4FK3haHY+7szeZAjmoG5DCsVHlOwdGVnBAAYn85mmhN35dlKeUKlU0V0uY2+4Gy
         sz80PAgfCcGbm83OjFv88AIjBatvvSx2zv+3Wzo62LaTgEwZKc9aDH+PM+luetMoRCpZ
         qMeyqHf2BuUAkkFuqNrWDU2PpD0b/cvL4gy5vXGj5BnyTLSLC7A6gWk8AevGxappaTEB
         vA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=02+eBEQJWm6NHimkROpVhmoHyIo4/pLc4YR1Y2rVwOA=;
        b=lL/GKDQhf9hggf/XjnL+ElVfdv2gJaWQgqhfeZEisQQ2Q3GkKfPTyozys6UKjUmg5f
         uo6dRBfDA7iGnGhDR85DyMsYJRqeyjURgri1xODbey3i4zLr1UXAxTDVZ+vf7cOQjQlz
         PNGHGo9BurQtckB5qDymYbvABj1cUDdInilMhde39LcyKN520tE/xq7JtdHJ1r/L00RG
         2fjw3OWZnKJIx/8AlPgZVjUNM1PuNlpcj0EN+u/NvNgcfl/BO+a1KdTcG64DS95F8o+m
         NzmhfyGEN7cXnMOuYWRj6I/VtNB5Qfaomp2F/BlO0WpuNxtDJe0kOKkE3I6aeyNpkBmR
         +eMw==
X-Gm-Message-State: APjAAAUiuqwxEShlW3jT6K/zQ3OfxVig4WsnBEAm0tA6jKxDvjrbdhmq
        WpFylE8lwXdmnZPgaYe1ECFK2A==
X-Google-Smtp-Source: APXvYqxYWfllLFvx+G/2hfqNwK0phBdw0yYAbUV1JDKDDrpF5Cmiadx1YRaxQl3l2TCyAI6O/wjG9Q==
X-Received: by 2002:aa7:84d2:: with SMTP id x18mr5859554pfn.250.1567567165787;
        Tue, 03 Sep 2019 20:19:25 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 185sm21836340pfd.125.2019.09.03.20.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 20:19:25 -0700 (PDT)
Date:   Tue, 3 Sep 2019 20:19:22 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     agross@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/1] soc: qcom: geni: Provide parameter error checking
Message-ID: <20190904031922.GC574@tuxbook-pro>
References: <20190903135052.13827-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903135052.13827-1-lee.jones@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03 Sep 06:50 PDT 2019, Lee Jones wrote:

> When booting with ACPI, the Geni Serial Engine is not set as the I2C/SPI
> parent and thus, the wrapper (parent device) is unassigned.  This causes
> the kernel to crash with a null dereference error.
> 

Now I see what you did in 8bc529b25354; i.e. stubbed all the other calls
between the SE and wrapper.

Do you think it would be possible to resolve the _DEP link to QGP[01]
somehow? For the clocks workarounds this could be resolved by us
representing that relationship using device_link and just rely on
pm_runtime to propagate the clock state.

For the DMA operation, iiuc it's the wrapper that implements the DMA
engine involved, but I'm guessing the main reason for mapping buffers on
the wrapper is so that it ends up being associated with the iommu
context of the wrapper.

Are the SMMU contexts at all represented in the ACPI world and if so do
you know how the wrapper vs SEs are bound to contexts? Can we map on
se->dev when wrapper is NULL (or perhaps always?)?

Regards,
Bjorn

> Fixes: 8bc529b25354 ("soc: qcom: geni: Add support for ACPI")
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> Since we are already at -rc7 this patch should be processed ASAP - thank you.
> 
> drivers/soc/qcom/qcom-geni-se.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index d5cf953b4337..7d622ea1274e 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -630,6 +630,9 @@ int geni_se_tx_dma_prep(struct geni_se *se, void *buf, size_t len,
>  	struct geni_wrapper *wrapper = se->wrapper;
>  	u32 val;
>  
> +	if (!wrapper)
> +		return -EINVAL;
> +
>  	*iova = dma_map_single(wrapper->dev, buf, len, DMA_TO_DEVICE);
>  	if (dma_mapping_error(wrapper->dev, *iova))
>  		return -EIO;
> @@ -663,6 +666,9 @@ int geni_se_rx_dma_prep(struct geni_se *se, void *buf, size_t len,
>  	struct geni_wrapper *wrapper = se->wrapper;
>  	u32 val;
>  
> +	if (!wrapper)
> +		return -EINVAL;
> +
>  	*iova = dma_map_single(wrapper->dev, buf, len, DMA_FROM_DEVICE);
>  	if (dma_mapping_error(wrapper->dev, *iova))
>  		return -EIO;
> -- 
> 2.17.1
> 
