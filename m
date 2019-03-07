Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF93C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7792D20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfCGI2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:28:53 -0500
Received: from mga18.intel.com ([134.134.136.126]:27920 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfCGI2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:28:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 00:28:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,451,1544515200"; 
   d="scan'208";a="121744066"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 07 Mar 2019 00:28:52 -0800
Received: from [10.125.252.109] (abudanko-mobl.ccr.corp.intel.com [10.125.252.109])
        by linux.intel.com (Postfix) with ESMTP id D50695805B4;
        Thu,  7 Mar 2019 00:28:49 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCH v5 02/10] perf record: implement
 -f,--mmap-flush=<threshold> option
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4d1b11a4-77ed-d9af-ed22-875fc17b6050@linux.intel.com>
 <3600e56e-0431-080e-9df8-e376cdea1aad@linux.intel.com>
 <20190305122541.GC16615@krava>
Organization: Intel Corp.
Message-ID: <74d9465c-cc26-4077-ed86-bbdc1cec1e9d@linux.intel.com>
Date:   Thu, 7 Mar 2019 11:28:48 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190305122541.GC16615@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.03.2019 15:25, Jiri Olsa wrote:
> On Fri, Mar 01, 2019 at 06:41:44PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index f3f7f3100336..9b02a68e8c23 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -334,6 +334,29 @@ static int record__aio_enabled(struct record *rec)
>>  	return rec->opts.nr_cblocks > 0;
>>  }
>>  
>> +#define MMAP_FLUSH_DEFAULT 1
>> +static int record__mmap_flush_parse(const struct option *opt,
>> +				    const char *str,
>> +				    int unset)
>> +{
>> +	int mmap_len;
>> +	struct record_opts *opts = (struct record_opts *)opt->value;
>> +
>> +	if (unset)
>> +		return 0;
>> +
>> +	if (str)
>> +		opts->mmap_flush = strtol(str, NULL, 0);
>> +	if (!opts->mmap_flush)
>> +		opts->mmap_flush = MMAP_FLUSH_DEFAULT;
>> +
>> +	mmap_len = perf_evlist__mmap_size(opts->mmap_pages);
>> +	if (opts->mmap_flush > mmap_len / 4)
>> +		opts->mmap_flush = mmap_len / 4;
>> +
> 
> if there's point in this config option, pelase make it
> configurable as the other size options we have with
> the B/K/M suffixes

in v7.

~Alexey

> 
> jirka
> 
