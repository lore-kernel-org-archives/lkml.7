Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC03C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244E120880
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbfHFLqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 07:46:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:63075 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfHFLqm (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:46:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 04:46:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="198288876"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.254.212.182]) ([10.254.212.182])
  by fmsmga004.fm.intel.com with ESMTP; 06 Aug 2019 04:46:38 -0700
Subject: Re: [PATCH v2] perf diff: Report noisy for cycles diff
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20190724221432.26297-1-yao.jin@linux.intel.com>
 <20190806083421.GH7695@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <3efff55b-511c-0748-432c-e7ef4718c506@linux.intel.com>
Date:   Tue, 6 Aug 2019 19:46:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806083421.GH7695@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/6/2019 4:34 PM, Jiri Olsa wrote:
> On Thu, Jul 25, 2019 at 06:14:32AM +0800, Jin Yao wrote:
>> This patch prints the stddev and hist for the cycles diff of
>> program block. It can help us to understand if the cycles diff
>> is noisy or not.
>>
>> This patch is inspired by Andi Kleen's patch
>> https://lwn.net/Articles/600471/
>>
>> We create new option '-n or --noisy'.
>>
>> Example:
>>
>> perf record -b ./div
>> perf record -b ./div
>> perf diff -c cycles
>>
>>   # Event 'cycles'
>>   #
>>   # Baseline                                       [Program Block Range] Cycles Diff  Shared Object      Symbol
>>   # ........  ......................................................................  .................  ................................
>>   #
>>       46.42%                                             [div.c:40 -> div.c:40]    0  div                [.] main
>>       46.42%                                             [div.c:42 -> div.c:44]    0  div                [.] main
>>       46.42%                                             [div.c:42 -> div.c:39]    0  div                [.] main
>>       20.72%                                 [random_r.c:357 -> random_r.c:394]   -2  libc-2.27.so       [.] __random_r
>>       20.72%                                 [random_r.c:357 -> random_r.c:380]   -1  libc-2.27.so       [.] __random_r
>>       20.72%                                 [random_r.c:388 -> random_r.c:388]    0  libc-2.27.so       [.] __random_r
>>       20.72%                                 [random_r.c:388 -> random_r.c:391]    0  libc-2.27.so       [.] __random_r
>>       17.58%                                     [random.c:288 -> random.c:291]    0  libc-2.27.so       [.] __random
>>       17.58%                                     [random.c:291 -> random.c:291]    0  libc-2.27.so       [.] __random
>>       17.58%                                     [random.c:293 -> random.c:293]    0  libc-2.27.so       [.] __random
>>       17.58%                                     [random.c:295 -> random.c:295]    0  libc-2.27.so       [.] __random
>>       17.58%                                     [random.c:295 -> random.c:295]    0  libc-2.27.so       [.] __random
>>       17.58%                                     [random.c:298 -> random.c:298]    0  libc-2.27.so       [.] __random
>>        8.33%                                             [div.c:22 -> div.c:25]    0  div                [.] compute_flag
>>        8.33%                                             [div.c:27 -> div.c:28]    0  div                [.] compute_flag
>>        4.80%                                           [rand.c:26 -> rand.c:27]    0  libc-2.27.so       [.] rand
>>        4.80%                                           [rand.c:28 -> rand.c:28]    0  libc-2.27.so       [.] rand
>>        2.14%                                         [rand@plt+0 -> rand@plt+0]    0  div                [.] rand@plt
>>
>> When we enable the option '-n' or '--noisy', the output is
>>
>> perf diff -c cycles -n
>>
>>   # Event 'cycles'
>>   #
>>   # Baseline                                     [Program Block Range]/Cycles Diff/stddev/Hist  Shared Object      Symbol
>>   # ........  ................................................................................  .................  ................................
>>   #
>>       46.42%                                    [div.c:40 -> div.c:40]    0  ± 40.2% ▂███▁▂▁▁   div                [.] main
>>       46.42%                                    [div.c:42 -> div.c:44]    0  ±100.0% ▁▁▁▁█▁▁▁   div                [.] main
>>       46.42%                                    [div.c:42 -> div.c:39]    0  ± 15.3% ▃▃▂▆▃▂█▁   div                [.] main
>>       20.72%                        [random_r.c:357 -> random_r.c:394]   -2  ± 20.1% ▁▄▄▅▂▅█▁   libc-2.27.so       [.] __random_r
>>       20.72%                        [random_r.c:357 -> random_r.c:380]   -1  ± 20.9% ▁▆▇▁█▅▇█   libc-2.27.so       [.] __random_r
>>       20.72%                        [random_r.c:388 -> random_r.c:388]    0  ±  0.0%            libc-2.27.so       [.] __random_r
>>       20.72%                        [random_r.c:388 -> random_r.c:391]    0  ± 88.0% ▁▁▁▁▁▁▁█   libc-2.27.so       [.] __random_r
>>       17.58%                            [random.c:288 -> random.c:291]    0  ± 29.3% ▁████▁█▁   libc-2.27.so       [.] __random
>>       17.58%                            [random.c:291 -> random.c:291]    0  ± 29.3% ▁████▁▁█   libc-2.27.so       [.] __random
>>       17.58%                            [random.c:293 -> random.c:293]    0  ± 29.3% ▁████▁▁█   libc-2.27.so       [.] __random
>>       17.58%                            [random.c:295 -> random.c:295]    0  ±  0.0%            libc-2.27.so       [.] __random
>>       17.58%                            [random.c:295 -> random.c:295]    0  ±  0.0%            libc-2.27.so       [.] __random
>>       17.58%                            [random.c:298 -> random.c:298]    0  ±  0.0%            libc-2.27.so       [.] __random
>>        8.33%                                    [div.c:22 -> div.c:25]    0  ± 29.3% ▁████▁█▁   div                [.] compute_flag
>>        8.33%                                    [div.c:27 -> div.c:28]    0  ± 48.8% ▁██▁▁▁█▁   div                [.] compute_flag
>>        4.80%                                  [rand.c:26 -> rand.c:27]    0  ± 29.3% ▁████▁█▁   libc-2.27.so       [.] rand
>>        4.80%                                  [rand.c:28 -> rand.c:28]    0  ±  0.0%            libc-2.27.so       [.] rand
>>        2.14%                                [rand@plt+0 -> rand@plt+0]    0  ±  0.0%            div                [.] rand@plt
> 
> I'm getting some unaligned lines:
> 
> 	# Event 'cycles'
> 	#
> 	# Baseline                                     [Program Block Range]/Cycles Diff/stddev/Hist  Shared Object        Symbol
> 	# ........  ................................................................................  ...................  ..............................................
> 	#
> 	    11.87%                     [do_syscall_64+0 -> do_syscall_64+30]  -22  ± 91.8% █▁         [kernel.kallsyms]    [k] do_syscall_64
> 	    11.87%                     [do_syscall_64+0 -> do_syscall_64+47]   -3  ± 84.9% ▁▁▁▁▁▁█▂   [kernel.kallsyms]    [k] do_syscall_64
> 	    11.87%                   [do_syscall_64+91 -> do_syscall_64+118]   -1  ± 33.5% ▁▁▅▃█▁▅█   [kernel.kallsyms]    [k] do_syscall_64
> 	    11.87%                    [do_syscall_64+0 -> do_syscall_64+286]    0  ±100.0% ▁▁█▁▁▁▁▁   [kernel.kallsyms]    [k] do_syscall_64
> 	    11.87%                    [do_syscall_64+0 -> do_syscall_64+332]    0  ±  0.0%            [kernel.kallsyms]    [k] do_syscall_64
> 	    11.87%                    [do_syscall_64+53 -> do_syscall_64+86]    0  ±  0.0%            [kernel.kallsyms]    [k] do_syscall_64
> 	    11.87%                  [do_syscall_64+124 -> do_syscall_64+148]    0  ± 26.3% ▁▆▂█▆▁██   [kernel.kallsyms]    [k] do_syscall_64
> 	    11.87%                  [do_syscall_64+181 -> do_syscall_64+219]    0  ± 38.9% █▄▄▂▁▁▁▁   [kernel.kallsyms]    [k] do_syscall_64
> 	    11.87%                  [do_syscall_64+278 -> do_syscall_64+281]    0  ±  0.0%            [kernel.kallsyms]    [k] do_syscall_64
> 	    11.87%                  [do_syscall_64+291 -> do_syscall_64+294]    0  ±100.0% ▁▁▁▁▁▁▁█   [kernel.kallsyms]    [k] do_syscall_64
> 	     6.76%              [psi_task_change+421 -> psi_task_change+440]   -5  ± 45.6% ▄▂▁▁▄▁█▁   [kernel.kallsyms]    [k] psi_task_change
> 	     6.76%                 [psi_task_change+0 -> psi_task_change+60]   -3  ± 47.9% ▁▃▁▂▁▁█▁   [kernel.kallsyms]    [k] psi_task_change
> 	     6.76%              [psi_task_change+126 -> psi_task_change+225]   -2  ± 22.8% ▂▅█▇▃▁▃▅   [kernel.kallsyms]    [k] psi_task_change
> 	     6.76%              [psi_task_change+126 -> psi_task_change+172]   -1  ± 48.8% ▁██▁█▁▁▁   [kernel.kallsyms]    [k] psi_task_change
> 	     6.76%              [psi_task_change+476 -> psi_task_change+488]   -1  ± 39.9% █▁▁█▁▁▄█   [kernel.kallsyms]    [k] psi_task_change
> 	     6.76%               [psi_task_change+80 -> psi_task_change+118]    0  ± 50.0% █▁▂▂▁▁▄▁   [kernel.kallsyms]    [k] psi_task_change
> 	     6.76%               [psi_task_change+80 -> psi_task_change+129]    0  ± 48.9% ▁▁▁▇▁█▁█   [kernel.kallsyms]    [k] psi_task_change
> 	     6.76%              [psi_task_change+126 -> psi_task_change+142]    0  ±  0.0%            [kernel.kallsyms]    [k] psi_task_change
> 	     6.76%              [psi_task_change+230 -> psi_task_change+252]    0  ±  0.0%            [kernel.kallsyms]    [k] psi_task_change
> 	     6.76%              [psi_task_change+230 -> psi_task_change+265]    0  ±  0.0%            [kernel.kallsyms]    [k] psi_task_change
> 	     6.76%              [psi_task_change+254 -> psi_task_change+324]    0  ±100.0% ▁█▁▁▁▁▁▁   [kernel.kallsyms]    [k] psi_task_change
> 	     6.76%              [psi_task_change+298 -> psi_task_change+307]    0  ±  0.0%            [kernel.kallsyms]    [k] psi_task_change
> 	     6.76%              [psi_task_change+309 -> psi_task_change+332]    0  ± 37.8% ▁▁█▁▁███   [kernel.kallsyms]    [k] psi_task_change
> 	     6.76%              [psi_task_change+326 -> psi_task_change+370]    0  ± 79.5% ▁█▁▁▁▁▁▁   [kernel.kallsyms]    [k] psi_task_change
> 	     6.76%              [psi_task_change+341 -> psi_task_change+348]    0  ±  0.0%            [kernel.kallsyms]    [k] psi_task_change
> 	     6.76%              [psi_task_change+446 -> psi_task_change+456]    0  ±  0.0%            [kernel.kallsyms]    [k] psi_task_change
> 	     6.76%              [psi_task_change+461 -> psi_task_change+475]    0  ±  0.0%            [kernel.kallsyms]    [k] psi_task_change
> 	     6.76%              [psi_task_change+493 -> psi_task_change+497]    0  ± 77.8% █▁▁▁▁▁▃▁   [kernel.kallsyms]    [k] psi_task_change
> 	     5.27%  [syscall_return_via_sysret+0 -> syscall_return_via_sysret+81]  -21  ± 28.1% ▂▄█▄▅▂▁▁   [kernel.kallsyms]    [k] syscall_return_via_sysret
> 	     5.27%  [syscall_return_via_sysret+0 -> syscall_return_via_sysret+66]    0  ± 48.7% ▁▇▂▁▁▁█▁   [kernel.kallsyms]    [k] syscall_return_via_sysret
> 	     5.27%  [syscall_return_via_sysret+83 -> syscall_return_via_sysret+114]    0  ± 12.8% █▅▆▅▆▁▅▅   [kernel.kallsyms]    [k] syscall_return_via_sysret
> 	     4.22%               [native_write_msr+0 -> native_write_msr+11]    0  ± 24.6% █▅▄▄▂▄▁▁   [kernel.kallsyms]    [k] native_write_msr
> 	     2.84%          [enqueue_task_fair+257 -> enqueue_task_fair+281] -168  ± 94.5% ▁█         [kernel.kallsyms]    [k] enqueue_task_fair
> 	     2.84%          [enqueue_task_fair+904 -> enqueue_task_fair+916] -122  ±  0.0%            [kernel.kallsyms]    [k] enqueue_task_fair
> 	     2.84%            [enqueue_task_fair+93 -> enqueue_task_fair+98]   27  ±  8.6% ▁█         [kernel.kallsyms]    [k] enqueue_task_fair
> 	     2.84%          [enqueue_task_fair+286 -> enqueue_task_fair+289]    5  ± 85.5% ▁▁█        [kernel.kallsyms]    [k] enqueue_task_fair
> 	     2.84%            [enqueue_task_fair+0 -> enqueue_task_fair+120]   -3  ± 19.5% ▁█▁▃▂▄▆▃   [kernel.kallsyms]    [k] enqueue_task_fair
> 
> thanks,
> jirka
> 

Line is too long. While putting the histogram in a separate column may 
have better display. Let me try it.

Thanks
Jin Yao
