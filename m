Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10ABC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FAE2053B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMh24P/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfFFULC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 16:11:02 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37430 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfFFULC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 16:11:02 -0400
Received: by mail-qt1-f195.google.com with SMTP id y57so4251398qtk.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 13:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=duYNpd7u6NCsl3zgH8XpP5ZaEHzH4usCoWirRor+tVo=;
        b=iMh24P/PiV0DTM7z521pzfS8+NG96xrFL3rQZpoIf5KLXR7ZI/zKx+hGb3j/LDr30n
         NKrUGRSnS/eqlnl8MpzOf2DBGandEFROt/qwYa+tzXX3sa19K7LyfLWLG1zfT/Qp9cJH
         fVKcJaHjFjaLKjkXlKaOqO6W3ql3jBEE/iy4x4Jw4vReZrFCtomtf8mt2O85InQ1Zvyo
         aTJQ8wNcUi7SyMdzwiSkTbZkmH+Csl9ha87rRKWbr3ullN7OC7GNa/UJ8GgN6JTE6QPB
         l87qAzUEFv/CzDy7GT6dtTVuQmoA3I7o2SPnHHVT/gASe+mMa2ztqmuasBCKnn+MNFvP
         ZdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=duYNpd7u6NCsl3zgH8XpP5ZaEHzH4usCoWirRor+tVo=;
        b=aokNYJS+UxNfZKyl3Z+hCiELqzcdlNuV53L3J7vQygG1bioeWcPX1LNUfI+06tR/17
         tMCF2yet2nFcnhUGz9vVXoWkuZWO85yAAPdGpzoIDpFIcuWIetiH2EHgzuxbkQT28Jd2
         9T6RQBA2/WzoLaYxvgxqOBDqeyHE8o/opKgc8SMedZ8TjXh1JNtXjgmGHZMOOajEP77K
         WjoFjSDlR+335GLMehzlsccWVGXULO9Bslrvxwt9N2sy3EWSlymHG6SWTQDrMa9LRjMu
         S5PqvGC20wftaQdaG7am5HzmJMS+9lzBTyauZDFGngtxm/qzkPk7HXrsc757wyLgmZiK
         6XVw==
X-Gm-Message-State: APjAAAXAekFrsiASFr76z7nk2XAly0e8vc1kfDOCoJxCFEBm66F1IMji
        sZpuLw6mcOwaKDmmSfIUrR4=
X-Google-Smtp-Source: APXvYqxotMrVYYKPrBuddtUruaaEgPOYMdyXx7CBvk6Ynad31TzuMnZ6HqfKTIG73wPrO+NhBkhRBw==
X-Received: by 2002:a0c:ad02:: with SMTP id u2mr40321031qvc.90.1559851860829;
        Thu, 06 Jun 2019 13:11:00 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id q36sm2118602qtc.12.2019.06.06.13.10.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 13:11:00 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0A63E41149; Thu,  6 Jun 2019 17:10:57 -0300 (-03)
Date:   Thu, 6 Jun 2019 17:10:56 -0300
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     suzuki.poulose@arm.com, leo.yan@linaro.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Properly set the value of 'old' and 'head'
 in snapshot mode
Message-ID: <20190606201056.GJ21245@kernel.org>
References: <20190605161633.12245-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605161633.12245-1-mathieu.poirier@linaro.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 05, 2019 at 10:16:33AM -0600, Mathieu Poirier escreveu:
> This patch adds the necessay intelligence to properly compute the value
> of 'old' and 'head' when operating in snapshot mode.  That way we can get
> the latest information in the AUX buffer and be compatible with the
> generic AUX ring buffer mechanic.

Leo, have you had the chance to test/review this one? Suzuki?

I also changed the subject to:

  [PATCH] perf cs-etm: Properly set the value of 'old' and 'head' in snapshot mode

So that when looking at a 'git log --oneline' one can have the proper
context and know that its about cs-etm.

- Arnaldo
 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  tools/perf/arch/arm/util/cs-etm.c | 127 +++++++++++++++++++++++++++++-
