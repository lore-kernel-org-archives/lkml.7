Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0820CC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 14:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06F420659
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 14:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfKROUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 09:20:36 -0500
Received: from mga06.intel.com ([134.134.136.31]:37653 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbfKROUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 09:20:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 06:20:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,320,1569308400"; 
   d="scan'208";a="258420312"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Nov 2019 06:20:34 -0800
Received: from [10.252.10.190] (abudanko-mobl.ccr.corp.intel.com [10.252.10.190])
        by linux.intel.com (Postfix) with ESMTP id 476A25800FE;
        Mon, 18 Nov 2019 06:20:32 -0800 (PST)
Subject: Re: [PATCH v2] perf session: fix decompression of
 PERF_RECORD_COMPRESSED records
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <ed01646b-3b28-0ce7-04da-4665b8ed8a04@linux.intel.com>
 <20191118122214.GB14046@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <924f076a-190f-330f-50e0-f06f35e2ee75@linux.intel.com>
Date:   Mon, 18 Nov 2019 17:20:31 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191118122214.GB14046@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.11.2019 15:22, Jiri Olsa wrote:
> On Mon, Nov 18, 2019 at 02:30:04PM +0300, Alexey Budankov wrote:
<SNIP>
>>
>> @@ -1971,20 +1971,32 @@ fetch_mmaped_event(struct perf_session *session,
>>  		return NULL;
>>  
>>  	event = (union perf_event *)(buf + head);
>> +	if (needs_swap)
>> +		perf_event_header__bswap(&event->header);
>>  
>> -	if (session->header.needs_swap)
>> +	if (head + event->header.size <= mmap_size)
>> +		return event;
>> +
>> +	/* We're not fetching the event so swap back again */
>> +	if (needs_swap)
>>  		perf_event_header__bswap(&event->header);
>>  
>> -	if (head + event->header.size > mmap_size) {
>> -		/* We're not fetching the event so swap back again */
>> -		if (session->header.needs_swap)
>> -			perf_event_header__bswap(&event->header);
>> -		pr_debug("%s: head=%#" PRIx64 " event->header_size=%#x, mmap_size=%#zx: fuzzed perf.data?\n",
>> -			 __func__, head, event->header.size, mmap_size);
>> -		return ERR_PTR(-EINVAL);
>> -	}
>> +	pr_debug("%s: head=%#" PRIx64 " event->header_size=%#x, mmap_size=%#zx\n",
>> +		__func__, head, event->header.size, mmap_size);
> 
> you're missign the 'fuzzed perf.data?' in here
> 
> I think we should keep it just change to: 'fuzzed or compressed perf.data?'

Fixed in v3.

> 
> thanks,
> jirka

~Alexey
