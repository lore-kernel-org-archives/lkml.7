Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AB0C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 03:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF982087E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 03:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gnz9R6zQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfDJDtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 23:49:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44684 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbfDJDtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 23:49:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id i2so650348pgj.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 20:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dPy4T3N8LC4Xpq2iPFM7ZlYM20FbtN+Y9BYcDLW1XyI=;
        b=Gnz9R6zQXzCSHNLBiiHPCRTyc7WDserrD36rdusfybsfSQKowmrnfs+EKPo4ALwupU
         pOXXHlNvY3GoTChEivPmIyn2QkC28vVRYytt+1HSv9CZYCVhorBR3ZeBN4eWslWzY+Dv
         9w1aeiq9bJH9WNEBIs+W59l5kGvlU/pUVETaZ0Iq4RHV4pR9zYCR/EqvqAWqLSjIDWHB
         PSd3bvqyRcRLrTG3JIT1iCw0+rhsd84XeuDMZIvqBpuAo3M3xF0Y7/bXriRAameFfBJ8
         dCkzEDXLfczXsW76Hu4J0v3e7PiH0bh1T1NIQGv+7wcikxAO4sLLfEIeO6KKvu9XCxDY
         XETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dPy4T3N8LC4Xpq2iPFM7ZlYM20FbtN+Y9BYcDLW1XyI=;
        b=Cw8gfBd9ZYjody5Bwc8Mrnlxr6zz6LmTXKtIDWqmxAiKg21vkA6FSY6nmqmBSNBFDd
         nMkqThMv5P4+iRxOqVsaUWHrgPGJ5fpkVlarUnZFXuwwhWM7AP0I/TNAocbFj3Wfd3cq
         LT3iZMPJZsRWn4Qnpf6+qe25dGQKBO4hExSnjq8Bo1Tg8TXa3YhD35ByEqwPnafuunEF
         bREc8OcuPKcOmy9/Ke3pRVavLd8I8cGsrBv5FLdsz3hrFqT0EozYypNQBghf459cBnxs
         ilyEWCK1CvR0A/5NyKgVTMbJ2PM9dlwGg3EC2BmujyX2eg3bsqb9+co9/r661IDmUq9i
         Zfrg==
X-Gm-Message-State: APjAAAV4aUwAj/O79c6E1rhsI4y1N4Li2BjOHKqFdq9/+dFiZlrcwB/o
        E80dwF8iU/7iz2EZMnv0hBPP6g==
X-Google-Smtp-Source: APXvYqyibgZVOir8pnTlOW1xWIvTpZY+zVeP4p5OTg7blJIKRTupHnjGC16mUBEqgbpb0TlKmcsr4A==
X-Received: by 2002:a63:3fc3:: with SMTP id m186mr39776220pga.151.1554868171598;
        Tue, 09 Apr 2019 20:49:31 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id t12sm74951308pfl.59.2019.04.09.20.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 20:49:30 -0700 (PDT)
Date:   Wed, 10 Apr 2019 09:19:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-scsi@vger.kernel.org, swboyd@chromium.org,
        ulf.hansson@linaro.org, dianders@chromium.org, rafael@kernel.org
Subject: Re: [RFC v2 09/11] drm/msm/dpu: Use OPP API to set clk/perf state
Message-ID: <20190410034928.wkfnebwmcdonhto6@vireshk-i7>
References: <20190320094918.20234-1-rnayak@codeaurora.org>
 <20190320094918.20234-10-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320094918.20234-10-rnayak@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-03-19, 15:19, Rajendra Nayak wrote:
> On some qualcomm platforms DPU needs to express a perforamnce state
> requirement on a power domain depennding on the clock rates.
> Use OPP table from DT to register with OPP framework and use
> dev_pm_opp_set_rate() to set the clk/perf state.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c | 7 ++++++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       | 9 +++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
> index 9f20f397f77d..db21a86b242b 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
> @@ -15,6 +15,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/errno.h>
>  #include <linux/mutex.h>
> +#include <linux/pm_opp.h>
>  #include <linux/sort.h>
>  #include <linux/clk.h>
>  #include <linux/bitmap.h>
> @@ -298,7 +299,11 @@ static int _dpu_core_perf_set_core_clk_rate(struct dpu_kms *kms, u64 rate)
>  		rate = core_clk->max_rate;
>  
>  	core_clk->rate = rate;
> -	return msm_dss_clk_set_rate(core_clk, 1);
> +
> +	if (dev_pm_opp_get_opp_table(&kms->pdev->dev))

This takes a reference of the OPP table, you need to call put thing as well to
balance it off.

> +		return dev_pm_opp_set_rate(&kms->pdev->dev, core_clk->rate);
> +	else
> +		return msm_dss_clk_set_rate(core_clk, 1);
>  }
-- 
viresh
