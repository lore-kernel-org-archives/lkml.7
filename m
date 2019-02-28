Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C18FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C244220857
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeCV/CLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388302AbfB1R5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:57:07 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45532 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfB1R5G (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:57:06 -0500
Received: by mail-qt1-f193.google.com with SMTP id d18so24485303qtg.12
        for <Linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 09:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5AwXLcWXStP5dLK0sNVKnALVkELiJ9uO8OsfvCY/B4s=;
        b=NeCV/CLCMbmQ1eXyu3FYvZ203v6LBhtnp6bNHlWmu9ISoLKyYr0jNy5o3gc20eJ0ab
         6Q07nMLZ7hIVU8Fjo+8nxZ8O7+0X3EhwRJcrdlnAHWYPanyzqBx0pLUWz5rHs0Y8lF8Y
         sikRCbERRpnQ8zE1pTr++htkFwKPSqTarhByq7VkjGbNHc0Oqtjs5VMQgIiChN6f5ctk
         YH0oySgYhg2WzWlLXIRZLVhtsYEFD4C0pqQyx/0T7NxrmF5PL5Ug5EabHUqoYBjbEDGG
         OV51SoOL731TzbKBu/oeE2X8YIDYyIMoG/NsszCbxHbRD25NrZKM85zVpLc2XFUmRfOn
         2aEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5AwXLcWXStP5dLK0sNVKnALVkELiJ9uO8OsfvCY/B4s=;
        b=r21/HjmMNR6UEAoY0saNjQVCDHcLKJqHYMnsDYNPlJxbPZocGvBzHgpGMCBMp434VY
         e9dWN5PNuwhVy2gm7j/cmI0AdRMFFyLtY6gCgkNeKhxV+vuyjhG9+hjY99/fDqNu9yQE
         wVuMRNs9gRA9AnkHT8c54Mc5HelS1hEAFsUcjqLGVIOEEL2Vl2ajIWCVXQEX+zVeHC1T
         yB/dRlLHJKxxXH2AIr9ciNTSKEo85eHORYr60LILMXokNn+9pLwlzf1Duu8W7yssOLBg
         9LqB8tzIsowuclDqc8EewjT1CwyD3kwDAQMLY87mBUM6gaoFfFd9XSE+3yUIhsJWUqzw
         oI4Q==
X-Gm-Message-State: APjAAAU3onWvI5VQd6KH2WIH0DY4YsMM1qylWKfqq8zmstbyEkUmPdSJ
        71W1/7uKxy5wXz4tjZr/VMY=
X-Google-Smtp-Source: APXvYqwsvr+x47gItORnwH6YaBidvavCSZfoL5eMqcMRk7PJgvSCQJurOZ2MS3GEnDLB9UQ5e8xHTA==
X-Received: by 2002:a0c:e1c9:: with SMTP id v9mr340453qvl.186.1551376625161;
        Thu, 28 Feb 2019 09:57:05 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id t20sm12818720qtb.58.2019.02.28.09.57.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 09:57:04 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EB7914039C; Thu, 28 Feb 2019 14:57:01 -0300 (-03)
Date:   Thu, 28 Feb 2019 14:57:01 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf util: Refactor time range parsing code
Message-ID: <20190228175701.GC9508@kernel.org>
References: <1551364210-31350-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551364210-31350-1-git-send-email-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 28, 2019 at 10:30:09PM +0800, Jin Yao escreveu:
> Jiri points out that we don't need any time checking and time string
> parsing if the --time option is not set. That makes sense.
> 
> This patch refactors the time range parsing code, move the duplicated
> code from perf report and perf script to time_utils and check if --time
> option is set before parsing the time string.

So, this should come with a "No logic change expected", but I'd say that
for this to be more quickly/easily tested, please provide intructions
about how to test that this indeed didn't change anything inadvertently.

Simply looking at the code should be enough, but having instructions on
how to use this helps in testing and advertises further the feature.

I.e. try not to lose an opportunity to teach about these perf features
:-)

