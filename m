Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C115C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366F3206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBE2A2nj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731882AbfJIURS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 16:17:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39651 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfJIURR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 16:17:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id v17so3972615wml.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 13:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6AEE8so4vqanvMnabGRUAj1QDKzo4+4N4D1c+Rl4nYM=;
        b=jBE2A2nj+i8HXAyGAlMkpkmAdgDbV56WtrL3tGicoSvm5QME35xBXVkdq7fjVHqA1X
         2lJAeEJM9Po3BXn8Ne74ta+QZtMXJ3xT0q1ImPlVa6p36EFhSerzEX/KLKQvMBU/EVtb
         IpbIF5JI5kfivrkfuBi5sbkQq/0aLAwuis9DxFSUlr3pwrfgD5qHUJJ4AxXzhMU0f5B0
         WAQnVd7ztfFfP2SbzjuafVDkBzxOMbKgo9fSAVb/yhkCiN3OJdTGhV7YcHs3t0Il9uo/
         iqIXuiSLDHaG+WeYnhfPVU3AjdZ53j89oPGw1u6RGr9mAt5oQpAicsSfaO/8I/aPfUwD
         Eejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6AEE8so4vqanvMnabGRUAj1QDKzo4+4N4D1c+Rl4nYM=;
        b=SOYqEBUo/IxoS+yQ0f+SS0L09qmm+wrZKrLK/zfHMxL9szsNF9bWjRoD34o1dewlno
         d/bbrxdfVhkL5As94bo/oIkVJtvgz1xFrhM8k43bIK/3GVArccIF6C7kK+CvUKAMOcm+
         6UbQakvrzxGBrcdKB57WehTd0HsvA0QyhiZOiR9f2K1dC88csqKRVIrFB+MIE0aOFL/e
         58IVRO6G090pla3OFej69/q7/THVCz33RECix5APlsG9fcguESZLWits6kEyGgOs5GqL
         exdCoB9YIujr+z7o351cLyvTBEGre6gom7S+/71Jr1yKviNLJBaPnhi2AVTOyrr+YKPR
         +7aA==
X-Gm-Message-State: APjAAAXudNa3t4+Zl8TKXJBaahC8Ofxx8baw8m2zalZdfkFJsLCsjkYg
        ShtXU/EcdM1XyTiIps9msDw=
X-Google-Smtp-Source: APXvYqy6cSu7DWLdMpHZi2GuasJrkggNRoPIwNWgP5YQbTXlwWQbWHT1ZLHJxTgfmKaXldyNwdt/mw==
X-Received: by 2002:a05:600c:da:: with SMTP id u26mr3801909wmm.122.1570652234274;
        Wed, 09 Oct 2019 13:17:14 -0700 (PDT)
Received: from andrea (ip-213-220-200-127.net.upcbroadband.cz. [213.220.200.127])
        by smtp.gmail.com with ESMTPSA id x5sm5190712wrg.69.2019.10.09.13.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 13:17:13 -0700 (PDT)
Date:   Wed, 9 Oct 2019 22:17:06 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Will Deacon <will@kernel.org>, Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Paul Turner <pjt@google.com>, Daniel Axtens <dja@axtens.net>,
        Anatol Pomazau <anatol@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>
Subject: Re: Kernel Concurrency Sanitizer (KCSAN)
Message-ID: <20191009201706.GA3755@andrea>
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
 <20190920155420.rxiflqdrpzinncpy@willie-the-truck>
 <0715d98b-12e9-fd81-31d1-67bcb752b0a1@gmail.com>
 <CACT4Y+bdPKQDGag1rZG6mCj2EKwEsgWdMuHZq_um2KuWOrog6Q@mail.gmail.com>
 <CACT4Y+Z+rX_cvDLwkzCvmudR6brCNM-8yA+hx9V6nXe159tf6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Z+rX_cvDLwkzCvmudR6brCNM-8yA+hx9V6nXe159tf6A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 09:45:50AM +0200, Dmitry Vyukov wrote:
> On Sat, Oct 5, 2019 at 6:16 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Sat, Oct 5, 2019 at 2:58 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> > > > This one is tricky. What I think we need to avoid is an onslaught of
> > > > patches adding READ_ONCE/WRITE_ONCE without a concrete analysis of the
> > > > code being modified. My worry is that Joe Developer is eager to get their
> > > > first patch into the kernel, so runs this tool and starts spamming
> > > > maintainers with these things to the point that they start ignoring KCSAN
> > > > reports altogether because of the time they take up.
> > > >
> > > > I suppose one thing we could do is to require each new READ_ONCE/WRITE_ONCE
> > > > to have a comment describing the racy access, a bit like we do for memory
> > > > barriers. Another possibility would be to use atomic_t more widely if
> > > > there is genuine concurrency involved.
> > > >
> > >
> > > About READ_ONCE() and WRITE_ONCE(), we will probably need
> > >
> > > ADD_ONCE(var, value)  for arches that can implement the RMW in a single instruction.
> > >
> > > WRITE_ONCE(var, var + value) does not look pretty, and increases register pressure.
> >
> > FWIW modern compilers can handle this if we tell them what we are trying to do:
> >
> > void foo(int *p, int x)
> > {
> >     x += __atomic_load_n(p, __ATOMIC_RELAXED);
> >     __atomic_store_n(p, x, __ATOMIC_RELAXED);
> > }
> >
> > $ clang test.c -c -O2 && objdump -d test.o
> >
> > 0000000000000000 <foo>:
> >    0: 01 37                add    %esi,(%rdi)
> >    2: c3                    retq
> >
> > We can have syntactic sugar on top of this of course.
> 
> An interesting precedent come up in another KCSAN bug report. Namely,
> it may be reasonable for a compiler to use different optimization
> heuristics for concurrent and non-concurrent code. Consider there are
> some legal code transformations, but it's unclear if they are
> profitable or not. It may be the case that for non-concurrent code the
> expectation is that it's a profitable transformation, but for
> concurrent code it is not. So that may be another reason to
> communicate to compiler what we want to do, rather than trying to
> trick and play against each other. I've added the concrete example
> here:
> https://github.com/google/ktsan/wiki/READ_ONCE-and-WRITE_ONCE#it-may-improve-performance

Unrelated, but maybe worth pointing out/for reference: I think that
the section discussing the LKMM,

  https://github.com/google/ktsan/wiki/READ_ONCE-and-WRITE_ONCE#it-is-required-for-kernel-memory-model ,

might benefit from a revision/an update, in particular, the statement
"The Kernel Memory Consistency Model requires marking of all shared
accesses" seems now quite inaccurate to me, c.f., e.g.,

  d1a84ab190137 ("tools/memory-model: Add definitions of plain and marked accesses")
  0031e38adf387 ("tools/memory-model: Add data-race detection")

and

  https://lkml.kernel.org/r/Pine.LNX.4.44L0.1910011338240.1991-100000@iolanthe.rowland.org .

Thanks,
  Andrea
