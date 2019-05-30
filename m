Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD563C28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C146825685
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfE3IYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:24:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:58488 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfE3IYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:24:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 01:24:52 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 30 May 2019 01:24:51 -0700
Received: from [10.125.252.126] (abudanko-mobl.ccr.corp.intel.com [10.125.252.126])
        by linux.intel.com (Postfix) with ESMTP id 57C8E580258;
        Thu, 30 May 2019 01:24:50 -0700 (PDT)
Subject: Re: [PATCH v4] perf record: collect user registers set jointly with
 dwarf stacks
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <01a322ee-c99d-0bb7-b7cf-bc1fa8064d75@linux.intel.com>
 <20190529192506.GB5553@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <378b81a7-b7db-c60f-134d-0c0f7cd6c0a1@linux.intel.com>
Date:   Thu, 30 May 2019 11:24:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529192506.GB5553@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29.05.2019 22:25, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 29, 2019 at 05:30:49PM +0300, Alexey Budankov escreveu:
>>
<SNIP>
>> ---
>>  tools/perf/util/evsel.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index a6f572a40deb..426dfefeecda 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -669,6 +669,9 @@ int perf_evsel__group_desc(struct perf_evsel *evsel, char *buf, size_t size)
>>  	return ret;
>>  }
>>  
>> +#define DWARF_REGS_MASK ((1ULL << PERF_REG_IP) | \
>> +			 (1ULL << PERF_REG_SP))
>> +
>>  static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
>>  					   struct record_opts *opts,
>>  					   struct callchain_param *param)
>> @@ -702,7 +705,13 @@ static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
>>  		if (!function) {
>>  			perf_evsel__set_sample_bit(evsel, REGS_USER);
>>  			perf_evsel__set_sample_bit(evsel, STACK_USER);
>> -			attr->sample_regs_user |= PERF_REGS_MASK;
>> +			if (opts->sample_user_regs) {
> 
> Where are you checking that opts->sample_user_regs doesn't have either
> IP or SP?

Sure. The the intention was to avoid such a complication, merge two 
masks and provide explicit warning that the resulting mask is extended.

If you still see the checking and auto detection of the exact mask 
extension as essential it can be implemented.

> 
> So, __perf_evsel__config_callchain its the routine that sets up the
> attr->sample_regs_user when callchains are asked for, and what was it
> doing? Asking for _all_ user regs, right?
> 
> I.e. what you're saying is that when --callgraph-dwarf is asked for,
> then only IP and BP are needed, and we should stop doing that, so that
> would be a first patch, if that is the case. I.e. a patch that doesn't
> even mention opts->sample_user_regs.
> 
> Then, a second patch would fix the opt->sample_user_regs request clash
> with --callgraph dwarf, i.e. it would do something like:
> 
> 	      if ((opts->sample_regs_user & DWARF_REGS_MASK) != DWARF_REGS_MASK) {
> 	      		char * ip = (opts->sample_regs_user & (1ULL << PERF_REG_IP)) ? NULL : "IP",
> 	      		     * sp = (opts->sample_regs_user & (1ULL << PERF_REG_SP)) ? NULL : "SP",
> 			     * all = (!ip && !sp) ?  "s" : "";
> 
> 			pr_warning("WARNING: specified --user-regs register set doesn't include register%s "
> 				   "needed by also specified --call-graph=dwarf, auto adding %s%s%s register%s.\n",
> 				   all, ip, all : ", " : "", sp, all);
> 		}
> 
> This if and only if all the registers that are needed to do DWARF
> unwinding are just IP and BP, which doesn't look like its true, since
> when no --user_regs is set (i.e. opts->user_regs is not set) then we
> continue asking for PERF_REGS_MASK...
> 
> Can you check where I'm missing something?

1.  -g call-graph dwarf,K                         full_regs
2.  --user-regs=user_regs                         user_regs
3.  -g call-graph dwarf,K --user-regs=user_regs	  user_regs + dwarf_regs

The default behavior stays the same for cases 1, 2 above.
For case 3 register set becomes the one asked using --user_regs option.
If the option value misses IP or SP or the both then they are explicitly
added to the option value and a warning message mentioning the exact 
added registers is provided.

> 
> Jiri DWARF unwind uses just IP and SP? Looking at
> tools/perf/util/unwind-libunwind-local.c's access_reg() I don't think
> so, right?

If you ask me, AFAIK, DWARF unwind rules sometimes can refer additional 
general purpose registers for frames boundaries calculation.

Thanks,
Alexey

> 
> - Arnaldo
> 
>> +				attr->sample_regs_user |= DWARF_REGS_MASK;
>> +				pr_warning("WARNING: specified --user-regs register set doesn't include registers "
>> +					   "needed by also specified --call-graph=dwarf, auto adding IP, SP registers.\n");
>> +			} else {
>> +				attr->sample_regs_user |= PERF_REGS_MASK;
>> +			}
>>  			attr->sample_stack_user = param->dump_size;
>>  			attr->exclude_callchain_user = 1;
>>  		} else {
>> -- 
>> 2.20.1
> 
