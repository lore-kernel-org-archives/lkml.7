Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C865CC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92228215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="k/M11Dz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbfJDSIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 14:08:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33230 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfJDSIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:08:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so4394518pfl.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 11:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bVhECVgYWcYWc1m8uEzWurmTDKJi7045y3cu4mRFVAc=;
        b=k/M11Dz4saLSXY/oEwlxgsQ7l0Dr8hDPMlIpPq7FGkAsht3TgvI9CcIH6kl2jsR/+S
         ny45poeLi7at/8K381Do3OFAxodfzFG9iGD7EczdKS+KeGWBsXTRfbdazLcl078vPeo9
         C4fcDKy8uP79EPLu1jeDJzvKEq0EZpJ2+omBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bVhECVgYWcYWc1m8uEzWurmTDKJi7045y3cu4mRFVAc=;
        b=L8B4UW2dneYaKVKlzrNoPFNBITF+Dh1CErC1kYFNPTu6d3CtUKD2hpNy7L8oPYORD8
         ydy0LxaM7jSnQ1LxkHo9TYWVv7CQ83C1thQ2G7hNtgNq+0NKUPhKW/sC0TmkvtiMHy37
         chh4Bq0DOvyz7xlw6FCDqs4I4YMam6CoASa69U5QH1YTz5YhCm2UlGoFUPdhs444JSAv
         co4G4zHcGaVwuDD2c/kiubedsLOmHr63DDYKcei00NIS7/DLEvlRtEF07itd/Uy/6bqc
         /jgqmGtfTbFIcw1GnnfuIQr72CBQm7BC+IMtPzYr99c+Ua3sVFYnU4kjxBe1L75IqZoB
         0JKg==
X-Gm-Message-State: APjAAAU97lo9pyYWnKPKrK0mn/VsMiwasx3Lm41s1vXeSk4hKWZgYBK2
        aGJatug5wI77WdKM8uFoH+zNvHu939w=
X-Google-Smtp-Source: APXvYqwX9QY/TN6mUiPJnsV6Y8CiBptzCAmd+h+KyyzYcV37Y7tt+vrtF9E3mhNZ+qdQc5kfP0umgw==
X-Received: by 2002:a17:90a:fb85:: with SMTP id cp5mr18637692pjb.42.1570212529974;
        Fri, 04 Oct 2019 11:08:49 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id u10sm6955967pfh.61.2019.10.04.11.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 11:08:49 -0700 (PDT)
Date:   Fri, 4 Oct 2019 14:08:48 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Paul Turner <pjt@google.com>, Daniel Axtens <dja@axtens.net>,
        Anatol Pomazau <anatol@google.com>,
        Will Deacon <willdeacon@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>
Subject: Re: Kernel Concurrency Sanitizer (KCSAN)
Message-ID: <20191004180848.GH253167@google.com>
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
 <20191001211948.GA42035@google.com>
 <CANpmjNNp=zVzM2iGcQwVYxzNHYjBo==_2nito4Dw=kHopy=0Sg@mail.gmail.com>
 <20191004164859.GD253167@google.com>
 <CACT4Y+bPZOb=h9m__Uo0feEshdGzPz0qGK7f2omsUc6-kEvwZA@mail.gmail.com>
 <20191004165736.GF253167@google.com>
 <CACT4Y+aEHmbLin_5Od++WVqgiFX7hkjARGgVK0QUj7eUpFLVeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aEHmbLin_5Od++WVqgiFX7hkjARGgVK0QUj7eUpFLVeg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 07:01:37PM +0200, Dmitry Vyukov wrote:
