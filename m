Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6BDC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043DC21897
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 09:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="B8nbCdz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfIRJdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 05:33:44 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45400 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbfIRJdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 05:33:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id q64so6460065ljb.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 02:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oVhNis/dF5C/JXuxrb6BPz9PriRAlEp0NTIbkhZyp5o=;
        b=B8nbCdz6S1ldEQ7bMIDaDYAD9/FFZKl5H5tbiDBQgmM5mtEzL5Cb++ud3waqdB5AvI
         S3Bt8fKcaZu1KgPR9x/Vr093cICdeFVV8pNrgQVbFj3uO36dphq6M9k5EED/V7cBmhZY
         mxM5PZXwLLiQmyK0n1Q9SyO0M587jTWg3fBvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oVhNis/dF5C/JXuxrb6BPz9PriRAlEp0NTIbkhZyp5o=;
        b=NpatgJQgOOYK4p5VFA7nvMKqfVaygO+4Pi+9kbB8YqqPh+WbF4+V7sw/u+nXUxk4Wg
         yeSu5KyUYlZSUNTZTjGEKkgWyJR2cOtGRvsCgiTEYfpOVrXN6I9f5Fdf2HHKKe4JOjQj
         y/03xrqLSbb/MlnYVEWPu4ahDAwTxoq9cY2/NH1NPpPzAFxRsJ6Mbdvk9qxIvSJGUbUb
         0u1MvzD0slAAsa5COXc17NjpqnvYDFyIjZ8cfCz8eQfW1MXS6olmYXvVzdWq5mi43VYR
         IKkf/Dz5Y+qm1PuzRPL81AmSqGw+LJ2wMz6NOG12BI7X/cBKXQ3416LnjrsxI13bmksF
         Z2/w==
X-Gm-Message-State: APjAAAUYUkeZ+zDyQxVNlXI8Hf/EY8B7sZacUOJ1QdBlBdHiNbrFmiuh
        2fiYBJ8ah4JjFuO4lqnkUZfhjVFQnKefzQza
X-Google-Smtp-Source: APXvYqwCRUNGp9YjvKH9IT59/6e8Y9GI5BZxn5DL8YUvWDvFixN1V1BGI/eSwpRdUjWLkC64Q+YKOA==
X-Received: by 2002:a2e:5dc3:: with SMTP id v64mr1722222lje.118.1568799221748;
        Wed, 18 Sep 2019 02:33:41 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f21sm1083158lfm.90.2019.09.18.02.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 02:33:41 -0700 (PDT)
Subject: Re: Linux 5.3-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lennart Poettering <mzxreary@0pointer.de>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org>
 <20190917052438.GA26923@1wt.eu> <2508489.jOnZlRuxVn@merkaba>
 <20190917121156.GC6762@mit.edu>
 <20190917123015.sirlkvy335crozmj@debian-stretch-darwi.lab.linutronix.de>
 <20190917160844.GC31567@gardel-login>
 <CAHk-=wgsWTCZ=LPHi7BXzFCoWbyp3Ey-zZbaKzWixO91Ryr9=A@mail.gmail.com>
 <20190917174219.GD31798@gardel-login>
 <CAHk-=wjABG3+daJFr4w3a+OWuraVcZpi=SMUg=pnZ+7+O0E2FA@mail.gmail.com>
 <CAHk-=wgOCv2eOT2M8Vw9GD_yOpsTwF364-hkeADyEu9erHgMGw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <89aeae9d-0bca-2a59-5ce2-1e18f6479936@rasmusvillemoes.dk>
Date:   Wed, 18 Sep 2019 11:33:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgOCv2eOT2M8Vw9GD_yOpsTwF364-hkeADyEu9erHgMGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/2019 22.58, Linus Torvalds wrote:
> Side note, and entirely unrelated to this particular problem, but
> _because_ I was looking at the entropy init and sources of randomness
> we have, I notice that we still don't use the ToD clock as a source.

And unrelated to the non-use of the RTC (which I agree seems weird), but
because there's no better place in this thread: How "random" is the
contents of RAM after boot? Sure, for virtualized environments one
probably always gets zeroed pages from the host (otherwise the host has
a problem...), and on PCs maybe the BIOS interferes.

But for cheap embedded devices with non-ECC RAM and not a lot of
value-add firmware between power-on and start_kernel(), would it make
sense to read a few MB of memory outside of where the kernel was loaded
and feed those to add_device_randomness() (of course, doing it as early
as possible, maybe first thing in start_kernel())? Or do the reading in
the bootloader and pass on the sha256() in the DT/rng-seed property?

A quick "kitchen-table" experiment with the board I have on my desk
shows that there are at least some randomness to be had after a cold boot.

Maybe this has already been suggested and rejected?

Rasmus
