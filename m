Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D5FC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 14:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F390C20873
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 14:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QY/1IxGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfELOdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 10:33:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45579 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfELOdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 10:33:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id s11so5729258pfm.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 07:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4lzMzXcIlsMyvnIM+cP+rdR98k+/37nVWWDJQ9nyZiU=;
        b=QY/1IxGGWk2J9aunJr+Apbe78b1IgbER4zCNvy7hNHL+Y3KZHfAhUKS4jI+TjEKMwA
         zSM2u2WZQKjM623dDZC3JfKcgTb9/hwU8+mxzPgrpIIDWjQod30+vXa8JL/Lp3yqdT/Y
         CBmFjjImooUcH0KbM9Ki/mQAgmfwnUAwzpDP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4lzMzXcIlsMyvnIM+cP+rdR98k+/37nVWWDJQ9nyZiU=;
        b=DG0H48+rEkQw+adivKPFNKxX9KyRGwSaG4PWPeaBOmzKnogEUfw+3Zte1Z7gEoQ18k
         DKjUUb0+tjunj/EtWuLwN7qFVttSC01+Ug/Dx67nMl3gGTMltbbz43ujFpM/5U9hy7Ky
         InENgLEXA5uOXT/gZyZF1dsfoaWsd/ICSNuifSITVweGlUsRSdfrjOYH0vcaAYG58yX5
         aVMsBol0tMcrcbQtbY413Y87oRPQwc+u6LVU/uVz0T1038JRAU6ctDEbllb9Q2xBAbxt
         UQGc+A/xZKajGuNNV/jmWc4cgBEPL2KZ/LRKodIAe1++mTHuvLJ836W1OXGShBp7/a1P
         3Wfw==
X-Gm-Message-State: APjAAAWDoIVK36/V/8zIZpxM5srvu0pUH7Q+Tn2ud50Mr/jm7A1ynFqH
        1yiE0qUJcwEQhJUAKoPkIVJQAA==
X-Google-Smtp-Source: APXvYqyg2IHZHZpoKFmGdujO4iZaB6snYi2jNh/0Osxu7S2u2i4+gitQsVXVx59qxegmyxG7wtT95A==
X-Received: by 2002:a63:6ac1:: with SMTP id f184mr26503055pgc.25.1557671593324;
        Sun, 12 May 2019 07:33:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r74sm18981716pfa.71.2019.05.12.07.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 May 2019 07:33:12 -0700 (PDT)
Date:   Sun, 12 May 2019 07:33:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        David Laight <David.Laight@aculab.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Eric Biggers <ebiggers3@gmail.com>,
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
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Message-ID: <201905120705.4F27DF3244@keescook>
References: <e4fbad8c51284a0583b98c52de4a207d@AcuMS.aculab.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C760A7@IRSMSX102.ger.corp.intel.com>
 <20190508113239.GA33324@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C762F7@IRSMSX102.ger.corp.intel.com>
 <20190509055915.GA58462@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C7741F@IRSMSX102.ger.corp.intel.com>
 <20190509084352.GA96236@gmail.com>
 <CALCETrV1067Es=KEjkz=CtdoT79a2EJg4dJDae6oGDiTaubL1A@mail.gmail.com>
 <201905111703.5998DF5F@keescook>
 <20190512080245.GA7827@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190512080245.GA7827@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 10:02:45AM +0200, Ingo Molnar wrote:
> * Kees Cook <keescook@chromium.org> wrote:
> > I still think just using something very simply like rdtsc would be good 
> > enough.
> >
> > This isn't meant to be a perfect defense: it's meant to disrupt the 
> > ability to trivially predict (usually another thread's) stack offset. 
> 
> But aren't most local kernel exploit attacks against the current task? 
> Are there any statistics about this?

I don't think I have any meaningful statistics on this any more. As
mentioned ealier, virtually all the known stack-based attack methods
have been mitigated:
- stack canaries: no linear buffer overflows
- thread_info moved: no more addr_limit games
- VMAP_STACK (i.e. guard page): no more linear overflows/exhaustion
  overwriting neighboring memory
- no VLAs: no more index overflows of stack arrays
- stack variable initialization: vastly reduced chance of memory exposures
  or use of "uninitialized" variables

One thing we don't have is a shadow call stack. i.e. the return addresses
are still mixed in with local variables, argument spills, etc. This is
still a potential target for attack, as ROP would need to get at the
return addresses. (Though creating a shadow stack just moves the problem,
but in theory to a place where there would be better control over it.)

As for current vs not, yes, many past exploits have been against the
current thread, though it's always been via the various low-hanging fruit
we've hopefully eliminated now. What I think remains interesting are
the attacks where there is some level of "spraying". It seems like this
happens more as mitigations land. For example, while trying to overwrite
a close() function pointer and an attacker can't target a specific heap
allocation, they make lots of sockets, and just close them all after
blindly poking memory. Similar things have been seen for thread-based
attacks (though that predated VMAP_STACK).

So, right now this mitigation remains a "what are we able to do to disrupt
the reliability of an attack that is targetting the stack?" without
a specific threat model in mind. I don't want the answer to be "we do
nothing because we can't find a way to perfectly construct entropy that
resists one threat model of many possible threats."

> > And any sufficiently well-positioned local attacker can defeat this no 
> > matter what the entropy source, given how small the number of bits 
> > actually ends up being, assuming they can just keep launching whatever 
> > they're trying to attack. (They can just hold still and try the same 
> > offset until the randomness aligns: but that comes back to us also 
> > needing a brute-force exec deterance, which is a separate subject...)
> > 
> > The entropy source bikeshedding doesn't seem helpful given how few bits 
> > we're dealing with.
> 
> The low number of bits is still useful in terms of increasing the 
> probability of crashing the system if the attacker cannot guess the stack 
> offset.

Right, we have the benefit of many attacks in the kernel being fragile,
but it's possible that it may only wreck the thread and not take out
the kernel itself. (Or the attack is depending on some kind of stack
information exposure, not a write.)

> With 5 bits there's a ~96.9% chance of crashing the system in an attempt, 
> the exploit cannot be used for a range of attacks, including spear 
> attacks and fast-spreading worms, right? A crashed and inaccessible 
> system also increases the odds of leaving around unfinished attack code 
> and leaking a zero-day attack.

Yup, which is why I'd like to have _something_ here without us getting
lost in the "perfect entropy" weeds. :)

-- 
Kees Cook
