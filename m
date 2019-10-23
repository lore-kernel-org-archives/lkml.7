Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F48CCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B05A20640
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405380AbfJWMrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:47:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:29838 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405290AbfJWMrl (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:47:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 05:47:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="196766480"
Received: from shilongz-mobl.ccr.corp.intel.com (HELO [10.254.210.50]) ([10.254.210.50])
  by fmsmga008.fm.intel.com with ESMTP; 23 Oct 2019 05:47:38 -0700
Subject: Re: [PATCH v3 1/5] perf util: Cleanup and refactor block info
 functions
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20191022080710.6491-1-yao.jin@linux.intel.com>
 <20191022080710.6491-2-yao.jin@linux.intel.com>
 <20191023113703.GQ22919@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <abda4105-41ab-7e5e-236e-d048dfe3abed@linux.intel.com>
Date:   Wed, 23 Oct 2019 20:47:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191023113703.GQ22919@krava>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/23/2019 7:37 PM, Jiri Olsa wrote:
> On Tue, Oct 22, 2019 at 04:07:06PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>>   
>> -static int filter_cb(struct hist_entry *he, void *arg __maybe_unused)
>> -{
>> -	/* Skip the calculation of column length in output_resort */
>> -	he->filtered = true;
>> -	return 0;
>> -}
> 
> please move this change into separate patch and explain in changelog
> why this is necessary
> 
> thanks,
> jirka
> 

Got it. I will move this change into a separate patch.

Thanks
Jin Yao

>> -
>>   static void hists__precompute(struct hists *hists)
>>   {
>>   	struct rb_root_cached *root;
>> @@ -792,8 +695,11 @@ static void hists__precompute(struct hists *hists)
>>   		he   = rb_entry(next, struct hist_entry, rb_node_in);
>>   		next = rb_next(&he->rb_node_in);
>>   
>> -		if (compute == COMPUTE_CYCLES)
>> -			process_block_per_sym(he);
>> +		if (compute == COMPUTE_CYCLES) {
>> +			bh = container_of(he, struct block_hist, he);
>> +			init_block_hist(bh);
>> +			block_info__process_sym(he, bh, NULL, 0);
>> +		}
>>   
>>   		data__for_each_file_new(i, d) {
>>   			pair = get_pair_data(he, d);
>> @@ -812,16 +718,18 @@ static void hists__precompute(struct hists *hists)
>>   				compute_wdiff(he, pair);
>>   				break;
>>   			case COMPUTE_CYCLES:
>> -				process_block_per_sym(pair);
>> -				bh = container_of(he, struct block_hist, he);
>>   				pair_bh = container_of(pair, struct block_hist,
>>   						       he);
>> +				init_block_hist(pair_bh);
>> +				block_info__process_sym(pair, pair_bh, NULL, 0);
>> +
>> +				bh = container_of(he, struct block_hist, he);
>>   
>>   				if (bh->valid && pair_bh->valid) {
>>   					block_hists_match(&bh->block_hists,
>>   							  &pair_bh->block_hists);
>> -					hists__output_resort_cb(&pair_bh->block_hists,
>> -								NULL, filter_cb);
>> +					hists__output_resort(&pair_bh->block_hists,
>> +							     NULL);
>>   				}
>>   				break;
>>   			default:
> 
> SNIP
> 
>> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
>> index 679a1d75090c..a7fa061987e4 100644
>> --- a/tools/perf/util/hist.c
>> +++ b/tools/perf/util/hist.c
>> @@ -18,6 +18,7 @@
>>   #include "srcline.h"
>>   #include "symbol.h"
>>   #include "thread.h"
>> +#include "block-info.h"
>>   #include "ui/progress.h"
>>   #include <errno.h>
>>   #include <math.h>
>> @@ -80,6 +81,8 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
>>   	int symlen;
>>   	u16 len;
>>   
>> +	if (h->block_info)
>> +		return;
>>   	/*
>>   	 * +4 accounts for '[x] ' priv level info
>>   	 * +2 accounts for 0x prefix on raw addresses
> 
> SNIP
> 
