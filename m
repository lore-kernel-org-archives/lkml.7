Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A151C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBF02171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfCMOhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:37:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbfCMOhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:37:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C194F300371C;
        Wed, 13 Mar 2019 14:37:06 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id 17D9818258;
        Wed, 13 Mar 2019 14:37:04 +0000 (UTC)
Date:   Wed, 13 Mar 2019 15:37:04 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/10] perf: enable compression of record mode trace to
 save storage space
Message-ID: <20190313143704.GC6676@krava>
References: <bb018a36-5249-ca6a-8e16-6afac442bae5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb018a36-5249-ca6a-8e16-6afac442bae5@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 13 Mar 2019 14:37:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:35:24AM +0300, Alexey Budankov wrote:
> 
> The patch set implements runtime trace compression (-z option) in 
> record mode and trace auto decompression in report and inject modes. 
> Streaming Zstandard (Zstd) API (zstd) is used for compression and 
> decompression of data that come from kernel mmaped data buffers.
> 
> Usage of implemented -z,--compression_level=n option provides ~3-5x 
> avg. trace file size reduction on variety of tested workloads what 
> saves storage space on larger server systems where trace file size 
> can easily reach several tens or even hundreds of GiBs, especially 
> when profiling with dwarf-based stacks and tracing of context switches.
> Implemented -f,--mmap-flush option can be used to avoid compressing 
> every single byte of data and increase compression ratio at the same 
> time lowering tool runtime overhead. Default option value is 1 what 
> is equal to the current perf record implementation. The option is 
> independent from -z setting and doesn't vary with compression level:
> 
>   $ tools/perf/perf record -z 1 -e cycles -- matrix.gcc
>   $ tools/perf/perf record --aio=1 -z 1 -e cycles -- matrix.gcc
>   $ tools/perf/perf record -z 1 -f 1024 -e cycles -- matrix.gcc
>   $ tools/perf/perf record --aio=1 -z 1 -f 1024 -e cycles -- matrix.gcc

please make the 'z' option to choose some default value,
so it's possible just to run:

  perf record -z ...

to get comrpessed data.. not sure which strategy to use,
probably the fastest '-z 1' as default

with some warning about using that default value perhaps

jirka
