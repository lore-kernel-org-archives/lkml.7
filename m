Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8004C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 07:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C883206DB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 07:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbfLEHbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 02:31:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:25418 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbfLEHbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 02:31:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 23:31:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,280,1571727600"; 
   d="scan'208";a="411546745"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 04 Dec 2019 23:31:21 -0800
Received: from [10.252.11.4] (abudanko-mobl.ccr.corp.intel.com [10.252.11.4])
        by linux.intel.com (Postfix) with ESMTP id 7BAD9580261;
        Wed,  4 Dec 2019 23:31:18 -0800 (PST)
Subject: Re: [PATCH v5 2/3] perf mmap: declare type for cpu mask of arbitrary
 length
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <d1aead99-474a-46d3-36be-36dbb8e5581b@linux.intel.com>
 <0fd2454f-477f-d15a-f4ee-79bcbd2585ff@linux.intel.com>
 <20191204134911.GB31283@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <9d31e13e-92b5-7e95-e4c8-cf6abab99502@linux.intel.com>
Date:   Thu, 5 Dec 2019 10:31:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191204134911.GB31283@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.12.2019 16:49, Arnaldo Carvalho de Melo wrote:
> Em Tue, Dec 03, 2019 at 02:44:18PM +0300, Alexey Budankov escreveu:
>>
>> Declare a dedicated struct map_cpu_mask type for cpu masks of
>> arbitrary length. Mask is available thru bits pointer and the
>> mask length is kept in nbits field. MMAP_CPU_MASK_BYTES() macro
>> returns mask storage size in bytes. mmap_cpu_mask__scnprintf()
>> function can be used to log text representation of the mask.
>>
>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>> ---
>>  tools/perf/util/mmap.c | 12 ++++++++++++
>>  tools/perf/util/mmap.h | 11 +++++++++++
>>  2 files changed, 23 insertions(+)
>>
>> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
>> index 063d1b93c53d..43c12b4a3e17 100644
>> --- a/tools/perf/util/mmap.c
>> +++ b/tools/perf/util/mmap.c
>> @@ -23,6 +23,18 @@
>>  #include "mmap.h"
>>  #include "../perf.h"
>>  #include <internal/lib.h> /* page_size */
>> +#include <linux/bitmap.h>
>> +
>> +#define MASK_SIZE 1023
>> +void mmap_cpu_mask__scnprintf(struct mmap_cpu_mask *mask, const char *tag)
>> +{
>> +	char buf[MASK_SIZE + 1];
>> +	size_t len;
>> +
>> +	len = bitmap_scnprintf(mask->bits, mask->nbits, buf, MASK_SIZE);
>> +	buf[len] = '\0';
>> +	pr_debug("%p: %s mask[%ld]: %s\n", mask, tag, mask->nbits, buf);
>> +}
> 
> Above should also be %zd, fixed.

Thanks Arnaldo, Jiri! Appreciate you collaboration and help.

~Alexey

> 
> - Arnaldo
> 
