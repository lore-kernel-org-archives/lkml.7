Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11F5C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 09:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFAA20643
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 09:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hcq6EH2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLXJeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 04:34:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35998 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfLXJeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 04:34:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so2008311wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 01:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UtyDToTRhseCzK9/TotzxKj/q4ckgBV14Zj5miZuzXk=;
        b=hcq6EH2DoFyWxrgAJ1RenPJkLrhXcIWVRTJEXSurFJC9Nicpki94e4VmuYqcP9dnMC
         WdUfqxRl18WerN3FOhJdh4d0U3V6x5le1fDdalDYEZFdyb4H85w4zid/wYeTmyHxD8aZ
         cfYDaF0NOJvjnB5KJWByuZE1kR6JwgarvEvgLrPiwC5j2eYAW74v1oQVgH+1+4OY400z
         czcfooZ6sf4Gn+VCW1C/y3YvzhlyTMTVhjW+Zu2HWQTyYHoxCw+f9CV6u+NQLRGFFUi5
         e6BGgQb2kZjUcca/epgGMhAWM8ZrB+oRKzicFlBak8YRxx/xTu1BiVdOaolzobGlyT47
         l1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UtyDToTRhseCzK9/TotzxKj/q4ckgBV14Zj5miZuzXk=;
        b=P3gXZG0eBjoAxfCRNCNVQyV57TpdO4+Ato6KlM+4gFpOxuZ1IHWSoTiZiqJ2wntdfb
         zlTjUCOMLjJp9wN9Dc7TWGLEJ8g8NTQ5dyj6Nuf9pz99nYEpfuZZUQJvJAZcaRNf4is5
         1rH0AIq6+A+CzHLBfYnIB2I2oRgRAX3Nfd35C+MOQvQ6Fx4BIjJtTeYYKpvz1BYunCOV
         KQ/DpA6HnDidh5YJS8jg4y2mr0UGwYCLfji2q5ctfzlefrg+2RVCu9PSdnwnxc0n96ke
         tmNH1gtbGItr0iKtI+FJG1NjB/qDgzbvhV/5YlFL16viLi6Utsu1qkltCFOfVrRiWlq4
         VWoQ==
X-Gm-Message-State: APjAAAXsTgmD5EeUFFqHmkPabzlprdWVha6nTjLvLMsCdYjuglviEBUn
        nIETkImpJJQUKbyyeRa12mzRLA==
X-Google-Smtp-Source: APXvYqzVsoxcKksi8FNWJYwOvubGzzFogNOwtejvKmc9lJhYvSUTJnMnqitwQqaom5g3XqOdM8ufEw==
X-Received: by 2002:a05:600c:2c2:: with SMTP id 2mr3284261wmn.155.1577180054521;
        Tue, 24 Dec 2019 01:34:14 -0800 (PST)
Received: from apalos.home (ppp-94-64-118-170.home.otenet.gr. [94.64.118.170])
        by smtp.gmail.com with ESMTPSA id n3sm2120706wmc.27.2019.12.24.01.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 01:34:14 -0800 (PST)
Date:   Tue, 24 Dec 2019 11:34:11 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Saeed Mahameed <saeedm@mellanox.com>
Cc:     "brouer@redhat.com" <brouer@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linyunsheng@huawei.com" <linyunsheng@huawei.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Li Rongqing <lirongqing@baidu.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [net-next v5 PATCH] page_pool: handle page recycle for
 NUMA_NO_NODE condition
Message-ID: <20191224093411.GA23925@apalos.home>
References: <20191218084437.6db92d32@carbon>
 <157676523108.200893.4571988797174399927.stgit@firesoul>
 <20191220102314.GB14269@apalos.home>
 <20191220114116.59d86ff6@carbon>
 <20191220104937.GA15487@apalos.home>
 <20191220162254.0138263e@carbon>
 <20191220160649.GA26788@apalos.home>
 <20191223075700.GA5333@apalos.home>
 <20191223175257.164557cd@carbon>
 <e5d14b5a9c95adf701219099b30c3effe0d1eb45.camel@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5d14b5a9c95adf701219099b30c3effe0d1eb45.camel@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saeed, 
> which is the msix affinity.. the pool has no knowledge of that on
> initialization.
> 
> > The reason I want this behavior is that during driver init/boot, it
> > can
> > easily happen that a driver allocates RX-pages from wrong NUMA node.
> > This will cause a performance slowdown, that normally doesn't happen,
> > because without a cache (like page_pool) RX-pages would fairly
> > quickly
> > transition over to the RX NUMA node (instead we keep recycling these,
> > in your case #2, where you suggest recycle blindly in case of
> > NUMA_NO_NODE). IMHO page_pool should hide this border-line case from
> > driver developers.
> > 
> 
> So, Ilias's #1 suggestion make sense, to always store a valid nid
> value. 
> the question is which value to store on initialization if the user
> provided NUMA_NO_NODE ? I don't think the pool is capable of choosing
> the right value, so let's just use numa node 0. 

Again i don't mind using the current solution. We could use 0 or the whatever
numa is choosen from alloc_pages_node()

