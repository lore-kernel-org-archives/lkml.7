Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20736CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 21:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E069D21925
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 21:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYJAofCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506224AbfJRVoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 17:44:24 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34077 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502528AbfJRVoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 17:44:24 -0400
Received: by mail-qk1-f194.google.com with SMTP id f18so6109896qkm.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 14:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f6k6Qcz0XIMruasWL54uOmkX+OaPWhnAxt/2ABdxQoo=;
        b=eYJAofCde05cTsTfaMyE6JeN+7sR2G7MIGdQnW2wOcWHORSY/qB7ldYTVk8whSwnmB
         L8gKSJrf8GAQZ6KwNRjlzol1gOoIMpCr+14U3yY5JayWUT8uz9Hubf9i6wdwchFvG8wW
         KffxTYu1geR2SSmJW5dHX3DZUWn4gxpSWhDluMq5Za5xEyz9+xZTqOM/n+DLBJTuyO6d
         bP1zJpBEQZw+bjeAgNOihhWKAHHWsRoDBxznbeDZpa7s667hVNVykqZu0tblKtAjkZAx
         7B1XHG/eSaCwNarrohViGtTx+/yL6wo9WRmnWkmEnkSujGaqy0b/ZJd+fkT9pgxiq40U
         EpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f6k6Qcz0XIMruasWL54uOmkX+OaPWhnAxt/2ABdxQoo=;
        b=mNpzQCbKwP0ojgDe2b1ABUBWrNx53RzQxauj8x1XFy90ZPZzV4tiARxTeMDfR35sB6
         SWYkKFdHNNTKd3RpIvbatqUDoYxiCeWC9DypM7fY/WEXZi3wYMtb6JfntNA9CUlLU7Zp
         qQ9TIRoXg0/8pNBfwpQfOUL82tcdIR7W9wF97CizGMVEpzCocW7mkoarmaLE1i2JAzAX
         jjrqatq2oXJ8g5mIIdrWJb/THb4zfxQAilNATQqe8iytoJShMZ1DZClR1aPDLJCjMEBQ
         np5I1Ma+wlFxdGm6XxpOfwx4qO8m7kSeFtJJOcI4Mvn/6dFGoRBZ94pcLeskTcXAWN00
         B9tQ==
X-Gm-Message-State: APjAAAV9BeH2nCP5M7qXVTfnojYHTT9ra7XNikxXEU7M5ATyJoZhzkLh
        X0THB3V6WIPavvTaU8O+Hq0xYaRMaawN1H+70ZA=
X-Google-Smtp-Source: APXvYqzDfShYzG1HI5hqk+rLhFI5e5bmwQUYPJHfZa3YoAdsk9Q3Ae7MIx6eul9el2hIln/xMdNwE22M0c2aRg6VzKM=
X-Received: by 2002:a37:f70f:: with SMTP id q15mr10224368qkj.428.1571435061780;
 Fri, 18 Oct 2019 14:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191016221148.F9CCD155@viggo.jf.intel.com> <CALvZod5wdToX6bx4Bnwx9AgrzY3xkmE0OMH61f88hKxeGX+tvA@mail.gmail.com>
 <496566a6-2581-17f4-a4f2-e5def7f97582@intel.com> <CAHbLzkq6cvS4L4DYnr+oyggfXzZTKegfpdNUi_XHA+-67HZYNA@mail.gmail.com>
 <CALvZod4yVgHa6oVjFFhV1rpE0auxdEmu2g2pEBmZ4Z-CP-ru=g@mail.gmail.com>
In-Reply-To: <CALvZod4yVgHa6oVjFFhV1rpE0auxdEmu2g2pEBmZ4Z-CP-ru=g@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 18 Oct 2019 14:44:08 -0700
Message-ID: <CAHbLzkp1cDFizWOvknHUT0N9Y6AtQM9Z_Af9mQpiQ4a=PRexkw@mail.gmail.com>
Subject: Re: [PATCH 0/4] [RFC] Migrate Pages in lieu of discard
To:     Shakeel Butt <shakeelb@google.com>
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

On Thu, Oct 17, 2019 at 3:58 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Thu, Oct 17, 2019 at 10:20 AM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Thu, Oct 17, 2019 at 7:26 AM Dave Hansen <dave.hansen@intel.com> wrote:
> > >
> > > On 10/16/19 8:45 PM, Shakeel Butt wrote:
> > > > On Wed, Oct 16, 2019 at 3:49 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
> > > >> This set implements a solution to these problems.  At the end of the
> > > >> reclaim process in shrink_page_list() just before the last page
> > > >> refcount is dropped, the page is migrated to persistent memory instead
> > > >> of being dropped.
> > > ..> The memory cgroup part of the story is missing here. Since PMEM is
> > > > treated as slow DRAM, shouldn't its usage be accounted to the
> > > > corresponding memcg's memory/memsw counters and the migration should
> > > > not happen for memcg limit reclaim? Otherwise some jobs can hog the
> > > > whole PMEM.
> > >
> > > My expectation (and I haven't confirmed this) is that the any memory use
> > > is accounted to the owning cgroup, whether it is DRAM or PMEM.  memcg
> > > limit reclaim and global reclaim both end up doing migrations and
> > > neither should have a net effect on the counters.
> >
> > Yes, your expectation is correct. As long as PMEM is a NUMA node, it
> > is treated as regular memory by memcg. But, I don't think memcg limit
> > reclaim should do migration since limit reclaim is used to reduce
> > memory usage, but migration doesn't reduce usage, it just moves memory
> > from one node to the other.
> >
> > In my implementation, I just skip migration for memcg limit reclaim,
> > please see: https://lore.kernel.org/linux-mm/1560468577-101178-7-git-send-email-yang.shi@linux.alibaba.com/
> >
> > >
> > > There is certainly a problem here because DRAM is a more valuable
> > > resource vs. PMEM, and memcg accounts for them as if they were equally
> > > valuable.  I really want to see memcg account for this cost discrepancy
> > > at some point, but I'm not quite sure what form it would take.  Any
> > > feedback from you heavy memcg users out there would be much appreciated.
> >
> > We did have some demands to control the ratio between DRAM and PMEM as
> > I mentioned in LSF/MM. Mel Gorman did suggest make memcg account DRAM
> > and PMEM respectively or something similar.
> >
>
> Can you please describe how you plan to use this ratio? Are
> applications supposed to use this ratio or the admins will be
> adjusting this ratio? Also should it dynamically updated based on the
> workload i.e. as the working set or hot pages grows we want more DRAM
> and as cold pages grows we want more PMEM? Basically I am trying to
> see if we have something like smart auto-numa balancing to fulfill
> your use-case.

We thought it should be controlled by admins and transparent to the
end users. The ratio is fixed, but the memory could be moved between
DRAM and PMEM dynamically as long as it doesn't exceed the ratio so
that we could keep warmer data in DRAM and colder data in PMEM.

I talked this about in LSF/MM, please check this out:
https://lwn.net/Articles/787418/

>
> > >
> > > > Also what happens when PMEM is full? Can the memory migrated to PMEM
> > > > be reclaimed (or discarded)?
> > >
> > > Yep.  The "migration path" can be as long as you want, but once the data
> > > hits a "terminal node" it will stop getting migrated and normal discard
> > > at the end of reclaim happens.
> >
> > I recalled I had a hallway conversation with Keith about this in
> > LSF/MM. We all agree there should be not a cycle. But, IMHO, I don't
> > think exporting migration path to userspace (or letting user to define
> > migration path) and having multiple migration stops are good ideas in
> > general.
> >
> > >
