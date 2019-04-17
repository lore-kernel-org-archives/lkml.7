Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97460C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D5E20645
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732626AbfDQPRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:17:51 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60724 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730463AbfDQPRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:17:50 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x3HFFuW9002870
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Apr 2019 11:15:58 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 89DFD420497; Wed, 17 Apr 2019 11:15:55 -0400 (EDT)
Date:   Wed, 17 Apr 2019 11:15:55 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "'Reshetova, Elena'" <elena.reshetova@intel.com>,
        "'Peter Zijlstra'" <peterz@infradead.org>,
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
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Message-ID: <20190417151555.GG4686@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        David Laight <David.Laight@ACULAB.COM>,
        "'Reshetova, Elena'" <elena.reshetova@intel.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
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
References: <20190415060918.3766-1-elena.reshetova@intel.com>
 <20190415072535.GA51449@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C4F90F@IRSMSX102.ger.corp.intel.com>
 <20190416073444.GC127769@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C51962@IRSMSX102.ger.corp.intel.com>
 <20190416120822.GV11158@hirez.programming.kicks-ass.net>
 <01914abbfc1a4053897d8d87a63e3411@AcuMS.aculab.com>
 <20190416154348.GB3004@mit.edu>
 <2236FBA76BA1254E88B949DDB74E612BA4C52338@IRSMSX102.ger.corp.intel.com>
 <9cf586757eb44f2c8f167abf078da921@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cf586757eb44f2c8f167abf078da921@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 09:28:35AM +0000, David Laight wrote:
> 
> If you can guarantee back to back requests on the PRNG then it is probably
> possible to recalculate its state from 'bits of state'/5 calls.
> Depend on the PRNG this might be computationally expensive.
> For some PRNG it will be absolutely trivial.
> ...
> Stirring in a little bit of entropy doesn't help much either.
> The entropy bits are effectively initial state bits.
> Add 4 in with each request and 128 outputs gives 640 linear
> equations in the (128 + 4 * 128) unknowns - still solvable.

This is basically a scenario where the attacker has already taken
control of Ring 3 execution and the question is how hard is it for
them to perform privilege escalation attack to ring 0, right?  I'm
sure the security folks will think I'm defeatist, but my personal rule
of thumb is if the attacker has ring 3 control, you've already lost
--- I figure there are so many zero days that getting ring 0 control
is a foregone conclusion.  :-(

So that basically means if we want to protect against this, we're
going to do something which involves Real Crypto (tm).  Whether that's
RDRAND, or using Chacha20, etc., or something that has some attack
resistance, such as "half MD5", etc., but emminently crackable by
brute force, is essentially a overhead vs. security argument, and what
it is we are willing to pay.

							- Ted