- Arnaldo
 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/builtin-report.c  | 38 +++++++--------------------------
>  tools/perf/builtin-script.c  | 39 +++++++--------------------------
>  tools/perf/util/time-utils.c | 51 +++++++++++++++++++++++++++++++++++++++++++-
>  tools/perf/util/time-utils.h |  6 ++++++
>  4 files changed, 72 insertions(+), 62 deletions(-)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 1532ebd..ee93c18 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1375,36 +1375,13 @@ int cmd_report(int argc, const char **argv)
>  	if (symbol__init(&session->header.env) < 0)
>  		goto error;
>  
> -	report.ptime_range = perf_time__range_alloc(report.time_str,
> -						    &report.range_size);
> -	if (!report.ptime_range) {
> -		ret = -ENOMEM;
> -		goto error;
> -	}
> -
> -	if (perf_time__parse_str(report.ptime_range, report.time_str) != 0) {
> -		if (session->evlist->first_sample_time == 0 &&
> -		    session->evlist->last_sample_time == 0) {
> -			pr_err("HINT: no first/last sample time found in perf data.\n"
> -			       "Please use latest perf binary to execute 'perf record'\n"
> -			       "(if '--buildid-all' is enabled, please set '--timestamp-boundary').\n");
> -			ret = -EINVAL;
> -			goto error;
> -		}
> -
> -		report.range_num = perf_time__percent_parse_str(
> -					report.ptime_range, report.range_size,
> -					report.time_str,
> -					session->evlist->first_sample_time,
> -					session->evlist->last_sample_time);
> -
> -		if (report.range_num < 0) {
> -			pr_err("Invalid time string\n");
> -			ret = -EINVAL;
> +	if (report.time_str) {
> +		ret = perf_time__parse_for_ranges(report.time_str, session,
> +						  &report.ptime_range,
> +						  &report.range_size,
> +						  &report.range_num);
> +		if (ret < 0)
>  			goto error;
> -		}
> -	} else {
> -		report.range_num = 1;
>  	}
>  
>  	if (session->tevent.pevent &&
> @@ -1426,7 +1403,8 @@ int cmd_report(int argc, const char **argv)
>  		ret = 0;
>  
>  error:
> -	zfree(&report.ptime_range);
> +	if (report.ptime_range)
> +		zfree(&report.ptime_range);
>  
>  	perf_session__delete(session);
>  	return ret;
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 2d8cb1d..53f78cf 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3699,37 +3699,13 @@ int cmd_script(int argc, const char **argv)
>  	if (err < 0)
>  		goto out_delete;
>  
> -	script.ptime_range = perf_time__range_alloc(script.time_str,
> -						    &script.range_size);
> -	if (!script.ptime_range) {
> -		err = -ENOMEM;
> -		goto out_delete;
> -	}
> -
> -	/* needs to be parsed after looking up reference time */
> -	if (perf_time__parse_str(script.ptime_range, script.time_str) != 0) {
> -		if (session->evlist->first_sample_time == 0 &&
> -		    session->evlist->last_sample_time == 0) {
> -			pr_err("HINT: no first/last sample time found in perf data.\n"
> -			       "Please use latest perf binary to execute 'perf record'\n"
> -			       "(if '--buildid-all' is enabled, please set '--timestamp-boundary').\n");
> -			err = -EINVAL;
> -			goto out_delete;
> -		}
> -
> -		script.range_num = perf_time__percent_parse_str(
> -					script.ptime_range, script.range_size,
> -					script.time_str,
> -					session->evlist->first_sample_time,
> -					session->evlist->last_sample_time);
> -
> -		if (script.range_num < 0) {
> -			pr_err("Invalid time string\n");
> -			err = -EINVAL;
> +	if (script.time_str) {
> +		err = perf_time__parse_for_ranges(script.time_str, session,
> +						  &script.ptime_range,
> +						  &script.range_size,
> +						  &script.range_num);
> +		if (err < 0)
>  			goto out_delete;
> -		}
> -	} else {
> -		script.range_num = 1;
>  	}
>  
>  	err = __cmd_script(&script);
> @@ -3737,7 +3713,8 @@ int cmd_script(int argc, const char **argv)
>  	flush_scripting();
>  
>  out_delete:
> -	zfree(&script.ptime_range);
> +	if (script.ptime_range)
> +		zfree(&script.ptime_range);
>  
>  	perf_evlist__free_stats(session->evlist);
>  	perf_session__delete(session);
> diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
> index 6193b46..0f53bae 100644
> --- a/tools/perf/util/time-utils.c
> +++ b/tools/perf/util/time-utils.c
> @@ -11,6 +11,8 @@
>  #include "perf.h"
>  #include "debug.h"
>  #include "time-utils.h"
> +#include "session.h"
> +#include "evlist.h"
>  
>  int parse_nsec_time(const char *str, u64 *ptime)
>  {
> @@ -374,7 +376,7 @@ bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
>  	struct perf_time_interval *ptime;
>  	int i;
>  
> -	if ((timestamp == 0) || (num == 0))
> +	if ((!ptime_buf) || (timestamp == 0) || (num == 0))
>  		return false;
>  
>  	if (num == 1)
> @@ -396,6 +398,53 @@ bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
>  	return (i == num) ? true : false;
>  }
>  
> +int perf_time__parse_for_ranges(const char *time_str,
> +				struct perf_session *session,
> +				struct perf_time_interval **ranges,
> +				int *range_size, int *range_num)
> +{
> +	struct perf_time_interval *ptime_range;
> +	int size, num, ret;
> +
> +	ptime_range = perf_time__range_alloc(time_str, &size);
> +	if (!ptime_range)
> +		return -ENOMEM;
> +
> +	if (perf_time__parse_str(ptime_range, time_str) != 0) {
> +		if (session->evlist->first_sample_time == 0 &&
> +		    session->evlist->last_sample_time == 0) {
> +			pr_err("HINT: no first/last sample time found in perf data.\n"
> +			       "Please use latest perf binary to execute 'perf record'\n"
> +			       "(if '--buildid-all' is enabled, please set '--timestamp-boundary').\n");
> +			ret = -EINVAL;
> +			goto error;
> +		}
> +
> +		num = perf_time__percent_parse_str(
> +				ptime_range, size,
> +				time_str,
> +				session->evlist->first_sample_time,
> +				session->evlist->last_sample_time);
> +
> +		if (num < 0) {
> +			pr_err("Invalid time string\n");
> +			ret = -EINVAL;
> +			goto error;
> +		}
> +	} else {
> +		num = 1;
> +	}
> +
> +	*range_size = size;
> +	*range_num = num;
> +	*ranges = ptime_range;
> +	return 0;
> +
> +error:
> +	free(ptime_range);
> +	return ret;
> +}
> +
>  int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz)
>  {
>  	u64  sec = timestamp / NSEC_PER_SEC;
> diff --git a/tools/perf/util/time-utils.h b/tools/perf/util/time-utils.h
> index 70b177d..b923de4 100644
> --- a/tools/perf/util/time-utils.h
> +++ b/tools/perf/util/time-utils.h
> @@ -23,6 +23,12 @@ bool perf_time__skip_sample(struct perf_time_interval *ptime, u64 timestamp);
>  bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
>  				   int num, u64 timestamp);
>  
> +struct perf_session;
> +
> +int perf_time__parse_for_ranges(const char *str, struct perf_session *session,
> +				struct perf_time_interval **ranges,
> +				int *range_size, int *range_num);
> +
>  int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz);
>  
>  int fetch_current_timestamp(char *buf, size_t sz);
> -- 
> 2.7.4

-- 

- Arnaldo
