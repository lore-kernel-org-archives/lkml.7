Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C30C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840CB20651
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387746AbfG2LlR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:41:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:52478 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387644AbfG2LlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:41:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 04:41:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,322,1559545200"; 
   d="scan'208";a="171541781"
Received: from irsmsx152.ger.corp.intel.com ([163.33.192.66])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jul 2019 04:41:12 -0700
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.59]) by
 IRSMSX152.ger.corp.intel.com ([169.254.6.27]) with mapi id 14.03.0439.000;
 Mon, 29 Jul 2019 12:41:11 +0100
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        "Andy Lutomirski" <luto@kernel.org>
CC:     Theodore Ts'o <tytso@mit.edu>,
        David Laight <David.Laight@aculab.com>,
        Eric Biggers <ebiggers3@gmail.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: RE: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Thread-Topic: [PATCH] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Index: AQHU81HQwzT9MH4dM0y/JZXnSwiYT6Y8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PCAAQuGgIAAYQuAgAAKhwCACsPi4IADJTwAgAAcagCAAExngIAEBbGAgACIbACAAbyQ8IAA626AgAGZfXCAAARpgIAAWpuAgAAF74CAABf/AIAAAvkAgAGZnrD///dzgIAHjbaA///31ICAAC4VAIABBxmAgAAfuaCAAA5FAIAED8OAgAAYaYCAAINWgIAAbRaAgBjvMfCAACWEgIABZK1ggACCc4CAX3oCYA==
Date:   Mon, 29 Jul 2019 11:41:11 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4D4BFCA@IRSMSX102.ger.corp.intel.com>
References: <20190509055915.GA58462@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C7741F@IRSMSX102.ger.corp.intel.com>
 <20190509084352.GA96236@gmail.com>
 <CALCETrV1067Es=KEjkz=CtdoT79a2EJg4dJDae6oGDiTaubL1A@mail.gmail.com>
 <201905111703.5998DF5F@keescook> <20190512080245.GA7827@gmail.com>
 <201905120705.4F27DF3244@keescook>
 <2236FBA76BA1254E88B949DDB74E612BA4CA8DBF@IRSMSX102.ger.corp.intel.com>
 <20190528133347.GD19149@mit.edu>
 <2236FBA76BA1254E88B949DDB74E612BA4CABA56@IRSMSX102.ger.corp.intel.com>
 <201905291136.FD61FF42@keescook>
In-Reply-To: <201905291136.FD61FF42@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo, Andy,

I want to summarize here the data (including the performance numbers)
and reasoning for the in-stack randomization feature. I have organized
it in a simple set of Q&A below.

Q: Why do we need in-stack per-syscall randomization when we already have
all known attack vectors covered with existing protections?

A: First, we have all known (to us) attack vectors covered *only* given that all
existing related protections are enabled.  While we do expect the vmalloc-stack
allocation with guard pages, as well as VLA-free kernel to be the default setup
for most of the kernels we concerned about, this cannot be said about GCC-plugin
based features, such as STACKLEAK. The reason for this is a) STACKLEAK requires
GCC plugin enablement during compilation and this is not a default case now for
many distros. b) STACKLEAK can introduce very visible performance overhead.
Please see the microbenchmarks below for the cases you have asked me to measure
before. The performance hit can be 79% for simple syscall and I believe even
bigger for complex syscalls where a lot of stack needs to be cleaned. 

Q: What is the performance impact both micro benchmark and on real workloads?

A: Here is the table summarizing the perf numbers depending on subroutine used
for obtaining random bits and STACKLEAK numbers for comparison:

1. Microbenchmarking:

lmbench: ./lat_syscall -N 1000000 null:

CONFIG_PAGE_TABLE_ISOLATION=y:

base:                                0.1737
rdtsc:                               0.1803 (+3.89%)
get_random_bytes (4096 byte buffer): 0.1811 (+4.26%)
RDRAND (every 10th syscall):         0.1910 (+9.96%)
STACKLEAK:                           0.2150 (+23.78%)

CONFIG_PAGE_TABLE_ISOLATION=n:

base:                                0.0522
rdtsc:                               0.0556 (+6.51%)
get_random_bytes (4096 byte buffer): 0.0599 (+14.75%)
RDRAND (every 10th syscall):         0.0706 (+35.25%)
STACKLEAK:                           0.0935 (+79.12%)

So, at least one thing that follows from above numbers is that STACKLEAK
performance is much worse even for simple syscall case (more complex
syscalls likely cause even more perf hit since stack must be cleaned deeper).
However, this hasn't prevented STACKLEAK upstream merge and STACKLEAK is much
more complex feature both code side and code logic...


2. Kernel compilation time (example of real workload):

Base (CONFIG_PAGE_TABLE_ISOLATION=n):

