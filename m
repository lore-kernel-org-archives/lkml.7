Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6327C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20AB206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfDZOCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:02:38 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54948 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726039AbfDZOCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:02:38 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x3QE12pF023693
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Apr 2019 10:01:03 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 240BF420EEC; Fri, 26 Apr 2019 10:01:02 -0400 (EDT)
Date:   Fri, 26 Apr 2019 10:01:02 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Eric Biggers <ebiggers3@gmail.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        David Laight <David.Laight@ACULAB.COM>,
        Ingo Molnar <mingo@kernel.org>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
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
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Message-ID: <20190426140102.GA4922@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Eric Biggers <ebiggers3@gmail.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        David Laight <David.Laight@ACULAB.COM>,
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
References: <2236FBA76BA1254E88B949DDB74E612BA4C51962@IRSMSX102.ger.corp.intel.com>
 <20190416120822.GV11158@hirez.programming.kicks-ass.net>
 <01914abbfc1a4053897d8d87a63e3411@AcuMS.aculab.com>
 <20190416154348.GB3004@mit.edu>
 <2236FBA76BA1254E88B949DDB74E612BA4C52338@IRSMSX102.ger.corp.intel.com>
 <9cf586757eb44f2c8f167abf078da921@AcuMS.aculab.com>
 <20190417151555.GG4686@mit.edu>
 <99e045427125403ba2b90c2707d74e02@AcuMS.aculab.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C5E473@IRSMSX102.ger.corp.intel.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C63E24@IRSMSX102.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4C63E24@IRSMSX102.ger.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 11:33:09AM +0000, Reshetova, Elena wrote:
> Adding Eric and Herbert to continue discussion for the chacha part. 
> So, as a short summary I am trying to find out a fast (fast enough to be used per syscall
> invocation) source of random bits with good enough security properties. 
> I started to look into chacha kernel implementation and while it seems that it is designed to 
> work with any number of rounds, it does not expose less than 12 rounds primitive. 
> I guess this is done for security sake, since 12 is probably the lowest bound we want people
> to use for the purpose of encryption/decryption, but if we are to build an efficient RNG,
> chacha8 probably is a good tradeoff between security and speed. 
> 
> What are people's opinions/perceptions on this? Has it been considered before to create a
> kernel RNG based on chacha?

Well, sure.  The get_random_bytes() kernel interface and the
getrandom(2) system call uses a CRNG based on chacha20.  See
extract_crng() and crng_reseed() in drivers/char/random.c.

It *is* possible to use an arbitrary number of rounds if you use the
low level interface exposed as chacha_block(), which is an
EXPORT_SYMBOL interface so even modules can use it.  "Does not expose
less than 12 rounds" applies only if you are using the high-level
crypto interface.

We have used cut down crypto algorithms for performance critical
applications before; at one point, we were using a cut down MD4(!) for
initial TCP sequence number generation.  But that was getting rekeyed
every five minutes, and the goal was to make it just hard enough that
there were other easier ways of DOS attacking a server.

I'm not a cryptographer, so I'd really us to hear from multiple
experts about the security level of, say, ChaCha8 so we understand
exactly kind of security we'd offering.  And I'd want that interface
to be named so that it's clear it's only intended for a very specific
use case, since it will be tempting for other kernel developers to use
it in other contexts, with undue consideration.

      	    	      	   	 - Ted
