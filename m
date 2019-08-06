Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFADC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FBD720818
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732783AbfHFLcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 07:32:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:57611 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729413AbfHFLca (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:32:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 04:32:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="198285894"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.212.182]) ([10.254.212.182])
  by fmsmga004.fm.intel.com with ESMTP; 06 Aug 2019 04:32:28 -0700
Subject: Re: [PATCH v2] perf diff: Report noisy for cycles diff
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20190724221432.26297-1-yao.jin@linux.intel.com>
 <20190806083429.GI7695@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <e61655d3-f69f-c210-3509-1cf745c1081c@linux.intel.com>
Date:   Tue, 6 Aug 2019 19:32:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806083429.GI7695@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/6/2019 4:34 PM, Jiri Olsa wrote:
> On Thu, Jul 25, 2019 at 06:14:32AM +0800, Jin Yao wrote:
> 
> SNIP
> 
>>   static int cycles_printf(struct hist_entry *he, struct hist_entry *pair,
>> -			 struct perf_hpp *hpp, int width)
>> +			 struct perf_hpp *hpp, int width __maybe_unused)
>>   {
>>   	struct block_hist *bh = container_of(he, struct block_hist, he);
>>   	struct block_hist *bh_pair = container_of(pair, struct block_hist, he);
>>   	struct hist_entry *block_he;
>>   	struct block_info *bi;
>> -	char buf[128];
>> +	char buf[128], spark[32];
>>   	char *start_line, *end_line;
>> +	int ret = 0, pad;
>> +	char pfmt[20] = " ";
>> +	double d;
>>   
>>   	block_he = hists__get_entry(&bh_pair->block_hists, bh->block_idx);
>>   	if (!block_he) {
>> @@ -1350,18 +1375,56 @@ static int cycles_printf(struct hist_entry *he, struct hist_entry *pair,
>>   	end_line = map__srcline(he->ms.map, bi->sym->start + bi->end,
>>   				he->ms.sym);
>>   
>> -	if ((start_line != SRCLINE_UNKNOWN) && (end_line != SRCLINE_UNKNOWN)) {
>> -		scnprintf(buf, sizeof(buf), "[%s -> %s] %4ld",
>> -			  start_line, end_line, block_he->diff.cycles);
>> +	if (show_noisy) {
>> +		ret = print_stat_spark(spark, sizeof(spark),
>> +				       &block_he->diff.stats);
>> +		d = rel_stddev_stats(stddev_stats(&block_he->diff.stats),
>> +				     avg_stats(&block_he->diff.stats));
>> +
>> +		if ((start_line != SRCLINE_UNKNOWN) &&
>> +		    (end_line != SRCLINE_UNKNOWN)) {
>> +			scnprintf(buf, sizeof(buf),
>> +				  "[%s -> %s] %4ld  %s%5.1f%% %s",
>> +				  start_line, end_line, block_he->diff.cycles,
>> +				  "\u00B1", d, spark);
>> +		} else {
>> +			scnprintf(buf, sizeof(buf),
>> +				  "[%7lx -> %7lx] %4ld  %s%5.1f%% %s",
>> +				  bi->start, bi->end, block_he->diff.cycles,
>> +				  "\u00B1", d, spark);
>> +		}
>> +
>> +		if (ret > 0) {
>> +			pad = 8 - ((ret - 1) / 3);
>> +			scnprintf(pfmt, 20, "%%%ds",
>> +				  81 + (2 * ((ret - 1) / 3)) - pad);
>> +			ret = scnprintf(hpp->buf, hpp->size, pfmt, buf);
>> +			if (pad > 0) {
>> +				ret += scnprintf(hpp->buf + ret,
>> +						 hpp->size - ret,
>> +						 "%-*s", pad, " ");
>> +			}
>> +		} else {
>> +			ret = scnprintf(hpp->buf, hpp->size, "%73s", buf);
>> +			ret += scnprintf(hpp->buf + ret, hpp->size - ret,
>> +					 "%-*s", 8, " ");
>> +		}
> 
> 
> hum, why isn't the histogram in the separate column?
> looks like there's lot of duplicated code in here
> 
> thanks,
> jirka
> 

Yes, it'd better add the histogram in a separate column. But it's not 
very easy to add that. Anyway let me double check if I can find a less 
complicated method for that.

Thanks
Jin Yao


>>   	} else {
>> -		scnprintf(buf, sizeof(buf), "[%7lx -> %7lx] %4ld",
>> -			  bi->start, bi->end, block_he->diff.cycles);
>> +		if ((start_line != SRCLINE_UNKNOWN) &&
>> +		    (end_line != SRCLINE_UNKNOWN)) {
>> +			scnprintf(buf, sizeof(buf), "[%s -> %s] %4ld",
>> +				  start_line, end_line, block_he->diff.cycles);
>> +		} else {
>> +			scnprintf(buf, sizeof(buf), "[%7lx -> %7lx] %4ld",
>> +				  bi->start, bi->end, block_he->diff.cycles);
>> +		}
>> +
>> +		ret = scnprintf(hpp->buf, hpp->size, "%*s", width, buf);
>>   	}
>>   
>>   	free_srcline(start_line);
>>   	free_srcline(end_line);
>> -
>> -	return scnprintf(hpp->buf, hpp->size, "%*s", width, buf);
>> +	return ret;
>>   }
> 
> SNIP
> 
