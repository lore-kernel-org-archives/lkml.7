Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399B0C31E5D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEDE2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 16:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Mu7sgXi6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbfFSQ3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 12:29:05 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41490 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbfFSQ3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 12:29:05 -0400
Received: by mail-qk1-f193.google.com with SMTP id c11so11303547qkk.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 09:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qnUOwWGBCAXAVLri1Ul0fDjUeERWKjKVp0Rio+t6Mw0=;
        b=Mu7sgXi6O1BEfTzeAxDFiZq9WYAU+8GuA+frzMgX9hRk0/2Eo2VPU9VKN7SPqn7GLw
         BMmvCbBlMZt8BrrdyjrzJb5mIwmN+Un5ohC6uh52oLeiu3fM9lYGSfsBxw2N/in8YFn5
         94JBdMTWXqhPkHC5ogDkAk30Vj3tK2OB7FH+D8RuRjkNrh4KSwvNzZkKLQDt1o6UXnKk
         akxzg79p5LQYrNgI6wQWhEDCa4i3Wr2Q3GuDm1M6C6XhuTkbEI5dQ8Rzs09QxzMXG/yv
         86i6u7h1UReQ+1KLg8ARX3o5vtg8COFFdiinD/3xnzFLxOpaxmET6WHLpP1penmwv6Fz
         qw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qnUOwWGBCAXAVLri1Ul0fDjUeERWKjKVp0Rio+t6Mw0=;
        b=K0iGehx69wSUoM4yHovc1DrMlr26UxLcUI3b7BOaDSbnEeKdK1TpiWJS+//r5Zrvwf
         /Sv/joX8DCpWWRwxJMvPmwG4VwBYN5eghCUqe98LmLx1bElDpNwSYG9rNK4GRXuvwBIR
         2hLlfM+tgG3e+1jSyzRY3oN11p4BPAmRjkd8enrisUtr6ezvCQMKf/4JdpN/LmwGQ9xu
         pqTBhaTMprNgzOHjjyajk0QV5plKUzzwlmXZQj+sBu2a0prx+jfH0R1krp8sBz8oxpGB
         1nWLexWrhsGgSkKR88XRsJfGK0Bc5SUV1ZiEGTdOBEsFIzTxIU+0yihsr4G0Hqm58piU
         nWBw==
X-Gm-Message-State: APjAAAUT5ztssvD3eD52hcfXy5colpFhNVXVDd11J+HhuP7kTNGT2ZmT
        xnzmdtgQCkMheBB2NEsxMBdiOA==
X-Google-Smtp-Source: APXvYqxI2A2AbFb1+ZoFRIh7H3fg512a+PNV8rhMF80/TQ7Ui3RJ5j2fJJDqC3jWu2+hRHD8V09puw==
X-Received: by 2002:a37:5444:: with SMTP id i65mr23556982qkb.263.1560961744340;
        Wed, 19 Jun 2019 09:29:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id n5sm11854916qta.29.2019.06.19.09.29.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 09:29:03 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hddSJ-0001sf-Di; Wed, 19 Jun 2019 13:29:03 -0300
Date:   Wed, 19 Jun 2019 13:29:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        devel@driverdev.osuosl.org, linux-s390@vger.kernel.org,
        Intel Linux Wireless <linuxwifi@intel.com>,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        linux-media@vger.kernel.org
Subject: Re: use exact allocation for dma coherent memory
Message-ID: <20190619162903.GF9360@ziepe.ca>
References: <20190614134726.3827-1-hch@lst.de>
 <20190617082148.GF28859@kadam>
 <20190617083342.GA7883@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617083342.GA7883@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 10:33:42AM +0200, Christoph Hellwig wrote:
> > drivers/infiniband/hw/cxgb4/qp.c
> >    129  static int alloc_host_sq(struct c4iw_rdev *rdev, struct t4_sq *sq)
> >    130  {
> >    131          sq->queue = dma_alloc_coherent(&(rdev->lldi.pdev->dev), sq->memsize,
> >    132                                         &(sq->dma_addr), GFP_KERNEL);
> >    133          if (!sq->queue)
> >    134                  return -ENOMEM;
> >    135          sq->phys_addr = virt_to_phys(sq->queue);
> >    136          dma_unmap_addr_set(sq, mapping, sq->dma_addr);
> >    137          return 0;
> >    138  }
> > 
> > Is this a bug?
> 
> Yes.  This will blow up badly on many platforms, as sq->queue
> might be vmapped, ioremapped, come from a pool without page backing.

Gah, this addr gets fed into io_remap_pfn_range/remap_pfn_range too..

Potnuri, you should fix this.. 

You probably need to use dma_mmap_from_dev_coherent() in the mmap ?

Jason
