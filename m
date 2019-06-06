Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E79C28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 01:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04932083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 01:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfFFB0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 21:26:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:61753 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfFFB0V (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 21:26:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 18:26:20 -0700
X-ExtLoop1: 1
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.71]) ([10.239.196.71])
  by orsmga002.jf.intel.com with ESMTP; 05 Jun 2019 18:26:19 -0700
Subject: Re: [PATCH v2 4/7] perf diff: Use hists to manage basic blocks per
 symbol
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <1559572577-25436-1-git-send-email-yao.jin@linux.intel.com>
 <1559572577-25436-5-git-send-email-yao.jin@linux.intel.com>
 <20190605114432.GD5868@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <1a9d402b-5f60-d34a-74fe-3bfb78c9b31e@linux.intel.com>
Date:   Thu, 6 Jun 2019 09:26:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605114432.GD5868@krava>
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
>> +
>>   static void hists__process(struct hists *hists)
>>   {
>>   	if (show_baseline_only)
>> @@ -746,6 +930,8 @@ static void data_process(void)
>>   	struct perf_evsel *evsel_base;
>>   	bool first = true;
>>   
>> +	memset(&dummy_al, 0, sizeof(dummy_al));
> 
> why is this needed? it's zero by static declaration, and it's never set, right?
> 
> jirka
> 

C standard says yes for initializing static variables to 0, but I just 
want to avoid any potential for unexpected behavior. Maybe I was over 
thinking it. I will remove this line.

Thanks
Jin Yao
