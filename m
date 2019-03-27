Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B7FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD4B2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbfC0I6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:58:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbfC0I6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:58:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AAA58C06783F;
        Wed, 27 Mar 2019 08:58:15 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4BD862B8D9;
        Wed, 27 Mar 2019 08:58:14 +0000 (UTC)
Date:   Wed, 27 Mar 2019 09:58:13 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/4] perf, tools: Implement duration_time as a proper
 event
Message-ID: <20190327085813.GB24156@krava>
References: <20190326221823.11518-1-andi@firstfloor.org>
 <20190326221823.11518-3-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326221823.11518-3-andi@firstfloor.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 27 Mar 2019 08:58:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 03:18:21PM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The perf metric expression use duration_time internally to normalize
> events. Normal perf stat without -x also prints the duration time.
> But when using -x, the interval is not output anywhere, which
> is inconvenient for any post processing which often wants to
> normalize values to time.
> 
> So implement duration_time as a proper perf event that
> can be specified explicitely with -e.
> 
> The previous implementation of duration_time only worked
> for metric processing. This adds the concept of a tool
> event that is handled by the tool. On the kernel level
> it is still mapped to the dummy software event, but the
> values are not read anymore, but instead computed by the tool.
> 
> Add proper plumbing to handle this in the event parser,
> and display it in perf stat. We don't want duration_time to be added up,
> so it's only printed for the first CPU.
> 
> % perf stat -e duration_time,cycles true
> 
>  Performance counter stats for 'true':
> 
>            555,476 ns   duration_time
>            771,958      cycles
> 
>        0.000555476 seconds time elapsed
> 
>        0.000644000 seconds user
>        0.000000000 seconds sys
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/builtin-stat.c      | 28 ++++++++++++++++++-------
>  tools/perf/util/evsel.h        |  6 ++++++
>  tools/perf/util/parse-events.c | 38 +++++++++++++++++++++++++++++-----
>  tools/perf/util/parse-events.h |  4 ++++
>  tools/perf/util/parse-events.l | 11 +++++++++-
>  tools/perf/util/parse-events.y | 12 +++++++++++
>  6 files changed, 86 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 49ee3c2033ec..7f9c4b7f5d69 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -244,11 +244,25 @@ perf_evsel__write_stat_event(struct perf_evsel *counter, u32 cpu, u32 thread,
>  					   process_synthesized_event, NULL);
>  }
>  
> +static int read_single_counter(struct perf_evsel *counter, int cpu,
> +			       int thread, struct timespec *rs)
> +{
> +	if (counter->tool_event == PERF_TOOL_DURATION_TIME) {
> +		u64 val = rs->tv_nsec + rs->tv_sec*1000000000ULL;
> +		struct perf_counts_values *count =
> +			perf_counts(counter->counts, cpu, thread);
> +		count->ena = count->run = val;
> +		count->val = val;
> +		return 0;
> +	}
> +	return perf_evsel__read_counter(counter, cpu, thread);
> +}

so now that we have time in a separate event, we could
get rid of the isolated update_stats(&walltime_nsecs_stats) calls
and move them to perf_stat__update_shadow_stats?

jirka
