Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9813EC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6117E20862
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="ilkHUpp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389204AbfIQIuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 04:50:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40845 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbfIQIuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:50:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id b24so2080538wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 01:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/VonGSSqqMDxfF4QwP1WKI+1bEgxLGoOBgLkXqBtfQA=;
        b=ilkHUpp/PYb0KHuZDcHzX1Ounlux5/YOswWqF8JQI4guW6HyXLoFNHBxUeNmgS4wgj
         K9dFh8cZLWZ/BdmJbF43N1GQBPg6kjKVLrRXRYjgVYTnMrRDG220nh4uH/Ae07miHenH
         41eiYv/vkY2/0nZDXcre85bHwnoMGFfGzSUqgb4/Zr6YXyN+4KRF5kOyRV10MSKNKVVE
         isggylYG8cxJ7Bqb3NED3KeUBFmz3uLAa7onauWOba53gvEICMBj/MDYo+Y8qIHRHc1O
         PMMWfgl1quOU1X7L9GHDhmzpPIchZUCWJ1X84ePdTR8qDIu1hS7xXVb+9iSwfCNp03eK
         vohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/VonGSSqqMDxfF4QwP1WKI+1bEgxLGoOBgLkXqBtfQA=;
        b=AhhB7iNiPwQd135JTaMDSCNtPMjpLUJdBogulC73cE+PfXUkc8a75LhL0PEO5KCwpq
         K/GB/CGfprpsyvrttiDfbEj5n7bK+PwHHeFgYzhAr3Ebv4RiM3RiFJZyYOCDgqrF347F
         zqJz8gYyGG+R0yw78ns/x/nVv0gjgYrcmn3MVgME08pxarEQ6cMIxDIFV/s80AjsGAo3
         bPMeG0mtbGuiOgMEmFedoOtfUL2co1Kbm3rkQH40+BCLdQzRi85KbUEhgvJ1d+yp8nao
         UsdyU626g9XLmqV8IkaHNqVhUwCatnsxOK+5ntR5kb+jsgp5OI1zJMCrY5N7BVkzAvDP
         ePvA==
X-Gm-Message-State: APjAAAWG2Ao+xFTlXqzm6Qd7BUgolEZLTtxXXyOsSHiiJNRCkHE2ZCI7
        dX/oqZvUpLwCVdVwmHLtePv5TzF11sek5A==
X-Google-Smtp-Source: APXvYqxmUuN4vsQBrM1hohQXVK4AD/ImfVSsKnQMjN5EZZTIlBaWxTXWVN88fT67M4dyPna59whj+g==
X-Received: by 2002:a7b:c949:: with SMTP id i9mr2307693wml.136.1568710212091;
        Tue, 17 Sep 2019 01:50:12 -0700 (PDT)
Received: from localhost (p4FC6BBBF.dip0.t-ipconnect.de. [79.198.187.191])
        by smtp.gmail.com with ESMTPSA id x6sm2904730wmf.35.2019.09.17.01.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 01:50:11 -0700 (PDT)
Date:   Tue, 17 Sep 2019 10:50:04 +0200
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH RFC 01/14] mm: memcg: subpage charging API
Message-ID: <20190917085004.GA1486@cmpxchg.org>
References: <20190905214553.1643060-1-guro@fb.com>
 <20190905214553.1643060-2-guro@fb.com>
 <20190916125611.GB29985@cmpxchg.org>
 <20190917022713.GB8073@castle.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917022713.GB8073@castle.DHCP.thefacebook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 02:27:19AM +0000, Roman Gushchin wrote:
> On Mon, Sep 16, 2019 at 02:56:11PM +0200, Johannes Weiner wrote:
> > On Thu, Sep 05, 2019 at 02:45:45PM -0700, Roman Gushchin wrote:
> > > Introduce an API to charge subpage objects to the memory cgroup.
> > > The API will be used by the new slab memory controller. Later it
> > > can also be used to implement percpu memory accounting.
> > > In both cases, a single page can be shared between multiple cgroups
> > > (and in percpu case a single allocation is split over multiple pages),
> > > so it's not possible to use page-based accounting.
> > > 
> > > The implementation is based on percpu stocks. Memory cgroups are still
> > > charged in pages, and the residue is stored in perpcu stock, or on the
> > > memcg itself, when it's necessary to flush the stock.
> > 
> > Did you just implement a slab allocator for page_counter to track
> > memory consumed by the slab allocator?
> 
> :)
> 
> > 
> > > @@ -2500,8 +2577,9 @@ void mem_cgroup_handle_over_high(void)
> > >  }
> > >  
> > >  static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> > > -		      unsigned int nr_pages)
> > > +		      unsigned int amount, bool subpage)
> > >  {
> > > +	unsigned int nr_pages = subpage ? ((amount >> PAGE_SHIFT) + 1) : amount;
> > >  	unsigned int batch = max(MEMCG_CHARGE_BATCH, nr_pages);
> > >  	int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
> > >  	struct mem_cgroup *mem_over_limit;
> > > @@ -2514,7 +2592,9 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> > >  	if (mem_cgroup_is_root(memcg))
> > >  		return 0;
> > >  retry:
> > > -	if (consume_stock(memcg, nr_pages))
> > > +	if (subpage && consume_subpage_stock(memcg, amount))
> > > +		return 0;
> > > +	else if (!subpage && consume_stock(memcg, nr_pages))
> > >  		return 0;
> > 
> > The layering here isn't clean. We have an existing per-cpu cache to
> > batch-charge the page counter. Why does the new subpage allocator not
> > sit on *top* of this, instead of wedged in between?
> > 
> > I think what it should be is a try_charge_bytes() that simply gets one
> > page from try_charge() and then does its byte tracking, regardless of
> > how try_charge() chooses to implement its own page tracking.
> > 
> > That would avoid the awkward @amount + @subpage multiplexing, as well
> > as annotating all existing callsites of try_charge() with a
> > non-descript "false" parameter.
> > 
> > You can still reuse the stock data structures, use the lower bits of
> > stock->nr_bytes for a different cgroup etc., but the charge API should
> > really be separate.
> 
> Hm, I kinda like the idea, however there is a complication: for the subpage
> accounting the css reference management is done in a different way, so that
> all existing code should avoid changing the css refcounter. So I'd need
> to pass a boolean argument anyway.

Can you elaborate on the refcounting scheme? I don't quite understand
how there would be complications with that.

Generally, references are held for each page that is allocated in the
page_counter. try_charge() allocates a batch of css references,
returns one and keeps the rest in stock.

So couldn't the following work?

When somebody allocates a subpage, the css reference returned by
try_charge() is shared by the allocated subpage object and the
remainder that is kept via stock->subpage_cache and stock->nr_bytes
(or memcg->nr_stocked_bytes when the percpu cache is reset).

When the subpage objects are freed, you'll eventually have a full page
again in stock->nr_bytes, at which point you page_counter_uncharge()
paired with css_put(_many) as per usual.

A remainder left in old->nr_stocked_bytes would continue to hold on to
one css reference. (I don't quite understand who is protecting this
remainder in your current version, actually. A bug?)

Instead of doing your own batched page_counter uncharging in
refill_subpage_stock() -> drain_subpage_stock(), you should be able to
call refill_stock() when stock->nr_bytes adds up to a whole page again.

Again, IMO this would be much cleaner architecture if there was a
try_charge_bytes() byte allocator that would sit on top of a cleanly
abstracted try_charge() page allocator, just like the slab allocator
is sitting on top of the page allocator - instead of breaking through
the abstraction layer of the underlying page allocator.
