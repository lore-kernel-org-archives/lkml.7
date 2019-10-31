Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEC0CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1FF2087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="yeVMDHjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfJaOly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 10:41:54 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43780 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbfJaOly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:41:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id c26so8849558qtj.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 07:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=csb+zRMQBtvVYv4Y8llA9Onr/2/OJpu+BIiFzZxkvM4=;
        b=yeVMDHjP1642J8Lrmf2nlscQjkVX+HMFEnXHaBQp+58ZNpohl02lmIz6Pb2pCkRgZJ
         XaPmIVXM/18UjWtkfibSRqdAyY39zgL7Ax2m3krqWVX64Os/3KtJyUIGw9d6ek1iRoFr
         QkpGj6qqn23ToCRQhGdafdUlNJ+cZ3LXKFcMtynYlOM2O/VzhdkdzlNVLDYijGEiaG4J
         amPsYtLXkyLbWXJvK+i6X33I0htjM8xnAmKDKNE+0s2CDN9xQde4KyHufR5yR1E4k/2i
         N3nUBj/EvEYKJG0+O/VedKTifQyTVRQke0v9IHMr3/rTKkNMqz85nyK81JsSDUkAbvwM
         NRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=csb+zRMQBtvVYv4Y8llA9Onr/2/OJpu+BIiFzZxkvM4=;
        b=NF9w/OwZi/7cmfyUodvFHEb7ErLiOg14k/jaRdZmfEjLRZCKniIdmAT5Z2uaxLH0zl
         avO3BlMjpVU65fYZ7HLE1ACtgDMF9Tkhp6gwP0gk1xxq+ibaZVUN+QLZtQSTLk2m6/Lu
         +l1uLAR1aspkcg9xWDW6VbTNMWOX7H1wrQDb8KM8nPcUnh0np6z0YGA191lEJ8Qth3xF
         nnk8a6di+tWHug8EDWEIrprwZnEgpyIejfA5dXeXhCFbCVt8B8i4/j9y7K7UvWaqqlTV
         NHtkM+gZgaEGcd9FU9O8jVjORX1K+p59xY+kYBqkb6bQ+lb5oW76KIUYN58/ErZRYCBm
         dcgQ==
X-Gm-Message-State: APjAAAXNtgiizeOWp1ay61Vdl8SiCiVc7gMvYyMlyPt/H5NY7WUeW8JE
        UUJ4dtabF1DczTa/lN8Q8TMq1w==
X-Google-Smtp-Source: APXvYqwx0FMTZTUqJiPpFdGnDITXqzkksvUKqXBAVF9Z+1zk96bFsmQED3z9795KXVCmTDArZJj+Xg==
X-Received: by 2002:ac8:92a:: with SMTP id t39mr5970709qth.170.1572532912816;
        Thu, 31 Oct 2019 07:41:52 -0700 (PDT)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id o12sm1896028qkk.54.2019.10.31.07.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 07:41:52 -0700 (PDT)
Date:   Thu, 31 Oct 2019 10:41:51 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 09/16] mm: memcg/slab: charge individual slab objects
 instead of pages
Message-ID: <20191031144151.GB1168@cmpxchg.org>
References: <20191018002820.307763-1-guro@fb.com>
 <20191018002820.307763-10-guro@fb.com>
 <20191025194118.GA393641@cmpxchg.org>
 <20191031015238.GA21323@castle.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031015238.GA21323@castle.DHCP.thefacebook.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 01:52:44AM +0000, Roman Gushchin wrote:
> On Fri, Oct 25, 2019 at 03:41:18PM -0400, Johannes Weiner wrote:
> > @@ -3117,15 +3095,24 @@ void __memcg_kmem_uncharge(struct page *page, int order)
> >  	css_put_many(&memcg->css, nr_pages);
> >  }
> >  
> > -int __memcg_kmem_charge_subpage(struct mem_cgroup *memcg, size_t size,
> > -				gfp_t gfp)
> > +int obj_cgroup_charge(struct obj_cgroup *objcg, size_t size, gfp_t gfp)
> >  {
> > -	return try_charge(memcg, gfp, size, true);
> > +	int ret;
> > +
> > +	if (consume_obj_stock(objcg, nr_bytes))
> > +		return 0;
> > +
> > +	ret = try_charge(objcg->memcg, gfp, 1);
> > +	if (ret)
> > +		return ret;

> The second problem is also here. If a task belonging to a different memcg
> is scheduled on this cpu, most likely we will need to refill both stocks,
> even if we need only a small temporarily allocation.

Yes, that's a good thing. The reason we have the per-cpu caches in the
first place is because most likely the same cgroup will perform
several allocations. Both the slab allocator and the page allocator
have per-cpu caches for the same reason. I don't really understand
what the argument is.

> > +
> > +	refill_obj_stock(objcg, PAGE_SIZE - size);
> 
> And the third problem is here. Percpu allocations (on which accounting I'm
> working right now) can be larger than a page.

How about this?

	nr_pages = round_up(size, PAGE_SIZE);
	try_charge(objcg->memcg, nr_pages);
	refill_obj_stock(objcg, size % PAGE_SIZE);

> This is fairly small issue in comparison to the first one. But it illustrates
> well the main point: we can't simple get a page from the existing API and
> sublease it in parts. The problem is that we need to break the main principle
> that a page belongs to a single memcg.

We can change the underlying assumptions of the existing API if they
are no longer correct. We don't have to invent a parallel stack.
