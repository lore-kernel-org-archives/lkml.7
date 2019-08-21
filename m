Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E05C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBDD206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 07:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfHUG6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 02:58:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36942 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbfHUG6r (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 02:58:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 22CC58AC6F6;
        Wed, 21 Aug 2019 06:58:47 +0000 (UTC)
Received: from krava (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C02E2C8E7;
        Wed, 21 Aug 2019 06:58:45 +0000 (UTC)
Date:   Wed, 21 Aug 2019 08:58:44 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v6] perf diff: Report noisy for cycles diff
Message-ID: <20190821065844.GA11701@krava>
References: <20190820122207.9723-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190820122207.9723-1-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Wed, 21 Aug 2019 06:58:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 08:22:07PM +0800, Jin Yao wrote:
> This patch prints the stddev and hist for the cycles diff of
> program block. It can help us to understand if the cycles
> is noisy or not.
> 
> This patch is inspired by Andi Kleen's patch
> https://lwn.net/Articles/600471/
> 
> We create new option '--cycles-hist'.
> 
> Example:
> 
> perf record -b ./div
> perf record -b ./div
> perf diff -c cycles
> 
>   # Baseline                                       [Program Block Range] Cycles Diff  Shared Object      Symbol
>   # ........  ......................................................................  .................  ............................
>   #
>       46.72%                                             [div.c:40 -> div.c:40]    0  div                [.] main
>       46.72%                                             [div.c:42 -> div.c:44]    0  div                [.] main
>       46.72%                                             [div.c:42 -> div.c:39]    0  div                [.] main
>       20.54%                                 [random_r.c:357 -> random_r.c:394]    1  libc-2.27.so       [.] __random_r
>       20.54%                                 [random_r.c:357 -> random_r.c:380]    0  libc-2.27.so       [.] __random_r
>       20.54%                                 [random_r.c:388 -> random_r.c:388]    0  libc-2.27.so       [.] __random_r
>       20.54%                                 [random_r.c:388 -> random_r.c:391]    0  libc-2.27.so       [.] __random_r
>       17.04%                                     [random.c:288 -> random.c:291]    0  libc-2.27.so       [.] __random
>       17.04%                                     [random.c:291 -> random.c:291]    0  libc-2.27.so       [.] __random
>       17.04%                                     [random.c:293 -> random.c:293]    0  libc-2.27.so       [.] __random
>       17.04%                                     [random.c:295 -> random.c:295]    0  libc-2.27.so       [.] __random
>       17.04%                                     [random.c:295 -> random.c:295]    0  libc-2.27.so       [.] __random
>       17.04%                                     [random.c:298 -> random.c:298]    0  libc-2.27.so       [.] __random
>        8.40%                                             [div.c:22 -> div.c:25]    0  div                [.] compute_flag
>        8.40%                                             [div.c:27 -> div.c:28]    0  div                [.] compute_flag
>        5.14%                                           [rand.c:26 -> rand.c:27]    0  libc-2.27.so       [.] rand
>        5.14%                                           [rand.c:28 -> rand.c:28]    0  libc-2.27.so       [.] rand
>        2.15%                                         [rand@plt+0 -> rand@plt+0]    0  div                [.] rand@plt
>        0.00%                                                                          [kernel.kallsyms]  [k] __x86_indirect_thunk_rax
>        0.00%                                       [do_mmap+714 -> do_mmap+732]  -10  [kernel.kallsyms]  [k] do_mmap
>        0.00%                                       [do_mmap+737 -> do_mmap+765]    1  [kernel.kallsyms]  [k] do_mmap
>        0.00%                                       [do_mmap+262 -> do_mmap+299]    0  [kernel.kallsyms]  [k] do_mmap
>        0.00%         [__x86_indirect_thunk_r15+0 -> __x86_indirect_thunk_r15+0]    7  [kernel.kallsyms]  [k] __x86_indirect_thunk_r15
>        0.00%                   [native_sched_clock+0 -> native_sched_clock+119]   -1  [kernel.kallsyms]  [k] native_sched_clock
>        0.00%                        [native_write_msr+0 -> native_write_msr+16]  -13  [kernel.kallsyms]  [k] native_write_msr
> 
> When we enable the option '--cycles-hist', the output is
> 
> perf diff -c cycles --cycles-hist
> 
>   # Baseline                                       [Program Block Range] Cycles Diff        stddev/Hist  Shared Object      Symbol
>   # ........  ......................................................................  .................  .................  ............................
>   #
>       46.72%                                             [div.c:40 -> div.c:40]    0  ± 37.8% ▁█▁▁██▁█   div                [.] main
>       46.72%                                             [div.c:42 -> div.c:44]    0  ± 49.4% ▁▁▂█▂▂▂▂   div                [.] main
>       46.72%                                             [div.c:42 -> div.c:39]    0  ± 24.1% ▃█▂▄▁▃▂▁   div                [.] main
>       20.54%                                 [random_r.c:357 -> random_r.c:394]    1  ± 33.5% ▅▂▁█▃▁▂▁   libc-2.27.so       [.] __random_r
>       20.54%                                 [random_r.c:357 -> random_r.c:380]    0  ± 39.4% ▁▁█▁██▅▁   libc-2.27.so       [.] __random_r
>       20.54%                                 [random_r.c:388 -> random_r.c:388]    0                     libc-2.27.so       [.] __random_r
>       20.54%                                 [random_r.c:388 -> random_r.c:391]    0  ± 41.2% ▁▃▁▂█▄▃▁   libc-2.27.so       [.] __random_r
>       17.04%                                     [random.c:288 -> random.c:291]    0  ± 48.8% ▁▁▁▁███▁   libc-2.27.so       [.] __random
>       17.04%                                     [random.c:291 -> random.c:291]    0  ±100.0% ▁█▁▁▁▁▁▁   libc-2.27.so       [.] __random
>       17.04%                                     [random.c:293 -> random.c:293]    0  ±100.0% ▁█▁▁▁▁▁▁   libc-2.27.so       [.] __random
>       17.04%                                     [random.c:295 -> random.c:295]    0  ±100.0% ▁█▁▁▁▁▁▁   libc-2.27.so       [.] __random
>       17.04%                                     [random.c:295 -> random.c:295]    0                     libc-2.27.so       [.] __random
>       17.04%                                     [random.c:298 -> random.c:298]    0  ± 75.6% ▃█▁▁▁▁▁▁   libc-2.27.so       [.] __random
>        8.40%                                             [div.c:22 -> div.c:25]    0  ± 42.1% ▁▃▁▁███▁   div                [.] compute_flag
>        8.40%                                             [div.c:27 -> div.c:28]    0  ± 41.8% ██▁▁▄▁▁▄   div                [.] compute_flag
>        5.14%                                           [rand.c:26 -> rand.c:27]    0  ± 37.8% ▁▁▁████▁   libc-2.27.so       [.] rand
>        5.14%                                           [rand.c:28 -> rand.c:28]    0                     libc-2.27.so       [.] rand
>        2.15%                                         [rand@plt+0 -> rand@plt+0]    0                     div                [.] rand@plt
>        0.00%                                                                                             [kernel.kallsyms]  [k] __x86_indirect_thunk_rax
>        0.00%                                       [do_mmap+714 -> do_mmap+732]  -10                     [kernel.kallsyms]  [k] do_mmap
>        0.00%                                       [do_mmap+737 -> do_mmap+765]    1                     [kernel.kallsyms]  [k] do_mmap
>        0.00%                                       [do_mmap+262 -> do_mmap+299]    0                     [kernel.kallsyms]  [k] do_mmap
>        0.00%         [__x86_indirect_thunk_r15+0 -> __x86_indirect_thunk_r15+0]    7                     [kernel.kallsyms]  [k] __x86_indirect_thunk_r15
>        0.00%                   [native_sched_clock+0 -> native_sched_clock+119]   -1  ± 38.5% ▄█▁        [kernel.kallsyms]  [k] native_sched_clock
>        0.00%                        [native_write_msr+0 -> native_write_msr+16]  -13  ± 47.1% ▁█▇▃▁▁     [kernel.kallsyms]  [k] native_write_msr
> 
>  v6:
>  ---
>  1. Jiri provides better code for using data__hpp_register() in ui_init().
>     Use this code in v6.

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
