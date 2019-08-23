Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F864C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CCE22CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WA1nHmf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390219AbfHWIWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:22:32 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40586 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbfHWIWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:22:32 -0400
Received: by mail-yw1-f65.google.com with SMTP id z64so3515271ywe.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 01:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gqMJISdK1sCvYoXtpRx34/j2w5oB126SSByYfrdAv0A=;
        b=WA1nHmf0HPn+DPmdLUPjZRzKgLBGLIIYwMtxCzN3RoUYJpZE7Jv7ZuPEECCwMvslsz
         zE+c63vSSHU/W0CzZy8AC4VLrulnjBfjgACbqqopi3m53qj+YK0oSf+NqAlnk37HSXYs
         Uyi+4Rh4CPeHS8oJCy6LasuAHWsL15kxJIrZ++ysLepjEx/WJTXyudh2M3XnS4XNcPf4
         6uFgLMupMLHUrVD4dibamjFoaT0vA556V/yrOaPK10AZoiSWRO1o2yJf2VWP1Nwma69A
         xae4VAM5Q/qAnAt/RhiPiHn3Hq+wQPX159xy1a2v+wOSfieuFg8dTwrJaa2j8cnN/Ipx
         6ZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gqMJISdK1sCvYoXtpRx34/j2w5oB126SSByYfrdAv0A=;
        b=MXRdDU3aR7t90bXDMcbldjGjIe07T2rIDM/h+fCo7vspCC2IkhfP15/oFOpojm+Fvf
         /cwR5s0EDNIWBYjB7F92iefP8xYqmASm3yO7hNz9lSxMfcXcaAxwKBmlXRWkXCRM5v81
         wK/SZ5uA8vi2nC7GhdNeyNXnE4vMZ0nQPEdZ1zQIBX0YVSNDixdk3AlIsJqHnXxgTXPe
         RWo2mPR66wEvWGawdsz1zl8meNep8vwDLSXY3gNnEO4Q46ImKcorzghkuVb/3IfWuGEt
         2LVtQS8b5CcxsJQFxF9r/wSPtA9pf4GLSMIOa/aETRKIciitSD6zMb56bJvUTMG6FuQ4
         0ppQ==
X-Gm-Message-State: APjAAAX+/v/ZScHtYwFjKybhq7vDaTNuFLQPRQosHcjLaxfJ/iavfchO
        RoAu2b7xOAX3QmETV6Uocwpr+Q==
X-Google-Smtp-Source: APXvYqzgV7MAThnepSDDwUZxhGw/YEQ6uHjAIBxukar3eVfsDVAzorisNiTPS4i6N/QuF2n3hn+rWg==
X-Received: by 2002:a0d:ddcd:: with SMTP id g196mr2330144ywe.460.1566548551310;
        Fri, 23 Aug 2019 01:22:31 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1320-244.members.linode.com. [45.79.221.244])
        by smtp.gmail.com with ESMTPSA id x67sm437667ywg.70.2019.08.23.01.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Aug 2019 01:22:27 -0700 (PDT)
Date:   Fri, 23 Aug 2019 16:22:21 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     yabinc@google.com, suzuki.poulose@arm.com, mike.leach@arm.com,
        alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] coresight: tmc-etr: Add barrier packet when moving
 offset forward
Message-ID: <20190823082221.GB18092@leoy-ThinkPad-X240s>
References: <20190822220915.8876-1-mathieu.poirier@linaro.org>
 <20190822220915.8876-3-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822220915.8876-3-mathieu.poirier@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Thu, Aug 22, 2019 at 04:09:15PM -0600, Mathieu Poirier wrote:
> This patch adds barrier packets in the trace stream when the offset in the
> data buffer needs to be moved forward.  Otherwise the decoder isn't aware
> of the break in the stream and can't synchronise itself with the trace
> data.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  .../hwtracing/coresight/coresight-tmc-etr.c   | 43 ++++++++++++++-----
>  1 file changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 4f000a03152e..0e4cd6ec5f28 100644
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
> @@ -1415,10 +1411,11 @@ static void tmc_free_etr_buffer(void *config)
>   * buffer to the perf ring buffer.
>   */
>  static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf,
> +				     unsigned long src_offset,
>  				     unsigned long to_copy)
>  {
>  	long bytes;
> -	long pg_idx, pg_offset, src_offset;
> +	long pg_idx, pg_offset;
>  	unsigned long head = etr_perf->head;
>  	char **dst_pages, *src_buf;
>  	struct etr_buf *etr_buf = etr_perf->etr_buf;
> @@ -1427,7 +1424,6 @@ static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf,
>  	pg_idx = head >> PAGE_SHIFT;
>  	pg_offset = head & (PAGE_SIZE - 1);
>  	dst_pages = (char **)etr_perf->pages;
> -	src_offset = etr_buf->offset + etr_buf->len - to_copy;
>  
>  	while (to_copy > 0) {
>  		/*
> @@ -1475,7 +1471,7 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
>  		      void *config)
>  {
>  	bool lost = false;
> -	unsigned long flags, size = 0;
> +	unsigned long flags, offset, size = 0;
>  	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>  	struct etr_perf_buffer *etr_perf = config;
>  	struct etr_buf *etr_buf = etr_perf->etr_buf;
> @@ -1503,11 +1499,39 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  
>  	size = etr_buf->len;
> +	offset = etr_buf->offset;
> +	lost |= etr_buf->full;
> +
> +	/*
> +	 * The ETR buffer may be bigger than the space available in the
> +	 * perf ring buffer (handle->size).  If so advance the offset so that we
> +	 * get the latest trace data.  In snapshot mode none of that matters
> +	 * since we are expected to clobber stale data in favour of the latest
> +	 * traces.
> +	 */
>  	if (!etr_perf->snapshot && size > handle->size) {
> -		size = handle->size;
> +		u32 mask = tmc_get_memwidth_mask(drvdata);
> +
> +		/*
> +		 * Make sure the new size is aligned in accordance with the
> +		 * requirement explained in function tmc_get_memwidth_mask().
> +		 */
> +		size = handle->size & mask;
> +		offset = etr_buf->offset + etr_buf->len - size;
> +
> +		if (offset >= etr_buf->size)
> +			offset -= etr_buf->size;
>  		lost = true;
>  	}
> -	tmc_etr_sync_perf_buffer(etr_perf, size);
> +
> +	/*
> +	 * Insert barrier packets at the beginning, if there was an overflow
> +	 * or if the offset had to be brought forward.
> +	 */
> +	if (lost)
> +		tmc_etr_buf_insert_barrier_packet(etr_buf, offset);
> +
> +	tmc_etr_sync_perf_buffer(etr_perf, offset, size);

With this new code, the inserting barrier packet has been moved out
from function tmc_sync_etr_buf(); but this patch doesn't handle the
path when user uses SysFS node to access trace data and the trace
buffer is also likely full, thus the SysFS mode might miss to insert
barrier packets?

Thanks,
Leo Yan

>  	/*
>  	 * In snapshot mode we simply increment the head by the number of byte
> @@ -1518,7 +1542,6 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
>  	if (etr_perf->snapshot)
>  		handle->head += size;
>  
> -	lost |= etr_buf->full;
>  out:
>  	/*
>  	 * Don't set the TRUNCATED flag in snapshot mode because 1) the
> -- 
> 2.17.1
> 
