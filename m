Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8817CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7FC21871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfCOM2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 08:28:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbfCOM2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 08:28:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E1A430AA389;
        Fri, 15 Mar 2019 12:28:14 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id 84C625D6A6;
        Fri, 15 Mar 2019 12:28:12 +0000 (UTC)
Date:   Fri, 15 Mar 2019 13:28:11 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 00/12] perf: enable compression of record mode trace
 to save storage space
Message-ID: <20190315122811.GC1400@krava>
References: <4c037bbd-1cc9-90f2-b9cd-0e0839c83b73@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c037bbd-1cc9-90f2-b9cd-0e0839c83b73@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 15 Mar 2019 12:28:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 02:26:23PM +0300, Alexey Budankov wrote:
> 
> The patch set implements runtime trace compression (-z option) in 
> record mode and trace auto decompression in report and inject modes. 
> Streaming Zstd API [1] is used for compression and decompression of
> data that come from kernel mmaped data buffers.
> 
> Usage of implemented -z,--compression_level=n option provides ~3-5x 
> avg. trace file size reduction on variety of tested workloads what 
> saves storage space on larger server systems where trace file size 
> can easily reach several tens or even hundreds of GiBs, especially 
> when profiling with dwarf-based stacks and tracing of context switches.
> Default option value is 1 (fastest compression).
> 
> Implemented --mmap-flush option can be used to specify minimal size 
> of data chunk that is extracted from mmaped kernel buffer to store
> into a trace. The option is independent from -z setting and doesn't 
> vary with compression level. The default option value is 1 byte what 
> means every time trace writing thread finds some new data in the 
> mmaped buffer the data is extracted, possibly compressed and written 
> to a trace. The option serves two purposes the first one is to increase 
> the compression ratio of trace data and the second one is to avoid 
> live-lock self tool process monitoring in system wide (-a) profiling
> mode. Profiling in system wide mode with compression (-a -z) can 
> additionally induce data into the kernel buffers along with the data 
> from monitored processes. If performance data rate and volume from 
> the monitored processes is high then trace streaming and compression 
> activity in the tool is also high. It can lead to subtle live-lock 
> effect of endless activity when compression of single new byte from 
> some of mmaped kernel buffer induces the next single byte at some 
> mmaped buffer. So perf tool thread never stops on polling event file 
> descriptors. Varying data chunk size to be extracted from mmap buffers 
> allows avoiding live-locking self monitoring in system wide mode and
> makes mmap buffers polling loop configurable.
> 
>   $ tools/perf/perf record -z -e cycles -- matrix.gcc
>   $ tools/perf/perf record --aio -z -e cycles -- matrix.gcc
>   $ tools/perf/perf record -z --mmap-flush 1024 -e cycles -- matrix.gcc
>   $ tools/perf/perf record --aio -z --mmap-flush 1K -e cycles -- matrix.gcc

hi,
I'm getting error with -z:

[root@krava perf]# ./perf record -z ./perf bench sched messaging -l 10000
# Running 'sched/messaging' benchmark:
# 20 sender and receiver processes per group
# 10 groups == 400 processes run

     Total time: 18.775 [sec]
[ perf record: Woken up 57 times to write data ]
0x5228 [0]: failed to process type: 81
[ perf record: Captured and wrote 6.453 MB perf.data, compressed (original 21.486 MB, ratio is 3.340) ]


jirka
