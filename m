Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1431FC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA732071C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfKRMaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 07:30:18 -0500
Received: from mga18.intel.com ([134.134.136.126]:19878 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbfKRMaR (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 07:30:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 04:30:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,320,1569308400"; 
   d="scan'208";a="215291753"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.212.51]) ([10.254.212.51])
  by fmsmga001.fm.intel.com with ESMTP; 18 Nov 2019 04:30:14 -0800
Subject: Re: [PATCH v1 2/2] perf report: Jump to symbol source view from total
 cycles view
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20191113004852.21265-1-yao.jin@linux.intel.com>
 <20191113004852.21265-2-yao.jin@linux.intel.com>
 <20191115133438.GA25491@krava>
 <cbf51f14-dc76-9030-2dce-6d83122a15c4@linux.intel.com>
 <20191118104737.GF28372@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <bf27b851-d91c-8934-4c55-000b8e8f66a2@linux.intel.com>
Date:   Mon, 18 Nov 2019 20:30:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191118104737.GF28372@krava>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/18/2019 6:47 PM, Jiri Olsa wrote:
> On Sun, Nov 17, 2019 at 08:12:02PM +0800, Jin, Yao wrote:
>>
>>
>> On 11/15/2019 9:34 PM, Jiri Olsa wrote:
>>> On Wed, Nov 13, 2019 at 08:48:52AM +0800, Jin Yao wrote:
>>>> This patch supports jumping from tui total cycles view to symbol
>>>> source view.
>>>>
>>>> For example,
>>>>
>>>> perf record -b ./div
>>>> perf report --total-cycles
>>>>
>>>> In total cycles view, we can select one entry and press 'a' or
>>>> press ENTER key to jump to symbol source view.
>>>>
>>>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>>>> ---
>>>>    tools/perf/builtin-report.c    |  9 ++++++---
>>>>    tools/perf/ui/browsers/hists.c | 25 +++++++++++++++++++++++--
>>>>    tools/perf/util/block-info.c   |  6 ++++--
>>>>    tools/perf/util/block-info.h   |  3 ++-
>>>>    tools/perf/util/hist.h         |  7 +++++--
>>>>    5 files changed, 40 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
>>>> index 1e81985b7d56..ceebea4013ca 100644
>>>> --- a/tools/perf/builtin-report.c
>>>> +++ b/tools/perf/builtin-report.c
>>>> @@ -493,7 +493,9 @@ static int perf_evlist__tui_block_hists_browse(struct evlist *evlist,
>>>>    	evlist__for_each_entry(evlist, pos) {
>>>>    		ret = report__browse_block_hists(&rep->block_reports[i++].hist,
>>>> -						 rep->min_percent, pos);
>>>> +						 rep->min_percent, pos,
>>>> +						 &rep->session->header.env,
>>>> +						 &rep->annotation_opts);
>>>>    		if (ret != 0)
>>>>    			return ret;
>>>>    	}
>>>> @@ -525,7 +527,8 @@ static int perf_evlist__tty_browse_hists(struct evlist *evlist,
>>>>    		if (rep->total_cycles_mode) {
>>>>    			report__browse_block_hists(&rep->block_reports[i++].hist,
>>>> -						   rep->min_percent, pos);
>>>> +						   rep->min_percent, pos,
>>>> +						   NULL, NULL);
>>>>    			continue;
>>>>    		}
>>>> @@ -1418,7 +1421,7 @@ int cmd_report(int argc, const char **argv)
>>>>    		if (sort__mode != SORT_MODE__BRANCH)
>>>>    			report.total_cycles_mode = false;
>>>>    		else
>>>> -			sort_order = "sym";
>>>> +			sort_order = NULL;
>>>
>>> hum, how is this related to this change?
>>>
>>> jirka
>>>
>>
>> Hi Jiri,
>>
>> If we set the sort_order to NULL, it will use the default branch sort order.
>> The percent value in new annotate view will be consistent with the percent
>> in annotate view which is switched from perf report.
>>
>> I observed the original percent gap with previous patches and then I decide
>> to use the default sort order. Now the test result looks good.
> 
> ok, plz make note of it in changelog or comment
> 
> thanks,
> jirka
> 

OK, I see, thanks Jiri! I will post v2.

Thanks
Jin Yao
