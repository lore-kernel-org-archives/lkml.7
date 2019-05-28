Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF75C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2F9208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfE1M27 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:28:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:18010 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbfE1M27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:28:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 May 2019 05:28:58 -0700
X-ExtLoop1: 1
Received: from irsmsx106.ger.corp.intel.com ([163.33.3.31])
  by fmsmga001.fm.intel.com with ESMTP; 28 May 2019 05:28:54 -0700
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.108]) by
 IRSMSX106.ger.corp.intel.com ([169.254.8.166]) with mapi id 14.03.0415.000;
 Tue, 28 May 2019 13:28:53 +0100
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        "Andy Lutomirski" <luto@kernel.org>
CC:     David Laight <David.Laight@aculab.com>,
        Theodore Ts'o <tytso@mit.edu>,
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
Thread-Index: AQHU81HQwzT9MH4dM0y/JZXnSwiYT6Y8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PCAAQuGgIAAYQuAgAAKhwCACsPi4IADJTwAgAAcagCAAExngIAEBbGAgACIbACAAbyQ8IAA626AgAGZfXCAAARpgIAAWpuAgAAF74CAABf/AIAAAvkAgAGZnrD///dzgIAHjbaA///31ICAAC4VAIABBxmAgAAfuaCAAA5FAIAED8OAgAAYaYCAAINWgIAAbRaAgBjvMfA=
Date:   Tue, 28 May 2019 12:28:53 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4CA8DBF@IRSMSX102.ger.corp.intel.com>
References: <e4fbad8c51284a0583b98c52de4a207d@AcuMS.aculab.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C760A7@IRSMSX102.ger.corp.intel.com>
 <20190508113239.GA33324@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C762F7@IRSMSX102.ger.corp.intel.com>
 <20190509055915.GA58462@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C7741F@IRSMSX102.ger.corp.intel.com>
 <20190509084352.GA96236@gmail.com>
 <CALCETrV1067Es=KEjkz=CtdoT79a2EJg4dJDae6oGDiTaubL1A@mail.gmail.com>
 <201905111703.5998DF5F@keescook> <20190512080245.GA7827@gmail.com>
 <201905120705.4F27DF3244@keescook>
In-Reply-To: <201905120705.4F27DF3244@keescook>
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

> > With 5 bits there's a ~96.9% chance of crashing the system in an attempt,
> > the exploit cannot be used for a range of attacks, including spear
> > attacks and fast-spreading worms, right? A crashed and inaccessible
> > system also increases the odds of leaving around unfinished attack code
> > and leaking a zero-day attack.
> 
> Yup, which is why I'd like to have _something_ here without us getting
> lost in the "perfect entropy" weeds. :)

I really start to believe that we cannot make good randomness sources behave
fast enough for per-syscall usage if our target is 1-2% overhead under worst possible
(and potentially unrealistic ) scenario (stress test of some simple syscall like getpid()).
The only thing that would fit the margin is indeed rdtsc().

I profiled the path in use with get_random_bytes() and results look like this 
(arch_get_random_long in not inline for measurement purpose here):

> >
> >                |          |          |           --9.44%--random_get_byte
> >                |          |          |                     |
> >                |          |          |                      --8.08%--get_random_bytes
> >                |          |          |                                |
> >                |          |          |                                 --7.80%--_extract_crng.constprop.45
> >                |          |          |                                           |
> >                |          |          |                                           |--4.95%--arch_get_random_long
> >                |          |          |                                           |
> >                |          |          |                                            --2.39%--chacha_block


And here is the proof that under such usage _extract_crng bottlenecks on rdrand: 

PerfTop:    5877 irqs/sec  kernel:78.6%  exact: 100.0% [4000Hz cycles:ppp],  (all, 8 CPUs)
------------------------------------------------------------------------------------------------------------------------------------
Showing cycles:ppp for _extract_crng.constprop.46
  Events  Pcnt (>=5%)
 Percent | Source code & Disassembly of kcore for cycles:ppp (2104 samples, percent: local period)
-------------------------------------------------------------------------------------------------------
    0.00 :   ffffffff9abd1a62:       mov    $0xa,%edx
   97.94 :   ffffffff9abd1a67:       rdrand %rax

And then of course there is chacha permutation itself. So, I think Andy's proposal to rewrite 
"get_random_bytes" for speed is not so easy to implement. 

So, given that all we want is to raise the bar for attackers to predict the stack location
on subsequent syscall, is it really worth to try to come up with more complex solutions than
just using lower bits of rdtsc() by default? 

One idea that I got suggested last week is to create a pool of good randomness and
 then during syscall select a random number from the pool using smth rdtsc()%POOL_SIZE.
Pool would need to be refilled periodically, outside of syscall path to maintain diversity. 
I can try this approach, if people believe that it would address the security concerns around
rdtsc() (my personal feeling is that one can still time attack this if we assume that rdtsc
can be attacked and complexity of the whole thing increases considerably). 

If we decide that this is too much trouble for just 5 bits of randomness we need per syscall, I would 
still propose we reconsider original rdtsc() approach since it is still better than nothing. 
We can have the whole thing on three levels:

CONFIG_RANDOMIZE_KSTACK_OFFSET - off - no randomization, like now
CONFIG_RANDOMIZE_KSTACK_OFFSET on with rdtsc(), fast, better than nothing, but prone to 
timing attacks
CONFIG_RANDOMIZE_KSTACK_OFFSET based on get_random_bytes() with better security guarantees. 

Performance numbers for  will approx. look like

No randomization: 			Simple syscall: 0.0534 microseconds
With rdtsc():				Simple syscall: 0.0539 microseconds
Wih get_random_bytes(4096 buffer): 	Simple syscall: 0.0597 microseconds

Pure rdrand option with calling rdrand_long every 10th syscall is considerably slower

With rdrand (every 10th syscall):		Simple syscall: 0.0719 microseconds

And I guess we should once again remember that these are *not* the numbers that real
users will see in practice since I doubt we have the real loads issuing millions of *very
lightweight* syscalls in a loop, so this is really more "theoretical, worst case ever" numbers. 

If someone could actually propose a reasonable *practical* workload to measure with, 
then we can see what is the overhead on that both for rdtsc and get_random_bytes(). 

Best Regards,
Elena.


