Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D31C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18DF320854
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfCMPAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:00:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:16556 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfCMPAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:00:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2019 08:00:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,474,1544515200"; 
   d="scan'208";a="306873186"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 13 Mar 2019 08:00:50 -0700
Received: from [10.252.18.45] (unknown [10.252.18.45])
        by linux.intel.com (Postfix) with ESMTP id D404D58046D;
        Wed, 13 Mar 2019 08:00:47 -0700 (PDT)
Subject: Re: [PATCH v7 02/12] perf record: implement
 -f,--mmap-flush=<threshold> option
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <5f3a8326-58a0-816e-ad61-31c111232c7a@linux.intel.com>
 <e582719a-ca01-22cd-bc73-6d693961bb18@linux.intel.com>
 <20190313143656.GB6676@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <8adaa965-8ddd-e67a-975a-495a9cda6e38@linux.intel.com>
Date:   Wed, 13 Mar 2019 18:00:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190313143656.GB6676@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13.03.2019 17:36, Jiri Olsa wrote:
> On Tue, Mar 12, 2019 at 08:12:23AM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>>  	record__aio_mmap_read_sync(rec);
>>  
>>  	if (forks) {
>> @@ -1815,6 +1863,7 @@ static struct record record = {
>>  			.uses_mmap   = true,
>>  			.default_per_cpu = true,
>>  		},
>> +		.mmap_flush          = MMAP_FLUSH_DEFAULT,
>>  	},
>>  	.tool = {
>>  		.sample		= process_sample_event,
>> @@ -1881,6 +1930,9 @@ static struct option __record_options[] = {
>>  	OPT_CALLBACK('m', "mmap-pages", &record.opts, "pages[,pages]",
>>  		     "number of mmap data pages and AUX area tracing mmap pages",
>>  		     record__parse_mmap_pages),
>> +	OPT_CALLBACK('f', "mmap-flush", &record.opts, "bytes",
>> +		     "Minimal number of bytes that is extracted from mmap data pages (default: 1)",
>> +		     record__mmap_flush_parse),
> 
> let's not consume the 'f' for this option, just --map-flush

in v8.

~Alexey

> 
> jirka
> 
