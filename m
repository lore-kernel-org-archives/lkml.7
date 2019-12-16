Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B120C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B10205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Quv3jFqy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfLPKN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:13:57 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34797 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfLPKN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:13:57 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so6531610wrr.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 02:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eBj5vDAhcxQNM9h83BAs5ytrCGULuIqcoVqUpd5RXFk=;
        b=Quv3jFqysyJ/6lmdrPmhuLct+POkHO/NdCIW5wdrnXBWjZ/v0XiPCpZuJTo0iufgxS
         lJf4tVqDE3M0Sem7rjACmd/3YxIXUjOL9u1UbtMYPsQKKjBgAay1seCy2qNG+K2ZCD7L
         BTYHDmxWBnacij1qZUlVD0muEPVv4qC4L2EcNtrFua0sXynl6PzlZAr5rt13jkLpTNmt
         YYd+KRfmqhd3KNdFSI0/+SCgLVDfv4lb6AAHhyLg7/NRPciQJGALsF9IkqRgCYyX8DV1
         IspCOaj+qN4mdUpbYTpa9Q24fky/KVydhoeXTQut24fu1tRg916udxQ40AjVrSq0fMcG
         qgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eBj5vDAhcxQNM9h83BAs5ytrCGULuIqcoVqUpd5RXFk=;
        b=cyPk7rYc/utoz71bjrGhB2z8pwlkn6C0KKhGztEhzn0AwLLNmdrr5GYtVIu7ZDLDjJ
         nQK2UQm8TPO3xxVFkfJgGJxWoAigTHjORhS1I/3DUkkrTM3YvgTEiljUhgh4R7oePS5f
         hXL6OmJGrpEveKGQ95SmbPfqAimCDE2G3NIyHJUqt0BZ9VVVBy3l0m01NpsVkg2QOj85
         8QMVgr0aXhKTKpeb9rasvw3tH6hA5CwBpTRvvZmSXWYsKOpqu90vPmpHALyVnLtl81cx
         ytonFeZzirAMTCuC+U5Cpm+puGSJwljYFbeaCrObpMw6PALXljU0gyx9zbMEMMSitoTC
         bDog==
X-Gm-Message-State: APjAAAUMYpSaqzBJ8tz7r0hdh+StQrXWU0DipSVWpFsT4/wpG5DOOHq8
        Qr+3RnJLJ0dP5jxbQQgUWc6xiw==
X-Google-Smtp-Source: APXvYqzOQAkTF8ma2KJBme5Jd1WneX81bLhbknZI3Sc4bGSIqpT+g/0/pJArgq0fvPs/TzLMcVYsUg==
X-Received: by 2002:adf:a141:: with SMTP id r1mr29685031wrr.285.1576491234354;
        Mon, 16 Dec 2019 02:13:54 -0800 (PST)
Received: from apalos.home (ppp-94-66-130-5.home.otenet.gr. [94.66.130.5])
        by smtp.gmail.com with ESMTPSA id z3sm20936283wrs.94.2019.12.16.02.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 02:13:53 -0800 (PST)
Date:   Mon, 16 Dec 2019 12:13:50 +0200
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
Message-ID: <20191216101350.GA6939@apalos.home>
References: <20191211194933.15b53c11@carbon>
 <831ed886842c894f7b2ffe83fe34705180a86b3b.camel@mellanox.com>
 <0a252066-fdc3-a81d-7a36-8f49d2babc01@huawei.com>
 <20191212111831.2a9f05d3@carbon>
 <7c555cb1-6beb-240d-08f8-7044b9087fe4@huawei.com>
 <1d4f10f4c0f1433bae658df8972a904f@baidu.com>
 <079a0315-efea-9221-8538-47decf263684@huawei.com>
 <20191213094845.56fb42a4@carbon>
 <15be326d-1811-329c-424c-6dd22b0604a8@huawei.com>
 <a5dea60221d84886991168781361b591@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5dea60221d84886991168781361b591@baidu.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 04:02:04AM +0000, Li,Rongqing wrote:
> 
> 
> > -----邮件原件-----
> > 发件人: Yunsheng Lin [mailto:linyunsheng@huawei.com]
> > 发送时间: 2019年12月16日 9:51
> > 收件人: Jesper Dangaard Brouer <brouer@redhat.com>
> > 抄送: Li,Rongqing <lirongqing@baidu.com>; Saeed Mahameed
> > <saeedm@mellanox.com>; ilias.apalodimas@linaro.org;
> > jonathan.lemon@gmail.com; netdev@vger.kernel.org; mhocko@kernel.org;
> > peterz@infradead.org; Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> > bhelgaas@google.com; linux-kernel@vger.kernel.org; Björn Töpel
> > <bjorn.topel@intel.com>
> > 主题: Re: [PATCH][v2] page_pool: handle page recycle for NUMA_NO_NODE
> > condition
> > 
> > On 2019/12/13 16:48, Jesper Dangaard Brouer wrote:> You are basically saying
> > that the NUMA check should be moved to
> > > allocation time, as it is running the RX-CPU (NAPI).  And eventually
> > > after some time the pages will come from correct NUMA node.
> > >
> > > I think we can do that, and only affect the semi-fast-path.
> > > We just need to handle that pages in the ptr_ring that are recycled
> > > can be from the wrong NUMA node.  In __page_pool_get_cached() when
> > > consuming pages from the ptr_ring (__ptr_ring_consume_batched), then
> > > we can evict pages from wrong NUMA node.
> > 
> > Yes, that's workable.
> > 
> > >
> > > For the pool->alloc.cache we either accept, that it will eventually
> > > after some time be emptied (it is only in a 100% XDP_DROP workload that
> > > it will continue to reuse same pages).   Or we simply clear the
> > > pool->alloc.cache when calling page_pool_update_nid().
> > 
> > Simply clearing the pool->alloc.cache when calling page_pool_update_nid()
> > seems better.
> > 
> 
> How about the below codes, the driver can configure p.nid to any, which will be adjusted in NAPI polling, irq migration will not be problem, but it will add a check into hot path.

We'll have to check the impact on some high speed (i.e 100gbit) interface
between doing anything like that. Saeed's current patch runs once per NAPI. This
runs once per packet. The load might be measurable. 
The READ_ONCE is needed in case all producers/consumers run on the same CPU
right?


Thanks
/Ilias
> 
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index a6aefe989043..4374a6239d17 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -108,6 +108,10 @@ static struct page *__page_pool_get_cached(struct page_pool *pool)
>                 if (likely(pool->alloc.count)) {
>                         /* Fast-path */
>                         page = pool->alloc.cache[--pool->alloc.count];
> +
> +                       if (unlikely(READ_ONCE(pool->p.nid) != numa_mem_id()))
> +                               WRITE_ONCE(pool->p.nid, numa_mem_id());
> +
>                         return page;
>                 }
>                 refill = true;
> @@ -155,6 +159,10 @@ static struct page *__page_pool_alloc_pages_slow(struct page_pool *pool,
>         if (pool->p.order)
>                 gfp |= __GFP_COMP;
>  
> +
> +       if (unlikely(READ_ONCE(pool->p.nid) != numa_mem_id()))
> +               WRITE_ONCE(pool->p.nid, numa_mem_id());
> +
>         /* FUTURE development:
>          *
>          * Current slow-path essentially falls back to single page
> Thanks
> 
> -Li
> > >
> 
