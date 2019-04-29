Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858EDC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F72F2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfD2IE5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 04:04:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:59463 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727448AbfD2IE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 04:04:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 01:04:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,408,1549958400"; 
   d="scan'208";a="139699800"
Received: from irsmsx109.ger.corp.intel.com ([163.33.3.23])
  by orsmga006.jf.intel.com with ESMTP; 29 Apr 2019 01:04:52 -0700
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.21]) by
 IRSMSX109.ger.corp.intel.com ([169.254.13.189]) with mapi id 14.03.0415.000;
 Mon, 29 Apr 2019 09:04:50 +0100
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Eric Biggers <ebiggers@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        'Peter Zijlstra' <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "luto@kernel.org" <luto@kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: RE: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Thread-Topic: [PATCH] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Index: AQHU81HQwzT9MH4dM0y/JZXnSwiYT6Y8wW2AgAAdM1CAAXexAIAANZ3ggAAW1gCAAApRgIAAMeKAgAAd+PCAAQuGgIAAYQuAgAAKhwCACsPi4IADJTwAgAAcagCAAD5kAIAEIeIQ
Date:   Mon, 29 Apr 2019 08:04:50 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4C66B18@IRSMSX102.ger.corp.intel.com>
References: <20190416120822.GV11158@hirez.programming.kicks-ass.net>
 <01914abbfc1a4053897d8d87a63e3411@AcuMS.aculab.com>
 <20190416154348.GB3004@mit.edu>
 <2236FBA76BA1254E88B949DDB74E612BA4C52338@IRSMSX102.ger.corp.intel.com>
 <9cf586757eb44f2c8f167abf078da921@AcuMS.aculab.com>
 <20190417151555.GG4686@mit.edu>
 <99e045427125403ba2b90c2707d74e02@AcuMS.aculab.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C5E473@IRSMSX102.ger.corp.intel.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C63E24@IRSMSX102.ger.corp.intel.com>
 <20190426140102.GA4922@mit.edu> <20190426174419.GB691@sol.localdomain>
In-Reply-To: <20190426174419.GB691@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNGU0NTgyNWYtZGI2MC00MWYxLTliNmMtZTYzNWMxNWFjMTljIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWFdNWkZ4Tm1cL3l3STQ5RVZ5dytNU1wvcCtidU15K2ZodnEzTE16TkFLVlhLMHRId3g4ZGttbUZxRTUwK3RCclVPIn0=
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Apr 26, 2019 at 10:01:02AM -0400, Theodore Ts'o wrote:
> > On Fri, Apr 26, 2019 at 11:33:09AM +0000, Reshetova, Elena wrote:
> > > Adding Eric and Herbert to continue discussion for the chacha part.
> > > So, as a short summary I am trying to find out a fast (fast enough to be used per
> syscall
> > > invocation) source of random bits with good enough security properties.
> > > I started to look into chacha kernel implementation and while it seems that it is
> designed to
> > > work with any number of rounds, it does not expose less than 12 rounds
> primitive.
> > > I guess this is done for security sake, since 12 is probably the lowest bound we
> want people
> > > to use for the purpose of encryption/decryption, but if we are to build an
> efficient RNG,
> > > chacha8 probably is a good tradeoff between security and speed.
> > >
> > > What are people's opinions/perceptions on this? Has it been considered before
> to create a
> > > kernel RNG based on chacha?
> >
> > Well, sure.  The get_random_bytes() kernel interface and the
> > getrandom(2) system call uses a CRNG based on chacha20.  See
> > extract_crng() and crng_reseed() in drivers/char/random.c.
> >
> > It *is* possible to use an arbitrary number of rounds if you use the
> > low level interface exposed as chacha_block(), which is an
> > EXPORT_SYMBOL interface so even modules can use it.  "Does not expose
> > less than 12 rounds" applies only if you are using the high-level
> > crypto interface.
> 
> chacha_block() actually WARNs if the round count isn't 12 or 20, because I
> didn't want people to sneak in uses of other variants without discussion :-)
> 
> (Possibly I should have made chacha_block() 'static' and only exported
> chacha12_block() and chacha20_block().  But the 'nrounds' parameter is
> convenient for crypto/chacha_generic.c.)
> 
> >
> > We have used cut down crypto algorithms for performance critical
> > applications before; at one point, we were using a cut down MD4(!) for
> > initial TCP sequence number generation.  But that was getting rekeyed
> > every five minutes, and the goal was to make it just hard enough that
> > there were other easier ways of DOS attacking a server.
> >
> > I'm not a cryptographer, so I'd really us to hear from multiple
> > experts about the security level of, say, ChaCha8 so we understand
> > exactly kind of security we'd offering.  And I'd want that interface
> > to be named so that it's clear it's only intended for a very specific
> > use case, since it will be tempting for other kernel developers to use
> > it in other contexts, with undue consideration.
> >
> >       	    	      	   	 - Ted
> 
> The best attack on ChaCha is against 7 rounds and has time complexity 2^235.  So
> while there's no publicly known attack on ChaCha8, its security margin is too
> small for it to be recommended for typical cryptographic use.  I wouldn't be
> suprised to see an attack published on ChaCha8 in the not-too-distant future.
> (*Probably* not a practical one, but the crypto will be technically "broken"
> regardless.)

Yes, this is also what is my understanding with regards to chacha official 
security strength. But our use case and requirements are slightly different
and can be in future upgraded, if needed, but let's indeed then try per-cpu
buffer solution that Andy is proposing first to see if it is satisfactory performance-
wise with chacha20, which probably stays secure for much longer unless whole
construction is fully broken. 

> 
> I don't think it's completely out of the question for this specific use case,
> since apparently you only need random numbers that are used temporarily for
> runtime memory layout.  Thus the algorithm can be upgraded at any time without
> spending decades deprecating it from network protocols and on-disk formats.
> 
> But if you actually need cryptographically secure random numbers, it would be
> much better to start with something with a higher security margin like ChaCha20,
> optimizing it, and only going lower if you actually need to.

Yes, agree, so this is what I am going to try then.

> Would it be possibly to call ChaCha20 through the actual crypto API so that SIMD
> instructions (e.g. AVX-2) could be used?  That would make it *much* faster.

I can try measuring both ways given that we ask for enough random bits as Andy suggested. 
Couple of pages or so, if it helps with overhead. Also, hope none of these specific 
Instructions (including AES-NI) can block, as I was pointed out with RDRAND, otherwise
I guess we have a problem.. 

> Also consider AES-CTR with AES-NI instructions.

Yes, I guess based on these numbers they go hand in hand with chacha8 (depending on CPU):
https://bench.cr.yp.to/results-stream.html
Also need to compare cases when no special instructions are available I guess when choosing a primitive
here... 

Best Regards,
Elena.

