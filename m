Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F69C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16D2218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbfCONnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:43:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:40574 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727248AbfCONnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:43:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 06:43:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,482,1544515200"; 
   d="scan'208";a="282964181"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 15 Mar 2019 06:43:30 -0700
Received: from [10.252.10.233] (tlazarev-mobl.ccr.corp.intel.com [10.252.10.233])
        by linux.intel.com (Postfix) with ESMTP id AF4DE5805FC;
        Fri, 15 Mar 2019 06:43:28 -0700 (PDT)
Subject: Re: [PATCH v8 00/12] perf: enable compression of record mode trace to
 save storage space
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <4c037bbd-1cc9-90f2-b9cd-0e0839c83b73@linux.intel.com>
 <20190315122811.GC1400@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <7e54bef0-b438-cf5d-1023-70508cc1bc06@linux.intel.com>
Date:   Fri, 15 Mar 2019 16:43:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190315122811.GC1400@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.03.2019 15:28, Jiri Olsa wrote:
> On Thu, Mar 14, 2019 at 02:26:23PM +0300, Alexey Budankov wrote:
>>
<SNIP>
>> The patch set implements runtime trace compression (-z option) in 
>> record mode and trace auto decompression in report and inject modes. 
>> Streaming Zstd API [1] is used for compression and decompression of
>> data that come from kernel mmaped data buffers.
>>
<SNIP>
>>   $ tools/perf/perf record -z -e cycles -- matrix.gcc
>>   $ tools/perf/perf record --aio -z -e cycles -- matrix.gcc
>>   $ tools/perf/perf record -z --mmap-flush 1024 -e cycles -- matrix.gcc
>>   $ tools/perf/perf record --aio -z --mmap-flush 1K -e cycles -- matrix.gcc
> 
> hi,
> I'm getting error with -z:
> 
> [root@krava perf]# ./perf record -z ./perf bench sched messaging -l 10000
> # Running 'sched/messaging' benchmark:
> # 20 sender and receiver processes per group
> # 10 groups == 400 processes run
> 
>      Total time: 18.775 [sec]
> [ perf record: Woken up 57 times to write data ]
> 0x5228 [0]: failed to process type: 81
> [ perf record: Captured and wrote 6.453 MB perf.data, compressed (original 21.486 MB, ratio is 3.340) ]

Reproduced locally. Investigating right now.

tools/perf/perf record -z tools/perf/perf bench sched messaging -l 10000
# Running 'sched/messaging' benchmark:
# 20 sender and receiver processes per group
# 10 groups == 400 processes run

     Total time: 8.799 [sec]
[ perf record: Woken up 35 times to write data ]
0x2e48 [0]: failed to process type: 81
[ perf record: Captured and wrote 3.142 MB perf.data, compressed (original 10.241 MB, ratio is 3.272) ]

However it is not observed in my tests on 8 cores Skylake.

tools/perf/perf record -z ../../matrix/linux/matrix.gcc
Addr of buf1 = 0x7f2eca1ab010
Offs of buf1 = 0x7f2eca1ab180
Addr of buf2 = 0x7f2ec81aa010
Offs of buf2 = 0x7f2ec81aa1c0
Addr of buf3 = 0x7f2ec61a9010
Offs of buf3 = 0x7f2ec61a9100
Addr of buf4 = 0x7f2ec41a8010
Offs of buf4 = 0x7f2ec41a8140
Threads #: 8 Pthreads
Matrix size: 2048
Using multiply kernel: multiply1
Execution time = 30.075 seconds
[ perf record: Woken up 127 times to write data ]
[ perf record: Captured and wrote 6.820 MB perf.data (953438 samples), compressed (original 36.372 MB, ratio is 5.344) ]

Thanks,
Alexey

> 
> 
> jirka
> 
