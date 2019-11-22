Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D2EC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5440B2071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfKVNzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 08:55:16 -0500
Received: from mga18.intel.com ([134.134.136.126]:58068 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbfKVNzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 08:55:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 05:55:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,229,1571727600"; 
   d="scan'208";a="210255586"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 22 Nov 2019 05:55:15 -0800
Received: from [10.251.82.176] (abudanko-mobl.ccr.corp.intel.com [10.251.82.176])
        by linux.intel.com (Postfix) with ESMTP id 877F658051A;
        Fri, 22 Nov 2019 05:55:12 -0800 (PST)
Subject: Re: [PATCH v1 3/3] perf record: adapt affinity to machines with #CPUs
 > 1K
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <26d1512a-9dea-bf7e-d18e-705846a870c4@linux.intel.com>
 <2561f736-bdb5-a10a-1a5d-590ad499ce49@linux.intel.com>
 <20191122132226.GF17308@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <a4985ba1-f7a6-d7c5-a124-c0b5e3f00ea0@linux.intel.com>
Date:   Fri, 22 Nov 2019 16:55:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191122132226.GF17308@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.11.2019 16:22, Jiri Olsa wrote:
> On Wed, Nov 20, 2019 at 12:38:57PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
<SNIP>
>> -static void perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params *mp)
>> +static int perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_params *mp)
>>  {
>> -	CPU_ZERO(&map->affinity_mask);
>> +	map->affinity_mask.nbits = cpu__max_cpu();
>> +	map->affinity_mask.bits = bitmap_alloc(map->affinity_mask.nbits);
>> +	if (!map->affinity_mask.bits)
>> +		return 1;
> 
> I guess this works, but please return < 0 on error

In v2.

> 
> thanks,
> jirka
> 
> 

~Alexey

