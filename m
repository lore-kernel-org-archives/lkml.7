Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5DFC2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 14:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353F6206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 14:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGDzJ+sn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfLXOBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 09:01:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48174 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726178AbfLXOBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 09:01:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577196072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dMsDBmBD7JZa0s+34AQ0kDBnfGUFwWvNelpOAou0124=;
        b=WGDzJ+snLNkXdxmuQ5v4/WZa+mhymPQejlQ+b0yNUB968xhJkOw7MULB/5uJpqvIzjIZ00
        f1nl+tIKnXmLOB4DzSsto8a+OqTLqwAOj1qTo230jBjmtcu7LF/paf5rtd9fPUE0+RZkn+
        a0a/5eZAX958BGCR+H6O+waxYM/bPDM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-nrrIhL2BM9SBzN9xUOdwig-1; Tue, 24 Dec 2019 09:01:10 -0500
X-MC-Unique: nrrIhL2BM9SBzN9xUOdwig-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D42D800D55;
        Tue, 24 Dec 2019 14:01:08 +0000 (UTC)
Received: from carbon (ovpn-200-18.brq.redhat.com [10.40.200.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8AC7660BF3;
        Tue, 24 Dec 2019 14:01:00 +0000 (UTC)
Date:   Tue, 24 Dec 2019 15:00:58 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Matteo Croce <mcroce@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Tomislav Tomasic <tomislav.tomasic@sartura.hr>,
        Marcin Wojtas <mw@semihalf.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Nadav Haklai <nadavh@marvell.com>, brouer@redhat.com
Subject: Re: [RFC net-next 0/2] mvpp2: page_pool support
Message-ID: <20191224150058.4400ffab@carbon>
In-Reply-To: <20191224095229.GA24310@apalos.home>
References: <20191224010103.56407-1-mcroce@redhat.com>
        <20191224095229.GA24310@apalos.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Dec 2019 11:52:29 +0200
Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:

> On Tue, Dec 24, 2019 at 02:01:01AM +0100, Matteo Croce wrote:
> > This patches change the memory allocator of mvpp2 from the frag allocator to
> > the page_pool API. This change is needed to add later XDP support to mvpp2.
> > 
> > The reason I send it as RFC is that with this changeset, mvpp2 performs much
> > more slower. This is the tc drop rate measured with a single flow:
> > 
> > stock net-next with frag allocator:
> > rx: 900.7 Mbps 1877 Kpps
> > 
> > this patchset with page_pool:
> > rx: 423.5 Mbps 882.3 Kpps
> > 
> > This is the perf top when receiving traffic:
> > 
> >   27.68%  [kernel]            [k] __page_pool_clean_page  
> 
> This seems extremly high on the list. 
 
This looks related to the cost of dma unmap, as page_pool have
PP_FLAG_DMA_MAP. (It is a little strange, as page_pool have flag
DMA_ATTR_SKIP_CPU_SYNC, which should make it less expensive).


> >    9.79%  [kernel]            [k] get_page_from_freelist

You are clearly hitting page-allocator every time, because you are not
using page_pool recycle facility.


> >    7.18%  [kernel]            [k] free_unref_page
> >    4.64%  [kernel]            [k] build_skb
> >    4.63%  [kernel]            [k] __netif_receive_skb_core
> >    3.83%  [mvpp2]             [k] mvpp2_poll
> >    3.64%  [kernel]            [k] eth_type_trans
> >    3.61%  [kernel]            [k] kmem_cache_free
> >    3.03%  [kernel]            [k] kmem_cache_alloc
> >    2.76%  [kernel]            [k] dev_gro_receive
> >    2.69%  [mvpp2]             [k] mvpp2_bm_pool_put
> >    2.68%  [kernel]            [k] page_frag_free
> >    1.83%  [kernel]            [k] inet_gro_receive
> >    1.74%  [kernel]            [k] page_pool_alloc_pages
> >    1.70%  [kernel]            [k] __build_skb
> >    1.47%  [kernel]            [k] __alloc_pages_nodemask
> >    1.36%  [mvpp2]             [k] mvpp2_buf_alloc.isra.0
> >    1.29%  [kernel]            [k] tcf_action_exec
> > 
> > I tried Ilias patches for page_pool recycling, I get an improvement
> > to ~1100, but I'm still far than the original allocator.  
-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

