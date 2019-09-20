Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71FCC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 17:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00C1208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 17:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GcxR+Hvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393773AbfITRvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 13:51:08 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41271 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389956AbfITRvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 13:51:08 -0400
Received: by mail-ot1-f66.google.com with SMTP id g13so6890784otp.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 10:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EvpPydj1iU8UnRZJqqbCnDu9C5EKJs0suXbTn88VB04=;
        b=GcxR+HvzkXI2nIDk0UXBhXZvmf/lAf6OwYRzeQlPhZdE5Qt1dME4AqiNQrA7sG9hI7
         0RvOgydID51KqqfXlPuQYPG7ZTCZC16F1Me3VzcyjmWM/wYVSr5W7b/UMOGiFHO+u4lr
         wl6whGez4/CFR6k7/2A+PNjyQXd61BffSYrvF2c8XXYYmBoHJx9EDPxlb7LN9/7+ljCV
         oFZURexaaFWGupJRBXjddkIXK9weNdDpMiiC8GzczkyW6sLjtPsYLTNLu9y7+yn4SsJb
         V061jLr8t6PbPzh2pxwyISRTt+EScUS3u/z2rHiplQM/SvCGkX4wvGzmKdOqXoKMvmWs
         NRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EvpPydj1iU8UnRZJqqbCnDu9C5EKJs0suXbTn88VB04=;
        b=I3BpwM5ppZk8ExQzYXIam8gGhNUkGv8ZdRarSsjbLiF+peR4awk4ck0yTOdCH/ZyCH
         YvDmWt09DL/ZqYRE4bAT15zOzp0l/EzsUWWdoEKQLnf/CsKspSas4Yoo+9tKHwsBbULH
         h2hfrfxvU/z97FP6ntQW/+jJTS9K1DBYDD3/k9Yzpzb1bT5veeA0xVgx+NNj5eIGHZJA
         KHxrSjNGk38eoqvJqXG7QSRkr77mBjOyqzaMoMvQ7ZR8Xa/7QWFimlC5pCXXB9WYZhPL
         DvATETAGmK015ZNnQQ7exVMwFb5743pQKCj7YgC2S3FA/KO79MUh6sCswLHBzN3dIHOE
         mg+g==
X-Gm-Message-State: APjAAAUVuvUNQnevZI/xF/T5ZLswXrzJmeQz1/WR21MpUNzRMdqpxbaV
        UUs9ZiDPR26mPSbrO1ym9js9Wx8nbRWxg+m6eQMpoGHybjbgdg==
X-Google-Smtp-Source: APXvYqyzmzVG2xYOq99xUP4w5iy+zJBLZPaNof5TDEw1fhaD8LImfZaxJr5QdDFcZ5u5mQbIB3nZS+1qNgi7NhY+dq0=
X-Received: by 2002:a9d:68d7:: with SMTP id i23mr5023651oto.23.1569001867060;
 Fri, 20 Sep 2019 10:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
 <20190920155420.rxiflqdrpzinncpy@willie-the-truck>
In-Reply-To: <20190920155420.rxiflqdrpzinncpy@willie-the-truck>
From:   Marco Elver <elver@google.com>
Date:   Fri, 20 Sep 2019 19:50:55 +0200
Message-ID: <CANpmjNMfredJzrmjV7Vm_VAeL_O=_mWWKXAMoGoPH=U8VhkS=A@mail.gmail.com>
Subject: Re: Kernel Concurrency Sanitizer (KCSAN)
To:     Will Deacon <will@kernel.org>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>, paulmck@linux.ibm.com,
        Paul Turner <pjt@google.com>, Daniel Axtens <dja@axtens.net>,
        Anatol Pomazau <anatol@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        stern@rowland.harvard.edu, akiyks@gmail.com, npiggin@gmail.com,
        boqun.feng@gmail.com, dlustig@nvidia.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2019 at 17:54, Will Deacon <will@kernel.org> wrote:
>
> Hi Marco,
>
> On Fri, Sep 20, 2019 at 04:18:57PM +0200, Marco Elver wrote:
> > We would like to share a new data-race detector for the Linux kernel:
> > Kernel Concurrency Sanitizer (KCSAN) --
> > https://github.com/google/ktsan/wiki/KCSAN  (Details:
> > https://github.com/google/ktsan/blob/kcsan/Documentation/dev-tools/kcsan.rst)
> >
> > To those of you who we mentioned at LPC that we're working on a
> > watchpoint-based KTSAN inspired by DataCollider [1], this is it (we
> > renamed it to KCSAN to avoid confusion with KTSAN).
> > [1] http://usenix.org/legacy/events/osdi10/tech/full_papers/Erickson.pdf
>
> Oh, spiffy!
>
> > In the coming weeks we're planning to:
> > * Set up a syzkaller instance.
> > * Share the dashboard so that you can see the races that are found.
> > * Attempt to send fixes for some races upstream (if you find that the
> > kcsan-with-fixes branch contains an important fix, please feel free to
> > point it out and we'll prioritize that).
>
> Curious: do you take into account things like alignment and/or access size
> when looking at READ_ONCE/WRITE_ONCE? Perhaps you could initially prune
> naturally aligned accesses for which __native_word() is true?

Nothing special (other than the normal check if accesses overlap) done
with size in READ_ONCE/WRITE_ONCE.

When you say prune naturally aligned && __native_word() accesses, I
assume you mean _plain_ naturally aligned && __native_word(), right? I
think this is a slippery slope, because if we start pretending that
such plain accesses should be treated as atomics, then we will also
miss e.g. races where the accesses should actually have been protected
by a mutex.

> > There are a few open questions:
> > * The big one: most of the reported races are due to unmarked
> > accesses; prioritization or pruning of races to focus initial efforts
> > to fix races might be required. Comments on how best to proceed are
> > welcome. We're aware that these are issues that have recently received
> > attention in the context of the LKMM
> > (https://lwn.net/Articles/793253/).
>
> This one is tricky. What I think we need to avoid is an onslaught of
> patches adding READ_ONCE/WRITE_ONCE without a concrete analysis of the
> code being modified. My worry is that Joe Developer is eager to get their
> first patch into the kernel, so runs this tool and starts spamming
> maintainers with these things to the point that they start ignoring KCSAN
> reports altogether because of the time they take up.
>
> I suppose one thing we could do is to require each new READ_ONCE/WRITE_ONCE
> to have a comment describing the racy access, a bit like we do for memory
> barriers. Another possibility would be to use atomic_t more widely if
> there is genuine concurrency involved.

Our plan here is to use some of the options in Kconfig.kcsan to limit
reported volume of races initially, at least for syzbot instances. But
of course, this will not make the real issue go away, and eventually
we'll have to deal with all reported races somehow.

Thanks,
-- Marco
