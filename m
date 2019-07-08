Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F08C606CF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 21:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 386CA216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 21:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9jlUqZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405390AbfGHV7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 17:59:45 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45346 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732609AbfGHV7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 17:59:44 -0400
Received: by mail-qt1-f194.google.com with SMTP id j19so19578113qtr.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 14:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=51c4IfPYBT+5J+agOJgYO3bIQC8MzKtwLDft7qMF0DM=;
        b=O9jlUqZ+4vCS085d+1YCzB9Oe//LLSFNctsqO/FWkvVqu0cICOCK3+5Og/Gd3FRZpl
         mV3awcmWfOuNhRPP/lCuILtVx8UbDEJ2qOX/VtYiwwtyFJdkmCLbHEcqqAcYKdgIKSav
         qc0nqdFHR69Ea4Sg/la9n1A1hOZ0nAodQMTLQiT6ioeQ0GW7VkBVI6+OnExylfrHLHF4
         miEGB497gyTXtBF8dth9RlOThOkO2GbLeFdWkDnpZg8LyyUCfiquRYlshDYOgyqenbcx
         HOnVxrH74884d3XwG3Nlo0LDDHGoQVTj9cUhckHNgWipR2FlEp86rdMYCw+Z1fw/NjNd
         HE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=51c4IfPYBT+5J+agOJgYO3bIQC8MzKtwLDft7qMF0DM=;
        b=R5oJxVVJOEnII83SPn2/ty2J96IASwtClFvf9aqPPoGjvOVAtBX9wDNMJSf425OjRg
         Cl+LcCfX2zDNBByjAn32Ok0T0F1cCb2aNaKj9DduwJuGLA32q0ig7TwHHFMBsxCkjEui
         XyLN1OSdCp7nUn+t0O4JWQB8Zukt5rF/i0wmea+oCvds2d7o8Eymyd9Y5Lk7ZGEGupS3
         wAsuoVj/0tSgHlYVhYFY0K44hvhBUITyphW1ZTd5ff/YGcI3hY8g1WRLJNe1ZAKgoUmO
         cP0icG5lIR/muJvoTtui4/Uu25lM9ffLkxRXKbOERHTh/q0gEahNLCh4mp27n7ZrH7EL
         psCA==
X-Gm-Message-State: APjAAAXtNXfbhmm3ep86iiFoVP7aZw24ckvgAxjUeeaSka4Vzb6iNCc2
        p0+2xFf+3zlCLMpuTKzg02A=
X-Google-Smtp-Source: APXvYqxA2ERXj6By30G/1nNVAe1ik9HlQ3pd1OM7S8J6I3dOIzgUkBWQgIK4pYoGSuV2hI4RY3yb6A==
X-Received: by 2002:ac8:303c:: with SMTP id f57mr15768350qte.294.1562623183271;
        Mon, 08 Jul 2019 14:59:43 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id m44sm9406125qtm.54.2019.07.08.14.59.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 14:59:42 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9857340340; Mon,  8 Jul 2019 18:59:40 -0300 (-03)
Date:   Mon, 8 Jul 2019 18:59:40 -0300
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/4] perf intel-pt: Smatch: Fix potential NULL pointer
 dereference
Message-ID: <20190708215940.GD7455@kernel.org>
References: <20190708143937.7722-1-leo.yan@linaro.org>
 <20190708143937.7722-4-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708143937.7722-4-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 08, 2019 at 10:39:36PM +0800, Leo Yan escreveu:
> Based on the following report from Smatch, fix the potential
> NULL pointer dereference check.

Adrian, are you ok now with these two for pt and bts? Can I have your
acked-by?

- Arnaldo
 
>   tools/perf/util/intel-pt.c:3200
>   intel_pt_process_auxtrace_info() error: we previously assumed
>   'session->itrace_synth_opts' could be null (see line 3196)
> 
>   tools/perf/util/intel-pt.c:3206
>   intel_pt_process_auxtrace_info() warn: variable dereferenced before
>   check 'session->itrace_synth_opts' (see line 3200)
> 
> tools/perf/util/intel-pt.c
> 3196         if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
> 3197                 pt->synth_opts = *session->itrace_synth_opts;
> 3198         } else {
> 3199                 itrace_synth_opts__set_default(&pt->synth_opts,
> 3200                                 session->itrace_synth_opts->default_no_sample);
>                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^
> 3201                 if (!session->itrace_synth_opts->default_no_sample &&
> 3202                     !session->itrace_synth_opts->inject) {
> 3203                         pt->synth_opts.branches = false;
> 3204                         pt->synth_opts.callchain = true;
> 3205                 }
> 3206                 if (session->itrace_synth_opts)
>                          ^^^^^^^^^^^^^^^^^^^^^^^^^^
> 3207                         pt->synth_opts.thread_stack =
> 3208                                 session->itrace_synth_opts->thread_stack;
> 3209         }
> 
> 'session->itrace_synth_opts' is impossible to be a NULL pointer in
> intel_pt_process_auxtrace_info(), thus this patch removes the NULL
> test for 'session->itrace_synth_opts'.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/intel-pt.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index c76a96f777fb..df061599fef4 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -3210,7 +3210,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
>  		goto err_delete_thread;
>  	}
>  
> -	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
> +	if (session->itrace_synth_opts->set) {
>  		pt->synth_opts = *session->itrace_synth_opts;
>  	} else {
>  		itrace_synth_opts__set_default(&pt->synth_opts,
> @@ -3220,8 +3220,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
>  			pt->synth_opts.branches = false;
>  			pt->synth_opts.callchain = true;
>  		}
> -		if (session->itrace_synth_opts)
> -			pt->synth_opts.thread_stack =
> +		pt->synth_opts.thread_stack =
>  				session->itrace_synth_opts->thread_stack;
>  	}
>  
> @@ -3241,11 +3240,9 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
>  		pt->cbr2khz = tsc_freq / pt->max_non_turbo_ratio / 1000;
>  	}
>  
> -	if (session->itrace_synth_opts) {
> -		err = intel_pt_setup_time_ranges(pt, session->itrace_synth_opts);
> -		if (err)
> -			goto err_delete_thread;
> -	}
> +	err = intel_pt_setup_time_ranges(pt, session->itrace_synth_opts);
> +	if (err)
> +		goto err_delete_thread;
>  
>  	if (pt->synth_opts.calls)
>  		pt->branches_filter |= PERF_IP_FLAG_CALL | PERF_IP_FLAG_ASYNC |
> -- 
> 2.17.1

-- 

- Arnaldo
