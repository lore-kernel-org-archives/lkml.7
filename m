Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47414C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01ACD206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="WHbzFAaC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbfC2OUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:20:37 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:39890 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbfC2OUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:20:37 -0400
Received: by mail-yb1-f193.google.com with SMTP id b88so898708ybi.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 07:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EdPl8wx9CT7eKW049LQPVwPDMTDYASSuYhqDUDUeQzw=;
        b=WHbzFAaCZ1Rp2mTxkykmaArTeY2OaUeosmIrcGXV6ktIDfrWsXSIgYtiWu1un+hAbq
         R4fjzyXoQYPoBkdpWu8lE5RFf/92pzrIyLJAs1KhZpiS8FXEYL73m+ZiH2Wh9j4TK6L8
         abyoN8VPyblI/VtDjAnujRSq46h8XrDiB+HgtCVJXHgFMPEXsnIgZ5waKIYUioG+S2+7
         UjEK1+iW2ihbPWGBu0fPbPR4P9aj6GuIHj7WKeAVee1sAuoYZe/+KpdLS1/Ueybal7ND
         4zOSk+UB/lR7hJC1MJLlzwGi9K3tHoDOTkGc6HytXXOWYeoRoVzKe+CK88Tl/AD/CBET
         AFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EdPl8wx9CT7eKW049LQPVwPDMTDYASSuYhqDUDUeQzw=;
        b=TaPT6p6upE8nNcMK1SlHdynm0KDeJQJsKmhRmacANH8xkLTg8rwBkXZ3ttYOB8IIj+
         fqWcAYIaDdtRb1Uu1b1J0biuavwU2F4yJaU5svE1HxOklG/TYhcK/pCnCDeMrdijK61H
         jQ1nosi16VbeG4GkWGFhfRYq8hg1vZkoXgmt8qA4CW8D4N+Z9qzTrQWfvrxzWe09oUCp
         1HBYxHmSuj/PY1SRul/OZsUDUzKcj8Px5KdiisOZLiC/nOeEA2GhfQG3P6KdqR+YcC7P
         oMjv/GIm2eVL6V6NSBlx+RUtLLRpzFCvdDLAfah+J+IHUu0QEcRHJkCehmejeVQLN6xN
         oS1A==
X-Gm-Message-State: APjAAAVhnX7D9xOmoYs9AcA3heR/FeXUBAv0cJ+xqHbWMX2PzI3jQ4H2
        luUxRiGu58vPOSMMFB8GjA8Guw==
X-Google-Smtp-Source: APXvYqxr/aJg2GTWvfMraC5VoXtkFI3s/QclcSjNZmIybpu9Sgmnn/PE4/h4exoDcU0bbQePdrrmDg==
X-Received: by 2002:a25:1482:: with SMTP id 124mr41366879ybu.421.1553869236276;
        Fri, 29 Mar 2019 07:20:36 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::20d1])
        by smtp.gmail.com with ESMTPSA id p75sm643875ywg.36.2019.03.29.07.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 07:20:35 -0700 (PDT)
Date:   Fri, 29 Mar 2019 10:20:33 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ben Gardon <bgardon@google.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Linux MM <linux-mm@kvack.org>, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm, kvm: account kvm_vcpu_mmap to kmemcg
Message-ID: <20190329142033.GB2474@cmpxchg.org>
References: <20190329012836.47013-1-shakeelb@google.com>
 <20190329023552.GV10344@bombadil.infradead.org>
 <CALvZod5GiC1+HB3_Mm969Qbgj7s6-unbd141uP5pnMbsufS+mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5GiC1+HB3_Mm969Qbgj7s6-unbd141uP5pnMbsufS+mg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 08:59:45PM -0700, Shakeel Butt wrote:
> On Thu, Mar 28, 2019 at 7:36 PM Matthew Wilcox <willy@infradead.org> wrote:
> > I don't understand why we need a PageKmemcg anyway.  We already
> > have an entire pointer in struct page; can we not just check whether
> > page->mem_cgroup is NULL or not?
> 
> PageKmemcg is for kmem while page->mem_cgroup is used for anon, file
> and kmem memory. So, page->mem_cgroup can not be used for NULL check
> unless we unify them. Not sure how complicated would that be.

A page flag warrants research into this.

The only reason we have PageKmemcg() is because of the way we do
memory type accounting at uncharge time:

	if (!PageKmemcg(page)) {
		unsigned int nr_pages = 1;

		if (PageTransHuge(page)) {
			nr_pages <<= compound_order(page);
			ug->nr_huge += nr_pages;
		}
		if (PageAnon(page))
			ug->nr_anon += nr_pages;
		else {
			ug->nr_file += nr_pages;
			if (PageSwapBacked(page))
				ug->nr_shmem += nr_pages;
		}
		ug->pgpgout++;
	} else {
		ug->nr_kmem += 1 << compound_order(page);
		__ClearPageKmemcg(page);
	}

	[...]

	if (!mem_cgroup_is_root(ug->memcg)) {
		page_counter_uncharge(&ug->memcg->memory, nr_pages);
		if (do_memsw_account())
			page_counter_uncharge(&ug->memcg->memsw, nr_pages);
		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && ug->nr_kmem)
			page_counter_uncharge(&ug->memcg->kmem, ug->nr_kmem);
		memcg_oom_recover(ug->memcg);
	}

	local_irq_save(flags);
	__mod_memcg_state(ug->memcg, MEMCG_RSS, -ug->nr_anon);
	__mod_memcg_state(ug->memcg, MEMCG_CACHE, -ug->nr_file);
	__mod_memcg_state(ug->memcg, MEMCG_RSS_HUGE, -ug->nr_huge);
	__mod_memcg_state(ug->memcg, NR_SHMEM, -ug->nr_shmem);
	__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);

But nothing says we have to have all these duplicate private counters,
or update them this late in the page's lifetime. The generic vmstat
counters in comparison are updated when 1) we know the page is going
away but 2) we still know the page type. We can do the same here.

We can either

a) Push up the MEMCG_RSS, MEMCG_CACHE etc. accounting sites to before
   the pages are uncharged, when the page type is still known, but
   page->mem_cgroup is exclusive, i.e. when they are deleted from page
   cache or when their last pte is going away. This would be very
   close to where the VM updates NR_ANON_MAPPED, NR_FILE_PAGES etc.

or

b) Tweak the existing NR_ANON_MAPPED, NR_FILE_PAGES, NR_ANON_THPS
   accounting sites to use the lruvec_page_state infra and get rid of
   the duplicate MEMCG_RSS, MEMCG_CACHE counters completely.

   These sites would need slight adjustments, as they are sometimes
   before commit_charge() set up page->mem_cgroup, but it doesn't look
   too complicated to fix that ordering.

The latter would be a great cleanup, and frankly one that is long
overdue. There is no good reason for all this duplication. We'd not
only get rid of the private counters and the duplicate accounting
sites, it would drastically simplify charging and uncharging, and it
would even obviate the need for a separate kmem (un)charge path.

[ The cgroup1 memcg->kmem thing is the odd-one-out, but I think this
  is complete legacy at this point and nobody is actively setting
  limits on that counter anyway. We can break out an explicit v1-only
  mem_cgroup_charge_legacy_kmem(), put it into the currently accounted
  callsites for compatibility, and not add any new ones. ]
