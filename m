Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9753DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706C720657
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfCDPlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:41:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbfCDPlG (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:41:06 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B2C9430718FE;
        Mon,  4 Mar 2019 15:41:05 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3EA425D6B3;
        Mon,  4 Mar 2019 15:41:02 +0000 (UTC)
Date:   Mon, 4 Mar 2019 16:41:01 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 1/3] perf diff: Support --time filter option
Message-ID: <20190304154101.GN30476@krava>
References: <1551703960-28957-1-git-send-email-yao.jin@linux.intel.com>
 <1551703960-28957-2-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551703960-28957-2-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 04 Mar 2019 15:41:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 08:52:38PM +0800, Jin Yao wrote:
> For better support for perf diff, it would be useful to add --time filter
> option to diff the samples within given time window.
> 
> It supports time percent with multipe time ranges. Time string is
> 'a%/n,b%/m,...' or 'a%-b%,c%-%d,...'.
> 
> For example:
> 
> Select the second 10% time slice to diff:
> perf diff --time 10%/2
> 
> Select from 0% to 10% time slice to diff:
> perf diff --time 0%-10%
> 
> Select the first and the second 10% time slices to diff:
> perf diff --time 10%/1,10%/2
> 
> Select from 0% to 10% and 30% to 40% slices to diff:
> perf diff --time 0%-10%,30%-40%
> 
> It also supports to analyze samples within given time window as:
> <start>,<stop>. Times have the format seconds.microseconds. If start
> is not given (i.e., time string is ',x.y') then analysis starts at
> the beginning of the file. If stop time is not given (i.e, time
> string is 'x.y,') then analysis goes to end of file. Time string is
> 'a1.b1,c1.d1:a2.b2,c2.d2'. Use ':' to separate timestamps for different
> perf.data files.
> 
> For example, we get the timestamp information from perf script.
> 
> perf script -i perf.data.old
>   mgen 13940 [000]  3946.361400: ...
> 
> perf script -i perf.data
>   mgen 13940 [000]  3971.150589 ...
> 
> perf diff --time 3946.361400,:3971.150589,
> 
> It analyzes the perf.data.old from the timestamp 3946.361400 to
> the end of perf.data.old and analyzes the perf.data from the
> timestamp 3971.150589 to the end of perf.data.
> 
>  v3:
>  ---
>  Don't parse the time string if --time option is not set.
>  Refactor the code to make it simpler.

it's much clearer now, thanks for doing this, some nits below

SNIP

> +
>  static int __cmd_diff(void)
>  {
>  	struct data__file *d;
>  	int ret = -EINVAL, i;
> +	char *abstime_ostr, *abstime_tmp;
> +
> +	abstime_ostr = abstime_str_dup();
> +	abstime_tmp = abstime_ostr;

could be just one line:

	abstime_ostr = abstime_tmp = abstime_str_dup();

also please fail if the allocation fails

>  
>  	data__for_each_file(i, d) {
> -		d->session = perf_session__new(&d->data, false, &tool);
> +		d->session = perf_session__new(&d->data, false, &pdiff.tool);
>  		if (!d->session) {
>  			pr_err("Failed to open %s\n", d->data.path);
>  			ret = -1;
>  			goto out_delete;
>  		}
>  
> +		if (pdiff.time_str) {
> +			ret = parse_time_str(d, abstime_ostr, &abstime_tmp);
> +			if (ret < 0)
> +				goto out_delete;
> +		}
> +
>  		ret = perf_session__process_events(d->session);
>  		if (ret) {
>  			pr_err("Failed to process %s\n", d->data.path);
> @@ -791,6 +889,9 @@ static int __cmd_diff(void)
>  		}
>  
>  		perf_evlist__collapse_resort(d->session->evlist);
> +
> +		if (pdiff.ptime_range)
> +			zfree(&pdiff.ptime_range);
>  	}
>  
>  	data_process();
> @@ -802,6 +903,13 @@ static int __cmd_diff(void)
>  	}
>  
>  	free(data__files);
> +
> +	if (pdiff.ptime_range)
> +		zfree(&pdiff.ptime_range);

is this zfree needed? you free it in a loop for every data above

jirka


SNIP
