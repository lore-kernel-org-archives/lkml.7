Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319ECC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D32215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="tPpec2Wn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfJDQtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:49:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39558 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDQtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:49:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id v4so4235132pff.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 09:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XdTgxouoyqXx/Y++6hFEOOkFgjmwtjxo2BV5ysqNRLk=;
        b=tPpec2WntRe/qAC1unvgm7fqyD04cSb5Sm0smTbXSsf9nc0dJfMRO4lEDBzvAOE5cu
         6Np6YgOPtvGLZdrahG/WqZCq3L95xDaCDfrZa6gixOQJNhJnOPh3X8zgCmBCfnfD/usk
         DlG2A8ZqQO6RgvCtRPA/dBXS5hW3PLoc7O9aY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XdTgxouoyqXx/Y++6hFEOOkFgjmwtjxo2BV5ysqNRLk=;
        b=Xx9G3AdF6hmmPnPuc3aI07Tm6YdpiHrxQRvLAtzxJ/fUjQ5a/kILNlE/emPqt4NSy9
         Y145m1rworv6Xct91vr1ufNMwPD4WB7+ulcRgvLRqiS65159K1E8fQpc4JK6FKOLrp9U
         BiFMx6tM9DuCcr8HnSGh0WdRbO62s1rP0ocQdV66argjTWt839OTSwR3IccatFvlgZBa
         5h17DGUJPxltIT6DYO5jSB4RUGmlpkR18QSnhpmCre6Yw/OvYmClRjitMCUEyOpkdw0Z
         wpW/CF+b2jSciyqxTQ0pQr07/dgzL6SRgqlwjvTNEy/ALgDInG33NYMubLKGQnIXJvFw
         7H7A==
X-Gm-Message-State: APjAAAXi/Tg6oepODAFSv6kbSlpipezSESlCbDJIVae2gZCgOvK2j9gp
        67p0ibb3rAI0K6WDV0PdwEWPVA==
X-Google-Smtp-Source: APXvYqzsXpBed+ffAJxWDGrQjQUP7QnP+uSURF21/EK+1MN7/WQZuLmQwvnIZVKquCQn+7cvkgWPOw==
X-Received: by 2002:a17:90a:33a2:: with SMTP id n31mr18569367pjb.28.1570207740561;
        Fri, 04 Oct 2019 09:49:00 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h2sm11564666pfq.108.2019.10.04.09.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 09:48:59 -0700 (PDT)
Date:   Fri, 4 Oct 2019 12:48:59 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Marco Elver <elver@google.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
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
Message-ID: <20191004164859.GD253167@google.com>
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
 <20191001211948.GA42035@google.com>
 <CANpmjNNp=zVzM2iGcQwVYxzNHYjBo==_2nito4Dw=kHopy=0Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNp=zVzM2iGcQwVYxzNHYjBo==_2nito4Dw=kHopy=0Sg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 09:51:58PM +0200, Marco Elver wrote:
> Hi Joel,
> 
> On Tue, 1 Oct 2019 at 23:19, Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Fri, Sep 20, 2019 at 04:18:57PM +0200, Marco Elver wrote:
> > > Hi all,
> > >
> > > We would like to share a new data-race detector for the Linux kernel:
> > > Kernel Concurrency Sanitizer (KCSAN) --
> > > https://github.com/google/ktsan/wiki/KCSAN  (Details:
> > > https://github.com/google/ktsan/blob/kcsan/Documentation/dev-tools/kcsan.rst)
> > >
> > > To those of you who we mentioned at LPC that we're working on a
> > > watchpoint-based KTSAN inspired by DataCollider [1], this is it (we
> > > renamed it to KCSAN to avoid confusion with KTSAN).
> > > [1] http://usenix.org/legacy/events/osdi10/tech/full_papers/Erickson.pdf
> > >
> > > In the coming weeks we're planning to:
> > > * Set up a syzkaller instance.
> > > * Share the dashboard so that you can see the races that are found.
> > > * Attempt to send fixes for some races upstream (if you find that the
> > > kcsan-with-fixes branch contains an important fix, please feel free to
> > > point it out and we'll prioritize that).
> > >
> > > There are a few open questions:
> > > * The big one: most of the reported races are due to unmarked
> > > accesses; prioritization or pruning of races to focus initial efforts
> > > to fix races might be required. Comments on how best to proceed are
> > > welcome. We're aware that these are issues that have recently received
> > > attention in the context of the LKMM
> > > (https://lwn.net/Articles/793253/).
> > > * How/when to upstream KCSAN?
> >
> > Looks exciting. I think based on our discussion at LPC, you mentioned
> > one way of pruning is if the compiler generated different code with _ONCE
> > annotations than what would have otherwise been generated. Is that still on
> > the table, for the purposing of pruning the reports?
> 
> This might be interesting at first, but it's not entirely clear how
> feasible it is. It's also dangerous, because the real issue would be
> ignored. It may be that one compiler version on a particular
> architecture generates the same code, but any change in compiler or
> architecture and this would no longer be true. Let me know if you have
> any more ideas.

My thought was this technique of looking at compiler generated code can be
used for prioritization of the reports.  Have you tested it though? I think
without testing such technique, we could not know how much of benefit (or
lack thereof) there is to the issue.

In fact, IIRC, the compiler generating different code with _ONCE annotation
can be given as justification for patches doing such conversions.

thanks,

 - Joel

