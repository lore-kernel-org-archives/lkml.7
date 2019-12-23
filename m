Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E5FC2D0C8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 00:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A548E20708
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 00:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfLWAzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 19:55:04 -0500
Received: from mga05.intel.com ([192.55.52.43]:56451 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfLWAzD (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 19:55:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Dec 2019 16:55:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,345,1571727600"; 
   d="scan'208";a="213777740"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.111]) ([10.239.196.111])
  by fmsmga007.fm.intel.com with ESMTP; 22 Dec 2019 16:55:01 -0800
Subject: Re: [PATCH v6 1/4] perf report: Fix incorrectly added dimensions as
 switch perf data file
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20191220013722.20592-1-yao.jin@linux.intel.com>
 <20191220163438.GA18798@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <7d517778-3edc-eeab-587a-ad09db978647@linux.intel.com>
Date:   Mon, 23 Dec 2019 08:55:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191220163438.GA18798@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/21/2019 12:34 AM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Dec 20, 2019 at 09:37:19AM +0800, Jin Yao escreveu:
>> We observed an issue that was some extra columns displayed after switching
>> perf data file in browser. The steps to reproduce:
>>
>> 1. perf record -a -e cycles,instructions -- sleep 3
>> 2. perf report --group
>> 3. In browser, we use hotkey 's' to switch to another perf.data
>> 4. Now in browser, the extra columns 'Self' and 'Children' are displayed.
>>
>> The issue is setup_sorting() executed again after repeat path, so dimensions
>> are added again.
>>
>> This patch checks the last key returned from __cmd_report(). If it's
>> K_SWITCH_INPUT_DATA, skips the setup_sorting().
> 
> you forgot to add this right?
> 
> Cc: Feng Tang <feng.tang@intel.com>
> Fixes: ad0de0971b7f ("perf report: Enable the runtime switching of perf data file")
>   

Yes, I should add this in patch description. Thanks for reminding

Do you need me to resend this patch-set (v7)?

Thanks
Jin Yao

>>   v6:
>>   ---
>>   No change.
>>
>>   v5:
>>   ---
>>   New patch in v5.
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/builtin-report.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
>> index 387311c67264..de988589d99b 100644
>> --- a/tools/perf/builtin-report.c
>> +++ b/tools/perf/builtin-report.c
>> @@ -1076,6 +1076,7 @@ int cmd_report(int argc, const char **argv)
>>   	struct stat st;
>>   	bool has_br_stack = false;
>>   	int branch_mode = -1;
>> +	int last_key = 0;
>>   	bool branch_call_mode = false;
>>   #define CALLCHAIN_DEFAULT_OPT  "graph,0.5,caller,function,percent"
>>   	static const char report_callchain_help[] = "Display call graph (stack chain/backtrace):\n\n"
>> @@ -1450,7 +1451,8 @@ int cmd_report(int argc, const char **argv)
>>   		sort_order = sort_tmp;
>>   	}
>>   
>> -	if (setup_sorting(session->evlist) < 0) {
>> +	if ((last_key != K_SWITCH_INPUT_DATA) &&
>> +	    (setup_sorting(session->evlist) < 0)) {
>>   		if (sort_order)
>>   			parse_options_usage(report_usage, options, "s", 1);
>>   		if (field_order)
>> @@ -1530,6 +1532,7 @@ int cmd_report(int argc, const char **argv)
>>   	ret = __cmd_report(&report);
>>   	if (ret == K_SWITCH_INPUT_DATA) {
>>   		perf_session__delete(session);
>> +		last_key = K_SWITCH_INPUT_DATA;
>>   		goto repeat;
>>   	} else
>>   		ret = 0;
>> -- 
>> 2.17.1
> 
