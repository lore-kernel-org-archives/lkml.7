Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB016C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 15:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A528421736
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 15:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfK2Pt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 10:49:29 -0500
Received: from mga11.intel.com ([192.55.52.93]:45899 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfK2Pt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 10:49:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2019 07:49:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,257,1571727600"; 
   d="scan'208";a="234742526"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 29 Nov 2019 07:49:28 -0800
Received: from [10.252.8.148] (abudanko-mobl.ccr.corp.intel.com [10.252.8.148])
        by linux.intel.com (Postfix) with ESMTP id 686C45802B9;
        Fri, 29 Nov 2019 07:49:26 -0800 (PST)
Subject: Re: [PATCH v3 3/3] perf record: adapt affinity to machines with #CPUs
 > 1K
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <908dbe98-7d8d-0ec1-d4ae-242f3e104979@linux.intel.com>
 <21bc3ad7-e1f2-68da-f004-36354a6e40ea@linux.intel.com>
 <20191129130710.GB14169@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <d11eb388-2a66-c791-3ad3-40eed930480a@linux.intel.com>
Date:   Fri, 29 Nov 2019 18:49:25 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191129130710.GB14169@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29.11.2019 16:07, Jiri Olsa wrote:
> On Fri, Nov 29, 2019 at 01:05:26PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>>  # undef REASON
>>  #endif
>>  
>> -	CPU_ZERO(&rec->affinity_mask);
>>  	rec->opts.affinity = PERF_AFFINITY_SYS;
>>  
>>  	rec->evlist = evlist__new();
>> @@ -2499,6 +2504,14 @@ int cmd_record(int argc, const char **argv)
>>  
>>  	symbol__init(NULL);
>>  
>> +	rec->affinity_mask.nbits = cpu__max_cpu();
>> +	rec->affinity_mask.bits = bitmap_alloc(rec->affinity_mask.nbits);
>> +	if (!rec->affinity_mask.bits) {
>> +		pr_err("Failed to allocate thread mask for %ld cpus\n", rec->affinity_mask.nbits);
>> +		return -ENOMEM;
>> +	}
>> +	pr_debug2("thread mask[%ld]: empty\n", rec->affinity_mask.nbits);
> 
> above can be done only for (rec->opts.affinity != PERF_AFFINITY_SYS)

Indeed. Corrected in v4.

> 
> 
>> +
>>  	err = record__auxtrace_init(rec);
>>  	if (err)
>>  		goto out;
>> @@ -2613,6 +2626,8 @@ int cmd_record(int argc, const char **argv)
>>  
>>  	err = __cmd_record(&record, argc, argv);
>>  out:
>> +	if (rec->affinity_mask.bits)
>> +		bitmap_free(rec->affinity_mask.bits);
>>  	evlist__delete(rec->evlist);
>>  	symbol__exit();
>>  	auxtrace_record__free(rec->itr);
>> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
>> index 30ff7aef06f2..615d05870849 100644
>> --- a/tools/perf/util/mmap.c
>> +++ b/tools/perf/util/mmap.c
>> @@ -219,6 +219,9 @@ static void perf_mmap__aio_munmap(struct mmap *map __maybe_unused)
>>  
>>  void mmap__munmap(struct mmap *map)
>>  {
>> +	if (map->affinity_mask.bits)
>> +		bitmap_free(map->affinity_mask.bits);
> 
> you don't need to check map->affinity_mask.bits, it's checked in free

Makes sense. Corrected in v4.

> 
> jirka

Thanks,
Alexey
