Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6C6C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 16:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333142068E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 16:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfKYQzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 11:55:12 -0500
Received: from mga18.intel.com ([134.134.136.126]:21593 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728683AbfKYQzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 11:55:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Nov 2019 08:55:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,242,1571727600"; 
   d="scan'208";a="291443540"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 25 Nov 2019 08:55:10 -0800
Received: from [10.252.11.205] (abudanko-mobl.ccr.corp.intel.com [10.252.11.205])
        by linux.intel.com (Postfix) with ESMTP id 83F8E580342;
        Mon, 25 Nov 2019 08:55:08 -0800 (PST)
Subject: Re: [PATCH v2 3/3] perf record: adapt affinity to machines with #CPUs
 > 1K
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <fb356fe9-ac87-71ab-9845-075b3fac3199@linux.intel.com>
 <69bd0062-0f9e-889b-b7ef-0d97d257569b@linux.intel.com>
 <20191125094220.GC4675@krava>
 <9b9209ce-ba61-824f-9443-3909991ff222@linux.intel.com>
 <20191125112122.GA1201@krava>
 <6c7de0f3-d75e-762d-f16e-10e9561c2afb@linux.intel.com>
Organization: Intel Corp.
Message-ID: <f9dd565f-a170-ce98-3ed0-23444bd8b89d@linux.intel.com>
Date:   Mon, 25 Nov 2019 19:55:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <6c7de0f3-d75e-762d-f16e-10e9561c2afb@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.11.2019 14:27, Alexey Budankov wrote:
> 
> On 25.11.2019 14:21, Jiri Olsa wrote:
>> On Mon, Nov 25, 2019 at 02:13:20PM +0300, Alexey Budankov wrote:
>>> On 25.11.2019 12:42, Jiri Olsa wrote:
>>>> On Mon, Nov 25, 2019 at 09:08:57AM +0300, Alexey Budankov wrote:
>>>>
>>>> SNIP
>>>>
>>>>> -static void perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params *mp)
>>>>> +static int perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params *mp)
>>>>>  {
>>>>> -	CPU_ZERO(&map->affinity_mask);
>>>>> +	map->affinity_mask.nbits = cpu__max_cpu();
>>>>> +	map->affinity_mask.bits = bitmap_alloc(map->affinity_mask.nbits);
>>>>> +	if (!map->affinity_mask.bits)
>>>>> +		return -1;
>>>>> +
>>>>>  	if (mp->affinity == PERF_AFFINITY_NODE && cpu__max_node() > 1)
>>>>>  		build_node_mask(cpu__get_node(map->core.cpu), &map->affinity_mask);
>>>>>  	else if (mp->affinity == PERF_AFFINITY_CPU)
>>>>> -		CPU_SET(map->core.cpu, &map->affinity_mask);
>>>>> +		set_bit(map->core.cpu, map->affinity_mask.bits);
>>>>> +
>>>>> +	return 0;
>>>>>  }
>>>>>  
>>>>> +#define MASK_SIZE 1023
>>>>>  int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
>>>>>  {
>>>>> +	char mask[MASK_SIZE + 1] = {0};
>>>>
>>>> does this need to be initialized?
>>>
>>> This is to make sure the message is zero terminated for vfprintf call()
>>
>> hum AFAICS it's used only in bitmap_scnprintf, which should
>> terminate the string properly
> 
> If vfprintf() explicitly terminates output buffer with zero then
> the initialization above can be avoided.

Well, bitmap_scnprintf() returns the length of resulting string and 
the length can be used to make zero termination in the buffer and 
avoid mask initialization in the beginning.

~Alexey
 
> 
>>
>> jirka
>>
> 
> ~Alexey
> 
