Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561BBC28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 01:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BED2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 01:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfFFB5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 21:57:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:56666 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbfFFB5U (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 21:57:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 18:57:19 -0700
X-ExtLoop1: 1
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.71]) ([10.239.196.71])
  by orsmga002.jf.intel.com with ESMTP; 05 Jun 2019 18:57:16 -0700
Subject: Re: [PATCH v2 4/7] perf diff: Use hists to manage basic blocks per
 symbol
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <1559572577-25436-1-git-send-email-yao.jin@linux.intel.com>
 <1559572577-25436-5-git-send-email-yao.jin@linux.intel.com>
 <20190605114450.GF5868@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <62fc9072-627c-52f2-0edc-1932f884fb54@linux.intel.com>
Date:   Thu, 6 Jun 2019 09:57:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605114450.GF5868@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/2019 7:44 PM, Jiri Olsa wrote:
> On Mon, Jun 03, 2019 at 10:36:14PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>>   		data__for_each_file_new(i, d) {
>>   			pair = get_pair_data(he, d);
>>   			if (!pair)
>> @@ -510,6 +683,9 @@ static void hists__precompute(struct hists *hists)
>>   			case COMPUTE_WEIGHTED_DIFF:
>>   				compute_wdiff(he, pair);
>>   				break;
>> +			case COMPUTE_CYCLES:
>> +				process_block_per_sym(pair, d);
>> +				break;
>>   			default:
>>   				BUG_ON(1);
>>   			}
>> @@ -713,6 +889,14 @@ hist_entry__cmp_wdiff_idx(struct perf_hpp_fmt *fmt __maybe_unused,
>>   					   sort_compute);
>>   }
>>   
>> +static int64_t
>> +hist_entry__cmp_cycles_idx(struct perf_hpp_fmt *fmt __maybe_unused,
>> +			   struct hist_entry *left __maybe_unused,
>> +			   struct hist_entry *right __maybe_unused)
>> +{
>> +	return 0;
>> +}
> 
> this is hist_entry__cmp_nop.. please use it instead and
> explain in comment why for COMPUTE_CYCLES we need the
> default sort
> 
> jirka
> 

fmt->sort should be set otherwise since fmt->sort will be called without 
checking valid, the crash happens. Yes, I should use hist_entry__cmp_nop 
instead, and will add some comments for COMPUTE_CYCLES.

Thanks
Jin Yao


