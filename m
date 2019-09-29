Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC72C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 08:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E4320863
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 08:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2pwvASX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfI2IFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 04:05:22 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45919 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfI2IFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 04:05:21 -0400
Received: by mail-lf1-f66.google.com with SMTP id r134so4760487lff.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 01:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0Kup/WuM5USev7LE9gSO4eOzCdji3byaAj/3kHQx28s=;
        b=h2pwvASX7WQiv/rG/0XYDhLUx3u00mBa+Jz8rIT6Pw+WoeadNb+O6ie2l7YKC5Rf8J
         5stOLp7KSQ4PIqko2eAhgEJHMyn7GKhuS7LudsvEaV80s0BKLUl7VclZjKIBvdIQsfMO
         PZRVepNvb3vht+suAXOPFWzPbi07gGt2OPjnRLRDi1x0XrB64PgxCOJ005atFdPXEoPj
         2aKrVzHgih52hT+GRID9d7Hk/593LA0slzUtT1NjK5rSX2i8FHW3OMU7eUQo2HGeFz5W
         tm2XBHctTStlpYlUPd6M8oG91MjnMPRWv68lvgfkc2fuVEQ49bEhT2SmQiQScJiusP0H
         ZkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Kup/WuM5USev7LE9gSO4eOzCdji3byaAj/3kHQx28s=;
        b=EsUWAZ7lJ2uyd5npKxT3C68Lgfd1qNSnRU+9EkcrrHlrJZxgJKRu2Urcjo92zkrVRg
         ml0aoIAxVnna7PvgVHTOrwwjpVzLuz5oTMhdjMK505OE61Hlx++xQiUOI0xToUAYfcWu
         YuuFPE3oYZYJYUGzT3qwG4B9Nn2zuHy1RXS/2TYI5R5qYe/SarrzTxzKes+mfKNPqvDM
         T1+PmayR5J/E6Bcne9uSz7XGF0qjMlcvq+OqlTMvc/2ayqL+S7RH7hBcT731YNdOktFX
         q7z28LtBv0jxOATig/o9b5GUXYeS/zGocqf7DeCPsjhEIi17vFxez5WmeVw65NFb1ktl
         AR3Q==
X-Gm-Message-State: APjAAAUOviR0i+Rm/Y+iujnWAmxTpUw2dB9yQEpe/ATIGTf+50yeoOpj
        TuDDArSq2b7+hVZWz4kL9sY=
X-Google-Smtp-Source: APXvYqzQ27SQ8AgNg+1d3xDMRZ/tOmc2/bsfFZmJc638vE9EJcM2NHuyfPs2y3RUwJio0D5B8VEjdA==
X-Received: by 2002:a19:dc10:: with SMTP id t16mr7774621lfg.85.1569744319667;
        Sun, 29 Sep 2019 01:05:19 -0700 (PDT)
Received: from ?IPv6:2a02:17d0:4a6:5700:d63d:7eff:fed9:a39? ([2a02:17d0:4a6:5700:d63d:7eff:fed9:a39])
        by smtp.googlemail.com with ESMTPSA id q3sm1985677ljq.4.2019.09.29.01.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2019 01:05:17 -0700 (PDT)
Subject: Re: x86/random: Speculation to the rescue
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Stephan Mueller <smueller@chronox.de>
References: <alpine.DEB.2.21.1909290010500.2636@nanos.tec.linutronix.de>
 <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
From:   "Alexander E. Patrakov" <patrakov@gmail.com>
Message-ID: <d606a69f-8d90-9f61-e0cb-c7f948f55c2d@gmail.com>
Date:   Sun, 29 Sep 2019 13:05:15 +0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgjC01UaoV35PZvGPnrQ812SRGPoV7Xp63BBFxAsJjvrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-PH
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

29.09.2019 04:53, Linus Torvalds пишет:
> On Sat, Sep 28, 2019 at 3:24 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Nicholas presented the idea to (ab)use speculative execution for random
>> number generation years ago at the Real-Time Linux Workshop:
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

This looks quite similar to the refactoring proposed earlier by Stephan 
Müller in his paper: https://www.chronox.de/lrng/doc/lrng.pdf . Indeed, 
he makes a good argument that the timing of device interrupts is right 
now the main actual source of entropy in Linux, at the end of Section 1.1:

"""
The discussion shows that the noise sources of block devices and HIDs 
are a derivative of the interrupt noise source. All events used as 
entropy source recorded by the block device and HID noise source are 
delivered to the Linux kernel via interrupts.
"""

Now your patch adds the timer interrupt (while the schedule() loop is 
running) to the mix, essentially in the same setup as proposed.

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
> And Thomas - mind double-checking that I didn't do anything
> questionable with the timer code..
> 
> And this goes without saying - this patch is ENTIRELY untested.  Apart
> from making people upset for the lack of rigor, it might do
> unspeakable crimes against your pets. You have been warned.
> 
>                 Linus
> 


-- 
Alexander E. Patrakov
