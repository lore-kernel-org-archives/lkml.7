Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20E9C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2F920675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfCGI0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:26:21 -0500
Received: from mga03.intel.com ([134.134.136.65]:10411 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfCGI0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:26:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 00:26:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,451,1544515200"; 
   d="scan'208";a="121743558"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 07 Mar 2019 00:26:19 -0800
Received: from [10.125.252.109] (abudanko-mobl.ccr.corp.intel.com [10.125.252.109])
        by linux.intel.com (Postfix) with ESMTP id 62563580489;
        Thu,  7 Mar 2019 00:26:17 -0800 (PST)
Subject: Re: [PATCH v5 07/10] perf record: implement -z,--compression_level=n
 option and compression
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4d1b11a4-77ed-d9af-ed22-875fc17b6050@linux.intel.com>
 <87fa1906-2d6a-a00a-7ba5-b570d0cbf9cc@linux.intel.com>
 <20190305122622.GJ16615@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <6c964c70-86d7-32ab-c497-5ea65a9fd034@linux.intel.com>
Date:   Thu, 7 Mar 2019 11:26:16 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190305122622.GJ16615@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.03.2019 15:26, Jiri Olsa wrote:
> On Fri, Mar 01, 2019 at 06:58:32PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> +static size_t record__process_comp_header(void *record, size_t increment)
>> +{
>> +	struct compressed_event *event = record;
>> +	size_t size = sizeof(struct compressed_event);
>> +
>> +	if (increment) {
>> +		event->header.size += increment;
>> +		return increment;
>> +	} else {
>> +		event->header.type = PERF_RECORD_COMPRESSED;
>> +		event->header.size = size;
>> +		return size;
>> +	}
> 
> so zstd_compress_stream_to_records calls this in the loop:
> 
>           while (input.pos < input.size) {
> 	  	...
>                 size = process_header(record, 0);
> 		...
>                 size = process_header(record, size);
> 	}
> 
> the header.size will get overwritten with every new iteration, no?

Every new record is headed by PERF_RECORD_COMPRESSED header an updated with 
resulted compressed frame size after compression. 

process_header(, 0) puts header, then 
compression puts compressed frame, then 
process_header(, N) updates header.size value (+=).

~Alexey

> 
> jirka
> 
