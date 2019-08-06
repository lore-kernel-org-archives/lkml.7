Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483A7C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B72206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbfHFIeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 04:34:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728056AbfHFIeY (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:34:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1FB6730FB8F3;
        Tue,  6 Aug 2019 08:34:24 +0000 (UTC)
Received: from krava (unknown [10.43.17.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33E9219C78;
        Tue,  6 Aug 2019 08:34:22 +0000 (UTC)
Date:   Tue, 6 Aug 2019 10:34:21 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] perf diff: Report noisy for cycles diff
Message-ID: <20190806083421.GH7695@krava>
References: <20190724221432.26297-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190724221432.26297-1-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 06 Aug 2019 08:34:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 06:14:32AM +0800, Jin Yao wrote:
> This patch prints the stddev and hist for the cycles diff of
> program block. It can help us to understand if the cycles diff
> is noisy or not.
> 
> This patch is inspired by Andi Kleen's patch
> https://lwn.net/Articles/600471/
> 
> We create new option '-n or --noisy'.
> 
> Example:
> 
> perf record -b ./div
> perf record -b ./div
> perf diff -c cycles
> 
>  # Event 'cycles'
>  #
>  # Baseline                                       [Program Block Range] Cycles Diff  Shared Object      Symbol
>  # ........  ......................................................................  .................  ................................
>  #
>      46.42%                                             [div.c:40 -> div.c:40]    0  div                [.] main
>      46.42%                                             [div.c:42 -> div.c:44]    0  div                [.] main
>      46.42%                                             [div.c:42 -> div.c:39]    0  div                [.] main
>      20.72%                                 [random_r.c:357 -> random_r.c:394]   -2  libc-2.27.so       [.] __random_r
>      20.72%                                 [random_r.c:357 -> random_r.c:380]   -1  libc-2.27.so       [.] __random_r
>      20.72%                                 [random_r.c:388 -> random_r.c:388]    0  libc-2.27.so       [.] __random_r
>      20.72%                                 [random_r.c:388 -> random_r.c:391]    0  libc-2.27.so       [.] __random_r
>      17.58%                                     [random.c:288 -> random.c:291]    0  libc-2.27.so       [.] __random
>      17.58%                                     [random.c:291 -> random.c:291]    0  libc-2.27.so       [.] __random
>      17.58%                                     [random.c:293 -> random.c:293]    0  libc-2.27.so       [.] __random
>      17.58%                                     [random.c:295 -> random.c:295]    0  libc-2.27.so       [.] __random
>      17.58%                                     [random.c:295 -> random.c:295]    0  libc-2.27.so       [.] __random
>      17.58%                                     [random.c:298 -> random.c:298]    0  libc-2.27.so       [.] __random
>       8.33%                                             [div.c:22 -> div.c:25]    0  div                [.] compute_flag
>       8.33%                                             [div.c:27 -> div.c:28]    0  div                [.] compute_flag
>       4.80%                                           [rand.c:26 -> rand.c:27]    0  libc-2.27.so       [.] rand
>       4.80%                                           [rand.c:28 -> rand.c:28]    0  libc-2.27.so       [.] rand
>       2.14%                                         [rand@plt+0 -> rand@plt+0]    0  div                [.] rand@plt
> 
> When we enable the option '-n' or '--noisy', the output is
> 
> perf diff -c cycles -n
> 
>  # Event 'cycles'
>  #
>  # Baseline                                     [Program Block Range]/Cycles Diff/stddev/Hist  Shared Object      Symbol
>  # ........  ................................................................................  .................  ................................
>  #
>      46.42%                                    [div.c:40 -> div.c:40]    0  ± 40.2% ▂███▁▂▁▁   div                [.] main
>      46.42%                                    [div.c:42 -> div.c:44]    0  ±100.0% ▁▁▁▁█▁▁▁   div                [.] main
>      46.42%                                    [div.c:42 -> div.c:39]    0  ± 15.3% ▃▃▂▆▃▂█▁   div                [.] main
>      20.72%                        [random_r.c:357 -> random_r.c:394]   -2  ± 20.1% ▁▄▄▅▂▅█▁   libc-2.27.so       [.] __random_r
>      20.72%                        [random_r.c:357 -> random_r.c:380]   -1  ± 20.9% ▁▆▇▁█▅▇█   libc-2.27.so       [.] __random_r
>      20.72%                        [random_r.c:388 -> random_r.c:388]    0  ±  0.0%            libc-2.27.so       [.] __random_r
>      20.72%                        [random_r.c:388 -> random_r.c:391]    0  ± 88.0% ▁▁▁▁▁▁▁█   libc-2.27.so       [.] __random_r
>      17.58%                            [random.c:288 -> random.c:291]    0  ± 29.3% ▁████▁█▁   libc-2.27.so       [.] __random
>      17.58%                            [random.c:291 -> random.c:291]    0  ± 29.3% ▁████▁▁█   libc-2.27.so       [.] __random
>      17.58%                            [random.c:293 -> random.c:293]    0  ± 29.3% ▁████▁▁█   libc-2.27.so       [.] __random
>      17.58%                            [random.c:295 -> random.c:295]    0  ±  0.0%            libc-2.27.so       [.] __random
>      17.58%                            [random.c:295 -> random.c:295]    0  ±  0.0%            libc-2.27.so       [.] __random
>      17.58%                            [random.c:298 -> random.c:298]    0  ±  0.0%            libc-2.27.so       [.] __random
>       8.33%                                    [div.c:22 -> div.c:25]    0  ± 29.3% ▁████▁█▁   div                [.] compute_flag
>       8.33%                                    [div.c:27 -> div.c:28]    0  ± 48.8% ▁██▁▁▁█▁   div                [.] compute_flag
>       4.80%                                  [rand.c:26 -> rand.c:27]    0  ± 29.3% ▁████▁█▁   libc-2.27.so       [.] rand
>       4.80%                                  [rand.c:28 -> rand.c:28]    0  ±  0.0%            libc-2.27.so       [.] rand
>       2.14%                                [rand@plt+0 -> rand@plt+0]    0  ±  0.0%            div                [.] rand@plt

I'm getting some unaligned lines:

	# Event 'cycles'
	#
	# Baseline                                     [Program Block Range]/Cycles Diff/stddev/Hist  Shared Object        Symbol                                        
	# ........  ................................................................................  ...................  ..............................................
	#
	    11.87%                     [do_syscall_64+0 -> do_syscall_64+30]  -22  ± 91.8% █▁         [kernel.kallsyms]    [k] do_syscall_64
	    11.87%                     [do_syscall_64+0 -> do_syscall_64+47]   -3  ± 84.9% ▁▁▁▁▁▁█▂   [kernel.kallsyms]    [k] do_syscall_64
	    11.87%                   [do_syscall_64+91 -> do_syscall_64+118]   -1  ± 33.5% ▁▁▅▃█▁▅█   [kernel.kallsyms]    [k] do_syscall_64
	    11.87%                    [do_syscall_64+0 -> do_syscall_64+286]    0  ±100.0% ▁▁█▁▁▁▁▁   [kernel.kallsyms]    [k] do_syscall_64
	    11.87%                    [do_syscall_64+0 -> do_syscall_64+332]    0  ±  0.0%            [kernel.kallsyms]    [k] do_syscall_64
	    11.87%                    [do_syscall_64+53 -> do_syscall_64+86]    0  ±  0.0%            [kernel.kallsyms]    [k] do_syscall_64
	    11.87%                  [do_syscall_64+124 -> do_syscall_64+148]    0  ± 26.3% ▁▆▂█▆▁██   [kernel.kallsyms]    [k] do_syscall_64
	    11.87%                  [do_syscall_64+181 -> do_syscall_64+219]    0  ± 38.9% █▄▄▂▁▁▁▁   [kernel.kallsyms]    [k] do_syscall_64
	    11.87%                  [do_syscall_64+278 -> do_syscall_64+281]    0  ±  0.0%            [kernel.kallsyms]    [k] do_syscall_64
	    11.87%                  [do_syscall_64+291 -> do_syscall_64+294]    0  ±100.0% ▁▁▁▁▁▁▁█   [kernel.kallsyms]    [k] do_syscall_64
	     6.76%              [psi_task_change+421 -> psi_task_change+440]   -5  ± 45.6% ▄▂▁▁▄▁█▁   [kernel.kallsyms]    [k] psi_task_change
	     6.76%                 [psi_task_change+0 -> psi_task_change+60]   -3  ± 47.9% ▁▃▁▂▁▁█▁   [kernel.kallsyms]    [k] psi_task_change
	     6.76%              [psi_task_change+126 -> psi_task_change+225]   -2  ± 22.8% ▂▅█▇▃▁▃▅   [kernel.kallsyms]    [k] psi_task_change
	     6.76%              [psi_task_change+126 -> psi_task_change+172]   -1  ± 48.8% ▁██▁█▁▁▁   [kernel.kallsyms]    [k] psi_task_change
	     6.76%              [psi_task_change+476 -> psi_task_change+488]   -1  ± 39.9% █▁▁█▁▁▄█   [kernel.kallsyms]    [k] psi_task_change
	     6.76%               [psi_task_change+80 -> psi_task_change+118]    0  ± 50.0% █▁▂▂▁▁▄▁   [kernel.kallsyms]    [k] psi_task_change
	     6.76%               [psi_task_change+80 -> psi_task_change+129]    0  ± 48.9% ▁▁▁▇▁█▁█   [kernel.kallsyms]    [k] psi_task_change
	     6.76%              [psi_task_change+126 -> psi_task_change+142]    0  ±  0.0%            [kernel.kallsyms]    [k] psi_task_change
	     6.76%              [psi_task_change+230 -> psi_task_change+252]    0  ±  0.0%            [kernel.kallsyms]    [k] psi_task_change
	     6.76%              [psi_task_change+230 -> psi_task_change+265]    0  ±  0.0%            [kernel.kallsyms]    [k] psi_task_change
	     6.76%              [psi_task_change+254 -> psi_task_change+324]    0  ±100.0% ▁█▁▁▁▁▁▁   [kernel.kallsyms]    [k] psi_task_change
	     6.76%              [psi_task_change+298 -> psi_task_change+307]    0  ±  0.0%            [kernel.kallsyms]    [k] psi_task_change
	     6.76%              [psi_task_change+309 -> psi_task_change+332]    0  ± 37.8% ▁▁█▁▁███   [kernel.kallsyms]    [k] psi_task_change
	     6.76%              [psi_task_change+326 -> psi_task_change+370]    0  ± 79.5% ▁█▁▁▁▁▁▁   [kernel.kallsyms]    [k] psi_task_change
	     6.76%              [psi_task_change+341 -> psi_task_change+348]    0  ±  0.0%            [kernel.kallsyms]    [k] psi_task_change
	     6.76%              [psi_task_change+446 -> psi_task_change+456]    0  ±  0.0%            [kernel.kallsyms]    [k] psi_task_change
	     6.76%              [psi_task_change+461 -> psi_task_change+475]    0  ±  0.0%            [kernel.kallsyms]    [k] psi_task_change
	     6.76%              [psi_task_change+493 -> psi_task_change+497]    0  ± 77.8% █▁▁▁▁▁▃▁   [kernel.kallsyms]    [k] psi_task_change
	     5.27%  [syscall_return_via_sysret+0 -> syscall_return_via_sysret+81]  -21  ± 28.1% ▂▄█▄▅▂▁▁   [kernel.kallsyms]    [k] syscall_return_via_sysret
	     5.27%  [syscall_return_via_sysret+0 -> syscall_return_via_sysret+66]    0  ± 48.7% ▁▇▂▁▁▁█▁   [kernel.kallsyms]    [k] syscall_return_via_sysret
	     5.27%  [syscall_return_via_sysret+83 -> syscall_return_via_sysret+114]    0  ± 12.8% █▅▆▅▆▁▅▅   [kernel.kallsyms]    [k] syscall_return_via_sysret
	     4.22%               [native_write_msr+0 -> native_write_msr+11]    0  ± 24.6% █▅▄▄▂▄▁▁   [kernel.kallsyms]    [k] native_write_msr
	     2.84%          [enqueue_task_fair+257 -> enqueue_task_fair+281] -168  ± 94.5% ▁█         [kernel.kallsyms]    [k] enqueue_task_fair
	     2.84%          [enqueue_task_fair+904 -> enqueue_task_fair+916] -122  ±  0.0%            [kernel.kallsyms]    [k] enqueue_task_fair
	     2.84%            [enqueue_task_fair+93 -> enqueue_task_fair+98]   27  ±  8.6% ▁█         [kernel.kallsyms]    [k] enqueue_task_fair
	     2.84%          [enqueue_task_fair+286 -> enqueue_task_fair+289]    5  ± 85.5% ▁▁█        [kernel.kallsyms]    [k] enqueue_task_fair
	     2.84%            [enqueue_task_fair+0 -> enqueue_task_fair+120]   -3  ± 19.5% ▁█▁▃▂▄▆▃   [kernel.kallsyms]    [k] enqueue_task_fair

thanks,
jirka
