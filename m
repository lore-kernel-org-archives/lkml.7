Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C145DC072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 06:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1D020863
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 06:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558508179;
	bh=kmn9mB4kA50Xw3EkopThJnf3nEu54rXXj5I+aS34jfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RIIERFRwydw0lamGzqvRdZOu7JvomfiMeyP10gQ86+1Ce97qpFAlevrVwsPE8HCVN
	 mWxCanpixJVcqSeEyJ50pBIC6zG1MdfsYNtR+CmDeiu6ZyX3zBfA53vvb7mx1ChX2r
	 oUhv2WyjCnYW4nNHH2SwFFEILJlY7qONhJPUiB0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfEVG4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 02:56:18 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37342 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfEVG4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 02:56:18 -0400
Received: by mail-pl1-f193.google.com with SMTP id p15so597604pll.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 23:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xNNjO3Z10SyEiIZGGK+eEhwTEkIQuQOZC/mTNRdPXMU=;
        b=Iyvhpnu71BRoO8hxoyP6STb8UG8Grq+OW2XWQAJiPJKGG+N0ts+3Dt85OfQUrcfglQ
         20ADlhUvnoMyWj7IAUtuOMRSVbnYDtjY98rr/pFHgI4rH+uQqFlXWrdW+qwLmJf3WwE6
         HzWUfXF0jo0qvhCK/PIaDl+pwaDxzBTuMszpAcbwY7G4hEUPWJeUJS0mYSw6huJxebDr
         NnhriCcgxrhzsxE3lq+I47+EVL+HyMqFNH6r8t0HDw7ID87kb82CqNojHWbKiiBtNXIL
         3WV7LGOqDl7SPsIoQQhGcZ65Xz32nA5xAr8x2Pi2+cYICqb9MXjUDU/1DcXdBQl+9RqX
         Bi1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xNNjO3Z10SyEiIZGGK+eEhwTEkIQuQOZC/mTNRdPXMU=;
        b=i4zyLPfWDPB5G7xCO4hFVjQBAs2rNSZjdb/VBH6sXlr3J+kuMdmZTJUok+iXYh/jm9
         iunhHQHAmN0MNvwFOsu7ApvmDkl6VBrGZ1JAJ6ZWoPdEHcgCREWsPFpuVpojJ4CDpojR
         NK4d79HFxyb796ISbgw9cxrlk/McPsTXx5WUXt2VYfxQF11abRDB9ft5gld2JlQ9wvXT
         fBmY3Eeg3NXuhytjk0eDD6gsb/ZyTWoeMi3mHdhXfARdAAV+VArsGpr1dkW/PwJqWrEE
         qxD2FCpaMm7WG4BXzBtVjzKwkimraTHlOvSJ0JwLLxpK3clej5kf+wBRSoiFcQ6/6Rpp
         6e5Q==
X-Gm-Message-State: APjAAAVuY3MmoL2KBp7guPqxNDc7OISgkFqW4PLnSCnZbIy1MJG9/GMo
        U5REOsvNOw2aNgXWuJPzUSo=
X-Google-Smtp-Source: APXvYqxo9NajZs5fZPCdw+ga/xnJHpXc5yK8GQ8WUfBD3FwYnm5v99Cz1yZmZJkteeSh07zN/Ej4jg==
X-Received: by 2002:a17:902:298a:: with SMTP id h10mr62396632plb.6.1558508176523;
        Tue, 21 May 2019 23:56:16 -0700 (PDT)
Received: from google.com ([2401:fa00:d:10:75ad:a5d:715f:f6d8])
        by smtp.gmail.com with ESMTPSA id x7sm19159629pfm.82.2019.05.21.23.56.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 23:56:15 -0700 (PDT)
Date:   Wed, 22 May 2019 15:56:10 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Wei Li <liwei391@huawei.com>
Cc:     acme@kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        xiezhipeng1@huawei.com
Subject: Re: [PATCH v2] fix use-after-free in perf_sched__lat
Message-ID: <20190522065555.GA206606@google.com>
References: <20190508143648.8153-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190508143648.8153-1-liwei391@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 10:36:48PM +0800, Wei Li wrote:
> After thread is added to machine->threads[i].dead in
> __machine__remove_thread, the machine->threads[i].dead is freed
> when calling free(session) in perf_session__delete(). So it get a
> Segmentation fault when accessing it in thread__put().
> 
> In this patch, we delay the perf_session__delete until all threads
> have been deleted.
> 
> This can be reproduced by following steps:
> 	ulimit -c unlimited
> 	export MALLOC_MMAP_THRESHOLD_=0
> 	perf sched record sleep 10
> 	perf sched latency --sort max
> 	Segmentation fault (core dumped)
> 
> Signed-off-by: Zhipeng Xie <xiezhipeng1@huawei.com>
> Signed-off-by: Wei Li <liwei391@huawei.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thahks,
Namhyung


