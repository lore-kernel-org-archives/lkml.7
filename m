Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D329CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B292084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 12:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfCKMci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 08:32:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbfCKMch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 08:32:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 54CB3308A953;
        Mon, 11 Mar 2019 12:32:37 +0000 (UTC)
Received: from krava (ovpn-204-224.brq.redhat.com [10.40.204.224])
        by smtp.corp.redhat.com (Postfix) with SMTP id D83EC614E6;
        Mon, 11 Mar 2019 12:32:35 +0000 (UTC)
Date:   Mon, 11 Mar 2019 13:32:35 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 03/15] perf tools script: Filter COMM/FORK/.. events
 by CPU
Message-ID: <20190311123235.GB26829@krava>
References: <20190309055628.21617-1-andi@firstfloor.org>
 <20190309055628.21617-4-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309055628.21617-4-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 11 Mar 2019 12:32:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 09:56:16PM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The --cpu option only filtered samples. Filter other perf events,
> such as COMM, FORK, SWITCH by the CPU too.
> 
> Reported-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> ---
> v2: Only filter printf output
> ---
>  tools/perf/builtin-script.c | 62 +++++++++++++++++++++++--------------
>  1 file changed, 39 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index fbc440bdf880..f6b5b19b3307 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2053,9 +2053,11 @@ static int process_comm_event(struct perf_tool *tool,
>  		sample->tid = event->comm.tid;
>  		sample->pid = event->comm.pid;
>  	}
> -	perf_sample__fprintf_start(sample, thread, evsel,
> +	if (!cpu_list || test_bit(sample->cpu, cpu_bitmap)) {
> +		perf_sample__fprintf_start(sample, thread, evsel,
>  				   PERF_RECORD_COMM, stdout);
> -	perf_event__fprintf(event, stdout);
> +		perf_event__fprintf(event, stdout);
> +	}

looks like this is all same code, and could be put
into a function, but it can be done later

thanks,
jirka

>  	ret = 0;
>  out:
>  	thread__put(thread);
> @@ -2089,9 +2091,11 @@ static int process_namespaces_event(struct perf_tool *tool,
>  		sample->tid = event->namespaces.tid;
>  		sample->pid = event->namespaces.pid;
>  	}
> -	perf_sample__fprintf_start(sample, thread, evsel,
> -				   PERF_RECORD_NAMESPACES, stdout);
> -	perf_event__fprintf(event, stdout);
> +	if (!cpu_list || test_bit(sample->cpu, cpu_bitmap)) {
> +		perf_sample__fprintf_start(sample, thread, evsel,
> +					   PERF_RECORD_NAMESPACES, stdout);
> +		perf_event__fprintf(event, stdout);
> +	}
>  	ret = 0;
>  out:
>  	thread__put(thread);
> @@ -2123,9 +2127,11 @@ static int process_fork_event(struct perf_tool *tool,
>  		sample->tid = event->fork.tid;
>  		sample->pid = event->fork.pid;
>  	}
> -	perf_sample__fprintf_start(sample, thread, evsel,
> -				   PERF_RECORD_FORK, stdout);
> -	perf_event__fprintf(event, stdout);
> +	if (!cpu_list || test_bit(sample->cpu, cpu_bitmap)) {
> +		perf_sample__fprintf_start(sample, thread, evsel,
> +					   PERF_RECORD_FORK, stdout);
> +		perf_event__fprintf(event, stdout);
> +	}
>  	thread__put(thread);
>  
>  	return 0;
> @@ -2153,9 +2159,11 @@ static int process_exit_event(struct perf_tool *tool,
>  		sample->tid = event->fork.tid;
>  		sample->pid = event->fork.pid;
>  	}
> -	perf_sample__fprintf_start(sample, thread, evsel,
> -				   PERF_RECORD_EXIT, stdout);
> -	perf_event__fprintf(event, stdout);
> +	if (!cpu_list || test_bit(sample->cpu, cpu_bitmap)) {
> +		perf_sample__fprintf_start(sample, thread, evsel,
> +					   PERF_RECORD_EXIT, stdout);
> +		perf_event__fprintf(event, stdout);
> +	}
>  
>  	if (perf_event__process_exit(tool, event, sample, machine) < 0)
>  		err = -1;
> @@ -2189,9 +2197,11 @@ static int process_mmap_event(struct perf_tool *tool,
>  		sample->tid = event->mmap.tid;
>  		sample->pid = event->mmap.pid;
>  	}
> -	perf_sample__fprintf_start(sample, thread, evsel,
> -				   PERF_RECORD_MMAP, stdout);
> -	perf_event__fprintf(event, stdout);
> +	if (!cpu_list || test_bit(sample->cpu, cpu_bitmap)) {
> +		perf_sample__fprintf_start(sample, thread, evsel,
> +					   PERF_RECORD_MMAP, stdout);
> +		perf_event__fprintf(event, stdout);
> +	}
>  	thread__put(thread);
>  	return 0;
>  }
> @@ -2221,9 +2231,11 @@ static int process_mmap2_event(struct perf_tool *tool,
>  		sample->tid = event->mmap2.tid;
>  		sample->pid = event->mmap2.pid;
>  	}
> -	perf_sample__fprintf_start(sample, thread, evsel,
> -				   PERF_RECORD_MMAP2, stdout);
> -	perf_event__fprintf(event, stdout);
> +	if (!cpu_list || test_bit(sample->cpu, cpu_bitmap)) {
> +		perf_sample__fprintf_start(sample, thread, evsel,
> +					   PERF_RECORD_MMAP2, stdout);
> +		perf_event__fprintf(event, stdout);
> +	}
>  	thread__put(thread);
>  	return 0;
>  }
> @@ -2248,9 +2260,11 @@ static int process_switch_event(struct perf_tool *tool,
>  		return -1;
>  	}
>  
> -	perf_sample__fprintf_start(sample, thread, evsel,
> -				   PERF_RECORD_SWITCH, stdout);
> -	perf_event__fprintf(event, stdout);
> +	if (!cpu_list || test_bit(sample->cpu, cpu_bitmap)) {
> +		perf_sample__fprintf_start(sample, thread, evsel,
> +					   PERF_RECORD_SWITCH, stdout);
> +		perf_event__fprintf(event, stdout);
> +	}
>  	thread__put(thread);
>  	return 0;
>  }
> @@ -2271,9 +2285,11 @@ process_lost_event(struct perf_tool *tool,
>  	if (thread == NULL)
>  		return -1;
>  
> -	perf_sample__fprintf_start(sample, thread, evsel,
> -				   PERF_RECORD_LOST, stdout);
> -	perf_event__fprintf(event, stdout);
> +	if (!cpu_list || test_bit(sample->cpu, cpu_bitmap)) {
> +		perf_sample__fprintf_start(sample, thread, evsel,
> +					   PERF_RECORD_LOST, stdout);
> +		perf_event__fprintf(event, stdout);
> +	}
>  	thread__put(thread);
>  	return 0;
>  }
> -- 
> 2.20.1
> 
