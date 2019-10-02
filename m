Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB777C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B382133F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DbBnVOau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfJBTwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 15:52:12 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33055 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfJBTwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 15:52:11 -0400
Received: by mail-oi1-f196.google.com with SMTP id e18so498932oii.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 12:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8UdMjUT2pdLGE8ndpyA/9BXAvjXXhiUaO/cTeSeGp6c=;
        b=DbBnVOauShbcm7l0q/J9/fw2wbdf91+kUqz5f43RUfHDMuXQWrtNZXQqeRJcDPUaOf
         hkXW8W33rQxI7uhJ3o430fKOCcpBUY/yXh+twebiRcH3aCqth0om2mK93lhekrhCyyqP
         uHrNFujwMRsNd+jBxEKVmsSyq4uQrUZeza0bgPgrR9J8NI2vYDUM19jZ0ipHWWTsD4R1
         JCXdyCWDfxYXK5aOq7uaz7f8OyO78Kkf3oGJmlJQfI69K68zGZrSAD5LNGK5p+30GbCZ
         fpHEulhvc78VthYynGANKy5J2Bn4/180s093P+J4wbKYH7FuXLHzLu43PZu1dLA9EZNQ
         VUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8UdMjUT2pdLGE8ndpyA/9BXAvjXXhiUaO/cTeSeGp6c=;
        b=SsC5UmGyg0SuJOAnpEADpDbyjn8ipJJ8unyK8WoWebiRbGXpGTH8+qEI+jTvnZRPtV
         ftKSglIqsh4wTVmuJhzEwVTNE/RJXpictB74MKHDmmpBVb46uJBn3KB0lvspYIfP1KKw
         6k1K+f3hyPTvjBiyv81ouCC7NmeOhHORgoT5nU83ld72zDyN8beqpZJCH47a7OQ+9/7U
         0I293P/VuVSM+cj40vXQiFAmKwxcpM+Sv5Enmip4Yg/3LnHvKFEbMli+O3o6bciZIpVT
         6hBO+b7Thi/71s2YMnzcwSSNFCR0vvU/18mMJc22U2OyIouod0r0d3KrHZros7+5+C7G
         3qkg==
X-Gm-Message-State: APjAAAVplBiQwlreJVbl8ZnCO7XTSGCeaPuYPDFRUk6D6xEN+fjua8ma
        ydk6tB7/PkKPqlMXevY6dqhzRqT1S1wlNKnDbC07ig==
X-Google-Smtp-Source: APXvYqz1YT3omR1kNDLuBKiDfURMS6bzBNjhTJRlFkZXP+SZaSq2jbrZWP5PYK5tZx2ORhjFFY4ZiuEABFMqmzfEeGQ=
X-Received: by 2002:a05:6808:13:: with SMTP id u19mr4279200oic.83.1570045929963;
 Wed, 02 Oct 2019 12:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
 <20191001211948.GA42035@google.com>
In-Reply-To: <20191001211948.GA42035@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 2 Oct 2019 21:51:58 +0200
Message-ID: <CANpmjNNp=zVzM2iGcQwVYxzNHYjBo==_2nito4Dw=kHopy=0Sg@mail.gmail.com>
Subject: Re: Kernel Concurrency Sanitizer (KCSAN)
To:     Joel Fernandes <joel@joelfernandes.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On Tue, 1 Oct 2019 at 23:19, Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Fri, Sep 20, 2019 at 04:18:57PM +0200, Marco Elver wrote:
> > Hi all,
> >
> > We would like to share a new data-race detector for the Linux kernel:
> > Kernel Concurrency Sanitizer (KCSAN) --
> > https://github.com/google/ktsan/wiki/KCSAN  (Details:
> > https://github.com/google/ktsan/blob/kcsan/Documentation/dev-tools/kcsan.rst)
> >
> > To those of you who we mentioned at LPC that we're working on a
> > watchpoint-based KTSAN inspired by DataCollider [1], this is it (we
> > renamed it to KCSAN to avoid confusion with KTSAN).
> > [1] http://usenix.org/legacy/events/osdi10/tech/full_papers/Erickson.pdf
> >
> > In the coming weeks we're planning to:
> > * Set up a syzkaller instance.
> > * Share the dashboard so that you can see the races that are found.
> > * Attempt to send fixes for some races upstream (if you find that the
> > kcsan-with-fixes branch contains an important fix, please feel free to
> > point it out and we'll prioritize that).
> >
> > There are a few open questions:
> > * The big one: most of the reported races are due to unmarked
> > accesses; prioritization or pruning of races to focus initial efforts
> > to fix races might be required. Comments on how best to proceed are
> > welcome. We're aware that these are issues that have recently received
> > attention in the context of the LKMM
> > (https://lwn.net/Articles/793253/).
> > * How/when to upstream KCSAN?
>
> Looks exciting. I think based on our discussion at LPC, you mentioned
> one way of pruning is if the compiler generated different code with _ONCE
> annotations than what would have otherwise been generated. Is that still on
> the table, for the purposing of pruning the reports?

This might be interesting at first, but it's not entirely clear how
feasible it is. It's also dangerous, because the real issue would be
ignored. It may be that one compiler version on a particular
architecture generates the same code, but any change in compiler or
architecture and this would no longer be true. Let me know if you have
any more ideas.

Best,
-- Marco

> Also appreciate a CC on future patches as well.
>
> thanks,
>
>  - Joel
>
>
> >
> > Feel free to test and send feedback.
> >
> > Thanks,
> > -- Marco
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20191001211948.GA42035%40google.com.
