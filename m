Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3035C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E86C20684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551921517;
	bh=4ut95DT4/jG2G/pwd7oxbOmEnM1ONTeamaxjnfz69cQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HisRORDSwmJ+JPfgcfOSpCtL9HhsykPXSZspW55wuam2HDCd0emjw+3n3zq9sVskY
	 MsV+pG4rmflwmXlHBCvMVXuvt8rRBGPR3WyqvN8CO7UgaRtrOvullkc/3YjnfqG4Km
	 d0OjPNaAqTfmMGHlUCLP1zeBzZym3hz23BsI1V8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfCGBSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:18:35 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35690 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfCGBSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:18:35 -0500
Received: by mail-lf1-f65.google.com with SMTP id h6so6151550lfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 17:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W4qVrYWV/n1ivRdL2qH25FlWqe7J/irdbUsfkEjqc+4=;
        b=iJ3dPGAfLy1mnGFufMPIpe8VYD9AVvbwLNzRcA6TEwUqiGRYLSBsZ5GPmaKj5hOoZh
         b654YSnZ6l38rLIIW/ChyiHqMXMWgI9MBKQ/Q9vYTMzJWOdw9CxNcUSTFTub7y/Ru5M6
         mgzu658aTLg4cCp//xEYeoAYz3cEQsKx6M3Cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W4qVrYWV/n1ivRdL2qH25FlWqe7J/irdbUsfkEjqc+4=;
        b=el3t5yrU6TJdNJ5U9BRjM9vSTMXf9qpXLS4mP7ZVNvauepcXNlD3ACX/Xu9IUkcO87
         MTfb63U+VEwuApTQPy49cnXngXg89kP3E7OJKu6GjHMV9UWjygwzJL1R5O/mt9B87UEI
         namGv9PErYbCdBvkXYivdGdwbZVqZwllG1x8H4xu5HJyYyVYlWIvrRZAcrV3PsPmDBoV
         BVY6SSUJzsvo8DREXBBla8AsJllWBt5nITRrym1cw2ebxpEcy93S7OX77smmMD1m1lPo
         6NR8Ppa21prPFJ8tFcU5SyA3XfoGbvRaS3mAOU+/70AxvnHBny6QdwWT52PZXEr8c6L9
         J0Cg==
X-Gm-Message-State: APjAAAV4hYPIWQlJ+qXFKUOomdsSH9pFkdfT3+Bkh/Qqti5E90b8d1jE
        7mqRIKT4JaCUjezKBxoLgqQCTMxqvGg=
X-Google-Smtp-Source: APXvYqwZ55zEU4pkm0GskKGPUMUZXSBBdJ4foHsUB2IsGFufn0ZZeNqEsvc+iKmazBLOnHzflx2syA==
X-Received: by 2002:ac2:51b2:: with SMTP id f18mr5430011lfk.21.1551921512667;
        Wed, 06 Mar 2019 17:18:32 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id f141sm580386lff.71.2019.03.06.17.18.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 17:18:32 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id g80so12673479ljg.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 17:18:32 -0800 (PST)
X-Received: by 2002:a2e:9786:: with SMTP id y6mr3687996lji.79.1551921209404;
 Wed, 06 Mar 2019 17:13:29 -0800 (PST)
MIME-Version: 1.0
References: <20190301140348.25175-1-will.deacon@arm.com> <20190301140348.25175-2-will.deacon@arm.com>
 <1551575210.6lwpiqtg5k.astroid@bobo.none> <87ef7n7x9v.fsf@concordia.ellerman.id.au>
 <CAHk-=wgbnn7x+i72NqnvXotbxjsk2Ag56Q5YP0OSvhY9sUk7QA@mail.gmail.com> <87k1hbv7ba.fsf@concordia.ellerman.id.au>
In-Reply-To: <87k1hbv7ba.fsf@concordia.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 Mar 2019 17:13:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi_tsKOxpJVEWnfh4Zkx58oYtGfKCx_-hPNJx4Yu0-_-w@mail.gmail.com>
Message-ID: <CAHk-=wi_tsKOxpJVEWnfh4Zkx58oYtGfKCx_-hPNJx4Yu0-_-w@mail.gmail.com>
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

On Wed, Mar 6, 2019 at 4:48 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> It's a bit hard to grep for, but I did find one case:
>
> static void netxen_nic_io_write_128M(struct netxen_adapter *adapter,
>                 void __iomem *addr, u32 data)
> {
>         read_lock(&adapter->ahw.crb_lock);
>         writel(data, addr);
>         read_unlock(&adapter->ahw.crb_lock);
> }
>
> It looks like that driver is using the rwlock to exclude cases that can
> just do a readl()/writel() (readers) vs another case that has to reconfigure a
> window or something, before doing readl()/writel() and then configuring
> the window back. So that seems like a valid use for a rwlock.

Oh, it's actually fairly sane: the IO itself is apparently windowed on
that hardware, and the *common* case is that you'd access "window 1".

So if everybody accesses window 1, they can all work in parallel - the
read case.

But if somebody needs to access any of the other special IO windows,
they need to take the write lock, then change the window pointer to
the window they want to access, do the access, and then set it back to
the default "window 1".

So yes. That driver very much relies on exclusion of the IO through an rwlock.

I'm guessing nobody uses that hardware on Power? Or maybe the "window
1 is common" is *so* common that the other cases basically never
happen and don't really end up ever causing problems?

[ Time passes, I look at it ]

Actually, the driver probably works on Power, because *setting* the
window isn't just a write to the window register, it's always
serialized by a read _from_ the window register to verify that the
write "took". Apparently the hardware itself really needs that "don't
do accesses to the window before I've settled".

And that would basically serialize the only operation that really
needs serialization, so in the case of _that_ driver, it all looks
safe. Even if it's partly by luck.

> > Perhaps more importantly, what about sleeping locks? When they
> > actually *block*, they get the barrier thanks to the scheduler, but
> > you can have a nice non-contended sequence that never does that.
>
> Yeah.
>
> The mutex unlock fast path is just:

Yup. Both lock/unlock have fast paths that should be just trivial
atomic sequences.

But the good news is that *usually* device IO is protected by a
spinlock, since you almost always have interrupt serialization needs
too whenever you have any sequence of MMIO that isn't just some "write
single word to start the engine".

So the "use mutex to serialize IO" may be fairly unusual.

                  Linus