> ---
>  tools/perf/builtin-sched.c | 63 ++++++++++++++++++++++++++------------
>  1 file changed, 43 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 275f2d92a7bf..8a4841fa124c 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -1774,7 +1774,8 @@ static int perf_sched__process_comm(struct perf_tool *tool __maybe_unused,
>  	return 0;
>  }
>  
> -static int perf_sched__read_events(struct perf_sched *sched)
> +static int __perf_sched__read_events(struct perf_sched *sched,
> +					struct perf_session *session)
>  {
>  	const struct perf_evsel_str_handler handlers[] = {
>  		{ "sched:sched_switch",	      process_sched_switch_event, },
> @@ -1783,30 +1784,17 @@ static int perf_sched__read_events(struct perf_sched *sched)
>  		{ "sched:sched_wakeup_new",   process_sched_wakeup_event, },
>  		{ "sched:sched_migrate_task", process_sched_migrate_task_event, },
>  	};
> -	struct perf_session *session;
> -	struct perf_data data = {
> -		.path  = input_name,
> -		.mode  = PERF_DATA_MODE_READ,
> -		.force = sched->force,
> -	};
> -	int rc = -1;
> -
> -	session = perf_session__new(&data, false, &sched->tool);
> -	if (session == NULL) {
> -		pr_debug("No Memory for session\n");
> -		return -1;
> -	}
>  
>  	symbol__init(&session->header.env);
>  
>  	if (perf_session__set_tracepoints_handlers(session, handlers))
> -		goto out_delete;
> +		return -1;
>  
>  	if (perf_session__has_traces(session, "record -R")) {
>  		int err = perf_session__process_events(session);
>  		if (err) {
>  			pr_err("Failed to process events, error %d", err);
> -			goto out_delete;
> +			return -1;
>  		}
>  
>  		sched->nr_events      = session->evlist->stats.nr_events[0];
> @@ -1814,9 +1802,28 @@ static int perf_sched__read_events(struct perf_sched *sched)
>  		sched->nr_lost_chunks = session->evlist->stats.nr_events[PERF_RECORD_LOST];
>  	}
>  
> -	rc = 0;
> -out_delete:
> +	return 0;
> +}
> +
> +static int perf_sched__read_events(struct perf_sched *sched)
> +{
> +	struct perf_session *session;
> +	struct perf_data data = {
> +		.path  = input_name,
> +		.mode  = PERF_DATA_MODE_READ,
> +		.force = sched->force,
> +	};
> +	int rc;
> +
> +	session = perf_session__new(&data, false, &sched->tool);
> +	if (session == NULL) {
> +		pr_debug("No Memory for session\n");
> +		return -1;
> +	}
> +
> +	rc = __perf_sched__read_events(sched, session);
>  	perf_session__delete(session);
> +
>  	return rc;
>  }
>  
> @@ -3130,12 +3137,25 @@ static void perf_sched__merge_lat(struct perf_sched *sched)
>  
>  static int perf_sched__lat(struct perf_sched *sched)
>  {
> +	struct perf_session *session;
> +	struct perf_data data = {
> +		.path  = input_name,
> +		.mode  = PERF_DATA_MODE_READ,
> +		.force = sched->force,
> +	};
>  	struct rb_node *next;
> +	int rc = -1;
>  
>  	setup_pager();
>  
> -	if (perf_sched__read_events(sched))
> +	session = perf_session__new(&data, false, &sched->tool);
> +	if (session == NULL) {
> +		pr_debug("No Memory for session\n");
>  		return -1;
> +	}
> +
> +	if (__perf_sched__read_events(sched, session))
> +		goto out_delete;
>  
>  	perf_sched__merge_lat(sched);
>  	perf_sched__sort_lat(sched);
> @@ -3164,7 +3184,10 @@ static int perf_sched__lat(struct perf_sched *sched)
>  	print_bad_events(sched);
>  	printf("\n");
>  
> -	return 0;
> +	rc = 0;
> +out_delete:
> +	perf_session__delete(session);
> +	return rc;
>  }
>  
>  static int setup_map_cpus(struct perf_sched *sched)
> -- 
> 2.17.1
> 