> 
> If the developer cares,  he would have picked the right affinity on
> initialization, or he can just call pool_update_nid() when the affinity
> is determined and every thing will be fine after that point.
> 
> My 2cent is that you just can't provide the perfect performance when
> the user uses NUMA_NO_NODE, so just pick any default concrete node id
> and avoid dealing with NUMA_NO_NODE in the pool fast or even slow
> path..

I don't have strong preference on any of those. I just prefer the homogeneous
approach of always storing a normal usable memory id. Either way rest of the
code seems fine, so i'll approve this once you manage to test it on your setup. 

I did test it on my netsec card using NUMA_NO_NODE. On that machine though it
doesn't make any difference since page_to_nid(page) and numa_mem_id() always
return 0 on that. So the allocation is already 'correct', the only thing that
changes once i call page_pool_update_nid() is pool->p.nid

Thanks
/Ilias
> 
> > --Jesper
> > 
> > 
> > > On Fri, Dec 20, 2019 at 06:06:49PM +0200, Ilias Apalodimas wrote:
> > > > On Fri, Dec 20, 2019 at 04:22:54PM +0100, Jesper Dangaard Brouer
> > > > wrote:  
> > > > > On Fri, 20 Dec 2019 12:49:37 +0200
> > > > > Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> > > > >   
> > > > > > On Fri, Dec 20, 2019 at 11:41:16AM +0100, Jesper Dangaard
> > > > > > Brouer wrote:  
> > > > > > > On Fri, 20 Dec 2019 12:23:14 +0200
> > > > > > > Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> > > > > > >     
> > > > > > > > Hi Jesper, 
> > > > > > > > 
> > > > > > > > I like the overall approach since this moves the check
> > > > > > > > out
> > > > > > > > of  the hotpath. @Saeed, since i got no hardware to test
> > > > > > > > this on, would it be possible to check that it still
> > > > > > > > works
> > > > > > > > fine for mlx5?
> > > > > > > > 
> > > > > > > > [...]    
> > > > > > > > > +	struct ptr_ring *r = &pool->ring;
> > > > > > > > > +	struct page *page;
> > > > > > > > > +	int pref_nid; /* preferred NUMA node */
> > > > > > > > > +
> > > > > > > > > +	/* Quicker fallback, avoid locks when ring is
> > > > > > > > > empty */
> > > > > > > > > +	if (__ptr_ring_empty(r))
> > > > > > > > > +		return NULL;
> > > > > > > > > +
> > > > > > > > > +	/* Softirq guarantee CPU and thus NUMA node is
> > > > > > > > > stable. This,
> > > > > > > > > +	 * assumes CPU refilling driver RX-ring will
> > > > > > > > > also run RX-NAPI.
> > > > > > > > > +	 */
> > > > > > > > > +	pref_nid = (pool->p.nid == NUMA_NO_NODE) ?
> > > > > > > > > numa_mem_id() : pool->p.nid;      
> > > > > > > > 
> > > > > > > > One of the use cases for this is that during the
> > > > > > > > allocation
> > > > > > > > we are not guaranteed to pick up the correct NUMA node. 
> > > > > > > > This will get automatically fixed once the driver starts
> > > > > > > > recycling packets. 
> > > > > > > > 
> > > > > > > > I don't feel strongly about this, since i don't usually
> > > > > > > > like hiding value changes from the user but, would it
> > > > > > > > make
> > > > > > > > sense to move this into __page_pool_alloc_pages_slow()
> > > > > > > > and
> > > > > > > > change the pool->p.nid?
> > > > > > > > 
> > > > > > > > Since alloc_pages_node() will replace NUMA_NO_NODE with
> > > > > > > > numa_mem_id() regardless, why not store the actual node
> > > > > > > > in
> > > > > > > > our page pool information? You can then skip this and
> > > > > > > > check
> > > > > > > > pool->p.nid == numa_mem_id(), regardless of what's
> > > > > > > > configured.     
> > > > > > > 
> > > > > > > This single code line helps support that drivers can
> > > > > > > control
> > > > > > > the nid themselves.  This is a feature that is only used my
> > > > > > > mlx5 AFAIK.
> > > > > > > 
> > > > > > > I do think that is useful to allow the driver to "control"
> > > > > > > the nid, as pinning/preferring the pages to come from the
> > > > > > > NUMA node that matches the PCI-e controller hardware is
> > > > > > > installed in does have benefits.    
> > > > > > 
> > > > > > Sure you can keep the if statement as-is, it won't break
> > > > > > anything. Would we want to store the actual numa id in
> > > > > > pool->p.nid if the user selects 'NUMA_NO_NODE'?  
> > > > >  
> > > > > No. pool->p.nid should stay as NUMA_NO_NODE, because that makes
> > > > > it
> > > > > dynamic.  If someone moves an RX IRQ to another CPU on another
> > > > > NUMA node, then this 'NUMA_NO_NODE' setting makes pages
> > > > > transitioned automatically.  
> > > > Ok this assumed that drivers were going to use
> > > > page_pool_nid_changed(), but with the current code we don't have
> > > > to
> > > > force them to do that. Let's keep this as-is.
> > > > 
> > > > I'll be running a few more tests  and wait in case Saeed gets a
> > > > chance to test it and send my reviewed-by
> > 
> > 
