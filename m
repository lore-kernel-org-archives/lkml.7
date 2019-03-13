Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E228C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A62020854
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfCMPAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:00:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:16334 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfCMPAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:00:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2019 08:00:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,474,1544515200"; 
   d="scan'208";a="282307026"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 13 Mar 2019 08:00:03 -0700
Received: from [10.252.18.45] (unknown [10.252.18.45])
        by linux.intel.com (Postfix) with ESMTP id 7563E580610;
        Wed, 13 Mar 2019 08:00:01 -0700 (PDT)
Subject: Re: [PATCH v4 0/10] perf: enable compression of record mode trace to
 save storage space
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <bb018a36-5249-ca6a-8e16-6afac442bae5@linux.intel.com>
 <20190313143704.GC6676@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <34070359-1a25-b64d-519e-2025185b4b68@linux.intel.com>
Date:   Wed, 13 Mar 2019 18:00:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190313143704.GC6676@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13.03.2019 17:37, Jiri Olsa wrote:
> On Thu, Feb 28, 2019 at 11:35:24AM +0300, Alexey Budankov wrote:
>>
>> The patch set implements runtime trace compression (-z option) in 
>> record mode and trace auto decompression in report and inject modes. 
>> Streaming Zstandard (Zstd) API (zstd) is used for compression and 
>> decompression of data that come from kernel mmaped data buffers.
>>
>> Usage of implemented -z,--compression_level=n option provides ~3-5x 
>> avg. trace file size reduction on variety of tested workloads what 
>> saves storage space on larger server systems where trace file size 
>> can easily reach several tens or even hundreds of GiBs, especially 
>> when profiling with dwarf-based stacks and tracing of context switches.
>> Implemented -f,--mmap-flush option can be used to avoid compressing 
>> every single byte of data and increase compression ratio at the same 
>> time lowering tool runtime overhead. Default option value is 1 what 
>> is equal to the current perf record implementation. The option is 
>> independent from -z setting and doesn't vary with compression level:
>>
>>   $ tools/perf/perf record -z 1 -e cycles -- matrix.gcc
>>   $ tools/perf/perf record --aio=1 -z 1 -e cycles -- matrix.gcc
>>   $ tools/perf/perf record -z 1 -f 1024 -e cycles -- matrix.gcc
>>   $ tools/perf/perf record --aio=1 -z 1 -f 1024 -e cycles -- matrix.gcc
> 
> please make the 'z' option to choose some default value,
> so it's possible just to run:
> 
>   perf record -z ...
> 
> to get comrpessed data.. not sure which strategy to use,
> probably the fastest '-z 1' as default
> 
> with some warning about using that default value perhaps

in v8.

~Alexey

> 
> jirka
> 
