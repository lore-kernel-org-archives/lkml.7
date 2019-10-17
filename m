Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A2BCA9EB3
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 22:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145C521D7A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 22:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p+M2qiLu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441686AbfJQW6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 18:58:42 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:45863 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389846AbfJQW6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 18:58:42 -0400
Received: by mail-yb1-f194.google.com with SMTP id q143so1229350ybg.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 15:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xo1bLe6Va8tnmcOxB+cAJzhjK1B4a9z/mc+c7z1lhpA=;
        b=p+M2qiLu8EUlhSPNJ0qBYnLVNCicHXW7PuT3K9uWLdiJhE0yFZdM3CBNfOxJ2acJ2c
         HxmVeF2tbjJUAVyAYXrHBrfSdbBBbnj7eBlxtDdXXKJLfzDLgzJT/65S5BAOTtUkby7n
         DSO9AKT0lVXxxRSQiLlGewqVx5iH0lgEXlGhqZSMc26wIwZAWbNBUV0MljbWuENiYeX8
         GPdk4U42+mf1omJAQ6TPx2W2xg9dGKMyTM7aiPxg42UuNWhPAd+daJMRJU+5eUsiOiIk
         qVHsEsg1A+XNMPj87QZHFmCARaJKf6tboJ9DTpkCtinT7KEORpoSQMccvyKh793qsTBS
         JeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xo1bLe6Va8tnmcOxB+cAJzhjK1B4a9z/mc+c7z1lhpA=;
        b=kRdF+ZTprG81DALjzwY74WFaosVDf3VuwjbEWEKN+I/3Wel79qeb6/hAVsvYu6rEhJ
         mz6GHRxWsMhUIrT6DTiORoPT0GhB6OoC2TgtwMhZvZHRz7IhRLZRZsyePJ5SIScmwaOG
         hPe21R5FqHnLi+nPeXRQttXROCflOCT3tSOaDhJ8wddin8/NDz54ifU3moMUrdqHY2CR
         +Sw4srakdm8l8AdRcZdDpabKhsUK8cmzm3inX7T131CeXHHEFoXbbvtDxg9b2c8CAj8I
         VUlYAbg56ayLPCDv3MXj51qYcXLY2jZYXuJ1l+aIf1Cfsdt3XuF03h7UhcCrrylY1ouu
         Ajaw==
X-Gm-Message-State: APjAAAWgwy0k6VAfcCTXZjsfcyDP6cK9WzTFYMuCwfuSnfz+BNtQuqtn
        XIBEvuUJ5TKy/96bwzXWekoeNtstM16wOf9Mafet5g==
X-Google-Smtp-Source: APXvYqyPCrKraJGurMIIY626E0VIH4hNNh5WWU07XpmBbfHFm8JU0bR6gOMEIIkkUhkRpD4eEpYJGY2h61UNPfI9kI8=
X-Received: by 2002:a25:c883:: with SMTP id y125mr4196740ybf.358.1571353119575;
 Thu, 17 Oct 2019 15:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191016221148.F9CCD155@viggo.jf.intel.com> <CALvZod5wdToX6bx4Bnwx9AgrzY3xkmE0OMH61f88hKxeGX+tvA@mail.gmail.com>
 <496566a6-2581-17f4-a4f2-e5def7f97582@intel.com> <CAHbLzkq6cvS4L4DYnr+oyggfXzZTKegfpdNUi_XHA+-67HZYNA@mail.gmail.com>
In-Reply-To: <CAHbLzkq6cvS4L4DYnr+oyggfXzZTKegfpdNUi_XHA+-67HZYNA@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 17 Oct 2019 15:58:28 -0700
Message-ID: <CALvZod4yVgHa6oVjFFhV1rpE0auxdEmu2g2pEBmZ4Z-CP-ru=g@mail.gmail.com>
Subject: Re: [PATCH 0/4] [RFC] Migrate Pages in lieu of discard
To:     Yang Shi <shy828301@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Adams <jwadams@google.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 10:20 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Thu, Oct 17, 2019 at 7:26 AM Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 10/16/19 8:45 PM, Shakeel Butt wrote:
> > > On Wed, Oct 16, 2019 at 3:49 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
> > >> This set implements a solution to these problems.  At the end of the
> > >> reclaim process in shrink_page_list() just before the last page
> > >> refcount is dropped, the page is migrated to persistent memory instead
> > >> of being dropped.
> > ..> The memory cgroup part of the story is missing here. Since PMEM is
> > > treated as slow DRAM, shouldn't its usage be accounted to the
> > > corresponding memcg's memory/memsw counters and the migration should
> > > not happen for memcg limit reclaim? Otherwise some jobs can hog the
> > > whole PMEM.
> >
> > My expectation (and I haven't confirmed this) is that the any memory use
> > is accounted to the owning cgroup, whether it is DRAM or PMEM.  memcg
> > limit reclaim and global reclaim both end up doing migrations and
> > neither should have a net effect on the counters.
>
> Yes, your expectation is correct. As long as PMEM is a NUMA node, it
> is treated as regular memory by memcg. But, I don't think memcg limit
> reclaim should do migration since limit reclaim is used to reduce
> memory usage, but migration doesn't reduce usage, it just moves memory
> from one node to the other.
>
> In my implementation, I just skip migration for memcg limit reclaim,
> please see: https://lore.kernel.org/linux-mm/1560468577-101178-7-git-send-email-yang.shi@linux.alibaba.com/
>
> >
> > There is certainly a problem here because DRAM is a more valuable
> > resource vs. PMEM, and memcg accounts for them as if they were equally
> > valuable.  I really want to see memcg account for this cost discrepancy
> > at some point, but I'm not quite sure what form it would take.  Any
> > feedback from you heavy memcg users out there would be much appreciated.
>
> We did have some demands to control the ratio between DRAM and PMEM as
> I mentioned in LSF/MM. Mel Gorman did suggest make memcg account DRAM
> and PMEM respectively or something similar.
>

Can you please describe how you plan to use this ratio? Are
applications supposed to use this ratio or the admins will be
adjusting this ratio? Also should it dynamically updated based on the
workload i.e. as the working set or hot pages grows we want more DRAM
and as cold pages grows we want more PMEM? Basically I am trying to
see if we have something like smart auto-numa balancing to fulfill
your use-case.

> >
> > > Also what happens when PMEM is full? Can the memory migrated to PMEM
> > > be reclaimed (or discarded)?
> >
> > Yep.  The "migration path" can be as long as you want, but once the data
> > hits a "terminal node" it will stop getting migrated and normal discard
> > at the end of reclaim happens.
>
> I recalled I had a hallway conversation with Keith about this in
> LSF/MM. We all agree there should be not a cycle. But, IMHO, I don't
> think exporting migration path to userspace (or letting user to define
> migration path) and having multiple migration stops are good ideas in
> general.
>
> >
