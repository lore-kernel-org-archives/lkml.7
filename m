Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD7EC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 17:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34EB20815
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 17:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569863049;
	bh=3TOzVG07souJUWStef4Ezz3arritY85TJpHVxY0XUn0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Fm/z3GbakP/XOa8l560Sp1Wdw3R83LZeJ+ioK0pmsyBF2zQYKjfKYuzxeJB+ONEw1
	 0waEiGslbi/NDTT+Q1/WsgfPgZWvmpYO3pViT/kHV9EHsODFUVMMS17U6gZvha5+D7
	 bI2iKW2lwNimcBXyJHUIW5+M8RyjCT4OkkbkZ2gg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbfI3REJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 13:04:09 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:35526 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfI3REI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 13:04:08 -0400
Received: by mail-lj1-f175.google.com with SMTP id m7so10315451lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 10:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G6kvqMJgkD9UCgFoqnQ/NukZeo+FSprO7GoT9qWDr+M=;
        b=aB3U6eAW/uZmwrUYAoCFXo2TwcFYt7/CygzXtx9Tt8lW622zC1011ULWCIYYxHePRZ
         Evhs4z86CTOPPX3REnIN6VMxNfv/JVK/8VoEqzf3TadXQMcYJFQ3LVlxlijpQQCzSSXa
         XTRgQBXEVctwDbT3smHmc8P1GVuDRo/0lPVh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G6kvqMJgkD9UCgFoqnQ/NukZeo+FSprO7GoT9qWDr+M=;
        b=jmP9sDy9Ot46+rhQVNb5FrbMfaQKt/Sh84X2/w87OkpY9nshh7ob0J2V4HwETOS+5r
         MlcNCluR2lAN7h2fNx4pFKbeQWLq1DECpUdIPqDuGyUKIAAMMcFCJvmt6BhgSGAH+JqZ
         COqLPwjijY3vlI/3JFF2feZ19naIQgz0lvguma1AKPkh482Et8P4AD0/QustaQHyqASg
         VjIplP7flZPSw7KM+v+PKBeWi+zpa0mSWJgmqADblLBtFW8LahJ5WS8WW0GDqEQyRblb
         PYTDcVbN0MlL6nvD9n4RLp6OmeB4rVBthRaCJ5AyZbIpZ8h7f7R1PV0vjmdVeKKMFbC+
         Gvcg==
X-Gm-Message-State: APjAAAVdHCAJiwA4SgVxxeaLcdDIW07gSAPdpY3/PoFNvX6bOB65DSqe
        kMDadux3/d2O+IRlbgZZVNsIFyOtBOM=
X-Google-Smtp-Source: APXvYqzf3ZQQYHdvNeiBJZF8ywC/94rfaWcn0iJyt2UhSyG8v0RS6kmDnOpCbxmJ7liDcwHYwRknfQ==
X-Received: by 2002:a2e:9943:: with SMTP id r3mr13313905ljj.171.1569863044403;
        Mon, 30 Sep 2019 10:04:04 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id z8sm4100307lfg.18.2019.09.30.10.04.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 10:04:03 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id m13so10252609ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 10:04:02 -0700 (PDT)
X-Received: by 2002:a2e:5b9a:: with SMTP id m26mr12707284lje.90.1569863042574;
 Mon, 30 Sep 2019 10:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
 <CAHk-=wi0vxLmwEBn2Xgu7hZ0U8z2kN4sgCax+57ZJMVo3huDaQ@mail.gmail.com>
 <20190930033706.GD4994@mit.edu> <20190930131639.GF4994@mit.edu>
 <CAHk-=wg7YAx_+CDe6fUqApPD_ghP18H9sPnJWWUg32pQ4pU82g@mail.gmail.com> <20190930163215.GH4519@hirez.programming.kicks-ass.net>
In-Reply-To: <20190930163215.GH4519@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Sep 2019 10:03:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjC0vTOgFU=dhX5NQxF84MBaGNpoQ1M6wD=yzBEy4tzTw@mail.gmail.com>
Message-ID: <CAHk-=wjC0vTOgFU=dhX5NQxF84MBaGNpoQ1M6wD=yzBEy4tzTw@mail.gmail.com>
Subject: Re: x86/random: Speculation to the rescue
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 9:32 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> In my experience LFSRs are good at defeating branch predictors, which
> would make even in-order cores suffer lots of branch misses. And that
> might be enough, maybe.

Agreed, branch mis-prediction is likely fairly hard to take into
account ahead of time even in an in-order CPU.

But when you know the LFSR, and you know the architecture, you could
just re-create the timing, and have a fairly high chance of getting
the same complex pattern.

And in the simple enough (ie bad) case - the embedded world - you
don't need to "know" or do any deep analysis of anything or try to
predict it ahead of time. You just look at what another identical
machine does when given the identical starting point.

So I don't think an LFSR is all that great on its own. It's
complicated to predict, and it gives odd patterns, but on an in-order
core I'm not convinced it gives sufficiently _different_ odd patterns
across booting.

This, btw, is why you shouldn't trust the "I ran the thing a billion
times" on my PC, even if you were to have an old in-order Atom CPU
available to you. If you didn't restart the whole CPU state from an
identical starting point as you re-run them, the differences you see
may simply not be real. They may be an artificial effect of cumulative
changes to internal CPU branch prediction arrays and cache tag layout.

I don't think it's a huge issue if you have a real load, and you have
_any_ source of entropy at all, but I really do not think that an LFSR
is necessarily a good idea. It's just _too_ identical across reboots,
and will have very similar (but yes, complex due to branch prediction)
behavior across different runs.

Of course, in the "completely and utterly identical state and
absolutely no timing differences anywhere" situation, even my "take
timer interrupts and force at least cache misses on SMP" model doesn't
protect you from just re-running the 100% identical sequence.

But when it's a more complex load than an LFSR, I personally at least
feel better about it. An LFSR I can well imagine will give the exact
same (odd) timing patterns across boots even if there were earlier
minor changes. But hopefully a bigger load with just a more complex
footprint will have more of that. More cache misses, more DRAM
accesses, more branch mispredicts, more "pipeline was broken in a
_slightly_ different place due to timer".

It is also, btw, why I don't mix in TSC _differences_ when I mix
things in. I think it's better to actually mix in the TSC value
itself. Even if you re-run the LFSR, and it has the exact same branch
mis-predicts (because it's the same LFSR), if there were any timing
differences from _anything_ else before you ran that LFSR, then the
bits you'll be mixing in are different across boots. But if you mix in
the relative difference, you might be mixing in the identical bits.

The only real difference is only the initial TSC value, of course, so
the added entropy is small. But when we're talking about trying to get
to a total of 256 bits, a couple of bits here and there end up
mattering.

But no. Never any _guarantees_. There is no absolute security. Only best effort.

An OoO CPU will have a _lot_ more internal state, and a lot of things
that perturb that internal state, and that will make small changes in
timing cause more chaos in the end. Much less to worry about.

An in-order CPU will have less internal state, and so less
perturbations and sources of real entropy from small differences. We
can only hope there is _some_.

It's not like our existing "depend on external interrupt timing" is
any hard guarantee either, regardless of how long we wait or how many
external interrupts we'd get.

It's always a "at some point you have to make a judgement call".

And we all have different levels of comfort about where that point
ends up being.

               Linus
