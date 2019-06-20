Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4630C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DD62070B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NhbZE295"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfFTRnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:43:12 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43422 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfFTRnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:43:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id cl9so1663677plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 10:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1KJ0e9ekOabFfxqwKvIk2A6/zmASWNljaHVvnXYUQxY=;
        b=NhbZE295vHsBmR1o4reSr3vcb9K8QjxL6emGCch81QYlNOzn7tv09NGjCC4euADxnF
         kQ9KHGtlQFK1CrMuPhar8/Gj18tnyoWZvwEwjjoeZ2Y8SXMRT0ZyVfD+LvYgGCWATUny
         i8Lyu2TMQ2OIPveZZ4LNrdJYrwqd0pP0sMzbjmZjiJMHYCcIrzLZQIWHl1FFlesbP1ox
         NNsDRkkjMXOQfhrCxZSpHUhVEU3i+VRqLDAwl1jKSZ+erU61VvXj4/vDVX52htPpCiYG
         gAm41dgBnAfhpb1fsukKduPkNOHXyGnyxvX6uxP9MRSJlzwV52XRAveCMA5b4uhZ74Vl
         U+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1KJ0e9ekOabFfxqwKvIk2A6/zmASWNljaHVvnXYUQxY=;
        b=HzjwHDeclCQTSLi+z6AAYIO8bSrHnZSAqcpZHz7o5NI8wpZ3g03bWb3Q8pK/r21mtJ
         0zk2DoYHd48e/nKPdSAue/TH5wG+Zu11kkxd4F+snNv2TJeNUtDnvkILLky7BRTyKkQe
         JxO5tRpsoFANQLO5V70Srrt4/6oOx5wSXkHJGz2TGf6OGG4liVP4sltiPKxMCX/+jbed
         et7bDDtLiQLIXE2E8RhsjZFRu58BTDWqylo91ZmJsdoOJitCSr2dUo0/9lKjCt3dhOQ4
         Xv1knm7kbXHGaXexYkSR5HmnhqlbS03Hz/wv6CkU4oOsDXFZf5f4fT49RBt+u5mi8o4q
         RvhA==
X-Gm-Message-State: APjAAAWDBpkagn7BUz7HoYyy7kWoDjF2Y6KWZ8yxiIb1yVHLHGEAXu6s
        JxbOQTgn9WWULWHkzhc9pvMv+Q==
X-Google-Smtp-Source: APXvYqyrJ3P57l2hXzKwykASSM4m8XDMhpVpPOdFDF+6NySV8L9SKNqqSA+NS5K7Rf8cf9mtKD7jIQ==
X-Received: by 2002:a17:902:2aa8:: with SMTP id j37mr82097915plb.316.1561052591240;
        Thu, 20 Jun 2019 10:43:11 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id y185sm95763pfy.110.2019.06.20.10.43.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 10:43:10 -0700 (PDT)
Date:   Thu, 20 Jun 2019 11:43:08 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] coresight: Abort probe for missing CPU phandle
Message-ID: <20190620174308.GB5581@xps15>
References: <cover.1561037262.git.saiprakash.ranjan@codeaurora.org>
 <d93e28fc80227f9a385130a766a24f8f39a1dcf0.1561037262.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d93e28fc80227f9a385130a766a24f8f39a1dcf0.1561037262.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 07:15:47PM +0530, Sai Prakash Ranjan wrote:
> Currently the coresight etm and cpu-debug drivers
> assume the affinity to CPU0 returned by coresight
> platform and continue the probe in case of missing
> CPU phandle. This is not true and leads to crash
> in some cases, so abort the probe in case of missing
> CPU phandle.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  drivers/hwtracing/coresight/coresight-cpu-debug.c | 3 +++
>  drivers/hwtracing/coresight/coresight-etm3x.c     | 3 +++
>  drivers/hwtracing/coresight/coresight-etm4x.c     | 3 +++
>  3 files changed, 9 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> index 07a1367c733f..43f32fa71ff9 100644
> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> @@ -579,6 +579,9 @@ static int debug_probe(struct amba_device *adev, const struct amba_id *id)
>  		return -ENOMEM;
>  
>  	drvdata->cpu = coresight_get_cpu(dev);
> +	if (drvdata->cpu == -ENODEV)
> +		return -ENODEV;

As Suzuki pointed out, simply return the error message conveyed by
coresight_get_cpu().

Also please merge both patches together to avoid bisect nightmare.

Thank you for the contribution,
Mathieu

> +
>  	if (per_cpu(debug_drvdata, drvdata->cpu)) {
>  		dev_err(dev, "CPU%d drvdata has already been initialized\n",
>  			drvdata->cpu);
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> index 225c2982e4fe..882e2751746c 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -816,6 +816,9 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
>  	}
>  
>  	drvdata->cpu = coresight_get_cpu(dev);
> +	if (drvdata->cpu == -ENODEV)
> +		return -ENODEV;
> +
>  	desc.name  = devm_kasprintf(dev, GFP_KERNEL, "etm%d", drvdata->cpu);
>  	if (!desc.name)
>  		return -ENOMEM;
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 7fe266194ab5..97d71dbbeb19 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -1101,6 +1101,9 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  	spin_lock_init(&drvdata->spinlock);
>  
>  	drvdata->cpu = coresight_get_cpu(dev);
> +	if (drvdata->cpu == -ENODEV)
> +		return -ENODEV;
> +
>  	desc.name = devm_kasprintf(dev, GFP_KERNEL, "etm%d", drvdata->cpu);
>  	if (!desc.name)
>  		return -ENOMEM;
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