>  1 file changed, 123 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index 911426721170..0a278bbcaba6 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -31,6 +31,8 @@ struct cs_etm_recording {
>  	struct auxtrace_record	itr;
>  	struct perf_pmu		*cs_etm_pmu;
>  	struct perf_evlist	*evlist;
> +	int			wrapped_cnt;
> +	bool			*wrapped;
>  	bool			snapshot_mode;
>  	size_t			snapshot_size;
>  };
> @@ -536,16 +538,131 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
>  	return 0;
>  }
>  
> -static int cs_etm_find_snapshot(struct auxtrace_record *itr __maybe_unused,
> +static int cs_etm_alloc_wrapped_array(struct cs_etm_recording *ptr, int idx)
> +{
> +	bool *wrapped;
> +	int cnt = ptr->wrapped_cnt;
> +
> +	/* Make @ptr->wrapped as big as @idx */
> +	while (cnt <= idx)
> +		cnt++;
> +
> +	/*
> +	 * Free'ed in cs_etm_recording_free().  Using realloc() to avoid
> +	 * cross compilation problems where the host's system supports
> +	 * reallocarray() but not the target.
> +	 */
> +	wrapped = realloc(ptr->wrapped, cnt * sizeof(bool));
> +	if (!wrapped)
> +		return -ENOMEM;
> +
> +	wrapped[cnt - 1] = false;
> +	ptr->wrapped_cnt = cnt;
> +	ptr->wrapped = wrapped;
> +
> +	return 0;
> +}
> +
> +static bool cs_etm_buffer_has_wrapped(unsigned char *buffer,
> +				      size_t buffer_size, u64 head)
> +{
> +	u64 i, watermark;
> +	u64 *buf = (u64 *)buffer;
> +	size_t buf_size = buffer_size;
> +
> +	/*
> +	 * We want to look the very last 512 byte (chosen arbitrarily) in
> +	 * the ring buffer.
> +	 */
> +	watermark = buf_size - 512;
> +
> +	/*
> +	 * @head is continuously increasing - if its value is equal or greater
> +	 * than the size of the ring buffer, it has wrapped around.
> +	 */
> +	if (head >= buffer_size)
> +		return true;
> +
> +	/*
> +	 * The value of @head is somewhere within the size of the ring buffer.
> +	 * This can be that there hasn't been enough data to fill the ring
> +	 * buffer yet or the trace time was so long that @head has numerically
> +	 * wrapped around.  To find we need to check if we have data at the very
> +	 * end of the ring buffer.  We can reliably do this because mmap'ed
> +	 * pages are zeroed out and there is a fresh mapping with every new
> +	 * session.
> +	 */
> +
> +	/* @head is less than 512 byte from the end of the ring buffer */
> +	if (head > watermark)
> +		watermark = head;
> +
> +	/*
> +	 * Speed things up by using 64 bit transactions (see "u64 *buf" above)
> +	 */
> +	watermark >>= 3;
> +	buf_size >>= 3;
> +
> +	/*
> +	 * If we find trace data at the end of the ring buffer, @head has
> +	 * been there and has numerically wrapped around at least once.
> +	 */
> +	for (i = watermark; i < buf_size; i++)
> +		if (buf[i])
> +			return true;
> +
> +	return false;
> +}
> +
> +static int cs_etm_find_snapshot(struct auxtrace_record *itr,
>  				int idx, struct auxtrace_mmap *mm,
> -				unsigned char *data __maybe_unused,
> +				unsigned char *data,
>  				u64 *head, u64 *old)
>  {
> +	int err;
> +	bool wrapped;
> +	struct cs_etm_recording *ptr =
> +			container_of(itr, struct cs_etm_recording, itr);
> +
> +	/*
> +	 * Allocate memory to keep track of wrapping if this is the first
> +	 * time we deal with this *mm.
> +	 */
> +	if (idx >= ptr->wrapped_cnt) {
> +		err = cs_etm_alloc_wrapped_array(ptr, idx);
> +		if (err)
> +			return err;
> +	}
> +
> +	/*
> +	 * Check to see if *head has wrapped around.  If it hasn't only the
> +	 * amount of data between *head and *old is snapshot'ed to avoid
> +	 * bloating the perf.data file with zeros.  But as soon as *head has
> +	 * wrapped around the entire size of the AUX ring buffer it taken.
> +	 */
> +	wrapped = ptr->wrapped[idx];
> +	if (!wrapped && cs_etm_buffer_has_wrapped(data, mm->len, *head)) {
> +		wrapped = true;
> +		ptr->wrapped[idx] = true;
> +	}
> +
>  	pr_debug3("%s: mmap index %d old head %zu new head %zu size %zu\n",
>  		  __func__, idx, (size_t)*old, (size_t)*head, mm->len);
>  
> -	*old = *head;
> -	*head += mm->len;
> +	/* No wrap has occurred, we can just use *head and *old. */
> +	if (!wrapped)
> +		return 0;
> +
> +	/*
> +	 * *head has wrapped around - adjust *head and *old to pickup the
> +	 * entire content of the AUX buffer.
> +	 */
> +	if (*head >= mm->len) {
> +		*old = *head - mm->len;
> +	} else {
> +		*head += mm->len;
> +		*old = *head - mm->len;
> +	}
>  
>  	return 0;
>  }
> @@ -586,6 +703,8 @@ static void cs_etm_recording_free(struct auxtrace_record *itr)
>  {
>  	struct cs_etm_recording *ptr =
>  			container_of(itr, struct cs_etm_recording, itr);
> +
> +	zfree(&ptr->wrapped);
>  	free(ptr);
>  }
>  
> -- 
> 2.17.1

-- 

- Arnaldo
