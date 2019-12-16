Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7D8C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012E8206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r1sNV+Iq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfLPKQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:16:38 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:42628 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfLPKQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:16:36 -0500
Received: by mail-wr1-f52.google.com with SMTP id q6so6492464wro.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 02:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qev6JcA4gAswu34dFI4mXsZfo3KopBps59omzMWQcZo=;
        b=r1sNV+IqjkdxuYSFtaiJMYJO58gjweAG3frMxtExkbwprE+3jBTzHbhSrIyxOUtImY
         i5dvHhWsAwmNprFY/oSGFD4X5TLYNV1O4OBCpJtdLAzhFyVsUcgkp7ApHxXFv6AvE47M
         HQ4KJO++LAFCO7kJKU0RY3nCUBy6hmuO1Lzr6yc9yJH/Ub6gzE1CgmUlzM/4fiRJa+Dq
         DzESGpc/qbbuPKnDS8v/xKn6/4RaEBJQOVlfUWzaeWlyvofIbBWpJAIUWuhgK/a4rpL5
         rgxVrGgQSmi2fZmxf9ihWiI9O5Dh6ap+KJJpQFtgD9Ulk7qAEqJkD82ivYkqWoKwU1mg
         FJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qev6JcA4gAswu34dFI4mXsZfo3KopBps59omzMWQcZo=;
        b=ae1crOIotZ/1rpCwAiTeGboaQ+uC4fZwZuByx3AKw/UJ79UR4jjbuIqU6ESzGwFt2y
         6PtIskSte2dQHlXFjDc+btySMMN2WMtdqOWr9Zfqgo+czxYt/gpblJgAgGrvRMXlSWC6
         48wP3flr6ObX/L0UiFr4VgQAf4MphEAHsY1rcOcfqEroL8zRFmLD3dfCJqEjvP3N0IEr
         00cq+0SCtP6sW5q6lMXk4aKZ1SFBHlQwEj6y1URQO7Z8zePy2q+1bFWxu74LeuE/hOsJ
         ErnPD53G643msXty0P6nE4U0eBko4NJ29Q1v5I6oNDYk8c6cctyDGimbKQrry/SzmRZ8
         kEEw==
X-Gm-Message-State: APjAAAUjmwlpARkQeDNGICpHlEf+xjt+ZhJkDCAmoU+QCd6vIfgfTiC8
        BmtsSNmI+IZdAKg2Q74KnwHjNQ==
X-Google-Smtp-Source: APXvYqyZzq54XDI8z5XqTqx2eFH5uMiMsWKlk+aJstX6+LwMFV45CiTX2TUgPNKIxyCLMt48aqe+tw==
X-Received: by 2002:a5d:6b03:: with SMTP id v3mr29435058wrw.289.1576491394127;
        Mon, 16 Dec 2019 02:16:34 -0800 (PST)
Received: from apalos.home (ppp-94-66-130-5.home.otenet.gr. [94.66.130.5])
        by smtp.gmail.com with ESMTPSA id a16sm20895577wrt.37.2019.12.16.02.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 02:16:33 -0800 (PST)
Date:   Mon, 16 Dec 2019 12:16:30 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     "Li,Rongqing" <lirongqing@baidu.com>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0hdW3Yy?= =?utf-8?Q?=5D?= page_pool:
 handle page recycle for NUMA_NO_NODE condition
Message-ID: <20191216101630.GA7102@apalos.home>
References: <831ed886842c894f7b2ffe83fe34705180a86b3b.camel@mellanox.com>
 <0a252066-fdc3-a81d-7a36-8f49d2babc01@huawei.com>
 <20191212111831.2a9f05d3@carbon>
 <7c555cb1-6beb-240d-08f8-7044b9087fe4@huawei.com>
 <1d4f10f4c0f1433bae658df8972a904f@baidu.com>
 <079a0315-efea-9221-8538-47decf263684@huawei.com>
 <20191213094845.56fb42a4@carbon>
 <15be326d-1811-329c-424c-6dd22b0604a8@huawei.com>
 <a5dea60221d84886991168781361b591@baidu.com>
 <20191216101350.GA6939@apalos.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216101350.GA6939@apalos.home>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 
> > > Simply clearing the pool->alloc.cache when calling page_pool_update_nid()
> > > seems better.
> > > 
> > 
> > How about the below codes, the driver can configure p.nid to any, which will be adjusted in NAPI polling, irq migration will not be problem, but it will add a check into hot path.
> 
> We'll have to check the impact on some high speed (i.e 100gbit) interface
> between doing anything like that. Saeed's current patch runs once per NAPI. This
> runs once per packet. The load might be measurable. 
> The READ_ONCE is needed in case all producers/consumers run on the same CPU

I meant different cpus!

> right?
> 
> 
> Thanks
> /Ilias
> > 
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > index a6aefe989043..4374a6239d17 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -108,6 +108,10 @@ static struct page *__page_pool_get_cached(struct page_pool *pool)
> >                 if (likely(pool->alloc.count)) {
> >                         /* Fast-path */
> >                         page = pool->alloc.cache[--pool->alloc.count];
> > +
> > +                       if (unlikely(READ_ONCE(pool->p.nid) != numa_mem_id()))
> > +                               WRITE_ONCE(pool->p.nid, numa_mem_id());
> > +
> >                         return page;
> >                 }
> >                 refill = true;
> > @@ -155,6 +159,10 @@ static struct page *__page_pool_alloc_pages_slow(struct page_pool *pool,
> >         if (pool->p.order)
> >                 gfp |= __GFP_COMP;
> >  
> > +
> > +       if (unlikely(READ_ONCE(pool->p.nid) != numa_mem_id()))
> > +               WRITE_ONCE(pool->p.nid, numa_mem_id());
> > +
> >         /* FUTURE development:
> >          *
> >          * Current slow-path essentially falls back to single page
> > Thanks
> > 
> > -Li
> > > >
> > 
