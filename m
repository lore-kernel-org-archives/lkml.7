Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09360C76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 17:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3680218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 17:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="O9hWpCDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391097AbfGWRae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 13:30:34 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:36118 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732740AbfGWRae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 13:30:34 -0400
Received: by mail-ua1-f66.google.com with SMTP id v20so17272261uao.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 10:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RbhpiDasw1Ewe5g+7weE9TXbMjL8KAWk+B3qwXxWc/M=;
        b=O9hWpCDR380rbhw90TNwrzp28pNffEoS4Us5UckcJaWEOyzBJaUbrQSE98N+ymjxQW
         oiBk973xZ6ORiEBiV9Zx6YM5f6Q32IYj0/SyGtmDoGFY8uMFYwt3mdlZ97s5C49fnMui
         2OTpVNIjIGGJAlPoeE+X847UupJo0ZA8rnMsUoH0URd6UnZ19b2YDamDSx3OJSe3EMOb
         Kt2uJ7zSPkpnVExd29sGDon2CJhSCEdXgWKiUUomK2L0M/1EIgZbY6L4agXTd7JVcj3V
         AkElcQgYYmWIkQrV6d6fmuAyO9EgG8sewHhTtRGw4oqVCiwsjjyyZ/Ue6PsPkX8h/K78
         iXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RbhpiDasw1Ewe5g+7weE9TXbMjL8KAWk+B3qwXxWc/M=;
        b=DYKN9QROEG0B1KBftWvnbY6MkRdcKt3APQKs8rlFzJBldn+Gwy8aam0YD3ivKoVfQr
         0UokkQJVX1RWnOh3W7bYt6MvvAh+BmH8ttHJlB53x3VINowILY7yndn/3MZcGC8wLPbq
         9CsiKTycAyNFzcuylDLFTQQZDNt2f1h7WXejgHKrtJyqdJRHhHJAs4We+tD477KDtxiM
         KlZdIBfQ6HqQUjHDsilKwA2PXgonPuDN+hCfDcWLo65BtRwJhqCl6Da9tA8fSxnkJRv3
         EGBATxBULEhFp7Z3MuX/JVSQ8Jsl34GEjaydOR+wKeUxYSfpPMDM2n++Tj0grAeChQwK
         bKmQ==
X-Gm-Message-State: APjAAAV3jKBUgWFVQoNgi+hmtHT/ZYAeKqfWu+4SH+rF9CK20nwZe3yA
        nPzIkH/EptETqnJrZbuvsqgGzg==
X-Google-Smtp-Source: APXvYqwgXpmyPlVv/AMR8i5yc7RI1B7//ksxiY/lelX41GFnDNSTYMBLZpaY2My1r5ik6s2sxtfhhQ==
X-Received: by 2002:ab0:60ad:: with SMTP id f13mr37669182uam.129.1563903033250;
        Tue, 23 Jul 2019 10:30:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id d3sm4771548uaq.20.2019.07.23.10.30.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 10:30:32 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hpycS-0002gy-4J; Tue, 23 Jul 2019 14:30:32 -0300
Date:   Tue, 23 Jul 2019 14:30:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] nouveau: unlock mmap_sem on all errors from
 nouveau_range_fault
Message-ID: <20190723173032.GF15357@ziepe.ca>
References: <20190722094426.18563-1-hch@lst.de>
 <20190722094426.18563-5-hch@lst.de>
 <20190723151824.GL15331@mellanox.com>
 <20190723163048.GD1655@lst.de>
 <20190723171731.GD15357@ziepe.ca>
 <20190723172335.GA2846@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723172335.GA2846@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 07:23:35PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 23, 2019 at 02:17:31PM -0300, Jason Gunthorpe wrote:
> > That reminds me, this code is also leaking hmm_range_unregister() in
> > the success path, right?
> 
> No, that is done by hmm_vma_range_done / nouveau_range_done for the
> success path.

.. which is done with the mmap_sem held :(

> > I think the right way to structure this is to move the goto again and
> > related into the nouveau_range_fault() so the whole retry algorithm is
> > sensibly self contained.
> 
> Then we'd take svmm->mutex inside the helper and let the caller
> unlock that.  Either way it is a bit of a mess, and I'd rather prefer
> if someone has the hardware would do a grand rewrite of this path
> eventually.  Alternatively if no one signs up to mainain this code
> we should eventually drop it given the staging status.

I tend to agree with the sentiment, it just makes me sad that all the
examples we have of these APIs are so troubled.

Jason
