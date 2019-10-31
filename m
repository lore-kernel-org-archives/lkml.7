Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ACDCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8252086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="YhpkCoNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbfJaSuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 14:50:35 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46006 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbfJaSuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:50:35 -0400
Received: by mail-qk1-f196.google.com with SMTP id q70so8062212qke.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 11:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HL/+3TtlUY1A9lUd/n5KjV5oIbKxu8POm6GzA/Cv8p0=;
        b=YhpkCoNhtZs5VLLKPePnAM8a5lfYvgFg/34vWbBuBAldDoGvbi2CvVKJ8y4/il/p+1
         CuLKmvZ7smzN3gY9z2QqP716U8OIEQFad4Ni6dqMkGr7ZGm8cvfywxxCkw9lQGcpGUBi
         iYCOAYWYpQmtOkRgiY66Dpt7+BzecLM5VyxLrNVKU3b1pb3UDfdwgLJSOmiBatIR5liT
         fcDzadRoupTCNGIg7CClpjz/5u4j8MRjvfPWVIRjKB+xhOSyToGd7bcpqwSFL5mxrjoa
         c2aWxokVVj5Wtt6Qz80jQXpzwccDvURy19xxRd8TwXFNBEXWsVBe2YAPGi5hyUKtOVHY
         2QRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HL/+3TtlUY1A9lUd/n5KjV5oIbKxu8POm6GzA/Cv8p0=;
        b=Vauyuzhv71CLdChGZatUHS6VK19Oi62m+tnnHPeO878ucMBuCIxsWagF9UR2MOOT8s
         SToeIokxd1GgtN1c/E1oiIFpEvSnpPSnv90AQF20ItlQltkc3d3tf5IsUrwgyuYTEDvd
         5XD3HA4Ri0HPAZvKzoVu4GdfHhbf0CGR9rT1smtSciSzZkcqt7Y8ELU2tmo842MkjisC
         4DYYZSV9x7EpCmB9BBVMAxRvYbdBKChvwmKH5UM1UwNgdb5ab4Wk3B5/F4nRpu8Sq8yG
         eja7374T5IOKgt+iS9J1lvCUCE015/7lduxliqhp3a7LDrktn4DZuolC4exYql3Bbmpv
         IzYA==
X-Gm-Message-State: APjAAAWoqo+Mfv8iggYKAC0nCrGmQAejRzrsCJOnGivfkXobkwvIxthD
        INRycwq14LJoIf6DVIsfFE/9UQ==
X-Google-Smtp-Source: APXvYqxnmZOz/ielTPeFGF2sbPd5pdCpbBKEFlugYKLvQZP5x9D9kJ3scuNqyAvkcJ5ASoNvEtNpyg==
X-Received: by 2002:a05:620a:1498:: with SMTP id w24mr1167645qkj.170.1572547833941;
        Thu, 31 Oct 2019 11:50:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:d5b5])
        by smtp.gmail.com with ESMTPSA id a28sm2178209qkn.126.2019.10.31.11.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 11:50:33 -0700 (PDT)
Date:   Thu, 31 Oct 2019 14:50:32 -0400
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
Message-ID: <20191031185032.GA2337@cmpxchg.org>
References: <20191018002820.307763-1-guro@fb.com>
 <20191018002820.307763-10-guro@fb.com>
 <20191025194118.GA393641@cmpxchg.org>
 <20191031015238.GA21323@castle.DHCP.thefacebook.com>
 <20191031144151.GB1168@cmpxchg.org>
 <20191031150657.GA31765@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031150657.GA31765@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 03:07:02PM +0000, Roman Gushchin wrote:
> On Thu, Oct 31, 2019 at 10:41:51AM -0400, Johannes Weiner wrote:
> > On Thu, Oct 31, 2019 at 01:52:44AM +0000, Roman Gushchin wrote:
> > > On Fri, Oct 25, 2019 at 03:41:18PM -0400, Johannes Weiner wrote:
> > > > @@ -3117,15 +3095,24 @@ void __memcg_kmem_uncharge(struct page *page, int order)
> > > >  	css_put_many(&memcg->css, nr_pages);
> > > >  }
> > > >  
> > > > -int __memcg_kmem_charge_subpage(struct mem_cgroup *memcg, size_t size,
> > > > -				gfp_t gfp)
> > > > +int obj_cgroup_charge(struct obj_cgroup *objcg, size_t size, gfp_t gfp)
> > > >  {
> > > > -	return try_charge(memcg, gfp, size, true);
> > > > +	int ret;
> > > > +
> > > > +	if (consume_obj_stock(objcg, nr_bytes))
> > > > +		return 0;
> > > > +
> > > > +	ret = try_charge(objcg->memcg, gfp, 1);
> > > > +	if (ret)
> > > > +		return ret;
> > 
> > > The second problem is also here. If a task belonging to a different memcg
> > > is scheduled on this cpu, most likely we will need to refill both stocks,
> > > even if we need only a small temporarily allocation.
> > 
> > Yes, that's a good thing. The reason we have the per-cpu caches in the
> > first place is because most likely the same cgroup will perform
> > several allocations. Both the slab allocator and the page allocator
> > have per-cpu caches for the same reason. I don't really understand
> > what the argument is.
> 
> I mean it seems strange (and most likely will show up in perf numbers)
> to move a page from one stock to another. Is there a reason why do you want
> to ask try_charge() and stock only a single page?
>
> Can we do the following instead?
> 
> 1) add a boolean argument to try_charge() to bypass the consume_stock() call
> at the beginning and just go slow path immediately
> 2) use try_charge() with this argument set to true to fill the objc/subpage
> stock with MEMCG_CHARGE_BATCH pages

No, think this through.

If you have disjunct caches for the page_counter, it means the cache
work cannot be shared. A slab allocation has to hit the page_counter,
and a subsequent page allocation has to hit it again; likewise, a slab
allocation cannot benefit from the caching of prior page allocations.

You're trading cheap, unlocked, cpu-local subtractions against costly
atomic RMW ops on shared cachelines. You also double the amount of
cached per-cpu memory and introduce a layering violation.

Hotpath (bytes cached)

	stacked:				disjunct:
	consume_subpage_stock()			try_charge()
						  consume_subpage_stock()

Warmpath (pages cached)

	stacked:				disjunct:
	consume_subpage_stock()			try_charge()
	  try_charge()				  consume_subpage_stock()
	    consume_stock()			  page_counter_charge()
	refill_subpage_stock()			  refill_subpage_stock()

Coldpath (nothing cached)

	stacked:				disjunct
	consume_subpage_stock()			try_charge()
	  try_charge()				  consume_subpage_stock()
	    consume_stock()			  page_counter_charge()
	    page_counter_charge()		  refill_subpage_stock()
	    refill_stock()
	refill_subpage_stock()
