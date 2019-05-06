Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E55BC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A38D2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 07:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfEFHc1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 03:32:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:27841 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbfEFHc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 03:32:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 00:32:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,437,1549958400"; 
   d="scan'208";a="344117474"
Received: from irsmsx153.ger.corp.intel.com ([163.33.192.75])
  by fmsmga006.fm.intel.com with ESMTP; 06 May 2019 00:32:23 -0700
Received: from irsmsx111.ger.corp.intel.com (10.108.20.4) by
 IRSMSX153.ger.corp.intel.com (163.33.192.75) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 6 May 2019 08:32:15 +0100
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.21]) by
 irsmsx111.ger.corp.intel.com ([169.254.2.85]) with mapi id 14.03.0415.000;
 Mon, 6 May 2019 08:32:14 +0100
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>
CC:     David Laight <David.Laight@aculab.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Eric Biggers <ebiggers3@gmail.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
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
Thread-Index: AQHU81HQwzT9MH4dM0y/JZXnSwiYT6Y8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PCAAQuGgIAAYQuAgAAKhwCACsPi4IADJTwAgAAcagCAAExngIAEBbGAgACIbACAAbyQ8IAA626AgAGZfXCAAARpgIAAWpuAgAAF74CABdWt4A==
Date:   Mon, 6 May 2019 07:32:14 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4C712F7@IRSMSX102.ger.corp.intel.com>
References: <2236FBA76BA1254E88B949DDB74E612BA4C63E24@IRSMSX102.ger.corp.intel.com>
 <20190426140102.GA4922@mit.edu>
 <57357E35-3D9B-4CA7-BAB9-0BE89E0094D2@amacapital.net>
 <2236FBA76BA1254E88B949DDB74E612BA4C66A8A@IRSMSX102.ger.corp.intel.com>
 <6860856C-6A92-4569-9CD8-FF6C5C441F30@amacapital.net>
 <2236FBA76BA1254E88B949DDB74E612BA4C6A4D7@IRSMSX102.ger.corp.intel.com>
 <303fc4ee5ac04e4fac104df1188952e8@AcuMS.aculab.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C6C2C3@IRSMSX102.ger.corp.intel.com>
 <2e55aeb3b39440c0bebf47f0f9522dd8@AcuMS.aculab.com>
 <CALCETrXjGvWVgZHrKCfH6RBsnYOyD2+Mey1Esw7BsA4Eg6PS0A@mail.gmail.com>
 <20190502150853.GA16779@gmail.com>
In-Reply-To: <20190502150853.GA16779@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTRmNDFjMWEtYjg0OS00OWUzLWEwNjAtY2U5MTYwNjQ3ZjUyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoick5hUktJayswZTc4VGFLSGtcL2tIWFoyREhucmxJN2cwV3NRMWZwM0RDaXdFMHMza0ZBNXhFN3FTZjVpR0JYNlgifQ==
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> * Andy Lutomirski <luto@kernel.org> wrote:
> 
> > Or we decide that calling get_random_bytes() is okay with IRQs off and
> > this all gets a bit simpler.
> 
> BTW., before we go down this path any further, is the plan to bind this
> feature to a real CPU-RNG capability, i.e. to the RDRAND instruction,
> which excludes a significant group of x86 of CPUs?

I would not like to bind this to only CPUs that have RDRAND. 
That's why I was looking into using kernel's CSRNG (we can also use it
as backup when rdrand is not available).
 
> Because calling tens of millions of system calls per second will deplete
> any non-CPU-RNG sources of entropy and will also starve all other users
> of random numbers, which might have a more legitimate need for
> randomness, such as the networking stack ...

This should not apply to the proper CSRNG. They of course also have a
limitation on the amount of bits they can produce safely (as any crypto
primitive), but this period is very big and within that it does not affect
any other user of this CSPRNG, otherwise all guarantees are broken. 
 
> I.e. I'm really *super sceptical* of this whole plan, as currently
> formulated.
> 
> If we bind it to RDRAND then we shouldn't be using the generic
> drivers/char/random.c pool *at all*, but just call the darn instruction
> directly. This is an x86 patch-set after all, right?

Yes, but my main issues with RDRAND (even if we focus strictly onx86) are:
- it is not available on older PCs
- its performance varies across CPUs that support it (and as I understood varies quite some)
The last one can actually give unpleasant surprises... 
 
> Furthermore the following post suggests that RDRAND isn't a per CPU
> capability, but a core or socket level facility, depending on CPU make:
> 
>   https://stackoverflow.com/questions/10484164/what-is-the-latency-and-
> throughput-of-the-rdrand-instruction-on-ivy-bridge
> 
> 8 gigabits/sec sounds good throughput in principle, if there's no
> scalability pathologies with that.
> 
> It would also be nice to know whether RDRAND does buffering *internally*,
> in which case it might be better to buffer as little at the system call
> level as possible, to allow the hardware RNG buffer to rebuild between
> system calls.

I will try asking around about concrete details on RDRAND behavior. 
I have various bits and pieces I have been told plus measurements I did, but things 
don't quite add up.. 

> 
> I.e. I'd suggest to retrieve randomness via a fixed number of RDRAND-r64
> calls (where '1' is a perfectly valid block size - it should be
> measured), which random bits are then used as-is for the ~6 bits of
> system call stack offset. (I'd even suggest 7 bits: that skips a full
> cache line almost for free and makes the fuzz actually meaningful: no
> spear attacker will take a 1/128, 0.8% chance to successfully attack a
> critical system.)
> 
> Then those 64*N random bits get buffered and consumed in 5-7 bit chunk,
> in a super efficient fashion, possibly inlining the fast path, totally
> outside the flow of the drivers/char/random.c

I will ask around on what is the best way to use RDRAND for our purpose.

> 
> Any non-CPU source of randomness for system calls and plans to add
> several extra function calls to every x86 system call is crazy talk I
> believe...

So, if we go the CPU randomness path, then what do we fall back to when
RNRAND is not available? Skip randomization altogether or backup to
CSRNG?

Best Regards,
Elena.
