Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0665AC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 22:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A536020644
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 22:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lrFiJUhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbfEVWwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 18:52:23 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46498 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfEVWwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 18:52:22 -0400
Received: by mail-qk1-f196.google.com with SMTP id a132so2598828qkb.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 15:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z/xm6Cl4ibMhuRCBQCtLQFmhKVon9z8MHhMjLCERca0=;
        b=lrFiJUhjohnbp2rSC6LiceOG6jQ/wn0zbsCFI0zCEfyAIF55kVAyx0gaWo4RD2o01r
         eanhb7r/FQorOEI0fwbD1PfoRWVxWwx3Jeg1Nfew6g7qyAd964BRkXg8POP8u3swr+Vo
         jrVlYCOId7NNoVVhRTUjOXDkrvB2fm6wETueDBa50XwHpDYAXObJsbkd06JCnpyH3maw
         BBz5/NyifHbCbc+8wvyXzDI3+N7g/YlgDanbWNXadrnFKADZokNiOgL1VFUTZQbmDk0L
         1hTNzc3zIQatQHqcAh/+KMsGH9yY8qfVBw6e1qVJXJ5+YjpCaZlgkmbyEH+yxKbFDclq
         BqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z/xm6Cl4ibMhuRCBQCtLQFmhKVon9z8MHhMjLCERca0=;
        b=SXuu1piCp56gOehVPzBH7ciX/Ng8Ji7sgU2abfQ5CX3df1CsWvtxCyfrKZpJ9arvzt
         RbtTEkSisF2KylGfFA3bIT3hYTvFtPBCS329iSlukj8FGa8ZTAKPV4wARvzG+fohDpC+
         Uh/y+ScXWl8V0kLX7LStMp6IlpoYOmgwMyzZZw/xkUs3aOagm5q+xq2h1/XMmQ/kcCqF
         VYLNRzIGHh5Asi+7RcOTAZ00DqLOAybcuwI5eDjo3TazpdTnVclBFViUc6EhmP0R+BPs
         +jPTjt47GDq6mv0nouRJPpoEYzmt9K0v8Owx/H+Q73eDv4rIKIRw77vwZyarFNvnZqnE
         SgvA==
X-Gm-Message-State: APjAAAWqkK5RiaxNq3y/7UEAmXIkTYd7dPT7s+FfLkaDNWvxJ0ch/tPF
        QpT9EKABohQayg/5yzIOrNVG3w==
X-Google-Smtp-Source: APXvYqwewerjjcgUFras31nkDpRcgCScCGS6yclsA3zOzL0x3MdSxP2F0tK1PbZ1f6abn3fW4b6qJg==
X-Received: by 2002:a37:ef1a:: with SMTP id j26mr63212619qkk.207.1558565541350;
        Wed, 22 May 2019 15:52:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id t17sm16094116qte.66.2019.05.22.15.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 15:52:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTa5s-0004Hv-A7; Wed, 22 May 2019 19:52:20 -0300
Date:   Wed, 22 May 2019 19:52:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH v4 0/1] Use HMM for ODP v4
Message-ID: <20190522225220.GC15389@ziepe.ca>
References: <20190411181314.19465-1-jglisse@redhat.com>
 <20190506195657.GA30261@ziepe.ca>
 <20190521205321.GC3331@redhat.com>
 <20190522005225.GA30819@ziepe.ca>
 <20190522174852.GA23038@redhat.com>
 <20190522201247.GH6054@ziepe.ca>
 <20190522220419.GB20179@redhat.com>
 <20190522223906.GA15389@ziepe.ca>
 <20190522224211.GF20179@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522224211.GF20179@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 06:42:11PM -0400, Jerome Glisse wrote:

> > > The way race is avoided is because mm->hmm will either be NULL or
> > > point to another hmm struct before an existing hmm is free. 
> > 
> > There is no locking on mm->hmm so it is useless to prevent races.
> 
> There is locking on mm->hmm

Not in mm_get_hmm()

> > So we agree this patch is necessary? Can you test it an ack it please?
> 
> A slightly different patch than this one is necessary i will work on
> it tomorrow.

I think if you want something different you should give feedback on
this patch. You haven't rasied any defects with it.

Jason
