Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3544FC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1667820881
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfENSFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 14:05:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:17499 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbfENSFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:05:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 11:05:30 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 14 May 2019 11:05:30 -0700
Received: from [10.252.16.172] (abudanko-mobl.ccr.corp.intel.com [10.252.16.172])
        by linux.intel.com (Postfix) with ESMTP id AACF35800CB;
        Tue, 14 May 2019 11:05:28 -0700 (PDT)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v3] perf record: collect user registers set jointly with
 dwarf stacks
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <b34d8f60-9163-beac-7faa-4fa5e897c0f7@linux.intel.com>
 <20190513194317.GA3198@kernel.org>
Organization: Intel Corp.
Message-ID: <b5cabb0e-01fb-d90f-feda-d26dc5b32d12@linux.intel.com>
Date:   Tue, 14 May 2019 21:05:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513194317.GA3198@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.05.2019 22:43, Arnaldo Carvalho de Melo wrote:
> Em Mon, Apr 22, 2019 at 05:37:52PM +0300, Alexey Budankov escreveu:
>>
>> When dwarf stacks are collected jointly with user specified register
>> set using --user-regs option like below the full register context is
>> still captured on a sample:
>>
>>   $ perf record -g --call-graph dwarf,1024 --user-regs=IP,SP,BP -- matrix.gcc.g.O3
>>
>>   188143843893585 0x6b48 [0x4f8]: PERF_RECORD_SAMPLE(IP, 0x4002): 23828/23828: 0x401236 period: 1363819 addr: 0x7ffedbdd51ac
>>   ... FP chain: nr:0
>>   ... user regs: mask 0xff0fff ABI 64-bit
>>   .... AX    0x53b
>>   .... BX    0x7ffedbdd3cc0
>>   .... CX    0xffffffff
>>   .... DX    0x33d3a
>>   .... SI    0x7f09b74c38d0
>>   .... DI    0x0
>>   .... BP    0x401260
>>   .... SP    0x7ffedbdd3cc0
>>   .... IP    0x401236
>>   .... FLAGS 0x20a
>>   .... CS    0x33
>>   .... SS    0x2b
>>   .... R8    0x7f09b74c3800
>>   .... R9    0x7f09b74c2da0
>>   .... R10   0xfffffffffffff3ce
>>   .... R11   0x246
>>   .... R12   0x401070
>>   .... R13   0x7ffedbdd5db0
>>   .... R14   0x0
>>   .... R15   0x0
>>   ... ustack: size 1024, offset 0xe0
>>    . data_src: 0x5080021
>>    ... thread: stack_test2.g.O:23828
>>    ...... dso: /root/abudanko/stacks/stack_test2.g.O3
>>
>> After applying the change suggested in the patch the sample data contain
>> only user specified register values:
>>
>>   $ perf record -g --call-graph dwarf,1024 --user-regs=BP -- matrix.gcc.g.03
>>
>>   188368474305373 0x5e40 [0x470]: PERF_RECORD_SAMPLE(IP, 0x4002): 23839/23839: 0x401236 period: 1260507 addr: 0x7ffd3d85e96c
>>   ... FP chain: nr:0
>>   ... user regs: mask 0x1c0 ABI 64-bit
>>   .... BP    0x401260
>>   .... SP    0x7ffd3d85cc20
>>   .... IP    0x401236
>>   ... ustack: size 1024, offset 0x58
>>    . data_src: 0x5080021
>>    ... thread: stack_test2.g.O:23839
>>    ...... dso: /root/abudanko/stacks/stack_test2.g.O3
>>
>> IP and SP registers (dwarf_regs) are collected anayways regardless of
>> the --user-regs option value provided from the command line:
> 
> So user asks for a, b and c and gets a, b, c + d and e? At the very
> least we should warn that those registers are being added to the mix,
> i.e. something like:
> 
> WARNING: specified --user-regs register set doesn't include registers
> needed by also specified --call-graph=dwarf, auto adding missing
> registers (list of missing registers auto-added).

Well, let's have it like this.

~Alexey 

> 
> - Arnaldo
> 
> P.S. Back from vacation, going thru backlog, hopefully will apply your
> perf.data compression patchkit after testing its patches one by one,
> sorry for the delay for that one (and this :))
>  
>>   -g call-graph dwarf,K                         full_regs
>>   -g call-graph dwarf,K --user-regs=user_regs	user_regs | dwarf_regs
>>   --user-regs=user_regs                         user_regs
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>> Changes in v3:
>> - avoid changes in platform specific header files
>>
>> Changes in v2:
>> - implemented dwarf register set to avoid corrupted trace 
>>   when --user-regs option value omits IP,SP
>>
>> ---
>>  tools/perf/util/evsel.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index 84cfb9fe2fc6..e5e61ee3c6e7 100644
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
>> @@ -702,7 +705,10 @@ static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
>>  		if (!function) {
>>  			perf_evsel__set_sample_bit(evsel, REGS_USER);
>>  			perf_evsel__set_sample_bit(evsel, STACK_USER);
>> -			attr->sample_regs_user |= PERF_REGS_MASK;
>> +			if (opts->sample_user_regs)
>> +				attr->sample_regs_user |= DWARF_REGS_MASK;
>> +			else
>> +				attr->sample_regs_user |= PERF_REGS_MASK;
>>  			attr->sample_stack_user = param->dump_size;
>>  			attr->exclude_callchain_user = 1;
>>  		} else {
>> -- 
>> 2.20.1
> 
