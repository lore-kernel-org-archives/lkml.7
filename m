Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35639C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033232173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vX3rxJJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfH0Bas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:30:48 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43117 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfH0Bar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:30:47 -0400
Received: by mail-yb1-f194.google.com with SMTP id o82so7664909ybg.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 18:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tnOKZVI2QOtjsx7l6GiMYgVTnUPPJYldd6RePG5ghms=;
        b=vX3rxJJm953Uw6Onz9/pZS2n4ACF3qqSTizq7x04kl2lFxHfNfTJN627+igH9UdpX7
         ARfAlJNXBpkT74h9GXk7w/g0j7vg9mhIc6E6Vopg3H1BMMNM/WzPP2aYXu97V0I66BXQ
         QV+/peRihYrX5YLimVdSBztjFOMnXSS7TtHjmN0ZnBIYl1QTfs1+aE4DlYE6XU2keRqL
         6AaEw1jxtX32qDcEr4s/h3IXvmYag70M4BYKEqXar8hSCueU9WtBT2VCoXAlMPP+deik
         Gww+apYt9+elDrgII9LHzlSTdl+Yq9AH3PtC4GEiubI5lI5fq87uyzz8psu9UYS++wqa
         7wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tnOKZVI2QOtjsx7l6GiMYgVTnUPPJYldd6RePG5ghms=;
        b=RvV48p0Qkr28E0ZoXv93328IMFtnsc2URf2zjqrrSG6BMiYw/Q+MmJvhK6YJpUYvxx
         /JAAb/XLdgYB4NXLLrYmJyoKthh1giytEcmztZISdB1cspqVAzQ0lydoG9Lhm1v0d6qW
         7F+QwvqusBk5TbKQRaJ3nSxWpfkCi95/Pgpmm7zUMsZkgUp2ZuUWIf/OFuDL/LLZ8Lvy
         g3VcrgnUFLRhV/ibxRAoqRIUubPiVb0F5S3CzlBT8l3UbG2cH1p7E83e1YnYkqQ2psP/
         jjGRtD4vssxJ0dehdzsdDpGIATbdqK2LX9Yssb5vJFmv9yh8m6cofor1iLstLfljBq18
         lYpg==
X-Gm-Message-State: APjAAAW3ks3AM7UKxUjgTHo7yb8zmbIjg3Flwvhk6++jfiJyGBCIZxY/
        71ICCUJfE1jMrvDJbv64JbLk1Q==
X-Google-Smtp-Source: APXvYqyvwkntuxPSlWKESJ6L4XB+N21yveACkjPf5xkRW4oRIYfpW5Wrgi1POx6hlYp6IxHJLJNeuA==
X-Received: by 2002:a25:aa23:: with SMTP id s32mr14370115ybi.198.1566869446653;
        Mon, 26 Aug 2019 18:30:46 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1320-244.members.linode.com. [45.79.221.244])
        by smtp.gmail.com with ESMTPSA id d191sm3600156ywh.12.2019.08.26.18.30.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Aug 2019 18:30:45 -0700 (PDT)
Date:   Tue, 27 Aug 2019 09:30:38 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     suzuki.poulose@arm.com, mike.leach@arm.com, yabinc@google.com,
        alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] coresight: tmc-etr: Decouple buffer sync and
 barrier packet insertion
Message-ID: <20190827013038.GA4596@leoy-ThinkPad-X240s>
References: <20190826194605.3791-1-mathieu.poirier@linaro.org>
 <20190826194605.3791-3-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826194605.3791-3-mathieu.poirier@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 01:46:04PM -0600, Mathieu Poirier wrote:
> If less space is available in the perf ring buffer than the ETR buffer,
> barrier packets inserted in the trace stream by tmc_sync_etr_buf() are
> skipped over when the head of the buffer is moved forward, resulting in
> traces that can't be decoded.
> 
> This patch decouples the process of syncing ETR buffers and the addition
> of barrier packets in order to perform the latter once the offset in the
> trace buffer has been properly computed.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  .../hwtracing/coresight/coresight-tmc-etr.c    | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 4f000a03152e..bae47272de98 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -946,10 +946,6 @@ static void tmc_sync_etr_buf(struct tmc_drvdata *drvdata)
>  	WARN_ON(!etr_buf->ops || !etr_buf->ops->sync);
>  
>  	etr_buf->ops->sync(etr_buf, rrp, rwp);
> -
> -	/* Insert barrier packets at the beginning, if there was an overflow */
> -	if (etr_buf->full)
> -		tmc_etr_buf_insert_barrier_packet(etr_buf, etr_buf->offset);
>  }
>  
>  static void __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
> @@ -1086,6 +1082,13 @@ static void tmc_etr_sync_sysfs_buf(struct tmc_drvdata *drvdata)
>  		drvdata->sysfs_buf = NULL;
>  	} else {
>  		tmc_sync_etr_buf(drvdata);
> +		/*
> +		 * Insert barrier packets at the beginning, if there was
> +		 * an overflow.
> +		 */
> +		if (etr_buf->full)
> +			tmc_etr_buf_insert_barrier_packet(etr_buf,
> +							  etr_buf->offset);
>  	}
>  }
>  
> @@ -1502,11 +1505,16 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
>  	CS_LOCK(drvdata->base);
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  
> +	lost = etr_buf->full;

Comparing to the previous version, it drops '|' bitwise operator;
seems to me this is more neat :)

I think Yabin's testing is more convinced, so I skip to test.
FWIW, these three patches look good to me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

>  	size = etr_buf->len;
>  	if (!etr_perf->snapshot && size > handle->size) {
>  		size = handle->size;
>  		lost = true;
>  	}
> +
> +	/* Insert barrier packets at the beginning, if there was an overflow */
> +	if (lost)
> +		tmc_etr_buf_insert_barrier_packet(etr_buf, etr_buf->offset);
>  	tmc_etr_sync_perf_buffer(etr_perf, size);
>  
>  	/*
> @@ -1517,8 +1525,6 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
>  	 */
>  	if (etr_perf->snapshot)
>  		handle->head += size;
> -
> -	lost |= etr_buf->full;
>  out:
>  	/*
>  	 * Don't set the TRUNCATED flag in snapshot mode because 1) the
> -- 
> 2.17.1
> 
