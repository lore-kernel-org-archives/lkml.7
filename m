Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFC3C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D236F222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfLSMio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:38:44 -0500
Received: from mga01.intel.com ([192.55.52.88]:46391 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfLSMin (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:38:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 04:38:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,331,1571727600"; 
   d="scan'208";a="222278232"
Received: from licongzh-mobl.ccr.corp.intel.com (HELO [10.254.208.198]) ([10.254.208.198])
  by fmsmga001.fm.intel.com with ESMTP; 19 Dec 2019 04:38:40 -0800
Subject: Re: [PATCH v5 4/4] perf report: support hotkey to let user select any
 event for sorting
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20191219060929.3714-1-yao.jin@linux.intel.com>
 <20191219060929.3714-4-yao.jin@linux.intel.com> <20191219091008.GB8141@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <c1f18601-41d5-451d-4278-b7adb08674c3@linux.intel.com>
Date:   Thu, 19 Dec 2019 20:38:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191219091008.GB8141@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/19/2019 5:10 PM, Jiri Olsa wrote:
> On Thu, Dec 19, 2019 at 02:09:29PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> +		case '0' ... '9':
>> +			if (!symbol_conf.event_group ||
>> +			    evsel->core.nr_members < 2) {
>> +				snprintf(buf, sizeof(buf),
>> +					 "Sort by index only available with group events!");
>> +				helpline = buf;
>> +				continue;
>> +			}
>> +
>> +			symbol_conf.group_sort_idx = key - '0';
>> +
>> +			if (symbol_conf.group_sort_idx >= evsel->core.nr_members) {
>> +				snprintf(buf, sizeof(buf),
>> +					 "Max event group index to sort is %d (index from 0 to %d)",
>> +					 evsel->core.nr_members - 1,
>> +					 evsel->core.nr_members - 1);
>> +				helpline = buf;
>> +				continue;
>> +			}
>> +
>> +			key = K_RELOAD;
>> +			goto out_free_stack;
>>   		case 'a':
>>   			if (!hists__has(hists, sym)) {
>>   				ui_browser__warning(&browser->b, delay_secs * 2,
>> -- 
>> 2.17.1
>>
> 
> maybe also something like this to eliminate unneeded refresh?
> 
> jirka
> 
> 
> ---
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index 22e76bd1a2d9..9f5dd48500a2 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -2947,6 +2947,9 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
>   				continue;
>   			}
>   
> +			if (key - '0' == symbol_conf.group_sort_idx)
> +				continue;
> +
>   			symbol_conf.group_sort_idx = key - '0';
>   
>   			if (symbol_conf.group_sort_idx >= evsel->core.nr_members) {
> 

Hi Jiri,

Thanks, I think it's a good improvement. It can avoid the unnecessary 
refresh.

If no more comments on this patch-set, I will add this improvement and 
then post v6.

Thanks
Jin Yao
