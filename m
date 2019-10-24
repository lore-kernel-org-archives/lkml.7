Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01965CA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C1A20650
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 17:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhGN6Jjj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410210AbfJXRGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:06:44 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:43616 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405931AbfJXRGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 13:06:44 -0400
Received: by mail-ed1-f50.google.com with SMTP id q24so13238297edr.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 10:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mjNJUxvJsKz/lvyp3sWZ6XLPxXD9qCaLF+79mgmKgJo=;
        b=QhGN6JjjVdrikoEc/rWYTTYN/4c5VSux7qGTTBM9A+Iwyoh42ygsksT6K5xMOG2f58
         qeDtBgRM8PN0PBu99oRSMsgK0uS5h8tmpS8+MfVVpjxcqSnQohgurjkJz8Mo9wJYHdCY
         01aZaI3U/6dRHAaLwvCyjEYKnqlJHSWhMKPOQDh4+1WSTUo50vIuHQYEGJk/dgME0IGg
         4F2aj5Br2ixRm4TmdA2LgcRj8Ju43WHF0qGts/LfwJXQZFb9HY4HBp1DrfkE1X4OTLDC
         65kDJftz7pwe5LERPCWK4CIy2lXap6OYATFLRMyHYZS1Hqk+AXhrlGkTKvr7eTFtwmu/
         e3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mjNJUxvJsKz/lvyp3sWZ6XLPxXD9qCaLF+79mgmKgJo=;
        b=asKu8xYhBA+vB2XQd1wSzprHmerVrH7c3j2A2v2AhA4sTnFXMaUYDoQJRD6q00b84f
         r5/A3eU6XCVFWrZEZDfViKeZav+2cAzx5jh1uGUcdYqOGPQA1B1FBCnCOdPs6JnQeLIv
         Ngd9qEFMUKFXWIe7EC7XTqcZCbtS2WhiE8pWL4dj+66d/qtYEhxPTxnDYGMlWqGAQEQu
         8rUocBtseoA+KV0biWTMlOlGIhR3tLEACw9Yr2JktPxZxQzFZFW+XiCIBh8uvA5egL0V
         NQp0rFt40PKQESF0UoZD79CRnQhGMHxVcD5Lb3SX11CwlvdG6LZ7lgighPJLn4b2cex9
         nhPQ==
X-Gm-Message-State: APjAAAV1BIJKFnICNpFlTb2sVDJTKLtynu+tlfd+TO3oz58p1V+4oLGW
        gHEs6aiY3Tn8igvseUmNNjV40G2zi0eDTqvVdFg=
X-Google-Smtp-Source: APXvYqwkqWjG8+Ezhi/+yt5XwrBiz4LeQhKtkC2JIYQYIeHlN+cVhMiB80zuJj2hJK2Q/lwJ9IvRjNtWnWdNJZr8Ov8=
X-Received: by 2002:a50:fc18:: with SMTP id i24mr21245392edr.42.1571936801598;
 Thu, 24 Oct 2019 10:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <c3d6de4d-f7c3-b505-2e64-8ee5f70b2118@intel.com> <CA+VK+GMAqMVXKQqjGzSj9P+-TKr_Jn6qQ1cHSyxhDsoChorm_w@mail.gmail.com>
In-Reply-To: <CA+VK+GMAqMVXKQqjGzSj9P+-TKr_Jn6qQ1cHSyxhDsoChorm_w@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 24 Oct 2019 10:06:29 -0700
Message-ID: <CAHbLzkrscPLFDapzFJUC_qML8pQQiPw3dP5h3yp1-iF=JEn6dA@mail.gmail.com>
Subject: Re: [RFC] Memory Tiering
To:     Jonathan Adams <jwadams@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Wu Fengguang <fengguang.wu@intel.com>,
        Huang Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 4:12 PM Jonathan Adams <jwadams@google.com> wrote:
