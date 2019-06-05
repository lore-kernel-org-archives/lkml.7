Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E0EC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708842067C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559767957;
	bh=aWxiKKVSC9AphkuiaOaLX6Ay4IYwlczyOloFLQans2Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Jb21akf9HnNC9LoPdcCx3Qc0uob+GPaDrVlq/ZViyQB0U3sIuBqmaeErMRl9edkYb
	 wh7KkIcylpuPr3BEuJK8L8DIlGZwNoEEcxAW/kHbS7BllPAh6r81mrwRGJG/c+Xn7V
	 Mkz5Hm7ggByFt/SjLEcJ8s8KvpM/OGzqplc2awT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfFEUwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:52:36 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40957 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFEUwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:52:36 -0400
Received: by mail-lj1-f195.google.com with SMTP id a21so9211774ljh.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 13:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UUmYALqkTRB8jq7IIMd1ZI8226gJUFMqe5N7OQkgNTM=;
        b=J6I3fdUNthnJVyG7CfnsGTfIcfhMYjMulzndseXmCbWp7tpKaoZkjdDbzmTRNbfUMW
         Ta2PYyn27ITZEjrTzc5xpqHaJE1nHsmbxK3SWbYkVDysjJw91k1K5oDu5Yi/Tbvx0anb
         0awWmAj64oDxZvHbFUdnduJwtHnovffhcyAwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UUmYALqkTRB8jq7IIMd1ZI8226gJUFMqe5N7OQkgNTM=;
        b=uRTUNrXxNzPcqXenj5UmYkH/6VkS7sa3gRZdf4XNnQpY/luYP88oFsP1GvWErE6+30
         48ZYEvjxq+g7OpIgxMLwvrNdzuMkYKu/+HygiHBciwdcqYpv4zJ2owgGoDPFMvWw6HGg
         xMsimh6TpGSKALnrc0v2N4qIVEmWgq1zbAfprqcIxD+7gCR+kycCucbAQCkQ69OoNCYp
         /3K1W5Gbs33mb0uE5WHIaq4I0e5wBlCNCgEF25KOrcYoEqbpbNS5zo+kqnConLtJYSYE
         cwrWu3Z4HEV5d9fmZ06s54VfNDRAoqFh1TejM68gQtatnTRWBQIxJ0hdpqoNswsGKSK8
         BO5w==
X-Gm-Message-State: APjAAAUhhLiczYOM3IVmv+VOyaOZ5JKPCCMsLRazIQucGu5KkrhW8PT6
        qk+0tY6F1gFynCOX2kPSTrsX9spS3tw=
X-Google-Smtp-Source: APXvYqy1kQE6frQ4qxvuSRLRGyBWQaCOrmq7YoahOg22UxNNCT7kP6lnbUOEjZorBgM5u69+ovMRtg==
X-Received: by 2002:a2e:8041:: with SMTP id p1mr23060948ljg.121.1559767953502;
        Wed, 05 Jun 2019 13:52:33 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id z9sm1012817lja.70.2019.06.05.13.52.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 13:52:32 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id m15so16138668ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 13:52:31 -0700 (PDT)
X-Received: by 2002:a2e:6109:: with SMTP id v9mr22673470ljb.205.1559767951604;
 Wed, 05 Jun 2019 13:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190520205918.22251-1-longman@redhat.com> <20190520205918.22251-16-longman@redhat.com>
 <20190604092008.GJ3402@hirez.programming.kicks-ass.net> <8e7d19ea-f2e6-f441-6ab9-cbff6d96589c@redhat.com>
 <20190604173853.GG3419@hirez.programming.kicks-ass.net> <f7f9b778-4f1a-7460-a7ae-1d4e3dd37181@redhat.com>
 <20190604181426.GH3419@hirez.programming.kicks-ass.net> <db89a086-3719-cea5-e24e-339085728c29@redhat.com>
 <46e44f43-87fd-251b-3b83-89a8bb3b407f@redhat.com> <20190605201901.GB3402@hirez.programming.kicks-ass.net>
In-Reply-To: <20190605201901.GB3402@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Jun 2019 13:52:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgqfXUeKkjT-TJRubxU5KNt9CLi88QSXhXT0H=3v4uF3g@mail.gmail.com>
Message-ID: <CAHk-=wgqfXUeKkjT-TJRubxU5KNt9CLi88QSXhXT0H=3v4uF3g@mail.gmail.com>
Subject: Re: [PATCH v8 15/19] locking/rwsem: Adaptive disabling of reader
 optimistic spinning
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 5, 2019 at 1:19 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Urgh, that's another things that's been on the TODO list for a long long
> time, write code to verify the alignment of allocations :/ I'm
> suspecting quite a lot of that goes wrong all over the place.

On x86, we only guarantee 8-byte alignment from things like kmalloc(), iirc.

That ends up actually being a useful thing for small allocations,
which do happen.

On the whole, I would suggest against cmpxchg2 unless it's something
_really_ special. And would definitely strongly suggest against it for
something like a rwsem. Requiring 16-byte alignment just because your
data structure has a lock is nasty. Of course, we could probably
fairly easily change our kmalloc alignment rules to be "still just 8
bytes for small allocations, 16 bytes for anything that is >=64 bytes"
or whatever.

At least nobody is hopefully crazy enough to put one of those things
on the stack, where we *definitely* don't want to increase alignment
issues.

And before people say "surely small allocations aren't normal" - take
a look at slaballoc. Small allocations (<= 32 bytes) are actually not
all that uncommon, and you want them dense in the cache and dense in
memory to not waste either. arm64 has some insane alignment issues
(128 byte alignment due to DMA coherency issues, iirc), and it hurts
them badly.

Right now my machine has 400k 8-byte allocations, if I read things right.

You also find some core slab caches that are small and that don't need
16-byte alignment. A quick script finds things like
ext4_extent_status, which is 40 bytes, not horribly uncommon (I've
apparently got 250k of those things on my system), and currently fits
102 entries per page *because* it's  not excessively aligned. Or
Acpi-Parse, which I apparently have 350k of, and is 56 bytes, and fits
73 per page exactly because it only needs 8-byte alignment (but
admittedly a 16-byte alignment would waste some memory, but guarantee
it doesn't cross a cacheline, so _maybe_ it would be ok).

16-byte alignment really isn't a good idea when you have data sizes
that are clearly smaller than even a cacheline.

So I *really* don't want to force excessive alignment. We'd have to
add some special static tooling to say "this kmalloc is assigned to a
pointer which requires 16-byte alignment" and make it use a separate
slab cache with that explicit alignment for that.

                Linus
