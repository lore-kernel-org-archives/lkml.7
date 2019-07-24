Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFA8C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC1B2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 08:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfGXIxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:53:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfGXIxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 04:53:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3038FB2DD2;
        Wed, 24 Jul 2019 08:53:35 +0000 (UTC)
Received: from krava (unknown [10.40.205.115])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2FABC102486D;
        Wed, 24 Jul 2019 08:53:26 +0000 (UTC)
Date:   Wed, 24 Jul 2019 10:53:25 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephane Eranian <eranian@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [RFC 00/79] perf tools: Initial libperf separation
Message-ID: <20190724085325.GB5860@krava>
References: <20190721112506.12306-1-jolsa@kernel.org>
 <CAP-5=fUt94YqLSwbKCbsgF+019U8dW3jgYdn0OhS01C1wooguA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUt94YqLSwbKCbsgF+019U8dW3jgYdn0OhS01C1wooguA@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 24 Jul 2019 08:53:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 09:23:36AM -0700, Ian Rogers wrote:
> This is really helpful and thank you for taking the initiative! I've
> no real feedback other than to offer support.
> We've been looking in this direction to avoid memory overhead in:
> https://github.com/google/perf_data_converter
> Some use cases:
> 1) streaming protobuf rather than perf.data files,

hum, we already have the CTF conversion support (perf data convert --to-ctf),
perhaps we could add support for profile.proto, so you dont need special app

> 2) using libperf inside of a runtime with JIT for a symbolization
> story that can reduce the storage/memory overhead of the current 'perf
> record' and 'perf inject -j'. Something similar is done here:
> https://github.com/jvm-profiling-tools/async-profiler/blob/936a9fea8dafc5d0674860d229a1b3d86d295e2f/src/perfEvents_linux.cpp

I think that once we have the mmap interface in place we can
discuss some higher level interface that would help you

> 3) self profiling with dwarf based call graphs, to avoid stack samples
> being visible outside of the process which could be a security
> concern.

same as above, once we have mmap support I think this is
one of the things we definitely want to add to libperf

> 
> Most of our tooling is C++ rather than C, and we run into issues like
> tools/include/linux/list.h using 'new' as a variable name. The

libperf has currently the full object separation, so outside users
dont see its object struct's inners.. that should solve the 'new' issue

> duplication of header files in tools/, the importance of -I precedence
> and the use of -include have been other build system gotchas -
> principally because there are so many files with exactly the same
> name. I don't know if in the reorganization into a library this can be
> simplified.

libperf will be public so the building should be hopefuly simpler
and straightforward

thanks a lot for the feedback,
jirka
