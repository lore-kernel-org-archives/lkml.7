Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACE0C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 00:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDD22085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 00:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732935AbfCAAzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 19:55:11 -0500
Received: from mga09.intel.com ([134.134.136.24]:28719 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbfCAAzK (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 19:55:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2019 16:55:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,425,1544515200"; 
   d="scan'208";a="150978394"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.159.76]) ([10.239.159.76])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2019 16:55:06 -0800
Subject: Re: [PATCH] perf util: Refactor time range parsing code
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <1551364210-31350-1-git-send-email-yao.jin@linux.intel.com>
 <20190228175701.GC9508@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <9537c5a0-66a2-1135-1bb1-a33b251ca666@linux.intel.com>
Date:   Fri, 1 Mar 2019 08:55:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190228175701.GC9508@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/1/2019 1:57 AM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Feb 28, 2019 at 10:30:09PM +0800, Jin Yao escreveu:
>> Jiri points out that we don't need any time checking and time string
>> parsing if the --time option is not set. That makes sense.
>>
>> This patch refactors the time range parsing code, move the duplicated
>> code from perf report and perf script to time_utils and check if --time
>> option is set before parsing the time string.
> 
> So, this should come with a "No logic change expected", but I'd say that
> for this to be more quickly/easily tested, please provide intructions
> about how to test that this indeed didn't change anything inadvertently.
> 
> Simply looking at the code should be enough, but having instructions on
> how to use this helps in testing and advertises further the feature.
> 
> I.e. try not to lose an opportunity to teach about these perf features
> :-)
> 
> - Arnaldo
>   

Oh, yes, you are right. I should provide some information in patch 
description about how to test that. I will add this instructions in v2.

Thanks
Jin Yao

