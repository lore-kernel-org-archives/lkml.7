Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA956C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69092075B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfE2KNu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:13:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:16575 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfE2KNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:13:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 03:13:49 -0700
X-ExtLoop1: 1
Received: from irsmsx110.ger.corp.intel.com ([163.33.3.25])
  by orsmga003.jf.intel.com with ESMTP; 29 May 2019 03:13:45 -0700
Received: from irsmsx155.ger.corp.intel.com (163.33.192.3) by
 irsmsx110.ger.corp.intel.com (163.33.3.25) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 29 May 2019 11:13:43 +0100
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.108]) by
 irsmsx155.ger.corp.intel.com ([169.254.14.127]) with mapi id 14.03.0415.000;
 Wed, 29 May 2019 11:13:43 +0100
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        "Eric Biggers" <ebiggers3@gmail.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
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
Thread-Index: AQHU81HQwzT9MH4dM0y/JZXnSwiYT6Y8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PCAAQuGgIAAYQuAgAAKhwCACsPi4IADJTwAgAAcagCAAExngIAEBbGAgACIbACAAbyQ8IAA626AgAGZfXCAAARpgIAAWpuAgAAF74CAABf/AIAAAvkAgAGZnrD///dzgIAHjbaA///31ICAAC4VAIABBxmAgAAfuaCAAA5FAIAED8OAgAAYaYCAAINWgIAAbRaAgBjvMfCAACWEgIABZK1g
Date:   Wed, 29 May 2019 10:13:43 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4CABA56@IRSMSX102.ger.corp.intel.com>
References: <20190508113239.GA33324@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C762F7@IRSMSX102.ger.corp.intel.com>
 <20190509055915.GA58462@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C7741F@IRSMSX102.ger.corp.intel.com>
 <20190509084352.GA96236@gmail.com>
 <CALCETrV1067Es=KEjkz=CtdoT79a2EJg4dJDae6oGDiTaubL1A@mail.gmail.com>
 <201905111703.5998DF5F@keescook> <20190512080245.GA7827@gmail.com>
 <201905120705.4F27DF3244@keescook>
 <2236FBA76BA1254E88B949DDB74E612BA4CA8DBF@IRSMSX102.ger.corp.intel.com>
 <20190528133347.GD19149@mit.edu>
In-Reply-To: <20190528133347.GD19149@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I confess I've kind of lost the plot on the performance requirements
> at this point.  Instead of measuring and evaluating potential
> solutions, can we try to approach this from the opposite direction and
> ask what the requirements are?
> 
> What's the maximum number of CPU cycles that we are allowed to burn
> such that we can meet the 1-2% overhead?

This is a good question on which I have no answer, so I tried to play with
performance numbers as much as I know. I don't know what is
considered acceptable for a syscall path and I guess answer can also 
be presented in two security configurations, like weak (less CPU cycles)
and strong (more cycles). 

> 
> And how many bits of uncertainty are we trying to present to the
> attacker?  

I think currently we are talking about 5 bits. Ideally maybe 8 bits,
given that offset is new for each syscall, it should be enough to remove
the "stability and predictability" feature of kernel thread stack that
attackers rely on. If your chances of crashing kernel 255 from 256,
you might figure some other attack path instead. 

What's the minimum beyond we shouldn't bother?  (Perhaps
> because rdtsc will give us that many bits?)  

Again, it is all about probabilities. 4 bits gives us success chance of
1 in 16 (of not crashing kernel), this is already starting to be dangerous
in my view, so maybe no less than 5?

And does that change if
> we vary the reseed window in terms of the number of system calls
> between reseeding?

I think if we talk about prng, reseeding should be done periodically to 
make sure we never overrun the safe generation period and also for 
additional security (seeding with proper entropy).
But the most important part is to have a distinct offset (random bits) between
each consequent syscall.
 
> And what are the ideal parameters after which point we're just gilding
> the lily?

Not sure about ideal params for the whole combination here since security
and performance are basically conflicting with each other (as usual). 
So, that's why I was trying to propose to have two version of this:
- one with tilt towards performance (rdtsc based)
- one with tilt towards security (CRNG-based)
And then let users choose what matters more for their workload. 
For normal things like dektops, etc. CRNG based version won't provide
any noticeable overhead. It might only matter for syscall sensitive workloads,
which btw, most likely not enable quite a bunch of other security protections, 
so I would say that for them to have even rdtsc() version is actually an 
improvement in their defenses for stack (and basically no impact on performance).

On related note: the current prng we have in kernel (prandom) is based on a
*very old* style of prngs, which is basically 4 linear LFSRs xored together. 
Nowadays, we have much more powerful prngs that show much better
statistical and even security properties (not cryptographically secure, but still
not so linear like the one above). 
What is the reason why we still use a prng that is couple of decades away from the
state of art in the area? It is actively used, especially by network stack,
should we update it to smth that is more appropriate (speed would be comparable)?

I am mostly talking about PCG-based generators:
http://www.pcg-random.org/

If people are interested, I could put together a PoC and we have an expert here we can
consult for providing calculations for min-entropy, HILL entropy and whatever 
is requested. 

Best Regards,
Elena.

