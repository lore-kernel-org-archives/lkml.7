Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE19DC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E5120730
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hm08IHNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfKRMbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 07:31:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40830 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfKRMbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 07:31:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1uTqX3A6ZeCQPMQGY2vxfYuUrgEAsqvrPYRGzUC2PfE=; b=hm08IHNpYpMkkjKt5slMQ5VyL+
        XZpcURx3zHDvY8niGep8cHLmc2fvdk/YyMPRJdnLyDJ+XRBgx26J2VsQwqPAlHHIa+yVFL61DVzMZ
        98Nvz5BYK+UVLJYZ+QnkX+SaNHJylb8QoMvDcwAJOq+qWeC5SChQsODKh66OdUYYpAfZn8yCF+rJI
        ipf1s4uQpak7zVsLlQTp5pXUyheF1CpOFBtgXz1Iw5LHMrwel4Qr3LGiallXM5GfyEEv0wmlrHTWi
        rTWLaVNleWubK+oCtLZ0T1RQGj6UV0e5UxwQ9GVfZl7Ox1NgVpx7ZElHdoBTXmi2CJ6qtKfECZxJT
        JYSnoh8Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iWgBu-0002mY-5l; Mon, 18 Nov 2019 12:31:38 +0000
Date:   Mon, 18 Nov 2019 04:31:38 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
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
Subject: Re: [PATCH v3 3/7] mm/lru: replace pgdat lru_lock with lruvec lock
Message-ID: <20191118123138.GL20752@bombadil.infradead.org>
References: <1573874106-23802-1-git-send-email-alex.shi@linux.alibaba.com>
 <1573874106-23802-4-git-send-email-alex.shi@linux.alibaba.com>
 <CALvZod7oUmUCk96ATrRwYvrROFNqL1gPGt7fy949M8TMwCQrWA@mail.gmail.com>
 <3f179d84-85e2-bace-2dbc-e77f73883c71@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f179d84-85e2-bace-2dbc-e77f73883c71@linux.alibaba.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 08:23:12PM +0800, Alex Shi wrote:
> 在 2019/11/16 下午3:03, Shakeel Butt 写道:
> >> +reget_lruvec:
> >> +               lruvec = mem_cgroup_page_lruvec(page, pgdat);
> >> +
> >>                 /* If we already hold the lock, we can skip some rechecking */
> >> -               if (!locked) {
> >> -                       locked = compact_lock_irqsave(&pgdat->lru_lock,
> >> -                                                               &flags, cc);
> >> +               if (lruvec != locked_lruvec) {
> >> +                       if (locked_lruvec) {
> >> +                               spin_unlock_irqrestore(&locked_lruvec->lru_lock,
> >> +                                               locked_lruvec->irqflags);
> >> +                               locked_lruvec = NULL;
> >> +                       }
> > What guarantees the lifetime of lruvec? You should read the comment on
> > mem_cgroup_page_lruvec(). Have you seen the patches Hugh had shared?
> > Please look at the  trylock_page_lruvec().
> > 
> 
> Thanks for comments, Shakeel.
> 
> lruvec lifetime is same as memcg, which allocted in mem_cgroup_alloc()->alloc_mem_cgroup_per_node_info()
> I have read Hugh's patchset, even not every lines. But what's point of you here?

I believe Shakeel's point is that here:

struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgdat)
{
...
        memcg = page->mem_cgroup;

there is nothing pinning the memcg, and it could be freed before
dereferencing memcg->nodeinfo in mem_cgroup_page_nodeinfo().
