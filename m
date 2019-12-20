Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FBAC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E252146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fibdeup0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfLTQGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 11:06:55 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53378 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfLTQGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 11:06:55 -0500
Received: by mail-wm1-f65.google.com with SMTP id m24so9461770wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 08:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7RYQGeZeAiJlCSmLOt1RG/lJJr6hqYlQYOlVZADBBeA=;
        b=Fibdeup0c7dyY5S/P2Ll9cyvCNFUYwfSc9O81jQFKYEGrJe1gmPmq7m2NCscxdcBw9
         7VEKmMi6MYhXp0DjD/RWc7MVr0L8S5ImhihJIK7PDbe5lVULPgYnyoAfgkFOgP5kpbRq
         R1T7awUqgW8+T6JtoKcyrMiUyKV7+BFn46m3WAksrIvaCPYH4peTE1CnIXoKkpVM0jEG
         JujC1EsXtEbXbEEdZuppX5h7U9Vf+Ov/VJpjMysfm9MDsFEEODpxs7DYIxJU/lySFDHw
         IuVlWHYxmj5AMhfh1SXAlTd13NSynKCMQ4CSoJP41XIBLqPDK+ld8Aw7nVB/sDRZfNmR
         opvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7RYQGeZeAiJlCSmLOt1RG/lJJr6hqYlQYOlVZADBBeA=;
        b=fY2GYy/2Iuu1QMqD3QGFLHEVDtni4wfqYn+q9yyYW0h20GLuaxGxRGzc4HAwj7wiIA
         4z+8oCZqRYUr/+tfWcH33a6DVPjOgfEBPG6JjV+cDptCOFHHTbMKLI7IEN2eHw1SE/k1
         TKeSTB0LCgtU0P6LHUGCCQ/Vu1jsWAKK/9SA6VV0ShroZjjmQO6SN0nRp+USUlCGQjKy
         AD94nJhyZ3i57MTYYCkDudgTos2/WHBqHn10xpxXjW/jUNFC6d4YFx/jAeZjdfFHNoTC
         LHCO7Msj7Kgxf+sUt2jmLqtpBTQnNza9u4+7X0QNldZeyrgnSbGaJ/wlLjYID8+ZiLb1
         901w==
X-Gm-Message-State: APjAAAXS5fKld0oNLRD3wnbpAfszausmqPItxf3lS4I/4AFA7BB0Tzym
        ydoh4KtDsMoiOcv+eFvrA9Yf8w==
X-Google-Smtp-Source: APXvYqy+T6boSrBnRoWvQxd+VXT4NB7tvQ0dXSNrh3hoRtWToVG89Rug2th6I2z7sjFE7qRBCi4flA==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr16855019wmg.92.1576858012823;
        Fri, 20 Dec 2019 08:06:52 -0800 (PST)
Received: from apalos.home (ppp-94-64-118-170.home.otenet.gr. [94.64.118.170])
        by smtp.gmail.com with ESMTPSA id j2sm10329263wmk.23.2019.12.20.08.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 08:06:52 -0800 (PST)
Date:   Fri, 20 Dec 2019 18:06:49 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     netdev@vger.kernel.org, lirongqing@baidu.com,
        linyunsheng@huawei.com, Saeed Mahameed <saeedm@mellanox.com>,
        mhocko@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next v5 PATCH] page_pool: handle page recycle for
 NUMA_NO_NODE condition
Message-ID: <20191220160649.GA26788@apalos.home>
References: <20191218084437.6db92d32@carbon>
 <157676523108.200893.4571988797174399927.stgit@firesoul>
 <20191220102314.GB14269@apalos.home>
 <20191220114116.59d86ff6@carbon>
 <20191220104937.GA15487@apalos.home>
 <20191220162254.0138263e@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220162254.0138263e@carbon>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 04:22:54PM +0100, Jesper Dangaard Brouer wrote:
> On Fri, 20 Dec 2019 12:49:37 +0200
> Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> 
> > On Fri, Dec 20, 2019 at 11:41:16AM +0100, Jesper Dangaard Brouer wrote:
> > > On Fri, 20 Dec 2019 12:23:14 +0200
> > > Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> > >   
> > > > Hi Jesper, 
> > > > 
> > > > I like the overall approach since this moves the check out of  the hotpath. 
> > > > @Saeed, since i got no hardware to test this on, would it be possible to check
> > > > that it still works fine for mlx5?
> > > > 
> > > > [...]  
> > > > > +	struct ptr_ring *r = &pool->ring;
> > > > > +	struct page *page;
> > > > > +	int pref_nid; /* preferred NUMA node */
> > > > > +
> > > > > +	/* Quicker fallback, avoid locks when ring is empty */
> > > > > +	if (__ptr_ring_empty(r))
> > > > > +		return NULL;
> > > > > +
> > > > > +	/* Softirq guarantee CPU and thus NUMA node is stable. This,
> > > > > +	 * assumes CPU refilling driver RX-ring will also run RX-NAPI.
> > > > > +	 */
> > > > > +	pref_nid = (pool->p.nid == NUMA_NO_NODE) ? numa_mem_id() : pool->p.nid;    
> > > > 
> > > > One of the use cases for this is that during the allocation we are not
> > > > guaranteed to pick up the correct NUMA node. 
> > > > This will get automatically fixed once the driver starts recycling packets. 
> > > > 
> > > > I don't feel strongly about this, since i don't usually like hiding value
> > > > changes from the user but, would it make sense to move this into 
> > > > __page_pool_alloc_pages_slow() and change the pool->p.nid?
> > > > 
> > > > Since alloc_pages_node() will replace NUMA_NO_NODE with numa_mem_id()
> > > > regardless, why not store the actual node in our page pool information?
> > > > You can then skip this and check pool->p.nid == numa_mem_id(), regardless of
> > > > what's configured.   
> > > 
> > > This single code line helps support that drivers can control the nid
> > > themselves.  This is a feature that is only used my mlx5 AFAIK.
> > > 
> > > I do think that is useful to allow the driver to "control" the nid, as
> > > pinning/preferring the pages to come from the NUMA node that matches
> > > the PCI-e controller hardware is installed in does have benefits.  
> > 
> > Sure you can keep the if statement as-is, it won't break anything. 
> > Would we want to store the actual numa id in pool->p.nid if the user
> > selects 'NUMA_NO_NODE'?
>  
> No. pool->p.nid should stay as NUMA_NO_NODE, because that makes it
> dynamic.  If someone moves an RX IRQ to another CPU on another NUMA
> node, then this 'NUMA_NO_NODE' setting makes pages transitioned
> automatically.
Ok this assumed that drivers were going to use page_pool_nid_changed(), but with
the current code we don't have to force them to do that. Let's keep this as-is.

I'll be running a few more tests  and wait in case Saeed gets a chance to test
it and send my reviewed-by

Cheers
/Ilias
> 
> -- 
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
> 
