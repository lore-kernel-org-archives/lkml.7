Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41571C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E34208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 13:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vK1kBeO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731800AbfFSNAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 09:00:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42552 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfFSNAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 09:00:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id x17so3279999wrl.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 06:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZPtMzsXKkMBsW4PImpt9W2WqZB9B46FVHfm7jHpIiJo=;
        b=vK1kBeO5pB0oPOUcDhnV1dVsLIUNePXri3RCN4CmmeceOkpt5LJZtl2bpaMFrvb+m2
         fDmFVykEDGN3TgFwReYK49KxvnaASFV8BJoWnTrPiF22x3vlJvkhE9qGRBZ07hzZ7MGx
         UtAIbdA9GP6hV5Nq2ijXTipBSW1CaAvPWo6I2dThCp+G0+6yhSE5oaHn4Etb81nfrb6a
         Frn3lBpbHMOukt1QrCdBneWxTJhatukKTde3+3Gy6vejF4hdiJgRuKcg5MThhH6R5pru
         rBP1sJh2IXCfD7RlxWqM1T4Ki2WZ9fkGtyAiNrHdhWD9+P84cS0wOA4KYx6PgTRZKplg
         zmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZPtMzsXKkMBsW4PImpt9W2WqZB9B46FVHfm7jHpIiJo=;
        b=c7ohdZ/0DwjZTRdbLchDTxDWX4c9csrIMNObM9hRecUFx+H82ZezBThhHsJseW/Fml
         vZ8pX7NMRwr2elTbOH9XA7q5KA9XgvEUK6rnlXFRsod6kD8nbYHobg00hVo5S9pfhOA4
         Pp1ij5PrmjF9p264CntjWxDRJt8k/cYjqfSm/xpyEGSZc3AP6OoqOicGCyTZ7ilSNh8n
         V8DfFvtKX6ly1wEF4bDq7vt+z695qDCZrOz8soZYyNCO9xw1J8H7aLn8itZyE11xH1AH
         O98s2xq78yfyRBk99A00KGgo40L2M+1F8474YCRssp/qWNRR9c8NCj4YeVf/49gp+aDm
         RxzQ==
X-Gm-Message-State: APjAAAWLG2XEHk+CVbNYVz/v0/qKUdxk3jAUyMEasWHbX0m6JJM1pCJr
        xUlPKNzW6EG5ThqVQdne4LoiAwgf697LBrTtt3GE
X-Google-Smtp-Source: APXvYqz/0yszyumiNDTcPF0ZTqWHxmKrnjlrkVNhcbqJJZTTIj8bhkNn6GitTiH/zhNwq0HpxdGKX02YeJt+wG74Snk=
X-Received: by 2002:adf:9d81:: with SMTP id p1mr9108405wre.294.1560949217586;
 Wed, 19 Jun 2019 06:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190613045903.4922-1-namit@vmware.com> <20190613045903.4922-4-namit@vmware.com>
 <20190617215750.8e46ae846c09cd5c1f22fdf9@linux-foundation.org>
 <98464609-8F5A-47B9-A64E-2F67809737AD@vmware.com> <8072D878-BBF2-47E4-B4C9-190F379F6221@vmware.com>
In-Reply-To: <8072D878-BBF2-47E4-B4C9-190F379F6221@vmware.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 19 Jun 2019 08:00:05 -0500
Message-ID: <CAErSpo5eiweMk2rfT81Kwnpd=MZsOa01prPo_rAFp-MZ9F2xdQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] resource: Introduce resource cache
To:     Nadav Amit <namit@vmware.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Borislav Petkov <bp@suse.de>,
        Toshi Kani <toshi.kani@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 12:40 AM Nadav Amit <namit@vmware.com> wrote:
>
> > On Jun 17, 2019, at 10:33 PM, Nadav Amit <namit@vmware.com> wrote:
> >
> >> On Jun 17, 2019, at 9:57 PM, Andrew Morton <akpm@linux-foundation.org>=
 wrote:
> >>
> >> On Wed, 12 Jun 2019 21:59:03 -0700 Nadav Amit <namit@vmware.com> wrote=
:
> >>
> >>> For efficient search of resources, as needed to determine the memory
> >>> type for dax page-faults, introduce a cache of the most recently used
> >>> top-level resource. Caching the top-level should be safe as ranges in
> >>> that level do not overlap (unlike those of lower levels).
> >>>
> >>> Keep the cache per-cpu to avoid possible contention. Whenever a resou=
rce
> >>> is added, removed or changed, invalidate all the resources. The
> >>> invalidation takes place when the resource_lock is taken for write,
> >>> preventing possible races.
> >>>
> >>> This patch provides relatively small performance improvements over th=
e
> >>> previous patch (~0.5% on sysbench), but can benefit systems with many
> >>> resources.
> >>
> >>> --- a/kernel/resource.c
> >>> +++ b/kernel/resource.c
> >>> @@ -53,6 +53,12 @@ struct resource_constraint {
> >>>
> >>> static DEFINE_RWLOCK(resource_lock);
> >>>
> >>> +/*
> >>> + * Cache of the top-level resource that was most recently use by
> >>> + * find_next_iomem_res().
> >>> + */
> >>> +static DEFINE_PER_CPU(struct resource *, resource_cache);
> >>
> >> A per-cpu cache which is accessed under a kernel-wide read_lock looks =
a
> >> bit odd - the latency getting at that rwlock will swamp the benefit of
> >> isolating the CPUs from each other when accessing resource_cache.
> >>
> >> On the other hand, if we have multiple CPUs running
> >> find_next_iomem_res() concurrently then yes, I see the benefit.  Has
> >> the benefit of using a per-cpu cache (rather than a kernel-wide one)
> >> been quantified?
> >
> > No. I am not sure how easy it would be to measure it. On the other hand=
er
> > the lock is not supposed to be contended (at most cases). At the time I=
 saw
> > numbers that showed that stores to =E2=80=9Cexclusive" cache lines can =
be as
> > expensive as atomic operations [1]. I am not sure how up to date these
> > numbers are though. In the benchmark I ran, multiple CPUs ran
> > find_next_iomem_res() concurrently.
> >
> > [1] http://sigops.org/s/conferences/sosp/2013/papers/p33-david.pdf
>
> Just to clarify - the main motivation behind the per-cpu variable is not
> about contention, but about the fact the different processes/threads that
> run concurrently might use different resources.

IIUC, the underlying problem is that dax relies heavily on ioremap(),
and ioremap() on x86 takes too long because it relies on
find_next_iomem_res() via the __ioremap_caller() ->
__ioremap_check_mem() -> walk_mem_res() path.

The fact that x86 is the only arch that does this much work in
ioremap() makes me wonder.  Is there something unique about x86
mapping attributes that requires this extra work, or is there some way
this could be reworked to avoid searching the resource map in the
first place?

Bjorn