> On Fri, Oct 4, 2019 at 6:57 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Fri, Oct 04, 2019 at 06:52:49PM +0200, Dmitry Vyukov wrote:
> > > On Fri, Oct 4, 2019 at 6:49 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >
> > > > On Wed, Oct 02, 2019 at 09:51:58PM +0200, Marco Elver wrote:
> > > > > Hi Joel,
> > > > >
> > > > > On Tue, 1 Oct 2019 at 23:19, Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > > >
> > > > > > On Fri, Sep 20, 2019 at 04:18:57PM +0200, Marco Elver wrote:
> > > > > > > Hi all,
> > > > > > >
> > > > > > > We would like to share a new data-race detector for the Linux kernel:
> > > > > > > Kernel Concurrency Sanitizer (KCSAN) --
> > > > > > > https://github.com/google/ktsan/wiki/KCSAN  (Details:
> > > > > > > https://github.com/google/ktsan/blob/kcsan/Documentation/dev-tools/kcsan.rst)
> > > > > > >
> > > > > > > To those of you who we mentioned at LPC that we're working on a
> > > > > > > watchpoint-based KTSAN inspired by DataCollider [1], this is it (we
> > > > > > > renamed it to KCSAN to avoid confusion with KTSAN).
> > > > > > > [1] http://usenix.org/legacy/events/osdi10/tech/full_papers/Erickson.pdf
> > > > > > >
> > > > > > > In the coming weeks we're planning to:
> > > > > > > * Set up a syzkaller instance.
> > > > > > > * Share the dashboard so that you can see the races that are found.
> > > > > > > * Attempt to send fixes for some races upstream (if you find that the
> > > > > > > kcsan-with-fixes branch contains an important fix, please feel free to
> > > > > > > point it out and we'll prioritize that).
> > > > > > >
> > > > > > > There are a few open questions:
> > > > > > > * The big one: most of the reported races are due to unmarked
> > > > > > > accesses; prioritization or pruning of races to focus initial efforts
> > > > > > > to fix races might be required. Comments on how best to proceed are
> > > > > > > welcome. We're aware that these are issues that have recently received
> > > > > > > attention in the context of the LKMM
> > > > > > > (https://lwn.net/Articles/793253/).
> > > > > > > * How/when to upstream KCSAN?
> > > > > >
> > > > > > Looks exciting. I think based on our discussion at LPC, you mentioned
> > > > > > one way of pruning is if the compiler generated different code with _ONCE
> > > > > > annotations than what would have otherwise been generated. Is that still on
> > > > > > the table, for the purposing of pruning the reports?
> > > > >
> > > > > This might be interesting at first, but it's not entirely clear how
> > > > > feasible it is. It's also dangerous, because the real issue would be
> > > > > ignored. It may be that one compiler version on a particular
> > > > > architecture generates the same code, but any change in compiler or
> > > > > architecture and this would no longer be true. Let me know if you have
> > > > > any more ideas.
> > > >
> > > > My thought was this technique of looking at compiler generated code can be
> > > > used for prioritization of the reports.  Have you tested it though? I think
> > > > without testing such technique, we could not know how much of benefit (or
> > > > lack thereof) there is to the issue.
> > > >
> > > > In fact, IIRC, the compiler generating different code with _ONCE annotation
> > > > can be given as justification for patches doing such conversions.
> > >
> > >
> > > We also should not forget about "missed mutex" races (e.g. unprotected
> > > radix tree), which are much worse and higher priority than a missed
> > > atomic annotation. If we look at codegen we may discard most of them
> > > as non important.
> >
> > Sure. I was not asking to look at codegen as the only signal. But to use the
> > signal for whatever it is worth.
> 
> But then we need other, stronger signals. We don't have any.
> So if the codegen is the only one and it says "this is not important",
> then we conclude "this is not important".

I didn't mean for codegen to say "this is not important", but rather "this IS
important". And for the other ones, "this may not be important, or it may
be very important, I don't know".

Why do you say a missed atomic anotation is lower priority? A bug is a bug,
and ought to be fixed IMHO. Arguably missing lock acquisition can be detected
more easily due to lockdep assertions and using lockdep, than missing _ONCE
annotations. The latter has no way of being detected at runtime easily and
can be causing failures in mysterious ways.

I think you can divide the problem up.. One set of bugs that are because of
codegen changes and data races and are "important" for that reason. Another
one that is less clear whether they are important or not -- until you have a
better way of providing a signal for categorizing those.

Did I miss something?

thanks,

 - Joel