>
>  1
> On Wed, Oct 16, 2019 at 1:05 PM Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > The memory hierarchy is getting more complicated and the kernel is
> > playing an increasing role in managing the different tiers.  A few
> > different groups of folks described "migration" optimizations they were
> > doing in this area at LSF/MM earlier this year.  One of the questions
> > folks asked was why autonuma wasn't being used.
> >
> > At Intel, the primary new tier that we're looking at is persistent
> > memory (PMEM).  We'd like to be able to use "persistent memory"
> > *without* using its persistence properties, treating it as slightly
> > slower DRAM.  Keith Busch has some patches to use NUMA migration to
> > automatically migrate DRAM->PMEM instead of discarding it near the end
> > of the reclaim process.  Huang Ying has some patches which use a
> > modified autonuma to migrate frequently-used data *back* from PMEM->DRAM.
> >
> > We've tried to do this all generically so that it is not tied to
> > persistent memory and can be applied to any memory types in lots of
> > topologies.
> >
> > We've been running this code in various forms for the past few months,
> > comparing it to pure DRAM and hardware-based caching.  The initial
> > results are encouraging and we thought others might want to take a look
> > at the code or run their own experiments.  We're expecting to post the
> > individual patches soon.  But, until then, the code is available here:
> >
> >         https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git
> >
> > and is tagged with "tiering-0.2", aka. d8e31e81b1dca9.
>
> Hi Dave,
>
> Thanks for sharing this git link and information on your approach.
> This interesting, and lines up somewhat with the approach Google has
> been investigating.  As we discussed at LSF/MM[1] and Linux
> Plumbers[2], we're working on an approach which integrates with our
> proactive reclaim work, with a similar attitude to PMEM (use it as
> "slightly slower" DRAM, ignoring its persistence).  The prototype we
> have has a similar basic structure to what you're doing here and Yang
> Shi's patchset from March[3] (separate NUMA nodes for PMEM), but
> relies on a fair amount of kernel changes to control allocations from
> the NUMA nodes, and uses a similar "is_far" NUMA flag to Yang Shi's
> approach.
>
> We're working on redesigning to reduce the scope of kernel changes and
> to remove the "is_far" special handling;  we still haven't refined
> down to a final approach, but one basic part we want to keep from the
> prototype is proactively pushing PMEM data back to DRAM when we've
> noticed it's in use. If we look at a two-socket system:
>
> A: DRAM & CPU node for socket 0
> B: PMEM node for socket 0
> C: DRAM & CPU node for socket 1
> D: PMEM node for socket 1
>
> instead of the unidirectional approach your patches go for:
>
>   A is marked as "in reclaim, push pages to" B
>   C is marked as "in reclaim, push pages to" D
>   B & D have no markings
>
> we would have a bidirectional attachment:
>
> A is marked "move cold pages to" B
> B is marked "move hot pages to" A
> C is marked "move cold pages to" D
> D is marked "move hot pages to" C
>
> By using autonuma for moving PMEM pages back to DRAM, you avoid
> needing the B->A  & D->C links, at the cost of migrating the pages
> back synchronously at pagefault time (assuming my understanding of how
> autonuma works is accurate).
>
> Our approach still lets you have multiple levels of hierarchy for a
> given socket (you could imaging an "E" node with the same relation to
> "B" as "B" has to "A"), but doesn't make it easy to represent (say) an
> "E" which was equally close to all sockets (which I could imagine for
> something like remote memory on GenZ or what-have-you), since there
> wouldn't be a single back link; there would need to be something like
> your autonuma support to achieve that.

I don't quite get why you want to achieve this and it is driven by
what usecase. With this approach pages just can be promoted from B to
A or D to C, is it correct? If A accesses the pages on D, the page
would have to be migrated twice D -> C -> A.

But NUMA balancing would migrate the page to the node of CPU that did
the access, of course it does some trick (twice access) to make sure
the connection is stable. So, it just does one migration.

>
> Does that make sense?
>
> Thanks,
> - Jonathan
>
> [1] Shakeel's talk, I can't find a link at the moment.  The basic
> kstaled/kreclaimd approach we built upon is talked about in
> https://blog.acolyer.org/2019/05/22/sw-far-memory/ and the linked
> ASPLOS paper
> [2] https://linuxplumbersconf.org/event/4/contributions/561/; slides
> at https://linuxplumbersconf.org/event/4/contributions/561/attachments/363/596/Persistent_Memory_as_Memory.pdf
> [3] https://lkml.org/lkml/2019/3/23/10
>
