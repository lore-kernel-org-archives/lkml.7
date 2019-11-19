Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACF5C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5F922309
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nLO0j7Gg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfKSQts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:49:48 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40189 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfKSQtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:49:47 -0500
Received: by mail-ot1-f65.google.com with SMTP id m15so18466468otq.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 08:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xTSI3K4thH+dUGZBU/j6hslBPPzRGNTIfM5lXqXhgmU=;
        b=nLO0j7Gg0I4t2Cwt7ZY4AmeHh+8e+5HrEz65UbBvjuE5gjjl3g0SEF2i93MCVB5gXA
         lUjFrjYHHZ7qMKnUMS2tkQoUfe4RU1yx/FVi/vXctllao1EVx0erNqphH2gvvXJ5UpVA
         /hKrFLc5Xolw/tcSpWvt4E0vbM4C/jjPTyEBxD0otVIUPDDIx0YJqEFYifVydKMdXpCO
         gRUeqP0Sy82tWw8eQvh3FsOyJCZisrf6vHeAPfBaszfGzxBfr+lRZ7e/jZVslvWlTRzS
         0QSvsOKyOb9RJ4mxNzlRl/c39ddBbBmkFzZ9JREw7bhXl1xIsXnIx2f1K0nQ8iQIXiad
         UdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xTSI3K4thH+dUGZBU/j6hslBPPzRGNTIfM5lXqXhgmU=;
        b=AxjeOOOLdO5VH1vXm092VqM7QFXY/FHZ7tM4T5s6bsN/BUxj+McJ8FL1dJIjyR3yeb
         cVC3A5yjxYC4KHY4xVRWc54TilUawGJ71ak2Gv7n9m22PLMZ3E1tEcSPs4ZacIQbPmqP
         PlYaFO83zKcv7OZn/VDrZJMa4VQeJeKghs76ccxai7FVWlDoLiUBI+mlivRPVMrcL/wL
         wTEv+EnEYFksQDeK+JFPehrGKZD/k/t8nsPPwLlFwsrEEVXVlG8esFfTEcbFhYfcotqn
         f2dL/Jldnz5HUor2MaskJiNe50h8vC3TWFMFXetNGXGPXpy4eN+luVB2EQ3r0GLlhpjo
         WSIQ==
X-Gm-Message-State: APjAAAWLWck0pY+V6g+0JpDSp6tMq/fbaMLbMfQy7X1w1oOSG9PpeRsR
        nbipRN1JdGqvdrzXEtuKrV/zVK6eSY9SdYM5p2mzrg==
X-Google-Smtp-Source: APXvYqwAE11CUIy9LnUeViWxpKB9m7ISi4+FxiJw+lLBnb3jjNIWkNkBlbwyd+Z1Vsn6B0MkoMl6OcFbHjQiLwALxLU=
X-Received: by 2002:a9d:66d9:: with SMTP id t25mr4780662otm.30.1574182186119;
 Tue, 19 Nov 2019 08:49:46 -0800 (PST)
MIME-Version: 1.0
References: <1574166203-151975-1-git-send-email-alex.shi@linux.alibaba.com> <1574166203-151975-4-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1574166203-151975-4-git-send-email-alex.shi@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 19 Nov 2019 08:49:34 -0800
Message-ID: <CALvZod7QDv4UtS9Xi4EPqynfUxe8qP3qJjrwxHEb4EnZO27kfg@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] mm/lru: replace pgdat lru_lock with lruvec lock
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        swkhack <swkhack@gmail.com>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Colin Ian King <colin.king@canonical.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 4:24 AM Alex Shi <alex.shi@linux.alibaba.com> wrote=
:
>
> This patchset move lru_lock into lruvec, give a lru_lock for each of
> lruvec, thus bring a lru_lock for each of memcg per node.
>
> This is the main patch to replace per node lru_lock with per memcg
> lruvec lock.
>
> We introduce function lock_page_lruvec, it's same as vanilla pgdat lock
> when memory cgroup unset, w/o memcg, the function will keep repin the
> lruvec's lock to guard from page->mem_cgroup changes in page
> migrations between memcgs. (Thanks Hugh Dickins and Konstantin
> Khlebnikov reminder on this. Than the core logical is same as their
> previous patchs)
>
> According to Daniel Jordan's suggestion, I run 64 'dd' with on 32
> containers on my 2s* 8 core * HT box with the modefied case:
>   https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/=
tree/case-lru-file-readtwice
>
> With this and later patches, the dd performance is 144MB/s, the vanilla
> kernel performance is 123MB/s. 17% performance increased.
>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Chris Down <chris@chrisdown.name>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: swkhack <swkhack@gmail.com>
> Cc: "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Colin Ian King <colin.king@canonical.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Nikolay Borisov <nborisov@suse.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> Cc: Yafang Shao <laoar.shao@gmail.com>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: cgroups@vger.kernel.org

This patch (and series) still have unsafe accesses to lruvec.

Alex, I was hoping that you would drop this series in favor of Hugh's
patches. Anyways I will post Hugh patches for review to be considered
for 5.6. I will run a couple of performance experiments.

Shakeel
