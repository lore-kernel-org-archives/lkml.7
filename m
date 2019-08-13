Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84E7C31E40
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 00:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5552206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 00:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfHMAte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 20:49:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:52572 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbfHMAte (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 20:49:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 17:49:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,379,1559545200"; 
   d="scan'208";a="259965205"
Received: from unknown (HELO [10.239.196.24]) ([10.239.196.24])
  by orsmga001.jf.intel.com with ESMTP; 12 Aug 2019 17:49:31 -0700
Subject: Re: [PATCH v3] perf diff: Report noisy for cycles diff
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20190809233029.12265-1-yao.jin@linux.intel.com>
 <20190812083549.GB11752@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <28ce9bd0-dbbf-9e27-d40d-dafb0667a3b8@linux.intel.com>
Date:   Tue, 13 Aug 2019 08:49:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812083549.GB11752@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/12/2019 4:35 PM, Jiri Olsa wrote:
> On Sat, Aug 10, 2019 at 07:30:29AM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> +
>> +		init_stats(&pair->diff.stats);
>> +		init_spark_values(pair->diff.svals, NUM_SPARKS);
>> +
>> +		for (int i = 0; i < pair->block_info->num; i++) {
>> +			u64 val;
>> +
>> +			if (i >= he->block_info->num || i >= NUM_SPARKS)
>> +				break;
>> +
>> +			val = labs(pair->block_info->cycles_spark[i] -
>> +				     he->block_info->cycles_spark[i]);
>> +
>> +			update_spark_value(pair->diff.svals, NUM_SPARKS,
>> +					   &pair->diff.stats, val);
>> +			update_stats(&pair->diff.stats, val);
>> +		}
>>   	}
>>   }
>>   
>> @@ -1250,6 +1292,8 @@ static const struct option options[] = {
>>   		    "Show period values."),
>>   	OPT_BOOLEAN('F', "formula", &show_formula,
>>   		    "Show formula."),
>> +	OPT_BOOLEAN('n', "noisy", &show_noisy,
>> +		    "Show cycles noisy - WARNING: use only with -c cycles."),
> 
> this should be more 'cycles' specific like --cycles-noisy or --cycles-hist?
> 
> also I dont think we should use 'n' for this, just the long option
> 
> jirka
> 

Yes, it's cycles specific. Maybe --cycles-hist is better and the long 
option should be enough. We can reserve -n for future feature. :)

Thanks
Jin Yao
