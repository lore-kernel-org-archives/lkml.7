Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E22C3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 01:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE342086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 01:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfHPBWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 21:22:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:64840 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbfHPBWS (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 21:22:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 18:22:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,391,1559545200"; 
   d="scan'208";a="171276273"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.32]) ([10.239.196.32])
  by orsmga008.jf.intel.com with ESMTP; 15 Aug 2019 18:22:16 -0700
Subject: Re: [PATCH v4] perf diff: Report noisy for cycles diff
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20190813073037.3420-1-yao.jin@linux.intel.com>
 <20190815132236.GH30356@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <0651bf65-12bb-f6df-003b-996dae2c4010@linux.intel.com>
Date:   Fri, 16 Aug 2019 09:22:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815132236.GH30356@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/2019 9:22 PM, Jiri Olsa wrote:
> On Tue, Aug 13, 2019 at 03:30:37PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>>   static void
>>   hpp__entry_unpair(struct hist_entry *he, int idx, char *buf, size_t size)
>>   {
>> @@ -1662,6 +1794,10 @@ static void data__hpp_register(struct data__file *d, int idx)
>>   		fmt->color = hpp__color_cycles;
>>   		fmt->sort  = hist_entry__cmp_nop;
>>   		break;
>> +	case PERF_HPP_DIFF__CYCLES_HIST:
>> +		fmt->color = hpp__color_cycles_hist;
>> +		fmt->sort  = hist_entry__cmp_nop;
>> +		break;
>>   	default:
>>   		fmt->sort  = hist_entry__cmp_nop;
>>   		break;
>> @@ -1688,8 +1824,15 @@ static int ui_init(void)
>>   		 *   PERF_HPP_DIFF__RATIO
>>   		 *   PERF_HPP_DIFF__WEIGHTED_DIFF
>>   		 */
>> -		data__hpp_register(d, i ? compute_2_hpp[compute] :
>> -					  PERF_HPP_DIFF__BASELINE);
>> +		if (cycles_hist && (compute == COMPUTE_CYCLES)) {
>> +			data__hpp_register(d, i ? PERF_HPP_DIFF__CYCLES :
>> +						  PERF_HPP_DIFF__BASELINE);
>> +			data__hpp_register(d, i ? PERF_HPP_DIFF__CYCLES_HIST :
>> +						  PERF_HPP_DIFF__BASELINE);
>> +		} else {
>> +			data__hpp_register(d, i ? compute_2_hpp[compute] :
>> +						  PERF_HPP_DIFF__BASELINE);
>> +		}
> 
> I tink that something like this might be less confusing instead of above:
> 
>                  if (cycles_hist && i && (compute == COMPUTE_CYCLES))
>                          data__hpp_register(d, PERF_HPP_DIFF__CYCLES);
> 
> other than that the patch looks ok to me
> 
> jirka
> 

Yes, your code is more beautiful. Thanks so much! :)

Thanks
Jin Yao
