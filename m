Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C5EC072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8302081C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R0/dA5gV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfE1L3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 07:29:12 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34187 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE1L3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 07:29:11 -0400
Received: by mail-ua1-f67.google.com with SMTP id 7so7693543uah.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 04:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ErCw9IwjYB4Bm/ESOgoCUc6lJbwqN2Dix2Mj1yQzd4s=;
        b=R0/dA5gVTuqKyN68OazVy0ZK/+lBLi08VEkT1epXWUFRyykQYWIf6MEAWFHbayO86S
         njYzeCF1jHKPHahHZtbkHQgKUobmXAr6hK08h0gux6hRvtgvzasb/EU/Crlc9ZmAaUR9
         IC6CqTSYqeTJfZ7C+3OoBAI97kWygVy/CRI3jdeuMlJvs7E5IVxIBAlqoo12x+8f9/Id
         /LA+fxpVzsOpjCoibwz3lOot3VeJhXNlOk6X1Dqdv4m3Lf5YRydGXeBKwG5Qew6olh6C
         //0qUcW9M+gAwQPZqMWLLNlmgI4ixud4Go4mBZjfuHLzCGiJq7JOCCCD3gY20WUQYNAW
         LyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ErCw9IwjYB4Bm/ESOgoCUc6lJbwqN2Dix2Mj1yQzd4s=;
        b=fDqwEvY/jY6c4DulAYfdM/3mt9fVOi7qPmD+ZYilF39layykTDTPHiEknUmkEcrjPT
         o5tqxIvZ8j99JWQ5FSa1iJizVtPSbRpo3hn5JVgRwaeI61Y6lD4ZCWuyGVRqv2nRkSOr
         F8Rpz0jJitVT1ZzVOi/aK+V3pLsnlO/0TvL2P/NBIgy9TtxXmXS2YJAMYlhv5mt+P92K
         ZsHSQMn/KKQ2yT096G1aYeZiIctMYaxgKmLCQsGMAnxyGrSByvb4iPemDwu9iNQVslIV
         Wm/wLpJ6ZKEGb47dKQZ2UB/8XgSf/sHO1YUxBHxQPhMmCuuuPUofv94Z6ALcyBA3s6Ia
         1WqQ==
X-Gm-Message-State: APjAAAVIgOmf0tNML1aBVO35o05iriGJ4Z2gN6DcEeggjAeUvFp0Rr3i
        36ImJuai7VyvIw6VcAD/aj2Lo285b0f03bxaYzVWtw==
X-Google-Smtp-Source: APXvYqzvCr8BFUAHqTS6Ysg8FvWrlyc0IxBbY5jsKNEqaA4c8t6D2O1A/O2hdxM9gRvzOoACI+VZLI1/FgNDQvxi+p4=
X-Received: by 2002:ab0:60d0:: with SMTP id g16mr47460086uam.85.1559042950097;
 Tue, 28 May 2019 04:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190521062628.GE32329@dhcp22.suse.cz> <20190527075811.GC6879@google.com>
 <20190527124411.GC1658@dhcp22.suse.cz> <20190528032632.GF6879@google.com>
 <20190528062947.GL1658@dhcp22.suse.cz> <20190528081351.GA159710@google.com>
 <CAKOZuesnS6kBFX-PKJ3gvpkv8i-ysDOT2HE2Z12=vnnHQv0FDA@mail.gmail.com>
 <20190528084927.GB159710@google.com> <20190528090821.GU1658@dhcp22.suse.cz>
 <20190528103256.GA9199@google.com> <20190528104117.GW1658@dhcp22.suse.cz>
In-Reply-To: <20190528104117.GW1658@dhcp22.suse.cz>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 28 May 2019 04:28:58 -0700
Message-ID: <CAKOZuevBtH8Sz9s+kRqrXo4HDq0GBMVDfDFRAgGOU9pguVhCWQ@mail.gmail.com>
Subject: Re: [RFC 7/7] mm: madvise support MADV_ANONYMOUS_FILTER and MADV_FILE_FILTER
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 3:41 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 28-05-19 19:32:56, Minchan Kim wrote:
> > On Tue, May 28, 2019 at 11:08:21AM +0200, Michal Hocko wrote:
> > > On Tue 28-05-19 17:49:27, Minchan Kim wrote:
> > > > On Tue, May 28, 2019 at 01:31:13AM -0700, Daniel Colascione wrote:
> > > > > On Tue, May 28, 2019 at 1:14 AM Minchan Kim <minchan@kernel.org> wrote:
> > > > > > if we went with the per vma fd approach then you would get this
> > > > > > > feature automatically because map_files would refer to file backed
> > > > > > > mappings while map_anon could refer only to anonymous mappings.
> > > > > >
> > > > > > The reason to add such filter option is to avoid the parsing overhead
> > > > > > so map_anon wouldn't be helpful.
> > > > >
> > > > > Without chiming on whether the filter option is a good idea, I'd like
> > > > > to suggest that providing an efficient binary interfaces for pulling
> > > > > memory map information out of processes.  Some single-system-call
> > > > > method for retrieving a binary snapshot of a process's address space
> > > > > complete with attributes (selectable, like statx?) for each VMA would
> > > > > reduce complexity and increase performance in a variety of areas,
> > > > > e.g., Android memory map debugging commands.
> > > >
> > > > I agree it's the best we can get *generally*.
> > > > Michal, any opinion?
> > >
> > > I am not really sure this is directly related. I think the primary
> > > question that we have to sort out first is whether we want to have
> > > the remote madvise call process or vma fd based. This is an important
> > > distinction wrt. usability. I have only seen pid vs. pidfd discussions
> > > so far unfortunately.
> >
> > With current usecase, it's per-process API with distinguishable anon/file
> > but thought it could be easily extended later for each address range
> > operation as userspace getting smarter with more information.
>
> Never design user API based on a single usecase, please. The "easily
> extended" part is by far not clear to me TBH. As I've already mentioned
> several times, the synchronization model has to be thought through
> carefuly before a remote process address range operation can be
> implemented.

I don't think anyone is overfitting for a specific use case. When some
process A wants to manipulate process B's memory, it's fair for A to
want to know what memory it's manipulating. That's a general concern
that applies to a large family of cross-process memory operations.
It's less important for non-destructive hints than for some kind of
destructive operation, but the same idea applies. If there's a simple
way to solve this A-B information problem in a general way, it seems
to be that we should apply that general solution. Likewise, an API to
get an efficiently-collected snapshot of a process's address space
would be immediately useful in several very different use cases,
including debuggers, Android memory use reporting tools, and various
kinds of metric collection. Because we're talking about mechanisms
that solve several independent problems at the same time and in a
general way, it doesn't sound to me like overfitting for a particular
use case.
