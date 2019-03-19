Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD31C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0934520828
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mETSIgJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfCSLZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:25:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42728 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCSLZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 07:25:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so16512152wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 04:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A3JgLHFiJiDKRWwNVpEhyRSFZhkZ10MYX6wZTJJU16w=;
        b=mETSIgJ1/NOhnEXBqXdeYCCF+zbNRGDUPzqsxFIG96ZmiCk62vHDjfWnQnykRc7KFy
         gWhQ11a/AMFBCO4Lbdl0hHwk3J9eaMX6U9u+T7+eKspENgYUVlPm7fXG9tuwuwP8qESp
         VXK2JU1S9+dfeUYQgfqXFaDMJvNnI2bJPreXJ0yjkoWYwHJlv4Jt/uB6NFtEblBv6fVj
         ZJeRhzHwgeC/k2bCI37aruuoCc/fMvr+nG3KZ6Rv8wLzBLWLAMdi9opSITfTaX0XiaId
         uSE753n1uwfdgOgLfAF/lJd39DXf8BWiFYJQ3a9duiXgJaGJ1QIpj5420uPNNo5fv6Za
         uk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A3JgLHFiJiDKRWwNVpEhyRSFZhkZ10MYX6wZTJJU16w=;
        b=lQTOiMpFlKmno2zgVa14CIdQia+akVL4mUjNJ3GXtpBxVdnOTRq3yDdewgL9BArhA/
         c0v5M55lIKYD4waC3aTdsUWbjwfr37eJZO9n5D2uVbh0s2P6MIhHt5pezb9A0YlS4f/U
         mFgke1RYOyarGO/NWHfpqBV503tCUkvRF2O1vsXvtoC+ZeMtPiMGDmjdXsICK8ut6TCS
         ARXS3346s8mjH/ZS5KIK86B83LHpW6gXpsMNj9GN8hnfFughcGO9lFopQFNRi2hs4nrS
         xQi0IDwxyEa2xtcl39t+TT11KVTd5hlImxPHkZetx1fWmKOoGCjfO5Kidel8nwxCX+Bt
         8qDQ==
X-Gm-Message-State: APjAAAVzhEcV4mOMkZq+yQm45BahPcdHnZe8WcwHtBPPbUCUVtljfCRT
        cXFXFSA8ItPT1CbjGyJPntAxcA==
X-Google-Smtp-Source: APXvYqyN+8Vho7yqLyT5s6MylHvBjMRkheqU82nnoC3EiyMtryfS76vLTfm0kruGHoNTW4yIX3Kisw==
X-Received: by 2002:a5d:464e:: with SMTP id j14mr17467772wrs.109.1552994739515;
        Tue, 19 Mar 2019 04:25:39 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id o8sm2610073wma.1.2019.03.19.04.25.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 04:25:38 -0700 (PDT)
Date:   Tue, 19 Mar 2019 11:25:37 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] tracing: Add trace_total_entries() /
 trace_total_entries_cpu()
Message-ID: <20190319112537.5yi7gelkk4ixswmu@holly.lan>
References: <20190318204741.116550-1-dianders@chromium.org>
 <20190318204741.116550-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318204741.116550-2-dianders@chromium.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 01:47:40PM -0700, Douglas Anderson wrote:
> These two new exported functions will be used in a future patch by
> kdb_ftdump() to quickly skip all but the last few trace entries.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v5: None
> Changes in v4:
> - trace_total_entries() / trace_total_entries_cpu() new for v4
> 
> Changes in v3: None
> 
>  kernel/trace/trace.c | 65 ++++++++++++++++++++++++++++++++++----------
>  kernel/trace/trace.h |  3 ++
>  2 files changed, 53 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index ccd759eaad79..7afc90f82e53 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3490,34 +3490,69 @@ static void s_stop(struct seq_file *m, void *p)
>  	trace_event_read_unlock();
>  }
>  
> +static void
> +get_total_entries_cpu(struct trace_buffer *buf, unsigned long *total,
> +		      unsigned long *entries, int cpu)
> +{
> +	unsigned long count;
> +
> +	count = ring_buffer_entries_cpu(buf->buffer, cpu);
> +	/*
> +	 * If this buffer has skipped entries, then we hold all
> +	 * entries for the trace and we need to ignore the
> +	 * ones before the time stamp.
> +	 */
> +	if (per_cpu_ptr(buf->data, cpu)->skipped_entries) {
> +		count -= per_cpu_ptr(buf->data, cpu)->skipped_entries;
> +		/* total is the same as the entries */
> +		*total = count;
> +	} else
> +		*total = count +
> +			ring_buffer_overrun_cpu(buf->buffer, cpu);
> +	*entries = count;
> +}
> +
>  static void
>  get_total_entries(struct trace_buffer *buf,
>  		  unsigned long *total, unsigned long *entries)
>  {
> -	unsigned long count;
> +	unsigned long t, e;
>  	int cpu;
>  
>  	*total = 0;
>  	*entries = 0;
>  
>  	for_each_tracing_cpu(cpu) {
> -		count = ring_buffer_entries_cpu(buf->buffer, cpu);
> -		/*
> -		 * If this buffer has skipped entries, then we hold all
> -		 * entries for the trace and we need to ignore the
> -		 * ones before the time stamp.
> -		 */
> -		if (per_cpu_ptr(buf->data, cpu)->skipped_entries) {
> -			count -= per_cpu_ptr(buf->data, cpu)->skipped_entries;
> -			/* total is the same as the entries */
> -			*total += count;
> -		} else
> -			*total += count +
> -				ring_buffer_overrun_cpu(buf->buffer, cpu);
> -		*entries += count;
> +		get_total_entries_cpu(buf, &t, &e, cpu);
> +		*total += t;
> +		*entries += e;
>  	}
>  }
>  
> +unsigned long trace_total_entries_cpu(struct trace_array *tr, int cpu)
> +{
> +	unsigned long total, entries;
> +
> +	if (!tr)
> +		tr = &global_trace;

This function is only ever called with tr set to NULL which means tr is
an argument looking for a user.

I wouldn't mind except if this was following copying prior art to keep
the API feel the same but I can't find any other trace function where
the trace_array can be substituted for NULL. AFAICT all the existing
sites where global_trace is used will use it unconditionally.


> +
> +	get_total_entries_cpu(&tr->trace_buffer, &total, &entries, cpu);
> +
> +	return entries;
> +}
> +
> +unsigned long trace_total_entries(struct trace_array *tr)
> +{
> +	unsigned long total, entries;
> +
> +	if (!tr)
> +		tr = &global_trace;

Ditto.


Daniel.


> +
> +	get_total_entries(&tr->trace_buffer, &total, &entries);
> +
> +	return entries;
> +}
> +
>  static void print_lat_help_header(struct seq_file *m)
>  {
>  	seq_puts(m, "#                  _------=> CPU#            \n"
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index d80cee49e0eb..4562b30eda9d 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -719,6 +719,9 @@ void trace_init_global_iter(struct trace_iterator *iter);
>  
>  void tracing_iter_reset(struct trace_iterator *iter, int cpu);
>  
> +unsigned long trace_total_entries_cpu(struct trace_array *tr, int cpu);
> +unsigned long trace_total_entries(struct trace_array *tr);
> +
>  void trace_function(struct trace_array *tr,
>  		    unsigned long ip,
>  		    unsigned long parent_ip,
> -- 
> 2.21.0.225.g810b269d1ac-goog
> 
