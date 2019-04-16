Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A7FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77966206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbfDPQxI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:53:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:50396 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbfDPQxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:53:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 09:47:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,358,1549958400"; 
   d="scan'208";a="338028401"
Received: from irsmsx151.ger.corp.intel.com ([163.33.192.59])
  by fmsmga006.fm.intel.com with ESMTP; 16 Apr 2019 09:47:02 -0700
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.21]) by
 IRSMSX151.ger.corp.intel.com ([169.254.4.174]) with mapi id 14.03.0415.000;
 Tue, 16 Apr 2019 17:47:01 +0100
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        David Laight <David.Laight@ACULAB.COM>
CC:     'Peter Zijlstra' <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "luto@kernel.org" <luto@kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Thread-Topic: [PATCH] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Index: AQHU81HQwzT9MH4dM0y/JZXnSwiYT6Y8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PA=
Date:   Tue, 16 Apr 2019 16:47:00 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4C52338@IRSMSX102.ger.corp.intel.com>
References: <20190415060918.3766-1-elena.reshetova@intel.com>
 <20190415072535.GA51449@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C4F90F@IRSMSX102.ger.corp.intel.com>
 <20190416073444.GC127769@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C51962@IRSMSX102.ger.corp.intel.com>
 <20190416120822.GV11158@hirez.programming.kicks-ass.net>
 <01914abbfc1a4053897d8d87a63e3411@AcuMS.aculab.com>
 <20190416154348.GB3004@mit.edu>
In-Reply-To: <20190416154348.GB3004@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTU3ZmM3YWItY2YxYi00NjA2LWEzMWEtODRhMzJjMjdjNTZmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZ1BMOXYwMkoxcEFxY1lSaGg4dWMwb0pJQWlDbkllUDhrRGdIV2hPcWs1bmp6SitsQzRBbmI1YmVtMkhzYTJuNCJ9
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So a couple of comments; I wasn't able to find the full context for
> this patch, and looking over the thread on kernel-hardening from late
> February still left me confused exactly what attacks this would help
> us protect against (since this isn't my area and I didn't take the
> time to read all of the links to slide decks, etc.)
> 
> So I'm not going to comment on the utility of this patch, but just on
> the random number generator issues.  If you're only going to be using
> the low 8 bits of the output of get_prandom_u32(), even if two
> adjacent calls to get_prandom_u32() (for which only the low 8 bits are
> revealed) can be used to precisely identify which set of 2**120
> potential prandom states could have generate that pair of states, it's
> still going to take a lot of calls before you'd be able to figure out
> the prandom's internal state.
> 
> It seems though the assumption that we're assuming the attacker has
> arbitrary ability to get the low bits of the stack, so *if* that's
> true, then eventually, you'd be able to get enough samples that you
> could reverse engineer the prandom state.  This could take long enough
> that the process will have gotten rescheduled to another CPU, and
> since the prandom state is per-cpu, that adds another wrinkle.

Well, yes, this is also my feeling that it is going to be hard to do, but can we get
some more concrete numbers of this? We can forget about per-cpu rescheduling
for simplicity and just calculate how many calls it would take to recover the state
given that each call leaks 5 bits.   

I can try to make the calculation of this based on my limited knowledge of crypto,
but I will have to read papers on this PRNG first, etc., so I was just checking if 
people already have a feeling on it given how common this generator is in kenrel. 

> 
> > > So the argument against using TSC directly was that it might be easy to
> > > guess most of the TSC bits in timing attack. But IIRC there is fairly
> > > solid evidence that the lowest TSC bits are very hard to guess and might
> > > in fact be a very good random source.
> > >
> > > So what one could do, is for each invocation mix in the low (2?) bits of
> > > the TSC into a per-cpu/task PRNG state. By always adding some fresh
> > > entropy it would become very hard indeed to predict the outcome, even
> > > for otherwise 'trivial' PRNGs.
> >
> > You could just feed 8 bits of TSC into a CRC.  Or even xor the
> > entire TSC over a CRC state and then cycle it at least 6 bits.
> > Probably doesn't matter which CRC - but you may want one that is
> > cheap in software.  Even a 16bit CRC might be enough.
> 
> Do we only care about x86 in this discussion?  Given "x86/entry/64",
> I'm guessing the answer we're not trying to worry about how to protect
> other architectures, like say ARM, that don't have a TSC?

Well, this patch is for x86 only, but other arch might want to have similar
functionality I guess...

> 
> If we do care about architectures w/o a TSC, how much cost are we
> willing to pay as far as system call overhead is concerned?

Good question, I don't know exact answer on what is acceptable overhead
for syscall for such a feature, but it should be very light to be useful, otherwise
the config would never be turned on. 

> 
> If it's x86 specific, maybe the simplest thing to do is to use RDRAND
> if it exists, and fall back to something involving a TSC and maybe
> prandom_u32 (assuming on how bad you think the stack leak is going to
> be) if RDRAND isn't available?
> 

RDRAND is way too slow, so it is out. That's why we were looking into other
options for the fast randomness. Unfortunately it looks like we don't have 
that many options in kernel. 
rdtsc was the original candidate (its low bits) and Peter Zijlstra pointed a paper
that claimed that it has good source of randomness:

http://www.chronox.de/jent/doc/CPU-Jitter-NPTRNG.html

But I don't have enough knowledge on this to make a good judgment. 
Original grsecurity patch used low bits of rdtsc for in-stack random offset.  

Best Regards,
Elena


