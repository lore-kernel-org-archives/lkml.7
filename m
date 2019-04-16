Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE6CC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0359920868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbfDPPpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:45:22 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36943 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726178AbfDPPpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:45:22 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x3GFhn5A012294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Apr 2019 11:43:51 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1C364420497; Tue, 16 Apr 2019 11:43:49 -0400 (EDT)
Date:   Tue, 16 Apr 2019 11:43:49 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "'Peter Zijlstra'" <peterz@infradead.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
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
Message-ID: <20190416154348.GB3004@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        David Laight <David.Laight@ACULAB.COM>,
        'Peter Zijlstra' <peterz@infradead.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01914abbfc1a4053897d8d87a63e3411@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So a couple of comments; I wasn't able to find the full context for
this patch, and looking over the thread on kernel-hardening from late
February still left me confused exactly what attacks this would help
us protect against (since this isn't my area and I didn't take the
time to read all of the links to slide decks, etc.)

So I'm not going to comment on the utility of this patch, but just on
the random number generator issues.  If you're only going to be using
the low 8 bits of the output of get_prandom_u32(), even if two
adjacent calls to get_prandom_u32() (for which only the low 8 bits are
revealed) can be used to precisely identify which set of 2**120
potential prandom states could have generate that pair of states, it's
still going to take a lot of calls before you'd be able to figure out
the prandom's internal state.

It seems though the assumption that we're assuming the attacker has
arbitrary ability to get the low bits of the stack, so *if* that's
true, then eventually, you'd be able to get enough samples that you
could reverse engineer the prandom state.  This could take long enough
that the process will have gotten rescheduled to another CPU, and
since the prandom state is per-cpu, that adds another wrinkle.

> > So the argument against using TSC directly was that it might be easy to
> > guess most of the TSC bits in timing attack. But IIRC there is fairly
> > solid evidence that the lowest TSC bits are very hard to guess and might
> > in fact be a very good random source.
> > 
> > So what one could do, is for each invocation mix in the low (2?) bits of
> > the TSC into a per-cpu/task PRNG state. By always adding some fresh
> > entropy it would become very hard indeed to predict the outcome, even
> > for otherwise 'trivial' PRNGs.
> 
> You could just feed 8 bits of TSC into a CRC.  Or even xor the
> entire TSC over a CRC state and then cycle it at least 6 bits.
> Probably doesn't matter which CRC - but you may want one that is
> cheap in software.  Even a 16bit CRC might be enough.

Do we only care about x86 in this discussion?  Given "x86/entry/64",
I'm guessing the answer we're not trying to worry about how to protect
other architectures, like say ARM, that don't have a TSC?

If we do care about architectures w/o a TSC, how much cost are we
willing to pay as far as system call overhead is concerned?

If it's x86 specific, maybe the simplest thing to do is to use RDRAND
if it exists, and fall back to something involving a TSC and maybe
prandom_u32 (assuming on how bad you think the stack leak is going to
be) if RDRAND isn't available?

					- Ted
