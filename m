Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC51C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 14:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC723206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 14:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4e5bR5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfLXOib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 09:38:31 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25650 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726140AbfLXOia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 09:38:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577198308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XhTSxydB787Fx7W9BGgbDNxwN40hZslUJG+z59R7n0E=;
        b=c4e5bR5dfyYDoI/bkl4IztF3trnBFVEwL4b5ulBN1KUCx6uR1x9AY0GrDfkDUnWrQ+BPK5
        1KvKBGmnKZfqw4Z6P4Jr4ThwZWJ/VjhUKHCccpzQ7HQoNd//Tp8AY/D2lG4aw8o5TxXcVI
        jFQvLLEjGcu0XJhF3okz+HrZbRic0PA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-4QC5sLpXNiicU25e3XEVzQ-1; Tue, 24 Dec 2019 09:38:26 -0500
X-MC-Unique: 4QC5sLpXNiicU25e3XEVzQ-1
Received: by mail-lj1-f200.google.com with SMTP id g5so1747244ljj.22
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 06:38:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XhTSxydB787Fx7W9BGgbDNxwN40hZslUJG+z59R7n0E=;
        b=ri3ld95xlUepRaf8aw8sXV5ZWFZjyQMvqrpFKUBKBhGXToCE7Dott43bINo7aajlP/
         JkBvwk53fSkeZmhgamjraxB2OVZWbI3udMFbXyYjn2yuzobUVODK+GSehbky7iZxQX4L
         33vHjBqhvVwdbhS2UGvd7FXP5/aXfa4Dy6KahYG5iUSFh2s2hFtIeBEvANDbw6AV0Oiq
         55P/W1F999MFSS69UHGuw4xfk2pPUNY6sbQg3o0mxl1IBRFktxm4J18y+el9F1tPysW2
         I9P6OgecpXyVBvI+HNQT13eKVb3nYyAkwdv30/975ptCafxdWUuVWXNyyOAgTkJYLh2x
         Bq6Q==
X-Gm-Message-State: APjAAAU4uU2Ul7+SKYEtz2ia0dxDy325CmvLLO+ID37DzjJLmsyJDoYb
        PNJ/yJZavb9wun4HARM7Oyhy2KX2jqiGyYz4wCfh9257KUwbfbhXAxL03jmZQiaxq6RIBwgzr9M
        Q3doyA1gA/euS6wgjBNdcDXL/lreUAappR75hGhQ0
X-Received: by 2002:a19:8456:: with SMTP id g83mr20275499lfd.0.1577198305007;
        Tue, 24 Dec 2019 06:38:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqwFw9Zd5Ca/3FACYA3fL7tMqVTaYlHAdjxV9dGZw75keJELu67CLpVePZwmd49Rk96cz5eQO0KvH8Ik3APQQjY=
X-Received: by 2002:a19:8456:: with SMTP id g83mr20275481lfd.0.1577198304733;
 Tue, 24 Dec 2019 06:38:24 -0800 (PST)
MIME-Version: 1.0
References: <20191224010103.56407-1-mcroce@redhat.com> <20191224095229.GA24310@apalos.home>
 <20191224150058.4400ffab@carbon>
In-Reply-To: <20191224150058.4400ffab@carbon>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Tue, 24 Dec 2019 15:37:49 +0100
Message-ID: <CAGnkfhzYdqBPvRM8j98HVMzeHSbJ8RyVH+nLpoKBuz2iqErPog@mail.gmail.com>
Subject: Re: [RFC net-next 0/2] mvpp2: page_pool support
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Tomislav Tomasic <tomislav.tomasic@sartura.hr>,
        Marcin Wojtas <mw@semihalf.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Nadav Haklai <nadavh@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 3:01 PM Jesper Dangaard Brouer
<brouer@redhat.com> wrote:
>
> On Tue, 24 Dec 2019 11:52:29 +0200
> Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>
> > On Tue, Dec 24, 2019 at 02:01:01AM +0100, Matteo Croce wrote:
> > > This patches change the memory allocator of mvpp2 from the frag allocator to
> > > the page_pool API. This change is needed to add later XDP support to mvpp2.
> > >
> > > The reason I send it as RFC is that with this changeset, mvpp2 performs much
> > > more slower. This is the tc drop rate measured with a single flow:
> > >
> > > stock net-next with frag allocator:
> > > rx: 900.7 Mbps 1877 Kpps
> > >
> > > this patchset with page_pool:
> > > rx: 423.5 Mbps 882.3 Kpps
> > >
> > > This is the perf top when receiving traffic:
> > >
> > >   27.68%  [kernel]            [k] __page_pool_clean_page
> >
> > This seems extremly high on the list.
>
> This looks related to the cost of dma unmap, as page_pool have
> PP_FLAG_DMA_MAP. (It is a little strange, as page_pool have flag
> DMA_ATTR_SKIP_CPU_SYNC, which should make it less expensive).
>
>
> > >    9.79%  [kernel]            [k] get_page_from_freelist
>
> You are clearly hitting page-allocator every time, because you are not
> using page_pool recycle facility.
>
>
> > >    7.18%  [kernel]            [k] free_unref_page
> > >    4.64%  [kernel]            [k] build_skb
> > >    4.63%  [kernel]            [k] __netif_receive_skb_core
> > >    3.83%  [mvpp2]             [k] mvpp2_poll
> > >    3.64%  [kernel]            [k] eth_type_trans
> > >    3.61%  [kernel]            [k] kmem_cache_free
> > >    3.03%  [kernel]            [k] kmem_cache_alloc
> > >    2.76%  [kernel]            [k] dev_gro_receive
> > >    2.69%  [mvpp2]             [k] mvpp2_bm_pool_put
> > >    2.68%  [kernel]            [k] page_frag_free
> > >    1.83%  [kernel]            [k] inet_gro_receive
> > >    1.74%  [kernel]            [k] page_pool_alloc_pages
> > >    1.70%  [kernel]            [k] __build_skb
> > >    1.47%  [kernel]            [k] __alloc_pages_nodemask
> > >    1.36%  [mvpp2]             [k] mvpp2_buf_alloc.isra.0
> > >    1.29%  [kernel]            [k] tcf_action_exec
> > >
> > > I tried Ilias patches for page_pool recycling, I get an improvement
> > > to ~1100, but I'm still far than the original allocator.
> --
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: http://www.linkedin.com/in/brouer
>

The change I did to use the recycling is the following:

--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3071,7 +3071,7 @@ static int mvpp2_rx(struct mvpp2_port *port,
struct napi_struct *napi,
    if (pp)
-       page_pool_release_page(pp, virt_to_page(data));
+      skb_mark_for_recycle(skb, virt_to_page(data), &rxq->xdp_rxq.mem);
    else
         dma_unmap_single_attrs(dev->dev.parent, dma_addr,




--
Matteo Croce
per aspera ad upstream

