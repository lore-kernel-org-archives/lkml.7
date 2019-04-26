Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C58EC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE92214C6
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556300666;
	bh=f/og59YkYC9ApZwrq1CuOoaeZXfjmj4D8LdPICM0l0g=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=LtFP4NV2YDojt/klxuRK4qPh+uzs4t5M2WZmdAFAOiOEGYG7DUocZpPJrIhCmj0WW
	 fAaTAPxotoSd8hkmuBM5kNzzMsLJs+RM3mUIpA1ZruOOG9O/xIFlMzDuJsYsM2x6Ap
	 CU1stNg2W9WdU/xwnjVT/1aiYrqfBUYjYd0ngWdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfDZRoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:44:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfDZRoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:44:24 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F9582077B;
        Fri, 26 Apr 2019 17:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556300662;
        bh=f/og59YkYC9ApZwrq1CuOoaeZXfjmj4D8LdPICM0l0g=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=f00dlNCwhDELLIrmHlCPV6JItu/FK9OR9/Y22oUmiiACSEVaZTUbn38SMhl3QuhJf
         Q/Yfa/o+PSBq60FcuzQ4SXgZxTbMVkrKaR+bbfAVb92cbH083Va/f4QNy3Qe62fCsS
         4MSHxFGWkxbP2RNoulgHwd8ogVIDf12LbmXkGI5A=
Date:   Fri, 26 Apr 2019 10:44:20 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
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
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Message-ID: <20190426174419.GB691@sol.localdomain>
References: <20190416120822.GV11158@hirez.programming.kicks-ass.net>
 <01914abbfc1a4053897d8d87a63e3411@AcuMS.aculab.com>
 <20190416154348.GB3004@mit.edu>
 <2236FBA76BA1254E88B949DDB74E612BA4C52338@IRSMSX102.ger.corp.intel.com>
 <9cf586757eb44f2c8f167abf078da921@AcuMS.aculab.com>
 <20190417151555.GG4686@mit.edu>
 <99e045427125403ba2b90c2707d74e02@AcuMS.aculab.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C5E473@IRSMSX102.ger.corp.intel.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C63E24@IRSMSX102.ger.corp.intel.com>
 <20190426140102.GA4922@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426140102.GA4922@mit.edu>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 10:01:02AM -0400, Theodore Ts'o wrote:
> On Fri, Apr 26, 2019 at 11:33:09AM +0000, Reshetova, Elena wrote:
> > Adding Eric and Herbert to continue discussion for the chacha part. 
> > So, as a short summary I am trying to find out a fast (fast enough to be used per syscall
> > invocation) source of random bits with good enough security properties. 
> > I started to look into chacha kernel implementation and while it seems that it is designed to 
> > work with any number of rounds, it does not expose less than 12 rounds primitive. 
> > I guess this is done for security sake, since 12 is probably the lowest bound we want people
> > to use for the purpose of encryption/decryption, but if we are to build an efficient RNG,
> > chacha8 probably is a good tradeoff between security and speed. 
> > 
> > What are people's opinions/perceptions on this? Has it been considered before to create a
> > kernel RNG based on chacha?
> 
> Well, sure.  The get_random_bytes() kernel interface and the
> getrandom(2) system call uses a CRNG based on chacha20.  See
> extract_crng() and crng_reseed() in drivers/char/random.c.
> 
> It *is* possible to use an arbitrary number of rounds if you use the
> low level interface exposed as chacha_block(), which is an
> EXPORT_SYMBOL interface so even modules can use it.  "Does not expose
> less than 12 rounds" applies only if you are using the high-level
> crypto interface.

chacha_block() actually WARNs if the round count isn't 12 or 20, because I
didn't want people to sneak in uses of other variants without discussion :-)

(Possibly I should have made chacha_block() 'static' and only exported
chacha12_block() and chacha20_block().  But the 'nrounds' parameter is
convenient for crypto/chacha_generic.c.)

> 
> We have used cut down crypto algorithms for performance critical
> applications before; at one point, we were using a cut down MD4(!) for
> initial TCP sequence number generation.  But that was getting rekeyed
> every five minutes, and the goal was to make it just hard enough that
> there were other easier ways of DOS attacking a server.
> 
> I'm not a cryptographer, so I'd really us to hear from multiple
> experts about the security level of, say, ChaCha8 so we understand
> exactly kind of security we'd offering.  And I'd want that interface
> to be named so that it's clear it's only intended for a very specific
> use case, since it will be tempting for other kernel developers to use
> it in other contexts, with undue consideration.
> 
>       	    	      	   	 - Ted

The best attack on ChaCha is against 7 rounds and has time complexity 2^235.  So
while there's no publicly known attack on ChaCha8, its security margin is too
small for it to be recommended for typical cryptographic use.  I wouldn't be
suprised to see an attack published on ChaCha8 in the not-too-distant future.
(*Probably* not a practical one, but the crypto will be technically "broken"
regardless.)

I don't think it's completely out of the question for this specific use case,
since apparently you only need random numbers that are used temporarily for
runtime memory layout.  Thus the algorithm can be upgraded at any time without
spending decades deprecating it from network protocols and on-disk formats.

But if you actually need cryptographically secure random numbers, it would be
much better to start with something with a higher security margin like ChaCha20,
optimizing it, and only going lower if you actually need to.

Would it be possibly to call ChaCha20 through the actual crypto API so that SIMD
instructions (e.g. AVX-2) could be used?  That would make it *much* faster.
Also consider AES-CTR with AES-NI instructions.

- Eric
