Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240AFECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F732168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBi2Ynzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389903AbfJAQPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:15:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41744 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389703AbfJAQPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:15:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id h7so16272923wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 09:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BCei3PtTB3rMlIMt40WC3jRb+qUnQ6Q+GHJxiUYNxIQ=;
        b=EBi2Ynzqa5jQw6jLtU4r3y2dKCk3InLokMMTkJVXMw0zTZfpgn/xSQrp9W5pmiUwHS
         JmSF63GQaPvCZcim5Lb4LLowwaCIR0jyprK0PD+CJBYapZPA89VDGXRyzjFxkCct8akk
         Eaq3DEexunJ16/FztPxFEBRDV4u4rlIfkOp2+fLrYfPc1myMZSUUyDLue1wKcubRSwax
         IWaqcN33SnrM7MH6HfHXwPTV5R4TKEN9jzDAXcLe9G3GUc0Hk7lOWupBd51YxIVA6RaV
         7E+3U6c6Y09VAXXK27hkx1j+SsYi4A1RNmh+UDhRxN/GxzJfJd+DscFuejGUVicn/jC7
         KAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BCei3PtTB3rMlIMt40WC3jRb+qUnQ6Q+GHJxiUYNxIQ=;
        b=s/vXxoCbBOFFacIpHhplLDpuY8yxmXWhU2EVS6G2jufg/vAyICbczPtoKNa5V9SR4V
         EQD0kyxyixhC24b59sHC8gEuCc3r7VpzYvMi2Rsl0T3I9YfHIhBx/X7HVNk/bQUbGWjT
         28MpZ6XfH8mSgtLwq290F/wrueb1oEQyZEat+0vLc02kFOnX7fQPPr6gW4B6SJi1cGKW
         asx9YsVUq68IUCWCs7VXNU40tnJQkp0geBuhsBjh4wNsPFkheHHpb7mWFeuQZF+OIl34
         Nyk6Uaei4ieGLwUuDJqBLquh+uQ//Lykn+akYqBcTa+nifw7Q0GsFZseQ48/up74OrHK
         3xCQ==
X-Gm-Message-State: APjAAAUC2ZrPK5rPiY4xrEe8xDWDBQfGh4+qAI6vGGe21FBoVJHvi48S
        N5UPuaFDZ2qCKvSKffLMhN4=
X-Google-Smtp-Source: APXvYqyZZ1slfayZoLN5w162VuI/10U8f1zr4BqjHCsLagH2fToYMGU6CtS6sTIfZ6vRmIir9DnXng==
X-Received: by 2002:adf:e88f:: with SMTP id d15mr1983033wrm.324.1569946515066;
        Tue, 01 Oct 2019 09:15:15 -0700 (PDT)
Received: from darwi-home-pc ([46.183.103.17])
        by smtp.gmail.com with ESMTPSA id i1sm4895050wmb.19.2019.10.01.09.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 09:15:14 -0700 (PDT)
Date:   Tue, 1 Oct 2019 18:15:02 +0200
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, a.darwish@linutronix.de,
        LKML <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: x86/random: Speculation to the rescue
Message-ID: <20191001161448.GA1918@darwi-home-pc>
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for the late reply as I'm also on vacation this week :-)

On Sat, Sep 28, 2019 at 04:53:52PM -0700, Linus Torvalds wrote:
> On Sat, Sep 28, 2019 at 3:24 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Nicholas presented the idea to (ab)use speculative execution for random
> > number generation years ago at the Real-Time Linux Workshop:
>
> What you describe is just a particularly simple version of the jitter
> entropy. Not very reliable.
>
> But hey, here's a made-up patch. It basically does jitter entropy, but
> it uses a more complex load than the fibonacci LFSR folding: it calls
> "schedule()" in a loop, and it sets up a timer to fire.
>
> And then it mixes in the TSC in that loop.
>
> And to be fairly conservative, it then credits one bit of entropy for
> every timer tick. Not because the timer itself would be all that
> unpredictable, but because the interaction between the timer and the
> loop is going to be pretty damn unpredictable.
>
> Ok, I'm handwaving. But I do claim it really is fairly conservative to
> think that a cycle counter would give one bit of entropy when you time
> over a timer actually happening. The way that loop is written, we do
> guarantee that we'll mix in the TSC value both before and after the
> timer actually happened. We never look at the difference of TSC
> values, because the mixing makes that uninteresting, but the code does
> start out with verifying that "yes, the TSC really is changing rapidly
> enough to be meaningful".
>
> So if we want to do jitter entropy, I'd much rather do something like
> this that actually has a known fairly complex load with timers and
> scheduling.
>
> And even if absolutely no actual other process is running, the timer
> itself is still going to cause perturbations. And the "schedule()"
> call is more complicated than the LFSR is anyway.
>
> It does wait for one second the old way before it starts doing this.
>
> Whatever. I'm entirely convinced this won't make everybody happy
> anyway, but it's _one_ approach to handle the issue.
>
> Ahmed - would you be willing to test this on your problem case (with
> the ext4 optimization re-enabled, of course)?
>

So I pulled the patch and the revert of the ext4 revert as they're all
now merged in master. It of course made the problem go away...

To test the quality of the new jitter code, I added a small patch on
top to disable all other sources of randomness except the new jitter
entropy code, [1] and made quick tests on the quality of getrandom(0).

Using the "ent" tool, [2] also used to test randomness in the Stephen
Müller LRNG paper, on a 500000-byte file, produced the following
results:

    $ ent rand-file

    Entropy = 7.999625 bits per byte.

    Optimum compression would reduce the size of this 500000 byte file
    by 0 percent.

    Chi square distribution for 500000 samples is 259.43, and randomly
    would exceed this value 41.11 percent of the times.

    Arithmetic mean value of data bytes is 127.4085 (127.5 = random).

    Monte Carlo value for Pi is 3.148476594 (error 0.22 percent).

    Serial correlation coefficient is 0.001740 (totally uncorrelated = 0.0).

As can be seen above, everything looks random, and almost all of the
statistical randomness tests matched the same kernel without the
"jitter + schedule()" patch added (after getting it un-stuck).

Thanks!

[1] Nullified add_{device,timer,input,interrupt,disk,.*}_randomness()
[2] http://www.fourmilab.ch/random/

--
Ahmed Darwish
