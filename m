Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D0DECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF5220842
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569950730;
	bh=+fEUdXS7U/s4Wm/A1vLCoUf1gP7CN4w1ZiPvsUEEhj8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QDtDUXrKfrYk+GHm6rDzv+8hCJTQ5+guPI9KAiHhxNkh6fkYiQ7eVr6+lU3OpBnpG
	 +igfx0I4m4U93DZiB3G43ucBZ1biy3zCpf4jEO2D54zzmC4MXX1RC0fPEMgB7QY+V7
	 Zm+UW3NeS/nwd0SUWDHPAY1UwV+UgDc+Rm0PUkxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbfJARZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:25:30 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42640 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfJARZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:25:29 -0400
Received: by mail-lf1-f65.google.com with SMTP id c195so10531419lfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 10:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qYzOtNd+OvSp1jcA2j3Zo16xP06tK4ORpxwmrrXPsz4=;
        b=DJdHG6NxS24yvxVndj3S+46jprRiQmR+UGWyqm1a61hVGlhD7ncbRUiP1+D18kVfMH
         jHtCfaeHloL/uhiOyx3iTHAfVJdfjVRwN0xeyn4s7RJrpF4rLuCRTzhh2Kyt9RF6bcWh
         TmM2RuW//Rt6vxIfbyXBRKOom6iSbAqS/bOlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qYzOtNd+OvSp1jcA2j3Zo16xP06tK4ORpxwmrrXPsz4=;
        b=fs4ZILzlVDbwnjmIuy/gB79hwqW3AZp860YBv1V7iAuOY6gDkKqgQimg2yLMF0JLzp
         2PJvbCqMGQ3sg4ZrxNnDNj3z5SFD0D9K+L6w7zbAY7p23RRZxCK3SBLjsAuju2jNB7Q6
         VUjFPCTbagNv1wJ1SlQ1c0UD1lu62EVycwdyaj6uS7Gj/c4BpXNsoLzmdzr32vroaVeM
         2wqTLEv12SiEeS6BS11ouKRxVH2RcOTToP/NEbXHcD5eoJXSAOS/I1TFVXJ/Yad0i+sc
         gfFIFP00QnMbFxJ/047++ApL3gLNxnUjQx3mTAIj7mZOxwMMnLld7XOicZzHN7GjI+p0
         8VQw==
X-Gm-Message-State: APjAAAV+m8HjKJd8X06BpW5Bim691AXlumx1S4cZ1hjhg5oVu0Y6zKFK
        +oGVr+hjrfRJI+h968qUJE9UbEJwLVE=
X-Google-Smtp-Source: APXvYqxhzJ10d44uKW1WoJ9yG97PX1zrt0evmx1HJ2Fne7gbzlxjPEAv/e+IbBWEe9mmburlboo8Gg==
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr15791447lfp.61.1569950727274;
        Tue, 01 Oct 2019 10:25:27 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id c3sm3987432lfi.32.2019.10.01.10.25.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2019 10:25:25 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id y3so14248076ljj.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 10:25:24 -0700 (PDT)
X-Received: by 2002:a2e:2c02:: with SMTP id s2mr17142967ljs.156.1569950724432;
 Tue, 01 Oct 2019 10:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com> <20191001161448.GA1918@darwi-home-pc>
In-Reply-To: <20191001161448.GA1918@darwi-home-pc>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Oct 2019 10:25:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjPTVJNtynBMUbcnChUu=11f=VK=ASkw+4TUU7MEpiugA@mail.gmail.com>
Message-ID: <CAHk-=wjPTVJNtynBMUbcnChUu=11f=VK=ASkw+4TUU7MEpiugA@mail.gmail.com>
Subject: Re: x86/random: Speculation to the rescue
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, a.darwish@linutronix.de,
        LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 1, 2019 at 9:15 AM Ahmed S. Darwish <darwish.07@gmail.com> wrot=
e:
>
> To test the quality of the new jitter code, I added a small patch on
> top to disable all other sources of randomness except the new jitter
> entropy code, [1] and made quick tests on the quality of getrandom(0).

You also need to make sure to disable rdrand. Even if we don't trust
it, we always mix it in.

> Using the "ent" tool, [2] also used to test randomness in the Stephen
> M=C3=BCller LRNG paper, on a 500000-byte file, produced the following
> results:

Entropy is hard to estimate, for roughly the same reasons it's hard to gene=
rate.

The entropy estimation is entirely bvroken by the whitening we do:
first we do the LFSR to mix things into the pools, then we whiten it
when we mix it between the input pool and the final pool, and then we
whiten it once more when we extract it when reading.

So the end result of urandom will look random to all the entropy tools
regardless of what the starting point is. Because we use good hashes
for whitening, and do all the updating of the pools while extracing,
the end result had better look perfect.

The only way to even make an educated estimate of actual entropy would
be to print out the raw state of the input pool when we do that "crng
init done".

And then you would have to automate some "reboot machine thousands of
times" and start looking for patterns.

And even then you'd only have a few thousand starting points that we
_claim_ have at least 128 bits of entropy in, and you'd have a really
hard time to prove that is the case.

You might prove that we are doing something very very wrong and don't
have even remotely close to 128 bits of randomness, but just 5 bits of
actual entropy or whatever - _that_ kind of pattern is easy to see.

But even then /dev/urandom as a _stream_ should look fine. Only the
(multiple, repeated) initial states in the input pool would show the
lack of entropy.

And you'd really have to reboot things for real. And not in a VM
either. Just repeating the entropy initialization wouldn't show the
pattern (unless it's even more broken) because the base TSC values
would be changing.

Entropy really is hard. It's hard to generate, and it's hard to measure.

              Linus
