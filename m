Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A90AC2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0F520684
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ymavTb38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfLTKtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 05:49:42 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38366 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfLTKtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 05:49:42 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so8981694wrh.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 02:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yrfph1/GfS10pnQ52qoQl7bLv2L4obyhx4T8y7yOMZM=;
        b=ymavTb38A76LwyPLUuMyrDSAg2m7QzQbPORR5ZPH2NkaFQG+SoOTdll8WBIR1m9LFw
         ITTFftJpv0huxyoEWX84c9qgYu4HbNRiDjrb9QohABFomV77z1zDuQl/xG7W3FZt4sy+
         cyD5/Jt+GqIURA0HvYLNT8qrsi9keEib+QZkaUfgaYEvvaPAroYRbBzOhHsO82uJbgzp
         tGCInwJQsonK3ajJ4TwX+ZQQtPjk44YqJOFgiRKPgtnXu2dh1T2C7vsZ1v7ZldR8YCJK
         BoX7Fu0hOu4ogHv8Da903OVwqH+QMqj0cCS9zG96TReYwU/URWn6o4LNdl+XZXde8XBx
         87lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yrfph1/GfS10pnQ52qoQl7bLv2L4obyhx4T8y7yOMZM=;
        b=taZ8jgbLKMrn6gVZle3Fj8YB6lIGoPcicZqjnSqHyhvYJKWNcK97BUkjDjfcW5CCH9
         +hNWp2guQwzriaJlmpVLWskj16hRiDwghGi2FYJJTbXPQ1/Jrts0tLZzJpBx95LwBB2h
         klEzjzry3HDa1rlyjjOx7BfBCdgGNzRPudvHhcNWyNoVtf2q1hKIfqmW+OCh/FTM1yJ3
         9xMe8DnG2DPxfrRLmOsyKXM6mzl7kr1MwbXtdu8Dnv8ljJGUzzQafilP/rfgiNLrJKf7
         iR19jD82JsrnCtKnOeXBv/ma41yz3+Tsh2D0bKH2c2e8abGb1sU56DEQ3lpUtKmclzYc
         lhZQ==
X-Gm-Message-State: APjAAAU+dITUdd6ZmMhr9hl/7e2EBkRXJxmnTKTJBsNd++N34HkskTM4
        5AWTfKGlsPnngkQ48gVldfLceQ==
X-Google-Smtp-Source: APXvYqzZVlLF/dmhxcIff1ZqwYclRHe8LhN0IapHUGsw0pW2MVvDeN20Q5Eah+SrS19icSAsn7/FMQ==
X-Received: by 2002:a5d:6886:: with SMTP id h6mr2376655wru.154.1576838980176;
        Fri, 20 Dec 2019 02:49:40 -0800 (PST)
Received: from apalos.home (ppp-94-64-118-170.home.otenet.gr. [94.64.118.170])
        by smtp.gmail.com with ESMTPSA id c4sm9328559wml.7.2019.12.20.02.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 02:49:39 -0800 (PST)
Date:   Fri, 20 Dec 2019 12:49:37 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     netdev@vger.kernel.org, lirongqing@baidu.com,
        linyunsheng@huawei.com, Saeed Mahameed <saeedm@mellanox.com>,
        mhocko@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next v5 PATCH] page_pool: handle page recycle for
 NUMA_NO_NODE condition
Message-ID: <20191220104937.GA15487@apalos.home>
References: <20191218084437.6db92d32@carbon>
 <157676523108.200893.4571988797174399927.stgit@firesoul>
 <20191220102314.GB14269@apalos.home>
 <20191220114116.59d86ff6@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220114116.59d86ff6@carbon>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 11:41:16AM +0100, Jesper Dangaard Brouer wrote:
> On Fri, 20 Dec 2019 12:23:14 +0200
> Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> 
> > Hi Jesper, 
> > 
> > I like the overall approach since this moves the check out of  the hotpath. 
> > @Saeed, since i got no hardware to test this on, would it be possible to check
> > that it still works fine for mlx5?
> > 
> > [...]
> > > +	struct ptr_ring *r = &pool->ring;
> > > +	struct page *page;
> > > +	int pref_nid; /* preferred NUMA node */
> > > +
> > > +	/* Quicker fallback, avoid locks when ring is empty */
> > > +	if (__ptr_ring_empty(r))
> > > +		return NULL;
> > > +
> > > +	/* Softirq guarantee CPU and thus NUMA node is stable. This,
> > > +	 * assumes CPU refilling driver RX-ring will also run RX-NAPI.
> > > +	 */
> > > +	pref_nid = (pool->p.nid == NUMA_NO_NODE) ? numa_mem_id() : pool->p.nid;  
> > 
> > One of the use cases for this is that during the allocation we are not
> > guaranteed to pick up the correct NUMA node. 
> > This will get automatically fixed once the driver starts recycling packets. 
> > 
> > I don't feel strongly about this, since i don't usually like hiding value
> > changes from the user but, would it make sense to move this into 
> > __page_pool_alloc_pages_slow() and change the pool->p.nid?
> > 
> > Since alloc_pages_node() will replace NUMA_NO_NODE with numa_mem_id()
> > regardless, why not store the actual node in our page pool information?
> > You can then skip this and check pool->p.nid == numa_mem_id(), regardless of
> > what's configured. 
> 
> This single code line helps support that drivers can control the nid
> themselves.  This is a feature that is only used my mlx5 AFAIK.
> 
> I do think that is useful to allow the driver to "control" the nid, as
> pinning/preferring the pages to come from the NUMA node that matches
> the PCI-e controller hardware is installed in does have benefits.

Sure you can keep the if statement as-is, it won't break anything. 
Would we want to store the actual numa id in pool->p.nid if the user selects 
'NUMA_NO_NODE'?


Thanks
/Ilias
> 
> -- 
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
> 
