Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A191CC2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77DE42465E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htjyBedo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfLTKl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 05:41:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31677 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727185AbfLTKl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 05:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576838486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o286XbqEZOzvo8vaNNAbdZckk8Oq7ortZIq6pvklUuM=;
        b=htjyBedoDaSyCN0o3kLBFdJ4q5zQjlp97WqMiOBIxqFItlg89TDXWFCU/ACnrcM2h+0JWL
        JIJRvdf5VKYm0ACdkW9+sN3+pTvPK9YSPB1gd/9hEsKY+ghxAuJoV5SsIG+cbBFqZJw5ck
        Vgs+ETwPgm9202n30CAlAdphmYNFPr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-kDuglqqyPYGYQ7IMX8e6Ew-1; Fri, 20 Dec 2019 05:41:24 -0500
X-MC-Unique: kDuglqqyPYGYQ7IMX8e6Ew-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 040D9DB21;
        Fri, 20 Dec 2019 10:41:23 +0000 (UTC)
Received: from carbon (ovpn-200-18.brq.redhat.com [10.40.200.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCCF77D9D7;
        Fri, 20 Dec 2019 10:41:17 +0000 (UTC)
Date:   Fri, 20 Dec 2019 11:41:16 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     netdev@vger.kernel.org, lirongqing@baidu.com,
        linyunsheng@huawei.com, Saeed Mahameed <saeedm@mellanox.com>,
        mhocko@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, brouer@redhat.com
Subject: Re: [net-next v5 PATCH] page_pool: handle page recycle for
 NUMA_NO_NODE condition
Message-ID: <20191220114116.59d86ff6@carbon>
In-Reply-To: <20191220102314.GB14269@apalos.home>
References: <20191218084437.6db92d32@carbon>
        <157676523108.200893.4571988797174399927.stgit@firesoul>
        <20191220102314.GB14269@apalos.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Dec 2019 12:23:14 +0200
Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:

> Hi Jesper, 
> 
> I like the overall approach since this moves the check out of  the hotpath. 
> @Saeed, since i got no hardware to test this on, would it be possible to check
> that it still works fine for mlx5?
> 
> [...]
> > +	struct ptr_ring *r = &pool->ring;
> > +	struct page *page;
> > +	int pref_nid; /* preferred NUMA node */
> > +
> > +	/* Quicker fallback, avoid locks when ring is empty */
> > +	if (__ptr_ring_empty(r))
> > +		return NULL;
> > +
> > +	/* Softirq guarantee CPU and thus NUMA node is stable. This,
> > +	 * assumes CPU refilling driver RX-ring will also run RX-NAPI.
> > +	 */
> > +	pref_nid = (pool->p.nid == NUMA_NO_NODE) ? numa_mem_id() : pool->p.nid;  
> 
> One of the use cases for this is that during the allocation we are not
> guaranteed to pick up the correct NUMA node. 
> This will get automatically fixed once the driver starts recycling packets. 
> 
> I don't feel strongly about this, since i don't usually like hiding value
> changes from the user but, would it make sense to move this into 
> __page_pool_alloc_pages_slow() and change the pool->p.nid?
> 
> Since alloc_pages_node() will replace NUMA_NO_NODE with numa_mem_id()
> regardless, why not store the actual node in our page pool information?
> You can then skip this and check pool->p.nid == numa_mem_id(), regardless of
> what's configured. 

This single code line helps support that drivers can control the nid
themselves.  This is a feature that is only used my mlx5 AFAIK.

I do think that is useful to allow the driver to "control" the nid, as
pinning/preferring the pages to come from the NUMA node that matches
the PCI-e controller hardware is installed in does have benefits.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