real: 31m17,601s
user: 224m56,144s
sys: 18m26,946s

get_random_bytes (4096 byte buffer, CONFIG_PAGE_TABLE_ISOLATION=n):

real: 31m22,684s (+0.271% increase)
user: 225m4,766s
sys: 18m27,113s

STACKLEAK (CONFIG_PAGE_TABLE_ISOLATION=n):

real: 31m23,289s (+0.303% increase)
user: 224m24,001s
sys: 19m36,882s

Q: Is there a way to drastically improve the microbenchmark results
for get_random_bytes() without decreasing security?

A: As far as I can see no, but I am not a perf optimization expert.
My measurements and profiling showed that biggest load comes from
extract_crng function and underlying arch_get_random_long() 
(basically calling RDRAND for x86) and chacha_block function (core 
chacha functionality and permutation itself). So, unless the permutation
is rewritten or additional seeding is dropped (happens automatically
if arch does not support RDRAND), there is no way in my understanding to 
improve things drastically. See traces below.

perf (4096 isolation off, get_random_byte, arch_get_random_long not inlined):

   98.94%     0.00%  lat_syscall  [unknown]         [k] 0x48fffffe27e80f74
            |
            ---0x48fffffe27e80f74
               |          
               |--97.73%--__GI___getppid
               |          |          
               |          |--53.29%--entry_SYSCALL_64_after_hwframe
               |          |          |          
               |          |          |--29.73%--do_syscall_64
               |          |          |          |          
               |          |          |          |--11.05%--__x64_sys_getppid
               |          |          |          |          |          
               |          |          |          |           --10.64%--__task_pid_nr_ns
               |          |          |          |          
               |          |          |           --9.44%--random_get_byte
               |          |          |                     |          
               |          |          |                      --8.08%--get_random_bytes
               |          |          |                                |          
               |          |          |                                 --7.80%--_extract_crng.constprop.45
               |          |          |                                           |          
               |          |          |                                           |--4.95%--arch_get_random_long
               |          |          |                                           |          
               |          |          |                                            --2.39%--chacha_block

    17.22%  [kernel]          [k] syscall_return_via_sysret
    15.32%  libc-2.27.so      [.] __GI___getppid
    13.33%  [kernel]          [k] __x64_sys_getppid
    10.04%  [kernel]          [k] __task_pid_nr_ns
     8.60%  [kernel]          [k] do_syscall_64
     7.94%  [kernel]          [k] entry_SYSCALL_64
     7.08%  [kernel]          [k] entry_SYSCALL_64_after_hwframe
     4.45%  [kernel]          [k] _extract_crng.constprop.46
     2.28%  [kernel]          [k] chacha_permute
     1.92%  [kernel]          [k] __indirect_thunk_start
     1.69%  [kernel]          [k] random_get_byte
     0.75%  lat_syscall       [.] do_getppid
     0.50%  [kernel]          [k] fw_domains_get_with_fallback
     0.43%  lat_syscall       [.] getppid@plt


   PerfTop:    5877 irqs/sec  kernel:78.6%  exact: 100.0% [4000Hz cycles:ppp],  (all, 8 CPUs)
---------------------------------------------------------------------------------------------
Showing cycles:ppp for _extract_crng.constprop.46
  Events  Pcnt (>=5%)
 Percent | Source code & Disassembly of kcore for cycles:ppp (2104 samples, percent: local period)
--------------------------------------------------------------------------------------------------
    0.00 :   ffffffff9abd1a62:       mov    $0xa,%edx
   97.94 :   ffffffff9abd1a67:       rdrand %rax

Q: So, what is the resulting benefit of in-stack per-syscall randomization?

A: Randomizing kernel stack per each syscall removes one of the main property
that attracted attackers to kernel thread stack for couple of last decades - the
deterministic stack structure.
Reliability is one of the most important feature for kernel exploits (not so
much for userspace ones, since they always can survive the fact that a process
can be terminated). An attacker cannot afford to panic the kernel, because it
normally means that the attack target is dead and at best he can continue from
square one after the target reboots and intrusion detection systems are already
alert. So, removing the feature of reliably predicting what would be the thread
stack layout upon the subsequent syscall is a bug hurdle for an attacker in
constructing the exploit chain that involves kernel stack.
It basically means that a class of stack-based attacks that do some preparation
(or information discovery) work in a first syscall and then utilize this
knowledge on a subsequent syscall cannot be reliable anymore (unless target is
pt_regs since we don't change pt_regs position), which means that they are much
less attractive for attackers.

The in-stack randomization is really a very small change both code wise and
logic wise.
It does not affect real workloads and does not require enablement of other
features (such as GCC plugins).
So, I think we should really reconsider its inclusion.
