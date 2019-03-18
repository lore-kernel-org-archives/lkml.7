Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E48C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F38A20854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfCRLq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:46:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48300 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfCRLq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:46:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC11A3092642;
        Mon, 18 Mar 2019 11:46:26 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id 53D935C207;
        Mon, 18 Mar 2019 11:46:25 +0000 (UTC)
Date:   Mon, 18 Mar 2019 12:46:25 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 00/12] perf: enable compression of record mode trace
 to save storage space
Message-ID: <20190318114625.GB7900@krava>
References: <c1423198-e474-1739-e800-4615cce501ce@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1423198-e474-1739-e800-4615cce501ce@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 18 Mar 2019 11:46:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 11:58:30AM +0300, Alexey Budankov wrote:

SNIP

> ---
> Alexey Budankov (12):
>   feature: implement libzstd check, LIBZSTD_DIR and NO_LIBZSTD defines
>   perf record: implement --mmap-flush=<number> option
>   perf session: define bytes_transferred and bytes_compressed metrics
>   perf record: implement COMPRESSED event record and its attributes
>   perf mmap: implement dedicated memory buffer for data compression
>   perf util: introduce Zstd streaming based compression API
>   perf record: implement compression for serial trace streaming
>   perf record: implement compression for AIO trace streaming
>   perf record: implement -z,--compression_level[=<n>] option
>   perf report: implement record trace decompression
>   perf inject: enable COMPRESSED records decompression
>   perf tests: implement Zstd comp/decomp integration test
> 
>  tools/build/Makefile.feature                  |   6 +-
>  tools/build/feature/Makefile                  |   6 +-
>  tools/build/feature/test-all.c                |   5 +
>  tools/build/feature/test-libzstd.c            |  12 +
>  tools/perf/Documentation/perf-record.txt      |  17 ++
>  .../Documentation/perf.data-file-format.txt   |  24 ++
>  tools/perf/Makefile.config                    |  20 ++
>  tools/perf/Makefile.perf                      |   3 +
>  tools/perf/builtin-inject.c                   |   4 +
>  tools/perf/builtin-record.c                   | 285 +++++++++++++++---
>  tools/perf/builtin-report.c                   |   5 +-
>  tools/perf/builtin-version.c                  |   2 +
>  tools/perf/perf.h                             |   2 +
>  .../tests/shell/record+zstd_comp_decomp.sh    |  28 ++
>  tools/perf/util/Build                         |   2 +
>  tools/perf/util/compress.h                    |  54 ++++
>  tools/perf/util/env.h                         |  11 +
>  tools/perf/util/event.c                       |   1 +
>  tools/perf/util/event.h                       |   7 +
>  tools/perf/util/evlist.c                      |   8 +-
>  tools/perf/util/evlist.h                      |   3 +-
>  tools/perf/util/header.c                      |  55 +++-
>  tools/perf/util/header.h                      |   1 +
>  tools/perf/util/mmap.c                        | 106 ++-----
>  tools/perf/util/mmap.h                        |  17 +-
>  tools/perf/util/session.c                     | 124 +++++++-
>  tools/perf/util/session.h                     |  14 +
>  tools/perf/util/tool.h                        |   2 +
>  tools/perf/util/zstd.c                        | 111 +++++++
>  29 files changed, 801 insertions(+), 134 deletions(-)
>  create mode 100644 tools/build/feature/test-libzstd.c
>  create mode 100755 tools/perf/tests/shell/record+zstd_comp_decomp.sh
>  create mode 100644 tools/perf/util/zstd.c
> 
> ---
> Changes in v9:
> - fixed issue with improper max COMPRESSED record size calculation
> - moved up calculation of ratio variable in 03/12
> - made minor corrections in changelogs
> - corrected several checkpatch.pl warnings and errors

apart from 2 comments I'm ok with this patchset

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks a lot,
jirka