>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/builtin-report.c  | 38 +++++++--------------------------
>>   tools/perf/builtin-script.c  | 39 +++++++--------------------------
>>   tools/perf/util/time-utils.c | 51 +++++++++++++++++++++++++++++++++++++++++++-
>>   tools/perf/util/time-utils.h |  6 ++++++
>>   4 files changed, 72 insertions(+), 62 deletions(-)
>>
>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
>> index 1532ebd..ee93c18 100644
>> --- a/tools/perf/builtin-report.c
>> +++ b/tools/perf/builtin-report.c
>> @@ -1375,36 +1375,13 @@ int cmd_report(int argc, const char **argv)
>>   	if (symbol__init(&session->header.env) < 0)
>>   		goto error;
>>   
>> -	report.ptime_range = perf_time__range_alloc(report.time_str,
>> -						    &report.range_size);
>> -	if (!report.ptime_range) {
>> -		ret = -ENOMEM;
>> -		goto error;
>> -	}
>> -
>> -	if (perf_time__parse_str(report.ptime_range, report.time_str) != 0) {
>> -		if (session->evlist->first_sample_time == 0 &&
>> -		    session->evlist->last_sample_time == 0) {
>> -			pr_err("HINT: no first/last sample time found in perf data.\n"
>> -			       "Please use latest perf binary to execute 'perf record'\n"
>> -			       "(if '--buildid-all' is enabled, please set '--timestamp-boundary').\n");
>> -			ret = -EINVAL;
>> -			goto error;
>> -		}
>> -
>> -		report.range_num = perf_time__percent_parse_str(
>> -					report.ptime_range, report.range_size,
>> -					report.time_str,
>> -					session->evlist->first_sample_time,
>> -					session->evlist->last_sample_time);
>> -
>> -		if (report.range_num < 0) {
>> -			pr_err("Invalid time string\n");
>> -			ret = -EINVAL;
>> +	if (report.time_str) {
>> +		ret = perf_time__parse_for_ranges(report.time_str, session,
>> +						  &report.ptime_range,
>> +						  &report.range_size,
>> +						  &report.range_num);
>> +		if (ret < 0)
>>   			goto error;
>> -		}
>> -	} else {
>> -		report.range_num = 1;
>>   	}
>>   
>>   	if (session->tevent.pevent &&
>> @@ -1426,7 +1403,8 @@ int cmd_report(int argc, const char **argv)
>>   		ret = 0;
>>   
>>   error:
>> -	zfree(&report.ptime_range);
>> +	if (report.ptime_range)
>> +		zfree(&report.ptime_range);
>>   
>>   	perf_session__delete(session);
>>   	return ret;
>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>> index 2d8cb1d..53f78cf 100644
>> --- a/tools/perf/builtin-script.c
>> +++ b/tools/perf/builtin-script.c
>> @@ -3699,37 +3699,13 @@ int cmd_script(int argc, const char **argv)
>>   	if (err < 0)
>>   		goto out_delete;
>>   
>> -	script.ptime_range = perf_time__range_alloc(script.time_str,
>> -						    &script.range_size);
>> -	if (!script.ptime_range) {
>> -		err = -ENOMEM;
>> -		goto out_delete;
>> -	}
>> -
>> -	/* needs to be parsed after looking up reference time */
>> -	if (perf_time__parse_str(script.ptime_range, script.time_str) != 0) {
>> -		if (session->evlist->first_sample_time == 0 &&
>> -		    session->evlist->last_sample_time == 0) {
>> -			pr_err("HINT: no first/last sample time found in perf data.\n"
>> -			       "Please use latest perf binary to execute 'perf record'\n"
>> -			       "(if '--buildid-all' is enabled, please set '--timestamp-boundary').\n");
>> -			err = -EINVAL;
>> -			goto out_delete;
>> -		}
>> -
>> -		script.range_num = perf_time__percent_parse_str(
>> -					script.ptime_range, script.range_size,
>> -					script.time_str,
>> -					session->evlist->first_sample_time,
>> -					session->evlist->last_sample_time);
>> -
>> -		if (script.range_num < 0) {
>> -			pr_err("Invalid time string\n");
>> -			err = -EINVAL;
>> +	if (script.time_str) {
>> +		err = perf_time__parse_for_ranges(script.time_str, session,
>> +						  &script.ptime_range,
>> +						  &script.range_size,
>> +						  &script.range_num);
>> +		if (err < 0)
>>   			goto out_delete;
>> -		}
>> -	} else {
>> -		script.range_num = 1;
>>   	}
>>   
>>   	err = __cmd_script(&script);
>> @@ -3737,7 +3713,8 @@ int cmd_script(int argc, const char **argv)
>>   	flush_scripting();
>>   
>>   out_delete:
>> -	zfree(&script.ptime_range);
>> +	if (script.ptime_range)
>> +		zfree(&script.ptime_range);
>>   
>>   	perf_evlist__free_stats(session->evlist);
>>   	perf_session__delete(session);
>> diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
>> index 6193b46..0f53bae 100644
>> --- a/tools/perf/util/time-utils.c
>> +++ b/tools/perf/util/time-utils.c
>> @@ -11,6 +11,8 @@
>>   #include "perf.h"
>>   #include "debug.h"
>>   #include "time-utils.h"
>> +#include "session.h"
>> +#include "evlist.h"
>>   
>>   int parse_nsec_time(const char *str, u64 *ptime)
>>   {
>> @@ -374,7 +376,7 @@ bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
>>   	struct perf_time_interval *ptime;
>>   	int i;
>>   
>> -	if ((timestamp == 0) || (num == 0))
>> +	if ((!ptime_buf) || (timestamp == 0) || (num == 0))
>>   		return false;
>>   
>>   	if (num == 1)
>> @@ -396,6 +398,53 @@ bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
>>   	return (i == num) ? true : false;
>>   }
>>   
>> +int perf_time__parse_for_ranges(const char *time_str,
>> +				struct perf_session *session,
>> +				struct perf_time_interval **ranges,
>> +				int *range_size, int *range_num)
>> +{
>> +	struct perf_time_interval *ptime_range;
>> +	int size, num, ret;
>> +
>> +	ptime_range = perf_time__range_alloc(time_str, &size);
>> +	if (!ptime_range)
>> +		return -ENOMEM;
>> +
>> +	if (perf_time__parse_str(ptime_range, time_str) != 0) {
>> +		if (session->evlist->first_sample_time == 0 &&
>> +		    session->evlist->last_sample_time == 0) {
>> +			pr_err("HINT: no first/last sample time found in perf data.\n"
>> +			       "Please use latest perf binary to execute 'perf record'\n"
>> +			       "(if '--buildid-all' is enabled, please set '--timestamp-boundary').\n");
>> +			ret = -EINVAL;
>> +			goto error;
>> +		}
>> +
>> +		num = perf_time__percent_parse_str(
>> +				ptime_range, size,
>> +				time_str,
>> +				session->evlist->first_sample_time,
>> +				session->evlist->last_sample_time);
>> +
>> +		if (num < 0) {
>> +			pr_err("Invalid time string\n");
>> +			ret = -EINVAL;
>> +			goto error;
>> +		}
>> +	} else {
>> +		num = 1;
>> +	}
>> +
>> +	*range_size = size;
>> +	*range_num = num;
>> +	*ranges = ptime_range;
>> +	return 0;
>> +
>> +error:
>> +	free(ptime_range);
>> +	return ret;
>> +}
>> +
>>   int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz)
>>   {
>>   	u64  sec = timestamp / NSEC_PER_SEC;
>> diff --git a/tools/perf/util/time-utils.h b/tools/perf/util/time-utils.h
>> index 70b177d..b923de4 100644
>> --- a/tools/perf/util/time-utils.h
>> +++ b/tools/perf/util/time-utils.h
>> @@ -23,6 +23,12 @@ bool perf_time__skip_sample(struct perf_time_interval *ptime, u64 timestamp);
>>   bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
>>   				   int num, u64 timestamp);
>>   
>> +struct perf_session;
>> +
>> +int perf_time__parse_for_ranges(const char *str, struct perf_session *session,
>> +				struct perf_time_interval **ranges,
>> +				int *range_size, int *range_num);
>> +
>>   int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz);
>>   
>>   int fetch_current_timestamp(char *buf, size_t sz);
>> -- 
>> 2.7.4
> 
