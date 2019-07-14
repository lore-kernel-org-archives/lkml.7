Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24815C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 20:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F129E20644
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 20:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbfGNUog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 16:44:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbfGNUog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 16:44:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F3CB620260;
        Sun, 14 Jul 2019 20:44:35 +0000 (UTC)
Received: from krava (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with SMTP id A7792608C6;
        Sun, 14 Jul 2019 20:44:33 +0000 (UTC)
Date:   Sun, 14 Jul 2019 22:44:32 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Numfor Mbiziwo-Tiapo <nums@google.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        songliubraving@fb.com, mbd@fb.com, linux-kernel@vger.kernel.org,
        irogers@google.com, eranian@google.com
Subject: Re: [PATCH] Fix perf stat repeat segfault
Message-ID: <20190714204432.GA8120@krava>
References: <20190710204540.176495-1-nums@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710204540.176495-1-nums@google.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sun, 14 Jul 2019 20:44:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 01:45:40PM -0700, Numfor Mbiziwo-Tiapo wrote:
> When perf stat is called with event groups and the repeat option,
> a segfault occurs because the cpu ids are stored on each iteration
> of the repeat, when they should only be stored on the first iteration,
> which causes a buffer overflow.
> 
> This can be replicated by running (from the tip directory):
> 
> make -C tools/perf
> 
> then running:
> 
> tools/perf/perf stat -e '{cycles,instructions}' -r 10 ls
> 
> Since run_idx keeps track of the current iteration of the repeat,
> only storing the cpu ids on the first iteration (when run_idx < 1)
> fixes this issue.
> 
> Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
> ---
>  tools/perf/builtin-stat.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 63a3afc7f32b..92d6694367e4 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -378,9 +378,10 @@ static void workload_exec_failed_signal(int signo __maybe_unused, siginfo_t *inf
>  	workload_exec_errno = info->si_value.sival_int;
>  }
>  
> -static bool perf_evsel__should_store_id(struct perf_evsel *counter)
> +static bool perf_evsel__should_store_id(struct perf_evsel *counter, int run_idx)
>  {
> -	return STAT_RECORD || counter->attr.read_format & PERF_FORMAT_ID;
> +	return STAT_RECORD || counter->attr.read_format & PERF_FORMAT_ID
> +		&& run_idx < 1;

we create counters for every iteration, so this can't be
based on iteration

I think that's just a workaround for memory corruption,
that's happening for repeating groupped events stats,
I'll check on this

jirka


>  }
>  
>  static bool is_target_alive(struct target *_target,
> @@ -503,7 +504,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  		if (l > stat_config.unit_width)
>  			stat_config.unit_width = l;
>  
> -		if (perf_evsel__should_store_id(counter) &&
> +		if (perf_evsel__should_store_id(counter, run_idx) &&
>  		    perf_evsel__store_ids(counter, evsel_list))
>  			return -1;
>  	}
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 
