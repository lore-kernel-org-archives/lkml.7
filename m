Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C7BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EC62082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbfCEM0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:26:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36690 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728027AbfCEM0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:26:12 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2295D30917A8;
        Tue,  5 Mar 2019 12:26:12 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6DD1960A9A;
        Tue,  5 Mar 2019 12:26:10 +0000 (UTC)
Date:   Tue, 5 Mar 2019 13:26:09 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 02/10] perf record: implement
 -f,--mmap-flush=<threshold> option
Message-ID: <20190305122609.GH16615@krava>
References: <4d1b11a4-77ed-d9af-ed22-875fc17b6050@linux.intel.com>
 <3600e56e-0431-080e-9df8-e376cdea1aad@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3600e56e-0431-080e-9df8-e376cdea1aad@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 05 Mar 2019 12:26:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 06:41:44PM +0300, Alexey Budankov wrote:
> 
> Implemented -f,--mmap-flush option that specifies minimal size of data
> chunk that is extracted from mmaped kernel buffer to store into a trace.
> 
>   $ tools/perf/perf record -f 1024 -e cycles -- matrix.gcc
>   $ tools/perf/perf record --aio -f 1024 -e cycles -- matrix.gcc
> 
> Option can serve two purposes the first one is to increase the compression
> ratio of a trace data and the second one is to avoid live-lock-like self 
> monitoring in system wide (-a) profiling mode.
> 
> The default option value is 1 byte what means that every time trace
> writing thread finds some new data in the mmaped buffer the data is
> extracted, possibly compressed and written to a trace. Larger data chunks
> are compressed more effectively in comparison to smaller chunks so
> extraction of larger chunks from the kernel buffer is preferable from
> perspective of trace size reduction. So the implemented option allows 
> specifying minimal data chunk size that is more than 1 byte to influence 
> data compression ratio. Also at some cases executing more write syscalls 
> with smaller data size can take longer than executing less write syscalls 
> with bigger data size due to syscall overhead so extracting bigger data 
> chunks specified by the option value could additionally decrease runtime 
> overhead.
> 
> Profiling in system wide mode with compression (-a -z) can additionally 
> induce data into the kernel buffers along with the data from monitored 
> processes. If performance data rate and volume from the monitored processes 
> is high then trace streaming and compression activity in the tool is also 
> high and it can lead to subtle live-lock effect of endless activity when 
> compression of single new byte from some of mmaped kernel buffer leads to 
> eneration of the next single byte at some mmaped buffer so perf tool trace 
> writing thread never stops on polling event file descriptors.
> 
> Implemented sync param is the mean to force data move independently from
> the threshold value. Despite the provided flush value from the command
> line, the tool needs capability to drain memory buffers, at least in the
> end of the collection.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-record.txt | 13 ++++++
>  tools/perf/builtin-record.c              | 53 +++++++++++++++++++++---
>  tools/perf/perf.h                        |  1 +
>  tools/perf/util/evlist.c                 |  6 +--
>  tools/perf/util/evlist.h                 |  3 +-
>  tools/perf/util/mmap.c                   |  4 +-
>  tools/perf/util/mmap.h                   |  3 +-
>  7 files changed, 71 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 8f0c2be34848..9fa33ce9bc00 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -459,6 +459,19 @@ Set affinity mask of trace reading thread according to the policy defined by 'mo
>    node - thread affinity mask is set to NUMA node cpu mask of the processed mmap buffer
>    cpu  - thread affinity mask is set to cpu of the processed mmap buffer
>  
> +-f::
> +--mmap-flush=n::
> +Specify minimal number of bytes that is extracted from mmap data pages and stored
> +into a trace. Maximal allowed value is a quarter of the size of mmaped data pages.
> +The default option value is 1 what means that every time trace writing thread finds
> +some new data in the mmaped buffer the data is extracted, possibly compressed (-z)
> +and written to a trace. Larger data chunks are compressed more effectively in
> +comparison to smaller chunks so extraction of larger chunks from the mmap data pages
> +is preferable from perspective of trace size reduction. Also at some cases
> +executing less trace write syscalls with bigger data size can take shorter than
> +executing more trace write syscalls with smaller data size thus lowering runtime
> +profiling overhead.

I was wondering if that's the same we would achieve with ring buffer
watermak config on kernel side.. but I guess it does not hurt to
have something on user side.. I'm just not sure it makes sense to have
a config option for that

I'd understand if we configure some sane value when compression is
enabled.. if it makes sense to have this option, I'd allow it only
when compression is enabled

jirka
