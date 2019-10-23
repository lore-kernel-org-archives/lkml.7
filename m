Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6CECA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 23:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2051F2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 23:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LPKaA53L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408012AbfJWXMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 19:12:22 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:36729 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbfJWXMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 19:12:22 -0400
Received: by mail-qt1-f182.google.com with SMTP id d17so20213851qto.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 16:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6chDs+IgEJKamu+cJb66Y7u49Uq6uTH7s8nRkQlDdp4=;
        b=LPKaA53L94ItgBQ7cRZRd0OF0ksHyc+ImxDvEoxDh+IWg0ADUvqw/DCa45By3Onsik
         gEU3iQy9d0ZpW+jKvEhPB/dns4TYCrDRKf0CiWDDwH5SKMn8XbAbBPGiBn+/jWiyLdHV
         awdW1hPhMkH/78y45KV6mVxeOLr1oGi9oABZLlyG7YxD8RpylW8NaZFy2c18py4LFwrr
         mgLjOB3reVQsqTcuG1jtcwbqv+gBtAHK4fwACqARXqd892/pvyR2RP3+YIgeqONkcrAy
         32DsNnCm4eybLA6NFqb4tqohrizzvQFkrEqxQ/0NCElAzRP796aEz92xJmbwSlNVwvTS
         wIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6chDs+IgEJKamu+cJb66Y7u49Uq6uTH7s8nRkQlDdp4=;
        b=I9YwL5CQRUSPf8M0cRoxtlEiSq+gS8+IZm6ZbmeVsJ85qEtDKMpNHs65mIemXnGrq2
         49lpl4SvB8y3SGcZm3wW5xDFaldP+3+FK27XuvaYqESxoRxhNDCslHY2MaAzMulPG3iA
         Mo6Gtt6bz4zrA7EQBB0kvl8mSpL8TRzSJb1nsM/blscpDGntGomtw/P1cpIALt3SxFWd
         n/8CP7HnkRut2Mbap+UMUisvxFCJ/vWhXpDT4hRD0gQmnXV/1wBTp+VfkrEzg9aLn5pJ
         wjITUYhALxkOfcPHLvQUWpkjj7nccnDOTfHHvP4NqOw3TsvoFW1NAPee9B2Zg0z6//n6
         QtmQ==
X-Gm-Message-State: APjAAAXOuJ0n1JVVpZLKCWt2N88yted0ueeGyQ/8R8fo28uMxli5yZin
        tI4/iyYt+GO5NBFTcbWQoLs4G+pXwS8uIU859z3UE7YWHEeO
X-Google-Smtp-Source: APXvYqw9jjyjfdvDyweAefKCm5wL44bLbMEPax372VuFPYTjsi7cw8qlwb8rL02E3il5G17GqHSSzKN2WhUwQdETlsU=
X-Received: by 2002:aed:3f57:: with SMTP id q23mr1240067qtf.116.1571872338418;
 Wed, 23 Oct 2019 16:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <c3d6de4d-f7c3-b505-2e64-8ee5f70b2118@intel.com>
In-Reply-To: <c3d6de4d-f7c3-b505-2e64-8ee5f70b2118@intel.com>
From:   Jonathan Adams <jwadams@google.com>
Date:   Wed, 23 Oct 2019 16:11:39 -0700
Message-ID: <CA+VK+GMAqMVXKQqjGzSj9P+-TKr_Jn6qQ1cHSyxhDsoChorm_w@mail.gmail.com>
Subject: Re: [RFC] Memory Tiering
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Wu Fengguang <fengguang.wu@intel.com>,
        Huang Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 1
On Wed, Oct 16, 2019 at 1:05 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> The memory hierarchy is getting more complicated and the kernel is
> playing an increasing role in managing the different tiers.  A few
> different groups of folks described "migration" optimizations they were
> doing in this area at LSF/MM earlier this year.  One of the questions
> folks asked was why autonuma wasn't being used.
>
> At Intel, the primary new tier that we're looking at is persistent
> memory (PMEM).  We'd like to be able to use "persistent memory"
> *without* using its persistence properties, treating it as slightly
> slower DRAM.  Keith Busch has some patches to use NUMA migration to
> automatically migrate DRAM->PMEM instead of discarding it near the end
> of the reclaim process.  Huang Ying has some patches which use a
> modified autonuma to migrate frequently-used data *back* from PMEM->DRAM.
>
> We've tried to do this all generically so that it is not tied to
> persistent memory and can be applied to any memory types in lots of
> topologies.
>
> We've been running this code in various forms for the past few months,
> comparing it to pure DRAM and hardware-based caching.  The initial
> results are encouraging and we thought others might want to take a look
> at the code or run their own experiments.  We're expecting to post the
> individual patches soon.  But, until then, the code is available here:
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/vishal/tiering.git
>
> and is tagged with "tiering-0.2", aka. d8e31e81b1dca9.

Hi Dave,

Thanks for sharing this git link and information on your approach.
This interesting, and lines up somewhat with the approach Google has
been investigating.  As we discussed at LSF/MM[1] and Linux
Plumbers[2], we're working on an approach which integrates with our
proactive reclaim work, with a similar attitude to PMEM (use it as
"slightly slower" DRAM, ignoring its persistence).  The prototype we
have has a similar basic structure to what you're doing here and Yang
Shi's patchset from March[3] (separate NUMA nodes for PMEM), but
relies on a fair amount of kernel changes to control allocations from
the NUMA nodes, and uses a similar "is_far" NUMA flag to Yang Shi's
approach.

We're working on redesigning to reduce the scope of kernel changes and
to remove the "is_far" special handling;  we still haven't refined
down to a final approach, but one basic part we want to keep from the
prototype is proactively pushing PMEM data back to DRAM when we've
noticed it's in use. If we look at a two-socket system:

A: DRAM & CPU node for socket 0
B: PMEM node for socket 0
C: DRAM & CPU node for socket 1
D: PMEM node for socket 1

instead of the unidirectional approach your patches go for:

  A is marked as "in reclaim, push pages to" B
  C is marked as "in reclaim, push pages to" D
  B & D have no markings

we would have a bidirectional attachment:

A is marked "move cold pages to" B
B is marked "move hot pages to" A
C is marked "move cold pages to" D
D is marked "move hot pages to" C

By using autonuma for moving PMEM pages back to DRAM, you avoid
needing the B->A  & D->C links, at the cost of migrating the pages
back synchronously at pagefault time (assuming my understanding of how
autonuma works is accurate).

Our approach still lets you have multiple levels of hierarchy for a
given socket (you could imaging an "E" node with the same relation to
"B" as "B" has to "A"), but doesn't make it easy to represent (say) an
"E" which was equally close to all sockets (which I could imagine for
something like remote memory on GenZ or what-have-you), since there
wouldn't be a single back link; there would need to be something like
your autonuma support to achieve that.

Does that make sense?

Thanks,
- Jonathan

[1] Shakeel's talk, I can't find a link at the moment.  The basic
kstaled/kreclaimd approach we built upon is talked about in
https://blog.acolyer.org/2019/05/22/sw-far-memory/ and the linked
ASPLOS paper
[2] https://linuxplumbersconf.org/event/4/contributions/561/; slides
at https://linuxplumbersconf.org/event/4/contributions/561/attachments/363/596/Persistent_Memory_as_Memory.pdf
[3] https://lkml.org/lkml/2019/3/23/10
