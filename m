Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE3CC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE47D20684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551745222;
	bh=Lua+XMI3Zphzo1cH+iD/U4zdzcNYEROs3+rPsj2wOE4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AT7TqqZ7DH1SvfrkgQmkxT0OFgL6cTCXSDEOGcSGAOIw3H0iOOH5AHdKDTNsNV9ad
	 uM5MvWsmqvS+yY+fz9i4kVkJqvBfdMF3JFlKPVl8N9SkRWVJmE3A8FrPKPWaE57jVd
	 +5n/9RQ9NnzOal/FZL9VlcshurtRI1XyMRIRYVzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfCEAUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:20:20 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43516 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCEAUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:20:19 -0500
Received: by mail-lf1-f65.google.com with SMTP id p73so4249830lfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 16:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X10NlC/byk7JQjbMFCtGWNvV4jecMH5AY93C/xcjuGM=;
        b=WzW8o8sfpWeM0HYBmZ5Lro5cTKVH0PEgVd5Hwm1VjO+eVuIPRTPKeqBQhANBjroAao
         EhAERH/wyavYctXDp2ZphlVz4lh/X/3k7/2dCO4WCplgeFG1zeu3wxzFOBs0XZn7cU1g
         I7tHOalb8BHZjmN+cmewwRmCsM+pRTe94b0eA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X10NlC/byk7JQjbMFCtGWNvV4jecMH5AY93C/xcjuGM=;
        b=AdH5g/R4kgcukpH4+b0YlqqXEA352uH+q1T+anLMnTTEJZZc8rdQo3wurPxW7J1n5v
         k02vA+kuf8bDyC3JYLQCaJgJOYStK92Vuq7Kv3AdrtAgub/nnGaiA7i42/p3l0da1Dgf
         hA+e5rF9XhBKHOqj/HFEXZQ52Kd94cR8imFX0fupZT3R2lBDlimsKWGrafFcJCed1lco
         2MgwhT0npRHGuzsPJlCe7IhM8Cm3Yg9LQW3nMwO5EGbMOsHXMaCRFIhtDFpTpSFyKGNj
         OtAZV+Dv4PXCAxxJxiNvRoxPuZJrtesOAnAN991jLKPSF0EY1gZhZblm64fZSrk8Lm5Y
         l1hw==
X-Gm-Message-State: APjAAAUQthgIgxC7lyYFW/U6Vd9fQcMQtxAj0V4YFjxGoNELUGEkOJOO
        isuvsqx2awiWwnfUC37jl4Xh/vfmp9c=
X-Google-Smtp-Source: APXvYqwNwlbGe8qaP1bZHvq1RUZgpE/hhuqDkUVLa50aQ2C591eFEjr31afoRsCAVEIms4TwBDzJOw==
X-Received: by 2002:ac2:4142:: with SMTP id c2mr3510992lfi.84.1551745217706;
        Mon, 04 Mar 2019 16:20:17 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id q12sm1770841lfc.8.2019.03.04.16.20.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 16:20:15 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id d26so4862258lfa.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 16:20:14 -0800 (PST)
X-Received: by 2002:a19:4ac4:: with SMTP id x187mr12125075lfa.166.1551745214041;
 Mon, 04 Mar 2019 16:20:14 -0800 (PST)
MIME-Version: 1.0
References: <20190301140348.25175-1-will.deacon@arm.com> <20190301140348.25175-2-will.deacon@arm.com>
 <1551575210.6lwpiqtg5k.astroid@bobo.none> <87ef7n7x9v.fsf@concordia.ellerman.id.au>
In-Reply-To: <87ef7n7x9v.fsf@concordia.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Mar 2019 16:19:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgbnn7x+i72NqnvXotbxjsk2Ag56Q5YP0OSvhY9sUk7QA@mail.gmail.com>
Message-ID: <CAHk-=wgbnn7x+i72NqnvXotbxjsk2Ag56Q5YP0OSvhY9sUk7QA@mail.gmail.com>
Subject: Re: [PATCH 01/20] asm-generic/mmiowb: Add generic implementation of
 mmiowb() tracking
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Luck <tony.luck@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 2:24 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Without wading into the rest of the discussion, this does raise an
> interesting point, ie. what about eg. rwlock's?
>
> They're basically equivalent to spinlocks, and so could reasonably be
> expected to have the same behaviour.
>
> But we don't check the io_sync flag in arch_read/write_unlock() etc. and
> both of those use lwsync.

I think technically rwlocks should do the same thing, at least when
they are used for exclusion.

Because of the exclusion argument, we can presubably limit it to just
write_unlock(), although at least in theory I guess you could have
some "one reader does IO, then a writer comes in" situation..

Perhaps more importantly, what about sleeping locks? When they
actually *block*, they get the barrier thanks to the scheduler, but
you can have a nice non-contended sequence that never does that.

I guess the fact that these cases have never even shown up as an issue
means that we could just continue to ignore it.

We could even give that approach some fancy name, and claim it as a
revolutionary new programming paradigm ("ostrich programming" to go
with "agile" and "pair programming").

                    Linus
