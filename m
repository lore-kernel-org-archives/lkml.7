Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEFEC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 23:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55A92067D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 23:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r5a/XbNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfIPXp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 19:45:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45698 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfIPXp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 19:45:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id y72so894845pfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 16:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=gPeqNA84uKm/2CLfm5fXdDKqLvuPs/0PfIC1lZBDVcE=;
        b=r5a/XbNS/jvudcLZbnEeEeBgDSpXdAkOEjlEqjWaVl7O/Keuu9SWppYwdpzqS9XUXd
         I++cPOGgE3jNUdIa30WtGkrBMf4xdS9Zym5SrGinlequi+YmMUh3dt3nzoY9x4MaQWbL
         a1PPBz0ECe86QyfBSkBMtFmZttbnAAC9nF7T3lvNBSbvbSfKh3CY6yHLQClu7mta6BxQ
         qFbfpNyr2CMtxnhne3PMeSYau+1m6+CUl680SgEhuv4n7UrmGSjgdWsNsQX3wZLaNXlB
         xWZyM1MT6hkXu/o0YiAC0cwF3yKfzKv0gwjjjK9Rc4eSqWan27FtAEqudrqfcz8ao8b2
         yYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=gPeqNA84uKm/2CLfm5fXdDKqLvuPs/0PfIC1lZBDVcE=;
        b=nDZIcojodXKG/avNN1XxoGTKy8eVS1TDcc12SM/7yH6L2fD72aYLEJKMNOotIPQ2N3
         HXmI7rAdeRHHEC4heUM+wRkZO340WpZAfqINVLucI1MoZu06xSWy33tb4LGcvar6KVtS
         fhohcb8yNbFFmJDCEN2iSIvMNX8Ut5q0dcRBwZkU4pnZjoRAtTr94Uqd9iXY6BbEn4hB
         Cn8mJwc9uJk7+BTWHP9xwrYBDYtPBehMxnPkiWnj2hHoZp97vu6ckxdBW77OQ6Cae49d
         6l8Nhtsj/bQ9gqVkD6GMpnZg/uUh/eXq10LkAHAWPkD+fLfmtmyajUnFVcUxWwqncwne
         S1VA==
X-Gm-Message-State: APjAAAV77i57fNBQFVq29KMYzBj6BPcPnS9U2mKcIhb7xOnl7wxhJDgC
        x5JyvQu93bkwqk345Sng/QQgSQ==
X-Google-Smtp-Source: APXvYqw92C74smlwK4lp/45d9xzXzuNO1t7cK8J2Wk45GzI+dOKhN4oA5k/eAQn9NkOzFT8IyuIcgA==
X-Received: by 2002:a62:b406:: with SMTP id h6mr1028857pfn.260.1568677526290;
        Mon, 16 Sep 2019 16:45:26 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id m24sm183103pgj.71.2019.09.16.16.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 16:45:25 -0700 (PDT)
Date:   Mon, 16 Sep 2019 16:45:24 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Jianxiong Gao <jxgao@google.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [bug] __blk_mq_run_hw_queue suspicious rcu usage
In-Reply-To: <alpine.DEB.2.21.1909051534050.245316@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.1909161641320.9200@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1909041434580.160038@chino.kir.corp.google.com> <20190905060627.GA1753@lst.de> <alpine.DEB.2.21.1909051534050.245316@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2019, David Rientjes wrote:

> > > Hi Christoph, Jens, and Ming,
> > > 
> > > While booting a 5.2 SEV-enabled guest we have encountered the following 
> > > WARNING that is followed up by a BUG because we are in atomic context 
> > > while trying to call set_memory_decrypted:
> > 
> > Well, this really is a x86 / DMA API issue unfortunately.  Drivers
> > are allowed to do GFP_ATOMIC dma allocation under locks / rcu critical
> > sections and from interrupts.  And it seems like the SEV case can't
> > handle that.  We have some semi-generic code to have a fixed sized
> > pool in kernel/dma for non-coherent platforms that have similar issues
> > that we could try to wire up, but I wonder if there is a better way
> > to handle the issue, so I've added Tom and the x86 maintainers.
> > 
> > Now independent of that issue using DMA coherent memory for the nvme
> > PRPs/SGLs doesn't actually feel very optional.  We could do with
> > normal kmalloc allocations and just sync it to the device and back.
> > I wonder if we should create some general mempool-like helpers for that.
> > 
> 
> Thanks for looking into this.  I assume it's a non-starter to try to 
> address this in _vm_unmap_aliases() itself, i.e. rely on a purge spinlock 
> to do all synchronization (or trylock if not forced) for 
> purge_vmap_area_lazy() rather than only the vmap_area_lock within it.  In 
> other words, no mutex.
> 
> If that's the case, and set_memory_encrypted() can't be fixed to not need 
> to sleep by changing _vm_unmap_aliases() locking, then I assume dmapool is 
> our only alternative?  I have no idea with how large this should be.
> 

Brijesh and Tom, we currently hit this any time we boot an SEV enabled 
Ubuntu 18.04 guest; I assume that guest kernels, especially those of such 
major distributions, are expected to work with warnings and BUGs when 
certain drivers are enabled.

If the vmap purge lock is to remain a mutex (any other reason that 
unmapping aliases can block?) then it appears that allocating a dmapool 
is the only alternative.  Is this something that you'll be addressing 
generically or do we need to get buy-in from the maintainers of this 
specific driver?
