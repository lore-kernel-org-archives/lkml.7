Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CDDCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 20:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7752321872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 20:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="XKKhV1Oj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfJYUwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 16:52:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34669 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfJYUwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 16:52:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id b128so2395235pfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 13:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zxh1OzG1sSzHAUy26sb63UfIm38Fki5GgDTIvxkjxAA=;
        b=XKKhV1Oj3KXRjwfmXPbF2FqyVlFo+ODP5O2WVCX7F3XzqMkYJmeLPZL67CvdF65SCW
         y86KKIXUn2w8N3N8W6KVPzcp249O/SWe4POcTOkRTCGvEfdc6Eywbp1ho8zth5WiGAes
         7aj1TCVWDi42fxLA9yLTRdm1OJqWjsJwemlqEhb2n3A7xmKJB4WdT80dCXuNiK2+XfT8
         lmDceltOJx39GeB4+unCbyaSdMI6fHPm22TySWjq7j6agOgaa3lTuKP7kCs01rcnREAF
         nD+U8Jl9HuEvLk0ngINl88MocL0d5b5QD4uhNGmmQxcex7EQ9Xgv6kAW/tMeSKxUPCK2
         Cacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zxh1OzG1sSzHAUy26sb63UfIm38Fki5GgDTIvxkjxAA=;
        b=mH4tN+eBEFoMfVgKds9PNkdwou+DcZPU5QBlaodYprJ3d7WdXuaviytihlU8nqmNdq
         hZMMqUrr9vA02PvLkc9IHTwXXba8gRRrjkZNuIDfrlwLou/AeZxOnBG4Qd0Y/FYNbMCi
         7fmiPaLCMHCnzKeuvLUNltsQahsJEGBiFN9wphV8JEoVVjTzh5ec8jhhrU7xQhXYBkW9
         JE+YN0A+sGsM/XlpM2ETbDEsFdnb70j8Wmc0vvp7WFc+aMnfk/m1P9sfU7hlx8DCp3M1
         7k8w4CPh1dXM+yhSj05Es/zsVeB07tG/bigldBCDCFEQT2pTJyVMglsmnCdR7NJbMj1v
         meZw==
X-Gm-Message-State: APjAAAXxIoXtiu98V9ZkXc699vpQtrtdkhnCO3waE6GjJAM7uhQ+bHfM
        pPt25+FFnnNF6X0iOlllMs32sQ==
X-Google-Smtp-Source: APXvYqyIzshTgnZ8NZSL6NFQcEW0E90cm6s9Qp3+WD+7UHDepE3Je97CkXYtKRaZhbQwcs3pAxHMQA==
X-Received: by 2002:a63:1f4e:: with SMTP id q14mr6808030pgm.144.1572036759831;
        Fri, 25 Oct 2019 13:52:39 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::7fa3])
        by smtp.gmail.com with ESMTPSA id l3sm4422260pgi.57.2019.10.25.13.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 13:52:39 -0700 (PDT)
Date:   Fri, 25 Oct 2019 16:52:37 -0400
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
Message-ID: <20191025205237.GA2010@cmpxchg.org>
References: <20191018002820.307763-1-guro@fb.com>
 <20191018002820.307763-10-guro@fb.com>
 <20191025194118.GA393641@cmpxchg.org>
 <20191025200020.GA8325@castle.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025200020.GA8325@castle.DHCP.thefacebook.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 08:00:32PM +0000, Roman Gushchin wrote:
> On Fri, Oct 25, 2019 at 03:41:18PM -0400, Johannes Weiner wrote:
> > On Thu, Oct 17, 2019 at 05:28:13PM -0700, Roman Gushchin wrote:
> > > +static inline struct kmem_cache *memcg_slab_pre_alloc_hook(struct kmem_cache *s,
> > > +						struct mem_cgroup **memcgp,
> > > +						size_t size, gfp_t flags)
> > > +{
> > > +	struct kmem_cache *cachep;
> > > +
> > > +	cachep = memcg_kmem_get_cache(s, memcgp);
> > > +	if (is_root_cache(cachep))
> > > +		return s;
> > > +
> > > +	if (__memcg_kmem_charge_subpage(*memcgp, size * s->size, flags)) {
> > > +		mem_cgroup_put(*memcgp);
> > > +		memcg_kmem_put_cache(cachep);
> > > +		cachep = NULL;
> > > +	}
> > > +
> > > +	return cachep;
> > > +}
> > > +
> > >  static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> > >  					      struct mem_cgroup *memcg,
> > >  					      size_t size, void **p)
> > >  {
> > >  	struct mem_cgroup_ptr *memcg_ptr;
> > > +	struct lruvec *lruvec;
> > >  	struct page *page;
> > >  	unsigned long off;
> > >  	size_t i;
> > > @@ -439,6 +393,11 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
> > >  			off = obj_to_index(s, page, p[i]);
> > >  			mem_cgroup_ptr_get(memcg_ptr);
> > >  			page->mem_cgroup_vec[off] = memcg_ptr;
> > > +			lruvec = mem_cgroup_lruvec(page_pgdat(page), memcg);
> > > +			mod_lruvec_memcg_state(lruvec, cache_vmstat_idx(s),
> > > +					       s->size);
> > > +		} else {
> > > +			__memcg_kmem_uncharge_subpage(memcg, s->size);
> > >  		}
> > >  	}
> > >  	mem_cgroup_ptr_put(memcg_ptr);
> > 
> > The memcg_ptr as a collection vessel for object references makes a lot
> > of sense. But this code showcases that it should be a first-class
> > memory tracking API that the allocator interacts with, rather than
> > having to deal with a combination of memcg_ptr and memcg.
> > 
> > In the two hunks here, on one hand we charge bytes to the memcg
> > object, and then handle all the refcounting through a different
> > bucketing object. To support that in the first place, we have to
> > overload the memcg API all the way down to try_charge() to support
> > bytes and pages. This is difficult to follow throughout all layers.
> > 
> > What would be better is for this to be an abstraction layer for a
> > subpage object tracker that sits on top of the memcg page tracker -
> > not unlike the page allocator and the slab allocators themselves.
> > 
> > And then the slab allocator would only interact with the subpage
> > object tracker, and the object tracker would deal with the memcg page
> > tracker under the hood.
> 
> Yes, the idea makes total sense to me. I'm not sure I like the new naming
> (I have to spend some time with it first), but the idea of moving
> stocks and leftovers to the memcg_ptr/obj_cgroup level is really good.

I'm not set on the naming, it was just to illustrate the
structuring. I picked something that has cgroup in it, is not easily
confused with the memcg API, and shortens nicely to local variable
names (obj_cgroup -> objcg), but I'm all for a better name.

> I'll include something based on your proposal into the next version
> of the patchset.

Thanks, looking forward to it.
