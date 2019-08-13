Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23212C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 04:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50B42067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 04:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfHMENa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 00:13:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:40911 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfHMENa (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 00:13:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 21:13:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,380,1559545200"; 
   d="scan'208";a="166939071"
Received: from unknown (HELO [10.239.196.24]) ([10.239.196.24])
  by orsmga007.jf.intel.com with ESMTP; 12 Aug 2019 21:13:26 -0700
Subject: Re: [PATCH v3] perf diff: Report noisy for cycles diff
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20190809233029.12265-1-yao.jin@linux.intel.com>
 <20190812083555.GC11752@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <0e1a0f70-5089-7524-c53b-2762fc174a20@linux.intel.com>
Date:   Tue, 13 Aug 2019 12:13:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812083555.GC11752@krava>
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
>> +		if (vals[i] != 0)
>> +			return 0;
>> +	return 1;
>> +}
>> +
>> +static int print_cycles_spark(char *bf, int size, unsigned long *svals, u64 n)
>> +{
>> +	int len = n, printed;
>> +
>> +	if (len <= 1)
>> +		return 0;
>> +
>> +	if (len > NUM_SPARKS)
>> +		len = NUM_SPARKS;
>> +	if (all_zero(svals, len))
>> +		return 0;
>> +
>> +	printed = print_spark(bf, size, svals, len);
>> +	printed += scnprintf(bf + printed, size - printed, " ");
>> +
>> +	if (n > NUM_SPARKS)
>> +		printed += scnprintf(bf + printed, size - printed, "..");
> 
> will this '..' ever be printed? I can't see that even if I enlarge
> the column width..
> 
> jirka
> 

@@ -83,6 +85,8 @@ struct hist_entry_diff {
                 /* PERF_HPP_DIFF__CYCLES */
                 s64     cycles;
         };
+       struct stats    stats;
+       unsigned long   svals[NUM_SPARKS];
  };

Now we only save 8 items in svals[] (NUM_PARKS = 8). So '..' will not be 
printed. The code of printing '..' is for future possible case.

If you think it's not necessary, I would remove this.

Thanks
Jin Yao


