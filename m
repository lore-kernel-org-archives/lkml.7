Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DAAC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693622075D
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbfI3MmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 08:42:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfI3MmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 08:42:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1008D83F42;
        Mon, 30 Sep 2019 12:42:14 +0000 (UTC)
Received: from krava (unknown [10.40.205.53])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1F39A5D9C3;
        Mon, 30 Sep 2019 12:42:10 +0000 (UTC)
Date:   Mon, 30 Sep 2019 14:42:09 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf tools: avoid sample_reg_masks being const + weak
Message-ID: <20190930124209.GF602@krava>
References: <20190927211005.147176-1-irogers@google.com>
 <20190927214341.170683-1-irogers@google.com>
 <20190929210514.GC602@krava>
 <20190930122335.GF9622@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930122335.GF9622@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 30 Sep 2019 12:42:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 09:23:35AM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

>   CC       /tmp/build/perf/util/lzma.o
>   CC       /tmp/build/perf/util/demangle-java.o
>   CC       /tmp/build/perf/util/demangle-rust.o
>   CC       /tmp/build/perf/util/jitdump.o
>   CC       /tmp/build/perf/util/genelf.o
>   CC       /tmp/build/perf/util/genelf_debug.o
>   CC       /tmp/build/perf/util/perf-hooks.o
>   CC       /tmp/build/perf/util/bpf-event.o
>   FLEX     /tmp/build/perf/util/parse-events-flex.c
>   LD       /tmp/build/perf/util/intel-pt-decoder/perf-in.o
>   FLEX     /tmp/build/perf/util/pmu-flex.c
>   CC       /tmp/build/perf/util/pmu-bison.o
>   CC       /tmp/build/perf/util/expr-bison.o
>   CC       /tmp/build/perf/util/parse-events.o
>   CC       /tmp/build/perf/util/parse-events-flex.o
>   CC       /tmp/build/perf/util/pmu.o
>   CC       /tmp/build/perf/util/pmu-flex.o
>   LD       /tmp/build/perf/util/perf-in.o
>   LD       /tmp/build/perf/perf-in.o
>   LINK     /tmp/build/perf/perf
> /usr/lib/gcc-cross/aarch64-linux-gnu/8/../../../../aarch64-linux-gnu/bin/ld: /tmp/build/perf/perf-in.o: in function `__parse_regs':
> /git/linux/tools/perf/util/parse-regs-options.c:39: undefined reference to `sample_reg_masks'
> /usr/lib/gcc-cross/aarch64-linux-gnu/8/../../../../aarch64-linux-gnu/bin/ld: /git/linux/tools/perf/util/parse-regs-options.c:47: undefined reference to `sample_reg_masks'
> /usr/lib/gcc-cross/aarch64-linux-gnu/8/../../../../aarch64-linux-gnu/bin/ld: /git/linux/tools/perf/util/parse-regs-options.c:60: undefined reference to `sample_reg_masks'
> /usr/lib/gcc-cross/aarch64-linux-gnu/8/../../../../aarch64-linux-gnu/bin/ld: /git/linux/tools/perf/util/parse-regs-options.c:50: undefined reference to `sample_reg_masks'

argh.. I tried on power.. should have tried on arm ;-)

I expected that all the archs that set NO_PERF_REGS := 0 would have
sample_reg_masks defined..  all those archs did fallback to the:

  const struct sample_reg __weak sample_reg_masks[] = {
       SMPL_REG_END
  };

those archs are not able to use --user-regs/--intr-regs options,
but for dwarf unwind we set those registers manualy, so that works

so I guess we need to define empty sample_reg_masks for those archs

jirka
