Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7290FC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 16:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DA0206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 16:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="D4nk0Sio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfKRQL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 11:11:29 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:46270 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfKRQL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 11:11:29 -0500
Received: by mail-qv1-f65.google.com with SMTP id w11so6746101qvu.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 08:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j0SqAQT8llYIw4e/49l3a9ohNbFeVl5zPNeEm/Wp4s0=;
        b=D4nk0Siou5s/cqdoqRqvYGa8zjueKxO+SjyVZm6/zT83sFfDUd2SnGh1k9QnwDRDrx
         CH6WGIyRKE0rF+mnWZMd8pHyYqF+YLfdNHGtqMo/fOoR4AXXtBL0Cj7J0CMVPjVHqH1A
         5p89M+K8M+qZDQsxCDXAtPbwLRRrKzSr3XyWyZ95bNw/QI/aHZbmCL8249BGxWEd1uNi
         NmxnkCqIoZnTJ4pMiiNzMsyDF7nPDvcgoyhCtivfuijsRgBIc92NpnNww90o0JoHuJom
         W1UH6Cibz2Uc69M0LwpMJivjKj1PUsQuKOhtJZg9yyVl2bQ6Et0jog0H3A2vuFx+O7mN
         fvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j0SqAQT8llYIw4e/49l3a9ohNbFeVl5zPNeEm/Wp4s0=;
        b=ht/Ap/WIIRDsWcm6JWRjuV3YaA5AcEKdlqNwWVrPRXHe2FEIl7SLXcSmyjk7/LLhnV
         fmInNzmFNVOOes3SGYU1SVT4Q+fXdpuxhdNfezoK8u2FFmhQ2g+NFVUigXjgfxo1Y3zk
         PG6+DKQuEPTKore5JAv/rSR+PltirwY809y5U7kF0Vq6NY+Lw59ftGXK50Qw872wHgcD
         K3BgS843tGEMsUA6TaYiaiMbfJzvGl30D2LZApXSJ8yeH5w0MClkTQO0D2eQfmVQlIky
         HwGVmeTDKK0u1AH0Zdl/2hJZ00BqSlbAtz8ufdPk9tZgKL3tr5EyWiFN+aRUVBFspK2F
         zo9w==
X-Gm-Message-State: APjAAAVfp6hkpLxJOw5kE+UJ64zB8MfHXb6yHQyllW5c/sceBa92p1IP
        qGeTJ6QipgcUW1Wy08YKusqDHg==
X-Google-Smtp-Source: APXvYqyvK7ktIXppKh1dR704A5mqOwl/diTd0Fr4GO7WaTkdgkBup/M3IW20e4uuZ1GlgXiw9mZ32w==
X-Received: by 2002:a0c:fa50:: with SMTP id k16mr10774204qvo.172.1574093487963;
        Mon, 18 Nov 2019 08:11:27 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:1113])
        by smtp.gmail.com with ESMTPSA id i4sm10125597qtp.57.2019.11.18.08.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 08:11:26 -0800 (PST)
Date:   Mon, 18 Nov 2019 11:11:26 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
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
Message-ID: <20191118161126.GB365174@cmpxchg.org>
References: <1573874106-23802-1-git-send-email-alex.shi@linux.alibaba.com>
 <1573874106-23802-4-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573874106-23802-4-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2019 at 11:15:02AM +0800, Alex Shi wrote:
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 62470325f9bc..cf274739e619 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1246,6 +1246,42 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
>  	return lruvec;
>  }
>  
> +struct lruvec *lock_page_lruvec_irq(struct page *page,
> +					struct pglist_data *pgdat)
> +{
> +	struct lruvec *lruvec;
> +
> +again:
> +	lruvec = mem_cgroup_page_lruvec(page, pgdat);
> +	spin_lock_irq(&lruvec->lru_lock);

This isn't safe. Nothing prevents the page from being moved to a
different memcg in between these two operations, and the lruvec having
been freed by the time you try to acquire the spinlock.

You need to use the rcu lock to dereference page->mem_cgroup and its
lruvec when coming from the page like this.

You also need to use page_memcg_rcu() to insert the appropriate
lockless access barriers, which mem_cgroup_page_lruvec() does not do
since it's designed for use with pgdat->lru_lock.
