Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18644C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F5F208CC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="oDIPg4xC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfKSQow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:44:52 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35343 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbfKSQov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:44:51 -0500
Received: by mail-qt1-f196.google.com with SMTP id n4so25373241qte.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 08:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zDBiRfFmubevLJV/wK2eb+YrsoC2fdQK9RvQnh7Da5M=;
        b=oDIPg4xCvt+FI8k7NV6RunpeXQu5TzDO2AQca/h0guGU4mgiq1YtDvI6V7LBxsaqq1
         uwfSLg0IcO4TaXVfotXy+i7rNoLMt0PZ6I8K3ThD3VGWQID8Fjl83+9XEhUriUJx3+g0
         0CzUtYPbOLTHDP3iDEv1yEzYoD7v8IpCbpfdiQsdXs/GiCDtuzmhZBqcY/rWbYwSADGR
         +RDSDa21cGwXkTrArBpw1fWESvOV6UzVqxuufjvGN2nrtcT8w6dlObbUyiIMeo9ilkLr
         Oz36AFMlb8Hm5Y3i2tJb2unF7k/PcMNsjY1DWl4W379Z/mzSC61zlxVa4JkS9/CCc4x7
         M/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zDBiRfFmubevLJV/wK2eb+YrsoC2fdQK9RvQnh7Da5M=;
        b=tHTTHRkBdf8Lct9U2krFZWqcFLoWW1LpuzlG/Tzh1uDcl4MPgQ+Ag3XBvMB9nH/Ry9
         eppsdkhW33Ab8FFWEskwU8cHX/fLyKCTk/q6XtcAXQW/4ST8EN70PTCWkuJfixUGtD8k
         ZNnk8FbKKe4S/itJ6nIf7etPPH9OFyntqCVJcRTbtctTVzC0bpDuCzaHnm3OMhHsPd8c
         YFy6cuzsNdKdDQ5/PD0GjZZXQjWVWXmt346ghcc6+pNs7p/2aYxHeGTL7pZMaL8DDiBi
         Q1RtTGkapp7B43oYaGXB3CZ3hd4gs0adgnhWlI2VcQ62O+pa4P49MTPxy71aAfkYhLRU
         DaAQ==
X-Gm-Message-State: APjAAAWolhtR5FH3RU+7AOn0Rkgq3snfZDq0r0VUgiVxO9mL8/f2QcYj
        ofzt8a9jONj7ZdneJqb7z+VRCA==
X-Google-Smtp-Source: APXvYqxgmrLsmMboCARtAfImqR9bUj+VTIOGRHcKUgwpjiS+UrPWRbOHVzpRwyE3DKy85K3bVtEgnQ==
X-Received: by 2002:ac8:724f:: with SMTP id l15mr34060653qtp.234.1574181890609;
        Tue, 19 Nov 2019 08:44:50 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::c7ac])
        by smtp.gmail.com with ESMTPSA id j7sm10286220qkd.46.2019.11.19.08.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 08:44:49 -0800 (PST)
Date:   Tue, 19 Nov 2019 11:44:48 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        shakeelb@google.com, Michal Hocko <mhocko@kernel.org>,
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
Subject: Re: [PATCH v4 3/9] mm/lru: replace pgdat lru_lock with lruvec lock
Message-ID: <20191119164448.GA396644@cmpxchg.org>
References: <1574166203-151975-1-git-send-email-alex.shi@linux.alibaba.com>
 <1574166203-151975-4-git-send-email-alex.shi@linux.alibaba.com>
 <20191119155704.GP20752@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119155704.GP20752@bombadil.infradead.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 07:57:04AM -0800, Matthew Wilcox wrote:
> On Tue, Nov 19, 2019 at 08:23:17PM +0800, Alex Shi wrote:
> > +static inline struct lruvec *lock_page_lruvec_irqsave(struct page *page,
> > +				struct pglist_data *pgdat, unsigned long *flags)
> > +{
> > +	struct lruvec *lruvec = mem_cgroup_page_lruvec(page, pgdat);
> > +
> > +	spin_lock_irqsave(&lruvec->lru_lock, *flags);
> > +
> > +	return lruvec;
> > +}
> 
> This should be a macro, not a function.  You basically can't do this;
> spin_lock_irqsave needs to write to a variable which can then be passed
> to spin_unlock_irqrestore().  What you're doing here will dereference the
> pointer in _this_ function, but won't propagate the modified value back to
> the caller.  I suppose you could do something like this ...

This works because spin_lock_irqsave and local_irq_save() are
macros. It boils down to '*flags = arch_local_irq_save()' in this
function, and therefor does the right thing.

We exploit that in quite a few places:

$ git grep 'spin_lock_irqsave(.*\*flags' | wc -l
39
