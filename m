Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9260C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B8521A4C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569860177;
	bh=WtbJtM6zFCA1PCjjFYwUxztCpiGh0pcvJDHDxsvn1qE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mzHkHsAF5Wz525MNzG04l/JIORhAYVslqgL87oCO0xxQZSz5jr2gIirHLzxNj2xNG
	 w4Z8Kbqr4TqihhGh1aLlvwfq7+g/1wtXJWPkmoin35KL/uVLjSXL4P8BmQvmO7MLJf
	 /S+TdpnH4nPI3FMV1sPZw/LB7FPlYYx+bORqmS5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732224AbfI3QQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 12:16:16 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42977 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731996AbfI3QQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 12:16:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id y23so10101757lje.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 09:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HJzNXlibyUtJI8ckm37bPQTIdCVqgMO9qTi0/pkY+ds=;
        b=EEfrV2PjBToGLxf7td7dDlHl0akRG2maraRMZTiYLJrAEnYn6KB45JRJIRioKaKqdx
         7IjY3d2lHVMRjX6VRZYq3Va/L7TTRvo7auRqyWvTUF+XoK53mCZv7Z5fPhyxF0bxN7vg
         tRxyx27cdMmNBCLNEuU66LcOdR4J9aeiWZVy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HJzNXlibyUtJI8ckm37bPQTIdCVqgMO9qTi0/pkY+ds=;
        b=hFYn7UEKguk4msx4DuvbUU5fg8+fyGsfg0hqwFaZDuNrJo0u19hhLL8gf9MByk4D7n
         Q2LH526WrApiMQCge+vePbC98XfmZRzsP5aprszVirD/etkGI4/OemAtTd2S3YmnJImK
         M6EWNes1hneyCEdZ/mqGXXZjILoj6RuyIkuumpyNDNPqr2VP9AEvNKh+/6zk41evO0Qt
         QJCFrOJhkD5O/MYLpTHkIim+dP+L437+GqypOCOPp81dp+LJfzYM5CUihfpFTywdu44b
         XQUEVdKZLocgHki3nxpMxnBdmhenSv4JPFee4IcuDn0Rgd4jV0WpnyueG/2+XCWDaMq3
         d61w==
X-Gm-Message-State: APjAAAXIqxcWHuqqM+Iy4j7dZBmV1i/bMhVEvm0MwhKN3kG/OPOR6U38
        At72AFhHqSAWVS6GpN1Z0OjdJVc0VCw=
X-Google-Smtp-Source: APXvYqyGZm7GL2bi2K2dwaiTQrUfBiHljxQcN4ijeK08gqHBEUT8+js2r42QDHMAT/N4rWvzWc+8nA==
X-Received: by 2002:a2e:7a04:: with SMTP id v4mr12721236ljc.237.1569860173100;
        Mon, 30 Sep 2019 09:16:13 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id t82sm3198726lff.58.2019.09.30.09.16.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 09:16:12 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id y3so10128848ljj.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 09:16:11 -0700 (PDT)
X-Received: by 2002:a2e:3015:: with SMTP id w21mr12784608ljw.165.1569860171571;
 Mon, 30 Sep 2019 09:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
 <CAHk-=wi0vxLmwEBn2Xgu7hZ0U8z2kN4sgCax+57ZJMVo3huDaQ@mail.gmail.com>
 <20190930033706.GD4994@mit.edu> <20190930131639.GF4994@mit.edu>
In-Reply-To: <20190930131639.GF4994@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Sep 2019 09:15:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg7YAx_+CDe6fUqApPD_ghP18H9sPnJWWUg32pQ4pU82g@mail.gmail.com>
Message-ID: <CAHk-=wg7YAx_+CDe6fUqApPD_ghP18H9sPnJWWUg32pQ4pU82g@mail.gmail.com>
Subject: Re: x86/random: Speculation to the rescue
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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

On Mon, Sep 30, 2019 at 6:16 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> Which is to say, I'm still worried that people with deep access to the
> implementation details of a CPU might be able to reverse engineer what
> a jitter entropy scheme produces.  This is why I'd be curious to see
> the results when someone tries to attack a jitter scheme on a fully
> open, simple architecture such as RISC-V.

Oh, I agree.

One of the reasons I didn't like some of the other jitter entropy
things was that they seemed to rely _entirely_ on just purely
low-level CPU unpredictability. I think that exists, but I think it
makes for problems for really simple cores.

Timing over a bigger thing and an actual interrupt (even if it's
"just" a timer interrupt, which is arguably much closer to the CPU and
has a much higher likelihood of having common frequency domains with
the cycle counter etc) means that I'm pretty damn convinced that a big
complex CPU will absolutely see issues, even if it has big caches.

But it _also_ means that if you have a small and excessively stupid
in-order CPU, I can almost guarantee that you will at least have cache
misses likely all the way out to memory. So a CPU-only loop like the
LFSR thing that Thomas reports generates entropy even on its own would
likely generate nothing at all on a simple in-order core - but I do
think that with timers and real cache misses etc, it's going to be
really really hard to try to figure out cycle counters even if you're
a CPU expert.

But the embedded market with small cores and 100% identical machines
and 100% identical system images is always going to be a potential
huge problem.

If somebody has connections to RISC-V hw people, maybe they could
bring this issue up with them?

                  Linus
