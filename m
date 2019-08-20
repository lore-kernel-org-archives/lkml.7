Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B1AC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3D222CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbfHTL74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 07:59:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:43578 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728731AbfHTL7z (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 07:59:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 04:59:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="169060576"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.212.127]) ([10.254.212.127])
  by orsmga007.jf.intel.com with ESMTP; 20 Aug 2019 04:59:53 -0700
Subject: Re: [PATCH v5] perf diff: Report noisy for cycles diff
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20190816021343.27160-1-yao.jin@linux.intel.com>
 <20190820083447.GA19265@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <5cd84513-77a5-223d-db22-f90aacab740d@linux.intel.com>
Date:   Tue, 20 Aug 2019 19:59:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820083447.GA19265@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/20/2019 4:34 PM, Jiri Olsa wrote:
> On Fri, Aug 16, 2019 at 10:13:43AM +0800, Jin Yao wrote:
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
>> @@ -1688,8 +1824,13 @@ static int ui_init(void)
>>   		 *   PERF_HPP_DIFF__RATIO
>>   		 *   PERF_HPP_DIFF__WEIGHTED_DIFF
>>   		 */
>> -		data__hpp_register(d, i ? compute_2_hpp[compute] :
>> -					  PERF_HPP_DIFF__BASELINE);
>> +		if (cycles_hist && i && (compute == COMPUTE_CYCLES)) {
>> +			data__hpp_register(d, PERF_HPP_DIFF__CYCLES);
>> +			data__hpp_register(d, PERF_HPP_DIFF__CYCLES_HIST);
>> +		} else {
>> +			data__hpp_register(d, i ? compute_2_hpp[compute] :
>> +						  PERF_HPP_DIFF__BASELINE);
>> +		}
> 
> 
> hum, why can't it be just like we treat other extra columns:
> 
> ---
> @@ -1687,6 +1823,7 @@ static int ui_init(void)
>   		 *   PERF_HPP_DIFF__DELTA
>   		 *   PERF_HPP_DIFF__RATIO
>   		 *   PERF_HPP_DIFF__WEIGHTED_DIFF
> +		 *   PERF_HPP_DIFF__CYCLES
>   		 */
>   		data__hpp_register(d, i ? compute_2_hpp[compute] :
>   					  PERF_HPP_DIFF__BASELINE);
> @@ -1704,6 +1841,9 @@ static int ui_init(void)
>   		if (show_period)
>   			data__hpp_register(d, i ? PERF_HPP_DIFF__PERIOD :
>   						  PERF_HPP_DIFF__PERIOD_BASELINE);
> +
> +		if (cycles_hist && i)
> +			data__hpp_register(d, PERF_HPP_DIFF__CYCLES_HIST);
> 
> 
> thanks,
> jirka
> 

Hi Jiri,

Yes, thanks, your code is better. Thanks so much!

Thanks
Jin Yao
