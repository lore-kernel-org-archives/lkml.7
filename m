Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29F2C28CC5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6952083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfFFCCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 22:02:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:64242 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbfFFCCy (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 22:02:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 19:02:53 -0700
X-ExtLoop1: 1
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.196.71]) ([10.239.196.71])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jun 2019 19:02:48 -0700
Subject: Re: [PATCH v2 6/7] perf diff: Print the basic block cycles diff
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <1559572577-25436-1-git-send-email-yao.jin@linux.intel.com>
 <1559572577-25436-7-git-send-email-yao.jin@linux.intel.com>
 <20190605114442.GE5868@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <049ff34b-b171-9c28-6e78-2e7b84ac30c8@linux.intel.com>
Date:   Thu, 6 Jun 2019 10:02:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605114442.GE5868@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/2019 7:44 PM, Jiri Olsa wrote:
> On Mon, Jun 03, 2019 at 10:36:16PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> -				break;
>>   			return setup_compute_opt(option);
>>   		}
>>   
>> @@ -949,6 +953,14 @@ hist_entry__cmp_wdiff(struct perf_hpp_fmt *fmt,
>>   }
>>   
>>   static int64_t
>> +hist_entry__cmp_cycles(struct perf_hpp_fmt *fmt __maybe_unused,
>> +		       struct hist_entry *left __maybe_unused,
>> +		       struct hist_entry *right __maybe_unused)
>> +{
>> +	return 0;
>> +}
> 
> we have hist_entry__cmp_nop for that
> 
> SNIP
> 
>>   	default:
>>   		BUG_ON(1);
>>   	}
>> @@ -1407,6 +1452,12 @@ static int hpp__color_wdiff(struct perf_hpp_fmt *fmt,
>>   	return __hpp__color_compare(fmt, hpp, he, COMPUTE_WEIGHTED_DIFF);
>>   }
>>   
>> +static int hpp__color_cycles(struct perf_hpp_fmt *fmt,
>> +			     struct perf_hpp *hpp, struct hist_entry *he)
>> +{
>> +	return __hpp__color_compare(fmt, hpp, he, COMPUTE_CYCLES);
>> +}
>> +
>>   static void
>>   hpp__entry_unpair(struct hist_entry *he, int idx, char *buf, size_t size)
>>   {
>> @@ -1608,6 +1659,10 @@ static void data__hpp_register(struct data__file *d, int idx)
>>   		fmt->color = hpp__color_delta;
>>   		fmt->sort  = hist_entry__cmp_delta_abs;
>>   		break;
>> +	case PERF_HPP_DIFF__CYCLES:
>> +		fmt->color = hpp__color_cycles;
>> +		fmt->sort  = hist_entry__cmp_cycles;
> 
> also please explain in comment why it's nop
> 
> jirka
> 

Got it, I will update the patch.

Thanks
Jin Yao
