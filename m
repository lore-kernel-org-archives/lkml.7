Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30D5C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C4A2071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfKVN6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 08:58:40 -0500
Received: from mga18.intel.com ([134.134.136.126]:58270 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfKVN6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 08:58:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 05:58:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,229,1571727600"; 
   d="scan'208";a="259730215"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Nov 2019 05:58:39 -0800
Received: from [10.251.82.176] (abudanko-mobl.ccr.corp.intel.com [10.251.82.176])
        by linux.intel.com (Postfix) with ESMTP id 4DBEB58049B;
        Fri, 22 Nov 2019 05:58:36 -0800 (PST)
Subject: Re: [PATCH v1 2/3] perf mmap: declare type for cpu mask of arbitrary
 length
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <26d1512a-9dea-bf7e-d18e-705846a870c4@linux.intel.com>
 <0c716b33-a91e-2972-637f-e7c3a187fa77@linux.intel.com>
 <20191122131513.GE17308@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <53af9c5c-a33d-4fc4-88e9-851b1caad3f1@linux.intel.com>
Date:   Fri, 22 Nov 2019 16:58:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191122131513.GE17308@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.11.2019 16:20, Jiri Olsa wrote:
> On Wed, Nov 20, 2019 at 12:37:48PM +0300, Alexey Budankov wrote:
>>
>> Declare a dedicated struct map_cpu_mask type for cpu masks of 
>> arbitrary length. Mask is available thru bits pointer and the 
>> mask length is kept in nbits field. mmap_cpu_mask_bytes() macro 
>> returns mask storage size in bytes.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/util/mmap.h | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
>> index bee4e83f7109..a218a0eb1466 100644
>> --- a/tools/perf/util/mmap.h
>> +++ b/tools/perf/util/mmap.h
>> @@ -15,6 +15,15 @@
>>  #include "event.h"
>>  
>>  struct aiocb;
>> +
>> +struct mmap_cpu_mask {
>> +	unsigned long *bits;
>> +	size_t nbits;
>> +};
>> +
>> +#define mmap_cpu_mask_bytes(m) \
> 
> we try to have all macros upper case

In v2.

> 
>> +	(BITS_TO_LONGS(((struct mmap_cpu_mask *)m)->nbits) * sizeof(unsigned long))
> 
> we have BITS_TO_BYTES

In v2.

> 
> thanks,
> jirka
> 

~Alexey

>> +
>>  /**
>>   * struct mmap - perf's ring buffer mmap details
>>   *
>> -- 
>> 2.20.1
>>
> 
> 
