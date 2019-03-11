Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DEDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACB1206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUCRoddE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfCKQ6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:58:13 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39265 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKQ6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:58:13 -0400
Received: by mail-qt1-f196.google.com with SMTP id t28so2208466qte.6;
        Mon, 11 Mar 2019 09:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1n0AbT4r+hr0wTPrWBYDO2avoTthREuvf6W00Gjg6xw=;
        b=OUCRoddEdmlv1Nk4M9LH4egartlMwJ56w535klcNCLqdidayu+nriTk/sH+BQ/i0lB
         w9vQKBuX/MlrenRbDLXW5Dnc2MMBrsNSYPuZGVP7utcX2AviUxmnkJ30p4dNVUHAUP2b
         u0tPC3OZExODrs6WXEAo6i6xzNKCJKkSJV8O6DSKPMLBcd05qGlmqgrJEF4C1U809k0K
         rkxR+ino83g12WWf7yvIrzeQw5PU5U55/z41WWzkPA0p5+hFXNAA0X9/Ud70We9TNg8A
         1YuSpF3cBa+h1yZcU9pR5/zjT/nZ5LGxQGdGSUQsRIFN/ClkSwvbATYdizBE3bmpOE9w
         yUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1n0AbT4r+hr0wTPrWBYDO2avoTthREuvf6W00Gjg6xw=;
        b=Zb/03AboGuIt8mz4MzuL+M50sOl0jMu08gic/YuF7XgkYaUCnY4pEgD7WVZ5iTVdre
         Cmnqd9BNou0iF7aOBgIDbNehjOUtUKkJOfIJF/QvHjJHtHqDQ291qzBX17Z/KsjP8IS2
         lktISQZWYYTBXDxLj2fn/tbwxdbNW285tMMfQfoEjDmoxLiuqP6mwacMOZ2WXnRlOY+j
         UEGzrLi3BR2kHvHJjfTX778eYnRtMlRiIBAwjGf6H2O3pTPByqBioY7N/cDmcCb8INFR
         dU/HfVWHFixnrXr1Wzkn3B3hlyJqA/bEKEbTwjvaE5qCZ5zC2kdZGQ7r8FGvmUBxo6Rd
         LXHA==
X-Gm-Message-State: APjAAAXsWkS6ICljX3wct4gmhkrRrfU1Ifbn/4EYpy+i6gwDZOVMJdq9
        UsRizK8wDuhE5l0jEw2n+pS3Jh5u
X-Google-Smtp-Source: APXvYqzuu8udpqQWlVQ4EI6MegvKkKoVgBlGiCL09JpvnwJ5foC+RUcTXTzMu4aeLN1n2Rv2fpfYjg==
X-Received: by 2002:a0c:e7cc:: with SMTP id c12mr26354672qvo.169.1552323491648;
        Mon, 11 Mar 2019 09:58:11 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([2804:1b1:210a:2644:8d4d:9170:85d5:da34])
        by smtp.gmail.com with ESMTPSA id w37sm2615951qtw.27.2019.03.11.09.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 09:58:10 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6B1A54039C; Mon, 11 Mar 2019 13:58:07 -0300 (-03)
Date:   Mon, 11 Mar 2019 13:58:07 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v6 01/11] perf tools script: Filter COMM/FORK/.. events
 by CPU
Message-ID: <20190311165807.GN10690@kernel.org>
References: <20190311144502.15423-1-andi@firstfloor.org>
 <20190311144502.15423-2-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311144502.15423-2-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 11, 2019 at 07:44:52AM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The --cpu option only filtered samples. Filter other perf events,
> such as COMM, FORK, SWITCH by the CPU too.
> 
> Reported-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Thanks, applied.
 
> ---
> v2: Only filter printf output
> v3: Move checking to function
> ---
>  tools/perf/builtin-script.c | 71 ++++++++++++++++++++++++-------------
>  1 file changed, 47 insertions(+), 24 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 111787e83784..b695b20ffc8a 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1933,6 +1933,13 @@ static int cleanup_scripting(void)
>  	return scripting_ops ? scripting_ops->stop_script() : 0;
>  }
>  
> +static bool filter_cpu(struct perf_sample *sample)
> +{
> +	if (cpu_list)
> +		return !test_bit(sample->cpu, cpu_bitmap);
> +	return false;
> +}
> +
>  static int process_sample_event(struct perf_tool *tool,
>  				union perf_event *event,
>  				struct perf_sample *sample,
> @@ -1967,7 +1974,7 @@ static int process_sample_event(struct perf_tool *tool,
>  	if (al.filtered)
>  		goto out_put;
>  
> -	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
> +	if (filter_cpu(sample))
>  		goto out_put;
>  
>  	if (scripting_ops)
> @@ -2052,9 +2059,11 @@ static int process_comm_event(struct perf_tool *tool,
>  		sample->tid = event->comm.tid;
>  		sample->pid = event->comm.pid;
>  	}
> -	perf_sample__fprintf_start(sample, thread, evsel,
> +	if (!filter_cpu(sample)) {
> +		perf_sample__fprintf_start(sample, thread, evsel,
>  				   PERF_RECORD_COMM, stdout);
> -	perf_event__fprintf(event, stdout);
> +		perf_event__fprintf(event, stdout);
> +	}
>  	ret = 0;
>  out:
>  	thread__put(thread);
> @@ -2088,9 +2097,11 @@ static int process_namespaces_event(struct perf_tool *tool,
>  		sample->tid = event->namespaces.tid;
>  		sample->pid = event->namespaces.pid;
>  	}
> -	perf_sample__fprintf_start(sample, thread, evsel,
> -				   PERF_RECORD_NAMESPACES, stdout);
> -	perf_event__fprintf(event, stdout);
> +	if (!filter_cpu(sample)) {
> +		perf_sample__fprintf_start(sample, thread, evsel,
> +					   PERF_RECORD_NAMESPACES, stdout);
> +		perf_event__fprintf(event, stdout);
> +	}
>  	ret = 0;
>  out:
>  	thread__put(thread);
> @@ -2122,9 +2133,11 @@ static int process_fork_event(struct perf_tool *tool,
>  		sample->tid = event->fork.tid;
>  		sample->pid = event->fork.pid;
>  	}
> -	perf_sample__fprintf_start(sample, thread, evsel,
> -				   PERF_RECORD_FORK, stdout);
> -	perf_event__fprintf(event, stdout);
> +	if (!filter_cpu(sample)) {
> +		perf_sample__fprintf_start(sample, thread, evsel,
> +					   PERF_RECORD_FORK, stdout);
> +		perf_event__fprintf(event, stdout);
> +	}
>  	thread__put(thread);
>  
>  	return 0;
> @@ -2152,9 +2165,11 @@ static int process_exit_event(struct perf_tool *tool,
>  		sample->tid = event->fork.tid;
>  		sample->pid = event->fork.pid;
>  	}
> -	perf_sample__fprintf_start(sample, thread, evsel,
> -				   PERF_RECORD_EXIT, stdout);
> -	perf_event__fprintf(event, stdout);
> +	if (!filter_cpu(sample)) {
> +		perf_sample__fprintf_start(sample, thread, evsel,
> +					   PERF_RECORD_EXIT, stdout);
> +		perf_event__fprintf(event, stdout);
> +	}
>  
>  	if (perf_event__process_exit(tool, event, sample, machine) < 0)
>  		err = -1;
> @@ -2188,9 +2203,11 @@ static int process_mmap_event(struct perf_tool *tool,
>  		sample->tid = event->mmap.tid;
>  		sample->pid = event->mmap.pid;
>  	}
> -	perf_sample__fprintf_start(sample, thread, evsel,
> -				   PERF_RECORD_MMAP, stdout);
> -	perf_event__fprintf(event, stdout);
> +	if (!filter_cpu(sample)) {
> +		perf_sample__fprintf_start(sample, thread, evsel,
> +					   PERF_RECORD_MMAP, stdout);
> +		perf_event__fprintf(event, stdout);
> +	}
>  	thread__put(thread);
>  	return 0;
>  }
> @@ -2220,9 +2237,11 @@ static int process_mmap2_event(struct perf_tool *tool,
>  		sample->tid = event->mmap2.tid;
>  		sample->pid = event->mmap2.pid;
>  	}
> -	perf_sample__fprintf_start(sample, thread, evsel,
> -				   PERF_RECORD_MMAP2, stdout);
> -	perf_event__fprintf(event, stdout);
> +	if (!filter_cpu(sample)) {
> +		perf_sample__fprintf_start(sample, thread, evsel,
> +					   PERF_RECORD_MMAP2, stdout);
> +		perf_event__fprintf(event, stdout);
> +	}
>  	thread__put(thread);
>  	return 0;
>  }
> @@ -2247,9 +2266,11 @@ static int process_switch_event(struct perf_tool *tool,
>  		return -1;
>  	}
>  
> -	perf_sample__fprintf_start(sample, thread, evsel,
> -				   PERF_RECORD_SWITCH, stdout);
> -	perf_event__fprintf(event, stdout);
> +	if (!filter_cpu(sample)) {
> +		perf_sample__fprintf_start(sample, thread, evsel,
> +					   PERF_RECORD_SWITCH, stdout);
> +		perf_event__fprintf(event, stdout);
> +	}
>  	thread__put(thread);
>  	return 0;
>  }
> @@ -2270,9 +2291,11 @@ process_lost_event(struct perf_tool *tool,
>  	if (thread == NULL)
>  		return -1;
>  
> -	perf_sample__fprintf_start(sample, thread, evsel,
> -				   PERF_RECORD_LOST, stdout);
> -	perf_event__fprintf(event, stdout);
> +	if (!filter_cpu(sample)) {
> +		perf_sample__fprintf_start(sample, thread, evsel,
> +					   PERF_RECORD_LOST, stdout);
> +		perf_event__fprintf(event, stdout);
> +	}
>  	thread__put(thread);
>  	return 0;
>  }
> -- 
> 2.20.1

-- 

- Arnaldo
